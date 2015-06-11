
shinyServer(function(input, output,session) {
  
  # create industry select based on company range
  
  output$industries <- renderUI({
    fortune %>% 
       filter(rank>=input$count[1]&rank<=input$count[2]) %>% 
    
      group_by(industry) %>% 
      summarize(count=n()) %>% 
      ungroup() %>% 
      arrange(desc(count)) -> topIndustries
    
   
    topIndustries$industry <- as.character(topIndustries$industry)
   
    
    industryChoice <- c("All",topIndustries$industry)
    
    selectInput("industry","Select Industry - ordered by count",industryChoice)
    
  })
  
  
  # create data used by all
  
  theData <- reactive({
  
    
    # create a ranking
    
    if (input$industry=="All") {
    df <-fortune %>% 
        filter(rank>=input$count[1]&rank<=input$count[2])
    } else {
      df <-fortune %>%
      filter(rank>=input$count[1]&rank<=input$count[2]&industry==input$industry)
    }
    ## several companies are located in same city so we need to
    ## separate them out for visual identification
    
    df$lon <- jitter(df$lon,amount=.1)
    df$lat <- jitter(df$lat,amount =.1)
    
    ## create a value useful for circlMarker size
    df <- df %>% 
      mutate(marker=ceiling(sqrt(revRank)/3))

    # create by state info
    summary<-df %>% 
      
      group_by(state) %>% 
      summarize(total=n())
    
    
    ## neeed to create value for all states and set NA to zero
    summary <- allStates %>% 
      left_join(summary)
    
    
    summary[is.na(summary$total),]$total <- 0
    
    summary <- summary %>% 
      
      mutate(rank=min_rank(desc(total)))
    
    info=list(df=df,summary=summary) 
    
    
    return(info)
  })
  
  # links to outputs
  source("code/locations.R", local=TRUE)
  source("code/statebins.R", local=TRUE)
  source("code/choropleth.R", local=TRUE)
  source("code/data.R", local=TRUE)
  
  
 
 
})

