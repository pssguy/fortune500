

output$choropleth <- renderLeaflet({
  
  if(is.null(input$industry)) return()
  
  states2  <- sp::merge(states, 
                        theData()$summary, 
                        by.x = "stateId", 
                        by.y = "state",                    
                        sort = FALSE)
  states2$popUp <- paste0("<strong>",states2$rank,": ", states2$name, "</strong><br>",
                          
                          states2$total," companies")
  
#   print(sort(names(states2)))
#   print(states2$total)
#   bins <- cut(states2$total,8,include.lowest = TRUE)
#   print(bins)
#   
#   print(nrow(states2))
#   print(table(states2$total))
# #   0  1  2  3  4  5 10 12 13 15 
# #   24  9  7  2  3  2  1  1  1  1 
#   breakCount <- 3
#   
#   pal <- colorQuantile("Reds", NULL, n = breakCount)
  pal <- colorNumeric("Reds", c(0,max(states2$total)))
  
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
  if (is.null(input$choropleth_shape_click$id)) return()
  stateID <-input$choropleth_shape_click$id
  
  theData()$df %>% 
    mutate(rank=row_number()) %>% 
    filter(state==stateID) %>% 
    select(rank,company,city,industry) %>% 
    DT::datatable(rownames=FALSE)
  
#   fortune %>% 
#     mutate(rank=row_number()) %>% 
#     filter(state==stateID) %>% 
#     select(rank,company,city,industry) %>% 
#     DT::datatable(rownames=FALSE)
})
