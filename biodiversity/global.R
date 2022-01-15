library(RPostgreSQL)
library(DBI)
library(memoise)
library(tidyverse)

## Loading required package: DBI
pgdrv <- dbDriver(drvName = "PostgreSQL")
db <-DBI::dbConnect(pgdrv,
                    dbname="dbname",
                    host="host", port=5432,
                    user = 'postgres',
                    password = 'password
')



get_vernacularNames <- function(conn=db){
  return(DBI::dbGetQuery(conn=conn,"SELECT DISTINCT \"vernacularName\" FROM occurence;"))
}
ver_func = memoise(get_vernacularNames)

#scientificName
get_scientificName <- function(conn=db){
  return(DBI::dbGetQuery(conn=conn,"SELECT DISTINCT \"scientificName\" FROM occurence;"))
}
sci_func = memoise(get_scientificName)
vernacularNames = ver_func()
scientificNames = sci_func()

get_init_data <- function(conn = db){
  dat = tibble(DBI::dbGetQuery(db,"SELECT id,kingdom,family,\"higherClassification\",\"vernacularName\",\"scientificName\",\"longitudeDecimal\",\"latitudeDecimal\",\"eventDate\",country FROM occurence"))
  dat$year = as.numeric(format(as.Date(dat$eventDate, format='%Y-%m-%d'),'%Y'))
  return(dat)
}


init_data = memoise(get_init_data)

#dat = init_data()


