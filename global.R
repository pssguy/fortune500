# load libraries

#library(rvest)
library(leaflet)
library(dplyr)
#library(ggmap)
library(readr)
library(rgdal)
library(stringr)
library(tidyr)
library(rcstatebin)
library(shiny)
library(shinydashboard)
library(htmlwidgets)
library(DT)

# load requisite files
## earlier manipulation of "http://fortune.com/fortune500/"

fortune <- read.csv("fortune500.csv")

# create a rank
fortune <-fortune %>% 
  mutate(rank=row_number(),revRank=1001-rank)

## create ability to select by industry
topIndustries <- fortune %>% 
  group_by(industry) %>% 
  summarize(count=n()) %>% 
  ungroup() %>% 
  arrange(desc(count)) %>% 
  mutate(name=paste0(industry," (",count,")"))
print(topIndustries$name)

## map spatial polygon

maps <- readOGR(dsn=".",
                layer = "ne_50m_admin_1_states_provinces_lakes", 
                encoding = "UTF-8",verbose=FALSE)

#limit to US states and DC
states <-maps[50:100,] 

# create a stateID fore merging

states$stateId <-str_replace(states$iso_3166_2,"US-","")


### Choropleth map
## take all states from rcstatebins data
allStates <- data.frame(state=unique(taxdata$state)) 

# ## then create summary by state
# summary<-fortune %>% 
#   group_by(state) %>% 
#   summarize(total=n()) #45 prob should do a joine with a states field
# 
# 
# ## neeed to create vaue for all states asn set NA to zero
# summary <- allStates %>% 
#   left_join(summary)
# 
# 
# summary[is.na(summary$total),]$total <- 0
# 
# summary <- summary %>% 
#   
#   mutate(rank=min_rank(desc(total)))
# 
# ### again may need to switch if restricting
# states2  <- sp::merge(states, 
#                       summary, 
#                       by.x = "stateId", 
#                       by.y = "state",                    
#                       sort = FALSE)
# states2$popUp <- paste0("<strong>",states2$rank,": ", states2$name, "</strong><br>",
#                         
#                         states2$total," companies")


# sort(names(states2))
# lng1 <- min(states$lng)
#pal <- colorQuantile("Reds", NULL, n = 8)
#print(states2$popUp)