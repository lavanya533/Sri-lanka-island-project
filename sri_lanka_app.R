library(shiny)

ui <- fluidPage(
  titlePanel("Sri Lanka: Island Exploration"),
  sidebarLayout(
    sidebarPanel(
      helpText("Explore Sri Lanka's geography, demographics, and more.")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Map", "Map will go here."),
        tabPanel("Plots", "Plots will go here."),
        tabPanel("Images", "Images will go here."),
        tabPanel("About", "About text will go here.")
      )
    )
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)

