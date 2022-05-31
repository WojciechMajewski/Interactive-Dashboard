#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
data <- read.csv("dnd-spells.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
  output$mytable = DT::renderDataTable({
    subset(data, select = c(name, level, school), 
    options = list(scrollX=TRUE, scrollCollapse=TRUE))
  })

})
