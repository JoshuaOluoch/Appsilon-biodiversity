library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(tidyverse)

#DB connection
library(RPostgreSQL)
library(DBI)
library(memoise)

#Europe map coordinates

#Wanted to use shiny continent filter, selected Europe instead

#df2 <- filter(df, Region == input$region)

function(input, output, session){
  #Speed up the vernacularNames and ScientificNames Input selecters
  pgdrv <- dbDriver(drvName = "PostgreSQL")
  db <-DBI::dbConnect(pgdrv,
                      dbname="biodiversity",
                      host="3.145.72.161", port=5432,
                      user = 'postgres',
                      password = 'Kennedyj.2022!')
  
  
  ### Interactive Map ###########################################
  
  # Create the map
  output$map <- renderLeaflet({
    #leaflet() %>%
     # addTiles() %>%
      #setView(lng = 33.87478, lat = 53.08414, zoom = 4)
    leaflet(data = quakes[1:20,]) %>% addTiles() %>%
      addMarkers(~long, ~lat, popup = ~as.character(mag), label = ~as.character(mag))
  })
  
  dataset<-reactive({ 
    if(is.null(input$verc_names) && is.null(input$sci_names)){
      dat = init_data()
    }else if(!is.null(input$verc_names)){
      dat = tibble(DBI::dbGetQuery("SELECT id,kingdom,family,\"higherClassification\",\"vernacularName\",\"longitudeDecimal\",\"latitudeDecimal\",\"eventDate\",country FROM occurence WHERE \"vernacularName\"=  ",input$verc_names,";"))
    }else if(!is.null(input$sci_names)){
      dat = tibble(DBI::dbGetQuery("SELECT id,kingdom,family,\"higherClassification\",\"vernacularName\",\"longitudeDecimal\",\"latitudeDecimal\",\"eventDate\",country FROM occurence WHERE \"vernacularName\"=  ",input$sci_names,";"))
    }
    selected_ver <- isolate(input$verc_names)
    updateSelectizeInput(session, "verc_names", choices = vernacularNames,
                         selected = selected_ver, server = TRUE)
    selected_sci <- isolate(input$sci_names)
    updateSelectizeInput(session, "sci_names", choices = scientificNames,
                         selected = selected_sci, server = TRUE)
    
    
  })%>% bindCache(input$verc_names, input$sci_names)
  
  
  
}