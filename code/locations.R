

output$locations <- renderLeaflet({
  

  df <- theData()$df
  
  
  leaflet(data=df) %>% 
    addTiles() %>% 
    clearBounds() %>% 
    # addCircleMarkers(radius= ~diameter/10,popup=~ paste0("Name: ",name,"<br>Diameter: ",diameter,"km"))
    addCircleMarkers(radius = ~ marker,popup=~ paste0(rank,": <b>",company,"</b><br>",location,"<br>",industry))
  
  
  
  
  
})