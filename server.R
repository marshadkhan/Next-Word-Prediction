
######## function to establish user interface for Shiny app
## Coursera Capstone Project
# created by: Arshad
# 
# the goal of this code is to create the right layout for my shiny app

#source("D:\DS\data_products\mak_capstone/func_word.R")
source("func_word.R")

shinyServer(function(input, output) {
    output$twitter_next <- renderText({
        hope <- as.character(gfun(as.character(input$text)))
    })
    
    
    
    
})

