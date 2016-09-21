library(rddtools)
library(readr)

## mat code: runApp("/home/matifou/Dropbox/Matt-Amit/try2",display.mode = "showcase")
myTxt <- "This is our 3rd edition of most of these plays.  See the index.
Copyright laws are changing all over the world, be sure to check
the copyright laws for your country before posting these files!!
  rther information is included below.  We need your donations."


shinyServer(function(input, output) {
  
  observe({
    if(!is.null(input$data)){
      datas <<- read_csv(input$data[1,4])
    } else {
      data("house")
      datas <<- house
    }
    output$colnames_y <- renderUI({
      selectInput("colnames_y", "Outcome variable", rev(colnames(datas)))
    })
    output$colnames_x <- renderUI({
      selectInput("colnames_x", "Forcing variable", colnames(datas))
    })
  })
 
  
  observe({
    # Run whenever button is pressed, then stay reactive.
    if (input$update){
      
      ## Declare data 
      rd<- rdd_data(x=datas[,input$colnames_x], y=datas[,input$colnames_y], cutpoint=0)
      
      ## estimation
      if(input$estim=="Parametric"){
        mod <- rdd_reg_lm(rd, order=input$param)
      } else {
        mod <- rdd_reg_np(rd, bw=input$param)
      }
      
      output$plot <- renderPlot({
        ## result
        plot(mod)

      })
      output$stats <- renderTable({
        coef(summary(mod))["D",, drop=FALSE]
      })
    }
  })
})


