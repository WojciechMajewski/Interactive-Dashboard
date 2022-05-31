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
    DT::datatable(
      subset(
        data, 
        select = c(name, level, school)
      ),
      selection = "single",
      options = list(
        dom = 't',
        #dom = 'tf'
        paging = FALSE,
        scrollY="80vh", 
        scrollCollapse=TRUE,
        initComplete = JS(
          "function(settings, json) {",
          "$(this.api().table().header()).css({'background-color': '#526', 'color': '#ff5'});",
          "}"
        )
      )
      
    )
  })
  
  # print the selected indices
  output$x4 = renderPrint({
    s = input$mytable_rows_selected
    if (length(s)) {
      cat('These rows were selected:\n\n')
      cat(s, sep = ', ')
    }
    else{
      cat('Select a spell!')
    }
  })
  
  output$spellname = renderText({
    if(length(input$mytable_rows_selected)){
      data[input$mytable_rows_selected, "name"]
    }
  })
  
  output$spelllevel = renderText({
    if(length(input$mytable_rows_selected)){
      data[input$mytable_rows_selected, "level"]
    }
  })
  
  output$spellschool = renderText({
    if(length(input$mytable_rows_selected)){
      data[input$mytable_rows_selected, "school"]
    }
  })
  
  output$spellclasses = renderText({
    if(length(input$mytable_rows_selected)){
      data[input$mytable_rows_selected, "classes"]
    }
  })
  
  output$spelldescription = renderText({
    if(length(input$mytable_rows_selected)){
      data[input$mytable_rows_selected, "description"]
    }
  })
  
})
