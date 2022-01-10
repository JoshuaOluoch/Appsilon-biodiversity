library(dplyr)

allzips <- readRDS("data/superzip.rds")
allzips$latitude <- jitter(allzips$latitude)
allzips$longitude <- jitter(allzips$longitude)
allzips$college <- allzips$college * 100
allzips$zipcode <- formatC(allzips$zipcode, width=5, format="d", flag="0")
row.names(allzips) <- allzips$zipcode

cleantable <- allzips %>%
  select(
    City = city.x,
    State = state.x,
    Zipcode = zipcode,
    Rank = rank,
    Score = centile,
    Superzip = superzip,
    Population = adultpop,
    College = college,
    Income = income,
    Lat = latitude,
    Long = longitude
  )


library(RPostgreSQL)
library(DBI)
library(memoise)
library(tidyverse)

## Loading required package: DBI
pgdrv <- dbDriver(drvName = "PostgreSQL")
db <-DBI::dbConnect(pgdrv,
                    dbname="biodiversity",
                    host="3.145.72.161", port=5432,
                    user = 'postgres',
                    password = 'Kennedyj.2022!')



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


