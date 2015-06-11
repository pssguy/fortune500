# load libraries

#library(rvest) required for initial scrape
library(leaflet)
library(dplyr)
#library(ggmap) required for obtaining lat lons
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



## map spatial polygon from previously downloaded info

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

