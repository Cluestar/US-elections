---
title: "Trend"
author: "Joost Klooster"
date: "27-9-2020"
---
install.packages("tidyverse")
install.packages("lubridate")
install.packages("dygraphs")
install.packages("gtrendsR")
install.packages("dplyr")
install.packages("maps")
install.packages("prophet")

library(tidyverse)
library(lubridate)
library(dygraphs)
library(gtrendsR)
library(dplyr)
library(maps)
library(prophet)

election <- gtrends(keyword=c("Trump", "Biden"), geo="US", time = "today 12-m")

names(election) #shows different data frames

election$interest_by_region %>% #The %>% operator is a 'pipe' operator, which passes data from the output of the function to the left and puts it, by default, into the first parameter of the function on the right. 
  filter(keyword == "Biden") %>% 
  arrange(desc(hits)) #filters on highest to lowest

mappedelection <- election$interest_by_region %>%
  mutate(region = tolower(location)) %>%
  filter(region %in% region,
         keyword == 'Trump') %>%
  select(region, hits) %>%
  arrange(desc(hits))

mappedelection
states_map <- map_data("state")
votes_map <- left_join(states_map, mappedelection, by = "region")

states_map <- map_data("state")
votes_map <- left_join(states_map, mappedelection, by = "region")
ggplot(votes_map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = hits), color = "white")+
  scale_fill_viridis_c(alpha = 1, direction = -1, option = "E")