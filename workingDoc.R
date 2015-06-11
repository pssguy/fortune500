# library(rvest)
# library(leaflet)
# library(dplyr)
# library(ggmap)
# library(readr)
# library(rgdal)
# library(stringr)
# 
# url <- "http://fortune.com/fortune500/"
# url <- "https://support.infinitewp.com/support/articles/206270-error-failed-to-connect-to-site-name-port-80-connection-timed-out"
# fortune <- html(url)
# 
# fortune <- html(httr::GET("http://fortune.com/fortune500/")) # only520B
# 
# fortune %>% 
#   html_nodes(".ranking")
# 
# ## easiest to download all 500 
# 
# fortune <- html("fortune500.html")
# 
# 
# company <- fortune %>% 
#   html_nodes(".company-name") %>% 
#   html_text()
# location <- fortune %>% 
#   html_nodes(".company-location") %>% 
#   html_text()
# 
# industry <- fortune %>% 
#   html_nodes(".company-industry") %>% 
#   html_text()
# 
# thumbnail <- fortune %>% 
#   html_nodes(".company-list-thumbnail") %>% 
#   html_text()
# 
# for (i in 1:length(location)) {
# 
# results <-geocode(location[i])
# print(i)
# print(results)
#     if (i!=1) {
#       df <- rbind(df,results)
#     } else {
#       df <- results
#     }
# }
# 
# a <- cbind(df,company)
# b <- cbind(a,location)
# c <- cbind(b,industry)
# 
# names(c)
# 
# write_csv(c,"fortune500.csv")
# 
# data <- read.csv("fortune500.csv")
# 
# str(data)
# 
# unique(data$company)
# # location = 410,
# # industry 74
# 
# topIndustries <- data %>% 
#     group_by(industry) %>% 
#   summarize(count=n()) %>% 
#   ungroup() %>% 
#   arrange(desc(count)) %>% 
#   mutate(name=paste0(industry," (",count,")"))
# 
# ## looks good could add all 1000
# 
# 
# maps <- readOGR(dsn=".",
#                 layer = "ne_50m_admin_1_states_provinces_lakes", 
#                 encoding = "UTF-8",verbose=FALSE)
# 
# states <-maps[50:100,] 
# 
# # might come in handy when doing a ranking by state count and ranking 1000-1
# sort(names(states))
# states$stateId <-str_replace(states$iso_3166_2,"US-","") #inc dc
# 
# 
# 
# states[1,1]
# 
# glimpse(data)
# 
# data <-data %>% 
#   mutate(rank=row_number(),revRank=1001-rank)
# 
# data <- data %>% 
#   mutate(revRank=1001-rank)
# 
# jitteredData <- data
# 
# jitteredData$lon <- jitter(jitteredData$lon,amount=.1)
# jitteredData$lat <- jitter(jitteredData$lat,amount =.1)
# 
# leaflet(data=jitteredData) %>% 
#   addTiles() %>% 
#   clearBounds() %>% 
#  # addCircleMarkers(radius= ~diameter/10,popup=~ paste0("Name: ",name,"<br>Diameter: ",diameter,"km"))
# addCircles(radius = ~ revRank/100,popup=~ paste0(rank,": <b>",company,"</b><br>",location,"<br>",industry))
# 
# 
# data %>% 
#   filter(location=="Las Vegas, NV")
# 
# ## create choropleth - say number by stats
# ## need to split company
# glimpse(data)
# library(tidyr)
# fortune <- read.csv("fortune500.csv")
# col=
# df %>% 
# separate(df,location,c("city","state"))
# 
# df <- data.frame(x = c("a.b", "a.d", "b.c"))
# df %>% separate(x, c("A", "B")) # as in vignette
# df %>% separate(x, c("A", "B"),sep="\\.") #this also works
# temp <- fortune %>%  separate(location,c("city","state"))
# glimpse(fortune)
# 
# fortune$location <- as.character(fortune$location) # did not help
# fortune %>%  separate(location,c("city","state"),sep="\\,")
# df %>% separate(x, c("city", "state"))
# 
# df <- data.frame(x = c("a.b", "a.d", "b.c"))
# temp <-df %>% extract(x, "A")
# df %>% extract(x, c("A", "B"), "([[:alnum:]]+)\\.([[:alnum:]]+)")
# 
# library(stringr)
# str_replace(fortune$location,", ",".")
# 
# fortune$state <- str_sub(fortune$location,-2)
# fortune$city <- str_sub(fortune$location,1,-5)
# write_csv(fortune,"fortune500.csv")
# 
# 
# allStates <- data.frame(state=unique(taxdata$state)) #51
# summary<-fortune %>% 
#   group_by(state) %>% 
#   summarize(total=n()) #45 prob should do a joine with a states field
# 
# summary <- allStates %>% 
#    left_join(summary)
# 
# summary[is.na(summary$total),]$total <- 0
# 
# summary <- summary %>% 
#    
#   mutate(rank=min_rank(desc(total)))
# 
# 
# ## statebin
# library(rcstatebin)
# library(dplyr)
# glimpse(taxdata)
# 
# td <- taxdata %>% 
#   select(state,share)
# 
# glimpse(td)
# 
# statebin(data = td,
#          x = "state",
#          y = "share")
# 
# glimpse(summary)
# str(summary)
# summary <- data.frame(summary)
# summary$state <- as.factor(summary$state)
# summary$total <- as.numeric(summary$total)
# statebin(data = summary,
#          x = "state",
#          y = "total"
# ,
# #facet = "description",
#          heading =  "<b>Where are Fortune 500 HQs?</b>",
#          footer = "<small>Source: Fortune500 <a href='http://fortune.com/fortune500/'>(Data)</a>",
#          colors = RColorBrewer::brewer.pal(5, 'PuRd')#,
#        #  control = 'dropdown'
# )
# 
# topIndustries <- data %>% 
#   group_by(industry) %>% 
#   summarize(count=n()) %>% 
#   ungroup() %>% 
#   arrange(desc(count)) %>% 
#   mutate(name=paste0(industry," (",count,")"))
# 
# 
# statebin(data = taxdata,
#          x = "state",
#          y = "share",
#          facet = "description",
#          heading =  "<b>Where do your state's taxes come from?</b>",
#          footer = "<small>Source: Census <a href='http://www2.census.gov/govs/statetax/14staxcd.txt'>(Data)</a>",
#          colors = RColorBrewer::brewer.pal(5, 'PuRd'),
#          control = 'dropdown'
# )
# 
# sort(names(maps))
# states2  <- sp::merge(states, 
#                                 summary, 
#                                 by.x = "stateId", 
#                                 by.y = "state",                    
#                                 sort = FALSE)
# states2$popUp <- paste0("<strong>",states2$rank,": ", states2$name, "</strong><br>",
#                         
#                         states2$total," companies")
#                        
# 
# sort(names(states2))
# lng1 <- min(states$lng)
# pal <- colorQuantile("Reds", NULL, n = 8)
# #pal <- RColorBrewer::brewer.pal(5, 'PuRd')
# leaflet(data = states2) %>%
#   addTiles() %>%
#  #
#   addPolygons(fillColor = ~pal(total), 
#               fillOpacity = 0.6, 
#               color = "#BDBDC3", 
#               weight = 1, 
#               layerId = states2$stateId,
#               popup = states2$popUp) %>% 
#    mapOptions(zoomToLimits="first")
# 
# ## check hex
# 
# library(rcstatebin)
# statebin(data = taxdata,
#          x = "state",
#          y = "share",
# #          facet = "description",
# #          heading =  "<b>Where do your state's taxes come from?</b>",
# #          footer = "<small>Source: Census <a href='http://www2.census.gov/govs/statetax/14staxcd.txt'>(Data)</a>",
# #          colors = RColorBrewer::brewer.pal(5, 'PuRd'),
# #          control = 'dropdown',
#          type='hex'
# )
# 
# ui <- statebinOutput("statebins")
# server <- shinyServer(function(input, output,session) {
#   
# })
# 
# library(shiny)
# library(rcstatebin)
# library(htmlwidgets)
# 
# app <- shinyApp(
#     ui = bootstrapPage(,
#       radioButtons("style","",choices=c("square","hex"),inline=TRUE),                  
#       statebinOutput("map")
#   ),
#   
#   server = function(input, output) {
#     
#  output$map <-   renderStatebin({
#    print(input$style)
#    
#    if(input$style=="hex") {
#       statebin(data = taxdata,
#                              x = "state",
#                              y = "share",
#                              type='hex'
#     )
#    } else {
#      if(input$style=="hex") {
#        statebin(data = taxdata,
#                 x = "state",
#                 y = "share"
#        )
#      }
#    }
#  }
# )
#   })
# runApp(app)
