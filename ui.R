
library(shiny)
# library(shinyIncubator)

shinyUI(fluidPage(

  # Google Analytics
  tags$head(includeScript("google-analytics.js")),

  # Application title
  headerPanel("RDD interface"),
  
  # Sidebar with a slider and selection inputs
  sidebarPanel(width = 3,
               fileInput('data', 'Choose file to upload'),
               hr(),
               h4("Variables selection"),
               uiOutput("colnames_y"),
               uiOutput("colnames_x"),
               numericInput('cutpoint', 'Cutpoint:', 0),
               actionButton("update","Run model")
  ),
  
  # Show Results
  mainPanel(
    h4("Model choices"),
    selectInput('estim', 'Estimator:', choices=c("Parametric", "Non-parametric")),
    conditionalPanel(
      condition = "input.estim == 'Parametric'",
      sliderInput("param", "Smoothing parameter:", 
                  min = 0,  max = 5,  value = 1)),
    conditionalPanel(
      condition = "input.estim == 'Non-parametric'",
      sliderInput("param2", "Smoothing parameter:", 
                  min = 0.01,  max = 2,  value = 0.1)),
    h4("Plot"),
    plotOutput("plot"),
    h4("Results"),
    tableOutput("stats")
  )
))

