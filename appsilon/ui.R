library(shiny)
library(leaflet)
library(RColorBrewer)
#DB

#



navbarPage(
  "Biodiversity", id="nav",
  tabPanel(
    'Biodiversity Map',
    div(class="outer",
        tags$head(# Include our custom CSS
          includeCSS("styles.css"),
          includeScript("gomap.js")
          )),
    fluidRow(
      column(
        3,
        selectizeInput(
          "verc_names", "Vernacular Name", choices =vernacularNames,
          options = list(placeholder = 'Please select an option below',
        onInitialize = I('function() { this.setValue(""); }')
      ))),
      column(
        3,
        selectizeInput(
          'sci_names', 'Scientific Name' , choices=scientificNames,
          options = list(placeholder = 'Please select an option below',
                         onInitialize = I('function() { this.setValue(""); }')
          )
          )),
      column(2,
        actionButton("goButton", "Generate Map")
      )
      
    ),
    hr(),
    # I set the height and width of the leaflet output to the maximum using the custom js
    leafletOutput("map", width="100%", height="100%")
    ),
  tabPanel('Data Exploration'))