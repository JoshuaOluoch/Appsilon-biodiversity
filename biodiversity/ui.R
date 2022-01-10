library(leaflet)


navbarPage("Biodiversity", id="nav",
  
  tabPanel('Biodiversity',
    div(class="outer",
        tags$head(
          # Include our custom CSS
          includeCSS("styles.css"),
          includeScript("gomap.js")
        ),
        leafletOutput("map1", width="100%", height="100%"),
        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                      width = 330, height = "auto",
                      
                      h2("Filter Species"),
                      selectizeInput(
                        "verc_names", "Vernacular Name", choices =vernacularNames$vernacularName,
                        options = list(placeholder = 'Please select an option below',
                                       onInitialize = I('function() { this.setValue(""); }')
                        )),
                      selectizeInput(
                        'sci_names', 'Scientific Name' , choices=scientificNames$scientificNames,
                        options = list(placeholder = 'Please select an option below',
                         onInitialize = I('function() { this.setValue(""); }')
                        )),
                      br(),
                      h4('Frequency of appearance of the species'),
                      textOutput('freq'),
        )
    )
           
    
  ),

 
)
