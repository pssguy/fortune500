


output$statebins <- renderStatebin({
  
  # initially all 1000 companies
  print(input$style)
  if (input$style=="square"){
  statebin(data = summary,
           x = "state",
           y = "total",
           #facet = "description",
           heading =  "<b>Where are Fortune 1000 HQs?</b>",
           footer = "<small>Source: Fortune500 <a href='http://fortune.com/fortune500/'>(Data)</a>",
           colors = RColorBrewer::brewer.pal(5, 'PuRd')#,
           #  control = 'dropdown'
  )
  } else if (input$style=="hex") {
    statebin(data = summary,
             x = "state",
             y = "total",
             type="hex",
             #facet = "description",
             heading =  "<b>Where are Fortune 1000 HQs?</b>",
             footer = "<small>Source: Fortune500 <a href='http://fortune.com/fortune500/'>(Data)</a>",
             colors = RColorBrewer::brewer.pal(5, 'PuRd')#,
             #  control = 'dropdown'
    )
  }
})