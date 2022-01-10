# Appsilon-biodiversity

## DATA
I used the first 1M rows of the occurence.csv (because of the disk limitation of the aws server). I then subset only European data to focus the dataset.

I stored the data into a Postgresql database for ease of access

## MAKING THE APP FAST
a) I used the `memoise()` function from the memoise library to fasten the functions of the app
b) I used the cache function `bindEvents` to also cache the inputs variables

## DEPLOYMENT
The app + the daatabase was deployed on aws linux server using shiny-server.

Go here to view the live dashboard: http://3.145.72.161:3838/Appsilon-biodiversity/biodiversity
