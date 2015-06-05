

output$choropleth <- renderLeaflet({
  
  print(sort(names(states2)))
  
  leaflet(data = states2) %>%
    addTiles() %>%
   setView(-110,38,zoom=3) %>% 
    addPolygons(fillColor = ~pal(total), 
                fillOpacity = 0.6, 
                color = "#BDBDC3", 
                weight = 1, 
                layerId = ~stateId,
                popup = ~popUp) %>% 
    mapOptions(zoomToLimits="first")
  
  
})

output$table <- DT::renderDataTable({
  print("enter")
  stateID <-input$choropleth_shape_click$id
  
  fortune %>% 
    mutate(rank=row_number()) %>% 
    filter(state==stateID) %>% 
    select(rank,company,city,industry) %>% 
    DT::datatable(rownames=FALSE)
})
