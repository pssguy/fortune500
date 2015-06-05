
dashboardPage(
  dashboardHeader(title = "Fortune 500"),
  
    dashboardSidebar(sidebarMenu(
    menuItem("HQs", tabName = "locations"),
    menuItem("StateBins", tabName = "statebins")
    )
    ),
    
  dashboardBody(
    tabItems(
      tabItem("locations",
    fluidRow(
    box(
      width = 8, status = "success", solidHeader = TRUE,
      title = "City Locations of top  US companies by total Revenue Click markers for details",
      sliderInput("count","",min=1,max=1000,value=c(1,100), ticks=FALSE),
      leafletOutput("locations")
      
    )
  )),
  tabItem("statebins",
          fluidRow(
            box(
              width = 8, status = "success", solidHeader = TRUE,
              title = "Fortune Companies by State. Hover for Info",
              statebinOutput("statebins")
              
            )
          ))
)
)
)

# header <-  dashboardHeader(title = "Fortune 500")
# sidebar <-dashboardSidebar(disable = TRUE)
# body <- dashboardBody(fluidRow(
#   box(
#     width = 8, status = "success", solidHeader = TRUE,
#     title = "Locations",
#     leafletOutput("locations")
#     
#   )
# ))
#  
# 
# dashboardPage(skin='green',
#               header,
#               sidebar,
#               body
# )