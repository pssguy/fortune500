

output$choropleth <- renderLeaflet({
  
  print(sort(names(states2)))
  
  leaflet(data = states2) %>%
    addTiles() %>%
    #
    addPolygons(fillColor = ~pal(total), 
                fillOpacity = 0.6, 
                color = "#BDBDC3", 
                weight = 1, 
                layerId = ~stateId,
                popup = ~popUp) %>% 
    mapOptions(zoomToLimits="first")
  
  
})