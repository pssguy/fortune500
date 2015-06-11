


output$statebins <- renderStatebin({
  
  print("enter statebins")
  
  print(theData()$summary)
  summary <- theData()$summary
 # theIndustry <- "Petroleum Refining"
  
#   summary<-fortune %>% 
#   #  filter(industry==theIndustry) %>% 
#     group_by(state) %>% 
#     summarize(total=n()) #
  
  theMax <- max(summary$total)
  print(theMax)
  
statebin(data = summary,
           x = "state",
           y = "total",
           type='hex',
                               heading =  "<b>Hover for Details</b>",
                               footer = "<small>Source: Fortune500 <a href='http://fortune.com/fortune500/'>(Data)</a>",)
          # colors =colorNumeric("Reds", c(0,theMax)))
  
#   statebin(data = summary,
#                       x = "state",
#                       y = "total",
#                       type='hex'),
#           #            facet = 'industry',
#                       heading =  "<b>Where are Fortune 1000 HQs?</b>",
#                       footer = "<small>Source: Fortune500 <a href='http://fortune.com/fortune500/'>(Data)</a>",
#                       #colors = RColorBrewer::brewer.pal(5, 'PuRd')#,
#                        colors =colorNumeric("Reds", c(0,max(summary$total)))
#               #          control = 'dropdown'
#              )
 


})