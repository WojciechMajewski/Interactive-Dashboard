#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)

data <- read.csv("dnd-spells.csv")
levelcolorvalues = c("#ead1dc", "#e3c3d1", "#dbb4c6", "#d4a5bb", "#cc97b0", 
                     "#c588a5", "#bd799a", "#b66b8f", "#ae5c84", "#a64d79")
levelcolorbreaks = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
schoolcolorvalues = c("Abjuration" = "#cfe2f3", "Conjuration"="#f4cccc", 
                      "Divination"="#d9ead3", "Enchantment" = "#ead1dc", "Evocation" = "#fce5cd", 
                      "Illusion" = "#d9d2e9", "Necromancy" = "#d9d9d9", "Transmutation" = "#e6b8af")

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
  
  output$chartschool = renderPlot({
    if(input$classpicker == "Any"){
      
      ggplot(data) +
        geom_bar(aes(x = school, fill = school), 
                 stat = "count")  +
        scale_fill_manual(values = schoolcolorvalues) +
        theme(legend.position = "none")
    }
    else{
      
      ggplot(subset(
        data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
        select = c(school)
      )) +
        geom_bar(aes(x = school, fill = school), 
                 stat = "count") +
        scale_fill_manual(values = schoolcolorvalues) +
        theme(legend.position = "none")
    }
  })
  
  output$chartlevel = renderPlot({
    if(input$classpicker == "Any"){
      
      ggplot(data) +
        geom_bar(aes(x = level, fill = factor(level)), 
                 stat = "count") +
        scale_fill_manual(values = levelcolorvalues, breaks = levelcolorbreaks) +
        theme(legend.position = "none") +
        scale_x_continuous(breaks = seq(0, 9))
    }
    else{
      
      ggplot(subset(
        data[grep(paste(input$classpicker, collapse = "|"), data$classes),],
        select = c(level)
      )) +
        geom_bar(aes(x = level, fill = factor(level)), 
                 stat = "count") +
        scale_fill_manual(values = levelcolorvalues, breaks = levelcolorbreaks) +
        theme(legend.position = "none") +
        scale_x_continuous(breaks = seq(0, 9))
    }
  })
  
})
