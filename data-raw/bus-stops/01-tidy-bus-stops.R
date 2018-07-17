library(tidyverse)

bris_min_lat <- c(-27.5282)
bris_max_lat <- c(-27.4322)
bris_min_long <- c(152.9702)
bris_max_long <- c(153.0952)

stops <- read_csv("data-raw/bus-stops/bus-stops-raw.csv") %>% 
  janitor::clean_names()  %>%
  rename(lat = latitude,
         long = longitude) %>%
  mutate(btn_both = between(lat, 
                            bris_min_lat,
                            bris_max_lat) & 
           between(long, 
                   bris_min_long,
                   bris_max_long)) %>%
  filter(btn_both) %>%
  rename(lat = lat,
         long = long) %>%
  select(-easting,
         -northing)

write_csv(stops, "data-raw/bus-stops/stops-tidy.csv")

library(leaflet)

# EDA --------------------------------------------------------------------------

bus_stops %>%
  leaflet() %>%
  addCircles() %>%
  addTiles()
