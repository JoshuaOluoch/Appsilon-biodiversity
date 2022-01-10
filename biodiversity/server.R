library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)


set.seed(100)

function(input, output, session) {

  ## Interactive Map ###########################################

 
  
  # Create the map
  output$map1 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 33.87478, lat = 53.08414, zoom = 4)
  })
  
  #A reactive expression that returns the correct data
  datuse<- reactive({
    if(is.null(input$verc_names) && is.null(input$sci_names)){
      return(init_data())
    }else if(!is.null(input$verc_names)){
      return(init_data() %>% filter(vernacularName==input$verc_names))
    }else{
      return(init_data() %>% filter(scientificName==input$sci_names))
    }
  })
  
  

  observe({
    #pal <- colorpal()
    if(is.null(input$verc_names) && is.null(input$sci_names)){
      datuse =init_data()
    }else if(!is.null(input$verc_names)){
      datuse =init_data() %>% filter(vernacularName==input$verc_names)
    }else{
      datuse=init_data() %>% filter(scientificName==input$sci_names)
    }
    
    leafletProxy("map1", data = unique(datuse %>% select(vernacularName,longitudeDecimal,latitudeDecimal))) %>%
      clearShapes() %>%
      addCircleMarkers(lng = ~longitudeDecimal, lat = ~latitudeDecimal, 
                       popup = ~vernacularName)
      
  })
  
  output$freq <- renderText(
    nrow(unique(datuse() %>% select(vernacularName,longitudeDecimal,latitudeDecimal)))
  )
  
}
