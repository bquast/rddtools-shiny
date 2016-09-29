library(rddtools)
library(stringr)


## mat code: runApp("/home/matifou/Dropbox/Matt-Amit/try2",display.mode = "showcase")
myTxt <- "This is our 3rd edition of most of these plays.  See the index.
Copyright laws are changing all over the world, be sure to check
the copyright laws for your country before posting these files!!
  rther information is included below.  We need your donations."


shinyServer(function(input, output) {
  
  observe({
    if(!is.null(input$data)){
      path <- input$data[1,4]
      ext <- str_extract(path, "\\.[aA-zZ]+$")
      ext <- tolower(ext)
      
      ## specify function and library to use
      read_fun <- switch(ext, ".csv"=read_csv, ".xls"=read_excel, ".xslx"=read_excel, 
                         ".dta"=read.dta, ".sav"=read_sav, ".sas"=read_sas)
      read_lib <- switch(ext, ".csv"="readr", ".xls"="readxl", ".xslx"="readxl", 
                         "haven")
      ## import the file
      library(read_lib, character.only=TRUE)
      datas <- read_fun(path)
    } else {
      data("house")
      datas <- house
    }
    output$colnames_y <- renderUI({
      selectInput("colnames_y", "Outcome variable", rev(colnames(datas)))
    })
    output$colnames_x <- renderUI({
      selectInput("colnames_x", "Forcing variable", colnames(datas))
    })

    if (input$update){
      
      ## Declare data 
      rd<- rdd_data(x=datas[,input$colnames_x], y=datas[,input$colnames_y], cutpoint=0)
      
      ## estimation
      if(input$estim=="Parametric"){
        mod <- rdd_reg_lm(rd, order=input$param)
      } else {
        mod <- rdd_reg_np(rd, bw=input$param2)
      }
      
      output$plot <- renderPlot({
        ## result
        plot(mod)

      })
      output$stats <- renderTable({
        mod_sum <- summary(mod)
        coefMat <- if(input$estim=="Parametric") mod_sum$coefficients else mod_sum$coefMat
        coefMat["D",,drop=FALSE]
      })
    }
  })
})


