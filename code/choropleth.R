

output$choropleth <- renderLeaflet({
  
  if(is.null(input$industry)) return()
  
  
  # merge map and data info
  
  states2  <- sp::merge(states, 
                        theData()$summary, 
                        by.x = "stateId", 
                        by.y = "state",                    
                        sort = FALSE)
  # add a popup field
  states2$popUp <- paste0("<strong>",states2$rank,": ", states2$name, "</strong><br>",
                          
                          states2$total," companies")
  
  # create colors with domain ranging to highest value
  pal <- colorNumeric("Reds", c(0,max(states2$total)))
  
 # create leaflet map
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
 
  if (is.null(input$choropleth_shape_click$id)) return()
  
  # use the clicked state as filter for data
  
  stateID <-input$choropleth_shape_click$id
  
  
  # create data to be tabulated
  theData()$df %>% 
    mutate(rank=row_number()) %>% 
    filter(state==stateID) %>% 
    select(rank,company,city,industry) %>% 
    DT::datatable(rownames=FALSE)

})
