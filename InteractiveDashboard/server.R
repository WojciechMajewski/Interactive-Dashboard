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
shinyServer(function(input, output, session) {
  
  observeEvent(input$spelllist, {
    updateTabsetPanel(session, "textPanel", selected = "spelllist")
  })
  observeEvent(input$charts, {
    updateTabsetPanel(session, "textPanel", selected = "charts")
  })
  observeEvent(input$info, {
    updateTabsetPanel(session, "textPanel", selected = "info")
  })
  
  output$mytable = DT::renderDataTable({
    #data <- read.csv("dnd-spells.csv")
    
    if(input$classpicker == "Any"){
      DT::datatable(
        subset(
          data,
          select = c(name, level, school)
        ),
        colnames = c("Spell Name" = "name", "Tier" = "level", "Spellschool" = "school"),
        rownames = FALSE,
        caption = htmltools::tags$caption(
          style = 'caption-side: bottom; text-align: center;', htmltools::em('Click on a spell to learn all about it!')
        ),
        selection = "single",
        options = list(
          dom = 't',
          #dom = 'tf',
          autoWidth = FALSE,
          paging = FALSE,
          #scrollY="80vh",
          scrollY="90vh",
          scrollX=TRUE,
          columnDefs=list(list(width="20px",targets=c(1,2)),
                          list(width="200px",targets=c(0))),
          scrollCollapse=TRUE,
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#526', 'color': '#ff5'});",
            "}"
          )
        )
      )
    }
    
    
    else{
      DT::datatable(
        subset(
          data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
          select = c(name, level, school)
        ),
        colnames = c("Spell Name" = "name", "Tier" = "level", "Spellschool" = "school"),
        rownames = FALSE,
        caption = htmltools::tags$caption(
          style = 'caption-side: bottom; text-align: center;', htmltools::em('Click on a spell to learn all about it!')
        ),
        selection = "single",
        options = list(
          dom = 't',
          #dom = 'tf'
          autoWidth = FALSE,
          paging = FALSE,
          #scrollY="80vh",
          scrollY="90vh",
          scrollX=TRUE,
          columnDefs=list(list(width="20px",targets=c(1,2)),
                          list(width="200px",targets=c(0))),
          scrollCollapse=TRUE,
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#526', 'color': '#ff5'});",
            "}"
          )
        )
      )
      
    }
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
    
    # If NO specific class is picked
    if(input$classpicker == "Any"){ 
      # If a spell is picked
      if(length(input$mytable_rows_selected)){
        data[input$mytable_rows_selected, "name"]
      }
      # If a spell is NOT picked
      else{
        "Pick a spell"
      }
      
    }
    # If specific class is picked
    else{
      # If a spell is picked
      if(length(input$mytable_rows_selected)){
        subset(
          data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
          select = c(name)
        )[input$mytable_rows_selected, "name"]
      }
      # If a spell is NOT picked
      else{
        "Pick a spell"
      }
    }
  })
  
  output$spelllevel = renderText({
    if(input$classpicker == "Any"){
      
      if(length(input$mytable_rows_selected)){
        paste("Tier: ", 
              data[input$mytable_rows_selected, "level"])
      }
      else{
        "Tier: -"
      }
    }
    else{
      if(length(input$mytable_rows_selected)){
        paste("Tier: ", 
              subset(
                data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
                select = c(level)
              )[input$mytable_rows_selected, "level"])
      }
      else{
        "Tier: -"
      }
      
    }
  })
  
  output$spellschool = renderText({
    if(input$classpicker == "Any"){
      
      if(length(input$mytable_rows_selected)){
        paste("Spell school: ", 
          data[input$mytable_rows_selected, "school"]
        )
      }
      else{
        "Spell school: -"
      }
    }
    else{
      
      if(length(input$mytable_rows_selected)){
        paste("Spell school: ", 
          subset(
            data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
            select = c(school)
          )[input$mytable_rows_selected, "school"]
        )
      }
      else{
        "Spell school: -"
      }
    }
  })
  
  output$spellclasses = renderText({
    if(input$classpicker == "Any"){
      
      if(length(input$mytable_rows_selected)){
        data[input$mytable_rows_selected, "classes"]
      }
    }
    else{
      
      if(length(input$mytable_rows_selected)){
        subset(
          data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
          select = c(classes)
        )[input$mytable_rows_selected, "classes"]
      }
    }
  })
  
  output$spelldescription = renderText({
    if(input$classpicker == "Any"){
      
      if(length(input$mytable_rows_selected)){
        data[input$mytable_rows_selected, "description"]
      }
    }
    else{
      
      if(length(input$mytable_rows_selected)){
        subset(
          data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
          select = c(description)
        )[input$mytable_rows_selected, "description"]
      }
    }
  })
  
})
