
shinyServer(function(input, output,session) {
  
  # create data used by all
  
  theData <- reactive({
    print(input$count)
    
    
    # create a ranking
    
    df <-fortune %>% 
      # mutate(rank=row_number(),revRank=1001-rank) %>% 
      filter(rank>=input$count[1]&rank<=input$count[2])
    
    ## several companies are located in same city so we need to
    ## separate them out for visual identification
    
    df$lon <- jitter(df$lon,amount=.1)
    df$lat <- jitter(df$lat,amount =.1)
    
    ## create a value useful for circlMarker size
    df <- df %>% 
      mutate(marker=ceiling(sqrt(revRank)/3))
    
    
    
    # do summary by state info
    
    ## then create summary by state
    summary<-fortune %>% 
      filter(rank>=input$count[1]&rank<=input$count[2]) %>% 
      group_by(state) %>% 
      summarize(total=n()) #45 prob should do a joine with a states field
    
    
    ## neeed to create vaue for all states asn set NA to zero
    summary <- allStates %>% 
      left_join(summary)
    
    
    summary[is.na(summary$total),]$total <- 0
    
    summary <- summary %>% 
      
      mutate(rank=min_rank(desc(total)))
    
    info=list(df=df,summary=summary) 
    
    
    return(info)
  })
  
  
  source("code/locations.R", local=TRUE)
  source("code/statebins.R", local=TRUE)
  source("code/choropleth.R", local=TRUE)
  source("code/data.R", local=TRUE)
  
  
 
 
})

