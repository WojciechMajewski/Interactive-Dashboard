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
    
    fluidRow(
      column(6,
             #verbatimTextOutput('x4'),
             fluidRow(
               img(src = "PP_logotyp_ANG_RGB.png", height="100%", width="100%"),
               style = "padding:30px;"
             ),
             
             fluidRow( 
               column(6, offset = 3,
                      #icon("calendar", class = NULL, lib = "font-awesome"),
                      textOutput("spellname"),
                      align = 'center',
                      style = "font-size:30px; font-weight: bold, vertical-align:top"
               )
             ),
             fluidRow(
               column(1, textOutput("spelllevel"), style = "font-size:18px; padding:10px"),
               column(1, textOutput("spellschool"), style = "font-size:18px; padding:10px"),
               column(10, textOutput("spellclasses"), 
                      align = 'right', style = "font-size:18px; padding:10px")
             ),
             fluidRow(class = "descriptionclass", 
               column(10, offset=1, textOutput("spelldescription"), 
                      align = 'justify', style = "font-size:16px;")
             ),
             
             tags$head(tags$style("
              .descriptionclass{height:64vh;}"
             ))
      
      ),
      column(6,
             
             fluidRow(
               column(6, align="right",
                      "Specific class:",
                      style = "font-size:18px; padding-top:16px"
                      ),
               column(4, align="left", 
                      selectInput("classpicker", NULL, 
                                  #selectize = FALSE,
                                  #size = 10,
                                  c("Any", "Artificer", "Bard", "Cleric",
                                    "Druid", "Paladin", "Ranger",
                                    "Sorcerer", "Warlock", "Wizard")),
                      style = "font-size:18px; width:140px; padding-top:12px"
                      )
              ),
             
             fluidRow(
                DT::dataTableOutput("mytable")
             )
      )
    )
    
    
))
