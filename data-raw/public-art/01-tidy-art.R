library(tidyverse)

art <- read_csv("data-raw/public-art/public-art-raw.csv") %>%
  janitor::clean_names()

# View(art)

write_csv(art, "data-raw/public-art/art-tidy.csv")
