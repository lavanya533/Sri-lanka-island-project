# Load  libraries
library(shiny)
library(leaflet)
library(bslib)
library(ggplot2)
library(readr)
library(tidyverse)

# Load trade data and compute trade balance
trade_data <- read.csv("data/trade_data.csv")
trade_data$Trade_Balance <- trade_data$Exports - trade_data$Imports

# Theme setup
my_theme <- bs_theme(
  version = 5,
  bootswatch = "flatly",
  primary = "#0A9396",
  secondary = "#005F73",
  base_font = font_google("Lato"),
  heading_font = font_google("Playfair Display")
)

# UI
ui <- fluidPage(tags$head(tags$meta(name = "viewport", content = "width=device-width, initial-scale=1")),
                theme = my_theme,
                titlePanel("Sri Lanka: Island Exploration"),
                sidebarLayout(
                  sidebarPanel(

                    selectInput("trade_year", "Choose a Year:", choices = sort(unique(trade_data$Year), decreasing = TRUE)),
                    helpText("Explore Sri Lanka's geography, economy, and recent events through interactive visuals."),
                    downloadButton("downloadData", "Download Trade Data"),
                    
                  ),
                  mainPanel(
                    tabsetPanel(
                      selected = "About",
                      tabPanel("Map",
                               card(
                                 card_header("Where is Sri Lanka?"),
                                 card_body(
                                   leafletOutput("sriMap", height = 400),
                                   p("Sri Lanka exists as a small island nation which forms a teardrop shape in the southeastern waters of India. The island exists between 5° and 10°N latitude and 79° to 82°E longitude in the Indian Ocean. The island measures approximately 65,000 square kilometers which is smaller than Ireland yet contains extensive ecological and cultural diversity."),
                                   p("The island has operated as a maritime crossroads for East-West trade for many centuries. Its position near Indian Ocean sea lanes has provided it with both military and commercial significance. Moreover, the ports of Colombo and Hambantota have emerged as key locations in regional geopolitical and trade activities."),
                                   p("Sri Lanka’s terrain is a mix of flat coastal plains and a rugged mountainous interior. The Central Highlands, which include Pidurutalagala (2,524 meters) among other peaks, determine the climate and agriculture of the island. These hills are famous for tea plantations which were introduced during the British colonial rule and are still the mainstay of the economy."),
                                   p("Apart from this, the island stands as one of the world’s 36 biodiversity hotspots despite its small size. It hosts distinctive bird, reptile, amphibian and plant species which exist nowhere else in the world. The natural heritage of Yala and Sinharaja national parks demonstrates this rich biodiversity."),
                                   p("This geographic location has shaped Sri Lanka's historical trade, cultural exchanges, and vulnerability to global market fluctuations.")
                                 )
                               )
                      ),
                      
                      tabPanel("Plots",
                               card(
                                 card_header("Sri Lanka: Inflation Trend"),
                                 card_body(
                                   plotOutput("inflationPlot", height = "400px"),
                                   p(em("This line chart illustrates the evolution of Sri Lanka’s inflation rate over the past decade. 
                                         Notably, there is a sharp and unprecedented spike in 2022, where inflation surpassed 50%. 
                                         This surge resulted from multiple converging factors; global commodity shocks, a collapsing currency, 
                                         and mismanaged domestic fiscal policy.")),
                                   p(em("Such extreme inflation severely eroded the value of the Sri Lankan rupee, reducing purchasing power, 
                                         increasing food and fuel insecurity, and driving mass public protests that eventually led to government change. 
                                         The shock waves from this episode were felt across all economic sectors.")),
                                   p(em("Tracking inflation through time not only highlights short-term volatility, but also helps in understanding 
                                         long-term fiscal health, policymaking effectiveness, and consumer confidence."))
                                 )
                               ),
                               
                               card(
                                 card_header("Sri Lanka: GDP Growth"),
                                 card_body(
                                   plotOutput("gdpPlot", height = "400px"),
                                   p(em("This bar chart visualizes Sri Lanka’s Gross Domestic Product (GDP) over the last decade. 
                                         The chart shows consistent growth through 2018, followed by a dip around 2020–2022 due to the COVID-19 pandemic and ensuing economic crisis.")),
                                   p(em("Sri Lanka’s GDP is driven by agriculture, industry, and services, with tourism being a significant contributor pre-2020. 
                                         GDP reflects the output and productivity of a nation, and declines here mirror drops in employment, income, and investment.")),
                                   p(em("Studying GDP trends is critical in understanding structural strengths, weaknesses, and the trajectory of 
                                         development, especially during volatile periods of inflation, currency collapse, and external debt accumulation."))
                                 )
                               ),
                               
                               card(
                                 card_header("Sri Lanka: Trade Balance"),
                                 card_body(
                                   plotOutput("tradePlot", height = "400px"),
                                   p(em("This plot compares annual export and import trends. A persistent trade deficit is evident, 
                                         with imports frequently exceeding exports, contributing to Sri Lanka's foreign currency shortage.")),
                                   p(em("In crisis years (2020–2022), essential imports such as fuel, medicine, and food surged while exports stalled, 
                                         deepening the deficit and eventually leading to a sovereign default in 2022.")),
                                   p(em("This imbalance is one of the most pressing indicators of macroeconomic instability. 
                                         Understanding these trade patterns is crucial for fiscal planning, currency stability, and negotiating aid or international support."))
                                 )
                               ),
                               
                               card(
                                 card_header("📦 Trade Table for Selected Year"),
                                 card_body(
                                   tableOutput("tradeTable"),
                                   p(em("This table allows users to view the actual values of Sri Lanka's imports and exports for a selected year. 
                                         It highlights the trade imbalance and provides transparency into how external trade was impacted year over year. 
                                         Values are listed in billions of USD.")),
                                   p(em("It’s especially valuable for understanding whether imports were driven by essential needs or consumption, 
                                        and whether export revenues were diversified or concentrated in vulnerable sectors."))
                                 )
                               ),
                               
                               card(
                                 card_header("🧾 Trade Balance Summary"),
                                 card_body(
                                   tableOutput("balanceTable"),
                                   p(em("The trade balance table shows the net difference between exports and imports. 
                                         Negative values signal a trade deficit, which implies that Sri Lanka is importing more than it's exporting. 
                                         These deficits have contributed to the country’s broader debt and currency crises.")),
                                   p(em("The direction and magnitude of the trade balance is a critical lens into foreign reserve adequacy and future economic growth potential. 
                                         It often influences exchange rate decisions, interest rate settings, and eligibility for loans or international relief."))
                                 )
                               ),
                               
                               card(
                                 card_header("📊 Economic Summary Statistics"),
                                 card_body(
                                   tableOutput("summaryStats"),
                                   p(em("This table summarizes Sri Lanka’s key economic indicators between 2012 and 2023. 
                                         Each metric offers insight into a different aspect of the country’s financial health over this turbulent decade.")),
                                   tags$ul(
                                     tags$li(strong("Inflation (Mean %): "), "The average annual inflation rate over the period. A higher mean suggests prolonged cost-of-living pressures, affecting food, fuel, and basic services."),
                                     tags$li(strong("Inflation (Max %): "), "The highest recorded inflation rate, peaking in 2022 during the economic crisis. It marks the most intense period of price volatility."),
                                     tags$li(strong("GDP (Mean): "), "The average Gross Domestic Product per year, measured in billions of Sri Lankan Rupees. It reflects the country’s productive output, combining agriculture, industry, and services."),
                                     tags$li(strong("GDP (Max): "), "The highest GDP recorded in any single year, often before or after economic shocks. It helps identify the country’s economic peak."),
                                     tags$li(strong("Avg Exports: "), "The average value of goods and services sold abroad each year. Steady or rising exports are crucial for earning foreign currency."),
                                     tags$li(strong("Avg Imports: "), "The average annual value of imported goods and services. High import values without matching export growth contribute to trade imbalance."),
                                     tags$li(strong("Avg Trade Balance: "), "This value shows the mean difference between exports and imports over time. A negative number means the country consistently spent more on imports than it earned from exports, signaling a chronic trade deficit."),
                                     hr(),
                                     h3("🔎 Key Takeaway"),
                                     card(
                                       full_screen = TRUE,
                                       card_header("Wrapping It Up"),
                                       card_body(
                                         p("Sri Lanka's economic challenges are not isolated incidents but a culmination of structural issues such as chronic trade deficits, volatile inflation, and declining GDP. These stressors were magnified during the 2020–2022 crisis, exacerbating currency depreciation and reducing foreign reserves."),
                                         p("This dashboard integrates visualizations, data summaries, and interactivity to present a holistic view of Sri Lanka's economic health over the last decade. 
                       By engaging with the data, users can appreciate how macroeconomic trends influence everyday life, and how policy missteps can trigger large-scale consequences.")
                                       )
                                     )
                                     
                                   )
                                 )
                               )
                      ),
                      
                      tabPanel("Images",
                               h3("Sri Lanka: A Glimpse Through Crisis and Geography", style = "text-align:center;"),
                               fluidRow(
                                 column(6,
                                        card(
                                          card_header("Topographic Map of Sri Lanka"),
                                          card_body(
                                            tags$img(src = "map.jpg", height = "300px", style = "display:block; margin:auto;"),
                                            p("This topographic map highlights Sri Lanka’s mountainous central region, surrounded by flatter coastal plains. 
                                               The varied terrain plays a role in climate and agriculture patterns, influencing economic sectors like tea, rubber, and rice.")
                                          )
                                        )
                                 ),
                                 column(6,
                                        card(
                                          card_header("Protests in Colombo (2022)"),
                                          card_body(
                                            tags$img(src = "protest.jpg", height = "300px", style = "display:block; margin:auto;"),
                                            p("In 2022, massive public demonstrations erupted in Colombo as citizens protested soaring inflation, fuel shortages, and government mismanagement. 
                                               These protests culminated in the resignation of top political leaders and reshaped the country’s governance landscape.")
                                          )
                                        )
                                 )
                               ),
                               fluidRow(
                                 column(6,
                                        card(
                                          card_header("Sri Lankan Currency (LKR)"),
                                          card_body(
                                            tags$img(src = "rupee.jpg", height = "300px", style = "display:block; margin:auto;"),
                                            p("The Sri Lankan Rupee (LKR) saw steep depreciation during the economic crisis. 
                                               These 1000 LKR notes became symbolic of purchasing power erosion, with basic necessities becoming increasingly unaffordable.")
                                          )
                                        )
                                 ),
                                 column(6,
                                        card(
                                          card_header("Colombo Inflation Chart – 2022"),
                                          card_body(
                                            tags$img(src = "inflation.jpg", height = "300px", style = "display:block; margin:auto;"),
                                            p("This chart shows the acceleration of inflation throughout 2022, with consumer prices climbing over 50%. 
                                               It reflects the central bank's struggles to stabilize prices amid conflicting policy goals and dwindling foreign reserves.")
                                          )
                                        )
                                 )
                               )
                      ),
                      
                      tabPanel("About",
                               h3("Sri Lanka Through an Economic Lens "),
                               p("This interactive dashboard explores Sri Lanka’s economic landscape from 2012 to 2023, focusing on inflation, GDP growth, and trade performance. Created for MA415 Island Exploration project at Boston University."),
                               
                               h4("\U0001F310 Objective"),
                               p("To visualize Sri Lanka's crisis period using time-series data, interactive visuals, and storytelling through economic indicators. The goal was to make complex data accessible, engaging, and interpretable."),
                               
                               h4("\U0001F4C1 Data Sources"),
                               tags$ul(
                                 tags$li(HTML('Inflation: <a href="https://data.worldbank.org/indicator/FP.CPI.TOTL.ZG?locations=LK" target="_blank">World Bank</a>')),
                                 tags$li(HTML('GDP: <a href="https://www.cbsl.gov.lk/en/statistics/economic-indicators" target="_blank">Central Bank of Sri Lanka</a>')),
                                 tags$li(HTML('Trade: <a href="https://comtradeplus.un.org/" target="_blank">UN Comtrade</a>'))
                               ),
                               
                               h4("\U0001F6E0\uFE0F Tools Used"),
                               tags$ul(
                                 tags$li("R, Shiny, ggplot2, Leaflet, tidyverse"),
                                 tags$li("renderTable, selectInput, bs4 cards, tabsets"),
                                 tags$li("bs_theme for custom styling and theming")
                               ),
                               
                               h4("\U0001F39B\uFE0F Interactive Features"),
                               tags$ul(
                                 tags$li("Year selector for trade analysis"),
                                 tags$li("Dynamic summary statistics table"),
                                 tags$li("Detailed insights with section-specific descriptions"),
                                 tags$li("Takeaway summary card to synthesize findings"),
                                 tags$li("Image gallery capturing geographic and political context"),
                                 tags$li("Downloadable data table feature for deeper exploration")
                               ),
                               
                               h4("\U0001F4F1 Mobile Friendly"),
                               p("The layout uses fluid components and Bootstrap 5 themes to ensure mobile responsiveness, making the app accessible across devices."),
                               
                               h4("\U0001F4CA Key Insights"),
                               tags$ul(
                                 tags$li("Sri Lanka has faced compounding economic stressors, including global commodity shocks, fiscal mismanagement, and weak export resilience."),
                                 tags$li("Inflation peaked dramatically in 2022, eroding consumer purchasing power and destabilizing the rupee."),
                                 tags$li("GDP growth reversed after the pandemic, especially impacting tourism and services."),
                                 tags$li("Chronic trade deficits highlight the structural imbalance in Sri Lanka’s economy."),
                                 tags$li("The interactive dashboard offers a lens into how data can tell human-centered stories about crisis and recovery.")
                               ),
                               
                               h4("\U0001F469\u200D\U0001F4BB Author"),
                               p("Lavanya Menon | Boston University | MA415 | Spring 2025")
                      )
                      
                               )
                      )
                    )
                  )
                


# Server
server <- function(input, output, session) {
  inflation_data <- read_csv("data/inflation_data.csv")
  gdp_data <- read_csv("data/gdp_sri_lanka.csv")
  trade_data <- read_csv("data/trade_data.csv")
  trade_data$Trade_Balance <- trade_data$Exports - trade_data$Imports
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("sri_lanka_trade_data.csv")
    },
    content = function(file) {
      write.csv(trade_data, file, row.names = FALSE)
    }
  )
  
  # Inflation Line Plot 
  output$inflationPlot <- renderPlot({
    ggplot(inflation_data, aes(x = Year, y = Inflation_Rate)) +
      geom_line(color = "firebrick", linewidth = 1.2) +
      geom_point(color = "black") +
      geom_vline(xintercept = 2022, linetype = "dashed", color = "blue", linewidth = 1) +
      annotate("text", x = 2021.7, y = max(inflation_data$Inflation_Rate, na.rm = TRUE),
               label = "2022 Crisis", color = "blue", angle = 90, hjust = 1.1) +
      labs(title = "Sri Lanka Inflation Rate Over Time", x = "Year", y = "Inflation Rate (%)") +
      theme_minimal()
  })
  
  
  
  
  # GDP Plot 
  output$gdpPlot <- renderPlot({
    ggplot(gdp_data, aes(x = Year, y = GDP)) +
      geom_col(fill = "steelblue") +
      geom_vline(xintercept = 2022, linetype = "dashed", color = "blue", linewidth = 1) +
      annotate("text", x = 2021.7, y = max(gdp_data$GDP, na.rm = TRUE),
               label = "2022 Crisis", color = "blue", angle = 90, hjust = 1.1) +
      labs(title = "Sri Lanka's GDP Over Time", x = "Year", y = "GDP (in Billion LKR)") +
      theme_minimal()
  })
  
  
  
  # Trade Plot 
  output$tradePlot <- renderPlot({
    ggplot(trade_data, aes(x = Year)) +
      geom_line(aes(y = Exports, color = "Exports"), linewidth = 1.2) +
      geom_line(aes(y = Imports, color = "Imports"), linewidth = 1.2) +
      geom_vline(xintercept = 2022, linetype = "dashed", color = "blue", linewidth = 1) +
      annotate("text", x = 2021.7, y = max(trade_data$Imports, na.rm = TRUE),
               label = "2022 Crisis", color = "blue", angle = 90, hjust = 1.1) +
      scale_color_manual(values = c("Exports" = "darkgreen", "Imports" = "firebrick")) +
      labs(title = "Sri Lanka Exports vs. Imports", x = "Year", y = "USD (in Billion)", color = "Legend") +
      theme_minimal()
  })
  
  
  
  # Interactive trade data 
  selectedYear <- reactive({ input$trade_year })
  output$tradeTable <- renderTable({ subset(trade_data, Year == selectedYear(), select = c("Year", "Imports", "Exports")) })
  output$balanceTable <- renderTable({ subset(trade_data, Year == selectedYear(), select = c("Year", "Trade_Balance")) })
  
  summary_stats <- tibble(
    Metric = c("Inflation (Mean %)", "Inflation (Max %)", "GDP (Mean)", "GDP (Max)",
               "Avg Exports", "Avg Imports", "Avg Trade Balance"),
    Value = c(
      round(mean(inflation_data$Inflation_Rate, na.rm = TRUE), 2),
      round(max(inflation_data$Inflation_Rate, na.rm = TRUE), 2),
      round(mean(gdp_data$GDP, na.rm = TRUE), 0),
      round(max(gdp_data$GDP, na.rm = TRUE), 0),
      round(mean(trade_data$Exports, na.rm = TRUE), 0),
      round(mean(trade_data$Imports, na.rm = TRUE), 0),
      round(mean(trade_data$Trade_Balance, na.rm = TRUE), 0)
    )
  )
  output$summaryStats <- renderTable({ summary_stats })
  
  output$sriMap <- renderLeaflet({
    leaflet() %>% addTiles() %>%
      setView(lng = 80.7718, lat = 7.8731, zoom = 6) %>%
      addMarkers(lng = 80.7718, lat = 7.8731, popup = "Sri Lanka 🇱🇰")
  })
}




# Run the app
shinyApp(ui = ui, server = server)
