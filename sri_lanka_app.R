# Load necessary libraries
library(shiny)
library(leaflet)
library(bslib)


ui <- fluidPage(
  titlePanel("Sri Lanka: Island Exploration"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Explore Sri Lanka's geography, economy, and recent events through interactive visuals.")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Map",
                 h3("Where is Sri Lanka?"),
                 leafletOutput("sriMap", height = 400),
                 p("Sri Lanka is an island nation in the Indian Ocean, just southeast of India.")
        ),
        
        tabPanel("Plots",
                 h3("Data Visualizations Coming Soon"),
                 p("This section will include visualizations of Sri Lanka’s inflation, currency trends, and more.")
        ),
        
        tabPanel("Images",
                 h3("Sri Lanka: A Glimpse Through Crisis and Geography", style = "text-align:center;"),
                 
                 fluidRow(
                   column(6,
                          tags$div(
                            tags$img(src = "map.jpg", height = "300px", style = "display:block; margin:auto;"),
                            tags$p("Topographic map of Sri Lanka.", style = "text-align:center;")
                          )
                   ),
                   column(6,
                          tags$div(
                            tags$img(src = "protest.jpg", height = "300px", style = "display:block; margin:auto;"),
                            tags$p("Protests in Colombo, 2022.", style = "text-align:center;")
                          )
                   )
                 ),
                 
                 fluidRow(
                   column(6,
                          tags$div(
                            tags$img(src = "rupee.jpg", height = "300px", style = "display:block; margin:auto;"),
                            tags$p("Sri Lankan Rupee notes.", style = "text-align:center;")
                          )
                   ),
                   column(6,
                          tags$div(
                            tags$img(src = "inflation.jpg", height = "300px", style = "display:block; margin:auto;"),
                            tags$p("Colombo inflation spikes to 54.6% in May 2022.", style = "text-align:center;")
                          )
                   )
                 )
        ),
        
        tabPanel("About",
                 h3("About This Project"),
                 p("Sri Lanka, an island with deep history and recent economic turbulence, is explored here through maps, visuals, and data."),
                 p("This project was created using R and Shiny for the Island Exploration course assignment.")
        )
      )
    )
  )
)

server <- function(input, output) {
  output$sriMap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 80.7718, lat = 7.8731, zoom = 6) %>%
      addMarkers(lng = 80.7718, lat = 7.8731, popup = "Sri Lanka 🇱🇰")
  })
}

shinyApp(ui = ui, server = server)
