library(shiny)
library(shinydashboard)

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
                box(title = "Select country", checkboxGroupInput(inputId = "checkGroup", label = NULL, 
                                                                            choices = list("Choice 1" = 1, 
                                                                                           "Choice 2" = 2, 
                                                                                           "Choice 3" = 3),
                                                                            selected = 1))),

              fluidRow(
                tabBox(
                  # Title can include an icon
                  title = tagList(icon("sliders-h" , lib = "font-awesome"), "tabBox status"),
                  width = 4,
                  tabPanel("Tab1",
                           "Currently selected tab from first box:",
                           verbatimTextOutput("tabset1Selected")
                  ),
                  tabPanel("Tab2", "Tab content 2")
                ),
                infoBox("New Orders", 10 * 2, icon = icon("cc-visa"), width = 4),
                infoBox("New Orders", 50, icon = icon("credit-card"), fill = TRUE)
              ),
              
              fluidRow(
                box(title = "Numeric input", numericInput("number", label = NULL , value = 1),
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
    )
  ),
  skin = "blue"
)

server <- function(input, output) {
  output$value <- renderText({ input$number + 10})
}

shinyApp(ui, server)