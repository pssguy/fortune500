
dashboardPage(
  dashboardHeader(title = "Fortune 1000 HQs"),
  
    dashboardSidebar(
      sliderInput("count","",min=1,max=1000,value=c(1,101),step=10, ticks=FALSE),
      uiOutput("industries"),
 
  sidebarMenu(
    menuItem("Maps", tabName = "maps"),
 
  menuItem("Data", tabName = "data"),
  menuItem("Info", tabName = "info"),
  menuItem("", icon = icon("twitter-square"),
           href = "https://twitter.com/pssGuy"),
  menuItem("", icon = icon("envelope"),
           href = "mailto:agcur@rogers.com")
    )
    ),
    
  dashboardBody( 
    tabItems(
      tabItem("maps",
  fluidRow(
    tabBox(
      
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset1", height = "500px",
      tabPanel("Choropleth Click State for Table",
               leafletOutput("choropleth")),
      tabPanel("Locations. Click for Details",
               leafletOutput("locations")),
      
      tabPanel("HexBins",
               statebinOutput("statebins"))
    ),
    
    box(
      width = 6, status = "success", solidHeader = TRUE,
      title = "Leading Companies within State - Use with Choropleth",
      DT::dataTableOutput("table")
      
    )
  )
      ),

tabItem("data",
          fluidRow(
            column(width=8,offset=2,
          
          box(
            status = "info", solidHeader = FALSE,
            includeMarkdown("data.md"),
            hr(),
            DT::dataTableOutput("data")
          )
            ))
        ),

tabItem("info",includeMarkdown("info.md"))

) #tabitems
       
        
)# body
) #page




