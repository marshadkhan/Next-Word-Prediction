
######## function to establish user interface for Shiny app
## Coursera Capstone Project
# created by: pmccullo06
# 
# the goal of this code is to create the right layout for my shiny app
library(shiny)

shinyUI(pageWithSidebar(
    
    headerPanel("*** Next Word Prediction ***"),
    
    sidebarPanel(
        
        textInput("text", label = h3("Text input"),
                  value = ""),
        
        h6(em("Instructions::Special characters are not considered as well as english stop words")),
        
        submitButton("Submit")
        
    ),
    
    mainPanel(
       
        
         h4("Next word prediction:"),
        verbatimTextOutput("twitter_next")
    )
    
    
))

