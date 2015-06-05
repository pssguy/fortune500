

output$locations <- renderLeaflet({
  
  print(input$count)
  
  
  # create a ranking

  df <-fortune %>% 
      mutate(rank=row_number(),revRank=1001-rank) %>% 
      filter(rank>=input$count[1]&rank<=input$count[2])
  
  ## several companies are located in same city so we need to
  ## separate them out for visual identification
  
  df$lon <- jitter(df$lon,amount=.1)
  df$lat <- jitter(df$lat,amount =.1)
  
  ## create a value useful for circlMarker size
  df <- df %>% 
    mutate(marker=ceiling(sqrt(revRank)/3))
  
 
  
  leaflet(data=df) %>% 
    addTiles() %>% 
    clearBounds() %>% 
    # addCircleMarkers(radius= ~diameter/10,popup=~ paste0("Name: ",name,"<br>Diameter: ",diameter,"km"))
    addCircleMarkers(radius = ~ marker,popup=~ paste0(rank,": <b>",company,"</b><br>",location,"<br>",industry))
  
  
  
  
  
})