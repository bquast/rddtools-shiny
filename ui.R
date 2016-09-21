
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
               # checkboxInput("lower", "lower", FALSE),
               # checkboxInput("stem", "Stem", FALSE),
               # hr(),
               # h4("Plotting"),
               # selectInput('colorScheme', 'Color Scheme:', 
               #             choices=c("Accent", "Dark2", "Paired", "Pastel1",
               #                       "Pastel2", "Set1", "Set2", "Set3")),
               # sliderInput("max", "Maximum Number of Words:", 
               #               min = 1,  max = 300,  value = 100),
               # hr(),
               actionButton("update","Run model")
  ),
  
  # Show Word Cloud
  mainPanel(
    h4("Plot"),
    plotOutput("plot"),
    h4("Results"),
    tableOutput("stats")
  )
))

