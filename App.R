library(shiny)
library(shinydashboard)
library(varhandle)
source("call_plots.R")
df_primary <- readRDS("data/001_global_primary_energy.RDS")

ui <- dashboardPage(
  dashboardHeader(title = "Dashboard framework"),
  dashboardSidebar(
    sidebarMenu(
      sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                        label = "Search..."),
      menuItem("Normal", tabName = "normal", icon = icon(name ="angle-right" , lib = "font-awesome")),
      menuItem("Uniform", tabName = "uniform", icon = icon(name ="angle-right" , lib = "font-awesome"))
      
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "normal",
              fluidRow(
                box(title = "Instructions",
                    p("On how to read this dashboard"),
                    strong("To have a colored bar on the top of the box use"), 
                    code("solidheader = TRUE"),
                    width = 6,
                    collapsible = TRUE
                ),
                tabBox(
                  # Title can include an icon
                  title = tagList(icon("gas-pump" , lib = "font-awesome"), "Global primary energy consumption"),
                  width = 4,
                  tabPanel("Tab1",
                           "Currently selected tab from first box:",
                           verbatimTextOutput("tabset1Selected")
                  ))),
              fluidRow(
                tabBox(
                  # Title can include an icon
                  title = tagList(icon("gas-pump" , lib = "font-awesome"), "Global primary energy consumption"),
                  width = 6,
                  tabPanel("Absolute", plotOutput("abs_001")),
                  tabPanel("Relative", plotOutput("rel_001")),
                  tabPanel("Per capita", plotOutput("cap_001"))
                  
                  
                ),
                tabBox(
                  # Title can include an icon
                  title = tagList(icon("gas-pump" , lib = "font-awesome"), "Primary energy consumption per source"),
                  width = 6,
                  tabPanel("Absolute", plotOutput("abs_002")),
                  tabPanel("Relative", plotOutput("rel_002")),
                  tabPanel("Per capita", plotOutput("cap_002"))
                  
                  
                )
              ),
              
              fluidRow(
                box(title = "Select period", sliderInput("date_001", label =  NULL, min = 1800, 
                                                         max = 2019, value = c(1800, 2019), sep =""),
                    width = 4
                ),
                box(
                  title = "Title 5", textOutput("value")
                ),
                box(
                  title = "Title 6", width = 4, background = "maroon",
                  "A box with a solid maroon background"
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "uniform",
              h2("Widgets tab content")
      )
    ),
    skin = "blue"
  )
)

server <- function(input, output) {
  min_data_001 <- reactive({input$date_001[1]})
  max_data_001 <- reactive({input$date_001[2]})
  output$value <- renderText({ input$number + 10})
  output$cap_001 <- renderPlot({plot_001( df_primary, y = "cons_per_capita", date_min = min_data_001(), date_max = max_data_001())})
  output$abs_001 <- renderPlot({plot_001( df_primary, y = "consumption", date_min = min_data_001(), date_max = max_data_001() )})
  output$rel_001 <- renderPlot({plot_001( df_primary, y = "cons_relative", date_min = min_data_001(), date_max = max_data_001())})
  
  output$cap_002 <- renderPlot({plot_002( df_primary, y = "cons_per_capita")})
  output$abs_002 <- renderPlot({plot_002( df_primary, y = "consumption" )})
  output$rel_002 <- renderPlot({plot_002( df_primary, y = "cons_relative")})
  
}

shinyApp(ui, server)