library(rvest)
library(leaflet)
library(dplyr)
library(ggmap)
library(readr)
library(rgdal)
library(stringr)

url <- "http://fortune.com/fortune500/"
url <- "https://support.infinitewp.com/support/articles/206270-error-failed-to-connect-to-site-name-port-80-connection-timed-out"
fortune <- html(url)

fortune <- html(httr::GET("http://fortune.com/fortune500/")) # only520B

fortune %>% 
  html_nodes(".ranking")

## easiest to download all 500 

fortune <- html("fortune500.html")


company <- fortune %>% 
  html_nodes(".company-name") %>% 
  html_text()
location <- fortune %>% 
  html_nodes(".company-location") %>% 
  html_text()

industry <- fortune %>% 
  html_nodes(".company-industry") %>% 
  html_text()

thumbnail <- fortune %>% 
  html_nodes(".company-list-thumbnail") %>% 
  html_text()

for (i in 1:length(location)) {

results <-geocode(location[i])
print(i)
print(results)
    if (i!=1) {
      df <- rbind(df,results)
    } else {
      df <- results
    }
}

a <- cbind(df,company)
b <- cbind(a,location)
c <- cbind(b,industry)

names(c)

write_csv(c,"fortune500.csv")

data <- read.csv("fortune500.csv")

str(data)

unique(data$company)
# location = 410,
# industry 74

topIndustries <- data %>% 
    group_by(industry) %>% 
  summarize(count=n()) %>% 
  ungroup() %>% 
  arrange(desc(count)) %>% 
  mutate(name=paste0(industry," (",count,")"))

## looks good could add all 1000


maps <- readOGR(dsn=".",
                layer = "ne_50m_admin_1_states_provinces_lakes", 
                encoding = "UTF-8",verbose=FALSE)

states <-maps[50:100,] 

# might come in handy when doing a ranking by state count and ranking 1000-1
sort(names(states))
stateId <-str_replace(states$iso_3166_2,"US-","") #inc dc



states[1,1]

glimpse(data)

data <-data %>% 
  mutate(rank=row_number(),revRank=1001-rank)

data <- data %>% 
  mutate(revRank=1001-rank)  

leaflet(data=data) %>% 
  addTiles() %>% 
  clearBounds() %>% 
 # addCircleMarkers(radius= ~diameter/10,popup=~ paste0("Name: ",name,"<br>Diameter: ",diameter,"km"))
addCircles(radius = ~ revRank/100,popup=~ paste0(rank,": <b>",company,"</b><br>",location,"<br>",industry))
