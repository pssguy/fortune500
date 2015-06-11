

output$locations <- renderLeaflet({
  

  df <- theData()$df
  
  
  leaflet(data=df) %>% 
    addTiles() %>% 
    clearBounds() %>% 
  
    addCircleMarkers(radius = ~ marker,popup=~ paste0(rank,": <b>",company,"</b><br>",location,"<br>",industry))
  
  
  
  
  
})