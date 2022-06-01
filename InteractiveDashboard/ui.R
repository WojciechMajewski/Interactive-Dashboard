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
             #verbatimTextOutput('x4'),
             
             fluidRow(
                column(8, offset = 2, textOutput("spellname"), align = 'center', style = "font-size:30px; ")
             ),
             fluidRow(
               column(1, textOutput("spelllevel"), style = "font-size:18px; padding:10px"),
               column(1, textOutput("spellschool"), style = "font-size:18px; padding:10px"),
               column(10, textOutput("spellclasses"), 
                      align = 'right', style = "font-size:18px; padding:10px")
             ),
             fluidRow(
               column(10, offset=1, textOutput("spelldescription"), 
                      align = 'justify', style = "font-size:16px;")
             )#,
             #img(src = "PP_logotyp_ANG_RGB.png", height="100%", width="100%")
      
      )
    )
    
    
))
