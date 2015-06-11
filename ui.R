
dashboardPage(
  dashboardHeader(title = "Fortune 1000 HQs"),
  
    dashboardSidebar(
      sliderInput("count","",min=1,max=1000,value=c(1,1000),step=10, ticks=FALSE),
      uiOutput("industries"),
 
  sidebarMenu(
    menuItem("Maps", tabName = "maps",icon = icon("map-marker")),
 
  menuItem("Data", tabName = "data",icon = icon("database")),
  menuItem("Info", tabName = "info",icon = icon("info")),
  
  menuItem("Code",icon = icon("code-fork"),
           href = "https://github.com/pssguy/fortune500"),
  
  menuItem("Other Dashboards",
          # menuSubItem("WikiGuardian",href = "https://mytinyshinys.shinyapps.io/fortune500"),
           menuSubItem("WikiGuardian",href = "https://mytinyshinys.shinyapps.io/wikiGuardian"),
           menuSubItem("World Soccer",href = "https://mytinyshinys.shinyapps.io/worldSoccer")
           
  ),
  
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
          
          box(width=12,
            status = "info", solidHeader = FALSE,
            includeMarkdown("data.md")
          ),
          box(width=12,
            DT::dataTableOutput("data")
          )
            ))
        ),

tabItem("info",includeMarkdown("info.md"))

) 
       
        
)
)




