
library(shiny)
# library(shinyIncubator)

shinyUI(fluidPage(
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
               # textInput
               h4("Model choices"),
               selectInput('estim', 'Estimator:', choices=c("Parametric", "Non-parametric")),
               numericInput('param', 'Smoothing parameter:', 1),
               actionButton("update","Run model")
  ),
  
  # Show Results
  mainPanel(
    h4("Plot"),
    plotOutput("plot"),
    h4("Results"),
    tableOutput("stats")
  )
))

