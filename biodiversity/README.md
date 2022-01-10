# Biodiversity Shiny Application

This app is found in aws repository, with a shiny server.

See the live app here :http://3.145.72.161:3838/Appsilon-biodiversity/biodiversity

## Speeding up the app
a) I used only the first 1M rows and subset for European observations. I was limited with disk space in my aws server.
b) I had both the data(in a postgresql) and the shiny server in the aws server. 
c) I also used memoise function in the memoise package to speed up some queries from the postgresql database
d) I also used cache function(bindEvent) to cache all the inputs
```
#Install required packages
install.packages('shiny', 'leaflets','tidyverse','RColorBrewer','lattice','scales','RPostgreSQL','DBI','memoise')
```
@Joshua Oluoch
