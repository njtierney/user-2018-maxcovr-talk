# reading in the wifi data
library(tidyverse)

bris_min_lat <- c(-27.5282)
bris_max_lat <- c(-27.4322)
bris_min_long <- c(152.9702)
bris_max_long <- c(153.0952)

wifi <- read_csv("data-raw/wifi/wifi-raw.csv") %>%
  janitor::clean_names() %>%
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
         long = long)

write_csv(wifi, "data-raw/wifi/wifi-tidy.csv")

# EDA --------------------------------------------------------------------------

wifi %>%
  count(site) %>%
  ggplot(aes(x = n,
             y = reorder(site,n))) + 
  geom_point()

library(leaflet)

wifi %>%
  leaflet() %>%
  addCircles() %>%
  addTiles()
