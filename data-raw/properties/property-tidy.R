library(tidyverse)

add_lat_long <- function(data, 
                         easting,
                         northing,
                         projection){
  
  east <- paste0(friendlyeval::treat_input_as_col(easting))
  north <- paste0(friendlyeval::treat_input_as_col(northing))
  
  lat_long_mat <- 
    sf::st_as_sf(data, 
                 coords = c(east, 
                            north),
                 crs = projection) %>%
    sf::st_transform(crs = 4326) %>% 
    sf::st_coordinates()
  
  colnames(lat_long_mat) <- c("longitude", "latitude")
  
  dplyr::bind_cols(data,
                   as.data.frame(lat_long_mat))
  
}

property <- read_csv("data-raw/properties/properties-raw.csv") %>%
  janitor::clean_names() %>%
  mutate(easting2 = as.numeric(easting), 
         northing2 = as.numeric(northing)) %>%
  # mutliple values given for about 5% of easting + northings, these are removed
  tidyr::drop_na(easting2,
                 northing2) %>%
  add_lat_long(easting2,
               northing2,
               projection = 28356) %>%
  # drop eastings and northings
  select(-northing,
         -easting,
         -northing2,
         -easting2)

# remove data not within the polygon of the bus stops
# load bus stop data
bus_stops <- read_csv(here::here("data-raw/bus-stops/bus-stops-tidy.csv"))

# make the property and bus stops within range of a region of inner brisbane
bris_min_lat <- c(-27.5282)
bris_max_lat <- c(-27.4322)
bris_min_long <- c(152.9702)
bris_max_long <- c(153.0952)

# property
# get the rough "inner city-ish" suburbs
prop <- property %>%
  mutate(btn_both = between(latitude, 
                            bris_min_lat,
                            bris_max_lat) & 
           between(longitude, 
                   bris_min_long,
                   bris_max_long)) %>%
  filter(btn_both) %>%
  rename(lat = latitude,
         long = longitude)


# bus stops
stops <- bus_stops %>%
  mutate(btn_both = between(latitude, 
                            bris_min_lat,
                            bris_max_lat) & 
           between(longitude, 
                   bris_min_long,
                   bris_max_long)) %>%
  filter(btn_both) %>%
  rename(lat = latitude,
         long = longitude)

# possibly shrink down the data to be within 3km of the city
# Or even better - find those places that are within 300m of a bus stop and only
# keep those

# EDA
library(leaflet)

prop %>%
  sample_frac(0.001) %>%
  leaflet() %>%
  addCircles() %>%
  addTiles()
  
library(maxcovr)

dim(prop)
names(prop)

dim(stops)
names(stops)

system.time(
  near_df <- nearest(stops, prop)
)

names(near_df)
names(prop)

plot(near_df$distance)
hist(near_df$distance)
plot(density(near_df$distance))

properties <-
  near_df %>%
  filter(distance <= 100) %>%
  select(distance:btn_both.x) %>%
  rename(street_name = street_name.x,
         suburb = suburb.x,
         long = long_to,
         lat = lat_to) %>%
  select(-btn_both.x,
         -unit_number,
         -house_number,
         -street_suffix,
         -address_use_type,
         -property_description)

write_csv(properties, 
          "data-raw/properties/properties-tidy.csv")

brizzy_properties %>%
  rename(lat = lat_to,
         long = long_to) %>%
  leaflet() %>%
  addCircles() %>%
  addTiles()


