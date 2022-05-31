#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  tags$head(
  # Note the wrapping of the string in HTML()
    tags$style(HTML("
        body{
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    }"
    ))
  ),

  
    # Application title
    titlePanel("Spell selection"),
    
    fluidRow(
      column(6,
             DT::dataTableOutput("mytable")
      ),
      column(6,
             verbatimTextOutput('x4'),
             textOutput("spellname"),
             textOutput("spelllevel"),
             textOutput("spellschool"),
             textOutput("spellclasses"),
             textOutput("spelldescription")
      )
    )
    
    
))
