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
  tags$style("@import url(https://use.fontawesome.com/releases/v6.1.1/css/all.css);"),
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
      column(8,
             #verbatimTextOutput('x4'),
             fluidRow(
               column(9, 
                      img(src = "PP_logotyp_ANG_RGB.png", 
                          height="100%", width="100%"),
                      style = "padding:20px;"),
               
               column(3,
                      style = "font-size:18px; padding-top:12px",
                      actionButton("spelllist", NULL, 
                                   style = "height:52px; width:52px; 
                                   background-color:#8c44c1;
                                   color:white;
                                   border:none",
                                   icon = icon("fa-solid fa-book", class = NULL, 
                                               lib = "font-awesome",
                                               verify_fa = FALSE,
                                               style="font-size: 32px; color:white")),
                      actionButton("charts", NULL, 
                                   style = "height:52px; width:52px; 
                                   background-color:#8c44c1;
                                   color:white;
                                   border:none",
                                   icon = icon("fa-solid fa-chart-simple", class = NULL, 
                                               lib = "font-awesome",
                                               verify_fa = FALSE,
                                               style="font-size: 32px; color:white")),
                      actionButton("info", NULL, 
                                   style = "height:52px; width:52px; 
                                   background-color:#8c44c1;
                                   color:white;
                                   border:none",
                                   icon = icon("fa-solid fa-question", class = NULL, 
                                               lib = "font-awesome",
                                               verify_fa = FALSE,
                                               style="font-size: 32px; color:white")),
                      
                      
                      fluidRow(
                        column(4, align="right",
                               style = "font-size:18px; padding-top:16px",
                               "Specific class:"
                        ),
                        column(4, align="left",
                               style = "font-size:18px; width:140px; padding-top:12px",
                               selectInput("classpicker", NULL, 
                                           #selectize = FALSE,
                                           #size = 10,
                                           c("Any", "Artificer", "Bard", "Cleric",
                                             "Druid", "Paladin", "Ranger",
                                             "Sorcerer", "Warlock", "Wizard"))
                        )
                      ),
               )
             
             ),
             
             tabsetPanel(
               id = "textPanel",
               type = "hidden",
               tabPanelBody("spelllist", 
                 fluidRow( 
                   column(6, offset = 3,
                                     #icon("calendar", class = NULL, lib = "font-awesome"),
                     textOutput("spellname"),
                     align = 'center',
                     style = "font-size:24px; font-weight: bold, vertical-align:top"
                   )
                 ),
                 fluidRow(
                   column(12, textOutput("spelldescription"), align = 'justify', 
                          style = "font-size:18px; height:56vh; word-wrapping:normal;
                      padding-top:10px; padding-left:16px; padding-right:16px;"
                          )
                 ),
                 
                 fluidRow(
                   column(4, #style = "width:40vw",
                          
                          fluidRow(
                            column(1, align="right", style = "; padding-right:24px",
                              icon("fa-solid fa-crosshairs", class = NULL, 
                                   lib = "font-awesome",
                                   verify_fa = FALSE,
                                   style="font-size: 28px; color:black")
                            ),
                            column(10, align="left", textOutput("range"), 
                                   style = "font-size:18px"
                            )
                          ),
                          
                          fluidRow(
                            column(1, align="right", style = "; padding-right:24px",
                              icon("fa-solid fa-wand-magic-sparkles", class = NULL, 
                                lib = "font-awesome",
                                verify_fa = FALSE,
                                style="font-size: 28px; color:black")
                            ),
                           column(10, align="left", textOutput("casttime"), 
                                  style = "font-size:18px"
                           )
                          ),
                          
                          
                          fluidRow(
                            column(1, align="right", style = "; padding-right:24px",  
                                   icon("fa-solid fa-hourglass", class = NULL, 
                                        lib = "font-awesome",
                                        verify_fa = FALSE,
                                        style="font-size: 28px; color:black")
                            ),
                            column(10, align="left", textOutput("duration"), 
                              style = "font-size:18px"
                            )
                          )
                    ),
                   column(6,
                          fluidRow(
                            column(1, align="right", style = "; padding-right:24px",  
                                   icon("fa-solid fa-landmark", class = NULL, 
                                        lib = "font-awesome",
                                        verify_fa = FALSE,
                                        style="font-size: 28px; color:black")
                            ),
                            column(10, align="left", textOutput("spellschool"), 
                                   style = "font-size:18px"
                            )
                       ),
                       fluidRow(
                         column(1, align="right", style = "; padding-right:24px",  
                                icon("fa-solid fa-stairs", class = NULL, 
                                     lib = "font-awesome",
                                     verify_fa = FALSE,
                                     style="font-size: 28px; color:black")
                         ),
                         column(10, align="left", textOutput("spelllevel"), 
                                style = "font-size:18px"
                         )
                       ),
                       fluidRow(
                         column(1, align="right", style = "; padding-right:24px",  
                                icon("fa-solid fa-coins", class = NULL, 
                                     lib = "font-awesome",
                                     verify_fa = FALSE,
                                     style="font-size: 28px; color:black")
                         ),
                         column(10, align="left", textOutput("cost"), 
                                style = "font-size:16px"
                         )
                       )
                   ),
                   
                   column(2, #style = "vertical-align:bottom",
                          plotOutput("components", height = "60px", width = "120px")
                   )
                 ),
                 fluidRow(
                   column(1, align="right", style = "; padding-right:24px",  
                          icon("fa-solid fa-hat-wizard", class = NULL, 
                               lib = "font-awesome",
                               verify_fa = FALSE,
                               style="font-size: 28px; color:black")
                   ),
                   column(10, align="left", textOutput("spellclasses"), 
                          style = "font-size:18px")
                 )
                 
               ),
               tabPanelBody("charts",
                            plotOutput("chartschool"),
                            plotOutput("chartlevel")),
               
               tabPanelBody("info", 
                 fluidRow(
                   column(6, 
                          fluidRow(
                            column(6, offset = 3,
                                   align="center",
                                   style = "font-size:24px; font-weight: bold, 
                                   vertical-align:top",
                                   "About")
                          )
                   ),
                   column(6, 
                          fluidRow(
                            column(6, offset = 3,
                                   align="center",
                                   style = "font-size:24px; font-weight: bold, 
                                   vertical-align:top",
                                   "Help")
                          )
                   )
                 )
               )
               
               
             )
      
      ),
      column(4,
             
             fluidRow(
                DT::dataTableOutput("mytable"),
                style = "padding-top:20px; padding-right:20px"
             )
      )
    )
    
    
))
