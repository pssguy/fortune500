


output$statebins <- renderStatebin({
  
  print("enter statebins")
  
  print(theData()$summary)
  summary <- theData()$summary

  # if looking at different color range
 # theMax <- max(summary$total)
 
  
statebin(data = summary,
           x = "state",
           y = "total",
           type='hex',
                               heading =  "<b>Hover for Details</b>",
                               footer = "<small>Source: Fortune500 <a href='http://fortune.com/fortune500/'>(Data)</a>",)



})