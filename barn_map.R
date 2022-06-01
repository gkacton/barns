
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(lubridate)
library(rlang)
library(skimr)
library(magrittr)
library(leaflet) ## For leaflet interactive maps
library(sf) ## For spatial data
library(RColorBrewer) ## For colour palettes
library(htmltools) ## For html
library(leafsync) ## For placing plots side by side
library(kableExtra) ## Table output
library(ggmap) ## for google geocoding

# read data ---------------------------------------------------------------

barns <- read_csv("data/barns_map.csv")


# geocoding ---------------------------------------------------------------

register_google(key = "AIzaSyBJKyY6SoLXHZlJ691STnK20wTleh4O6Aw")

barns <- barns %>% 
  mutate_geocode(location = address, 
                 output = "latlon", 
                 source = "google") 

# leaflet -----------------------------------------------------------------

pin_icon <- makeIcon(
  iconUrl = "https://endlessicons.com/wp-content/uploads/2012/12/pin-map-icon-614x460.png",
  iconWidth = 150
)


barns_map <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(
    data = barns,
    lng = ~lon,
    lat = ~lat,
    icon = pin_icon,
    popup = ~barn
  )

