#### SETUP ####
library(tidyverse)

df <- read_csv("Dec_lsoa_grocery.csv")

#### FILTER
df |> filter(area_id == "E01004735") # for rows


selected_cols <- c("area_id", "population", "avg_age", "area_sq_km", "carb", "sugar", "alcohol", "saturate", "fat")
newdftd <- df |> select(all_of(selected_cols)) # for cols

newdftd <- newdftd |> arrange(desc(alcohol))
newdftd <- newdftd |> arrange(desc(sugar))

slice() #more versatile
head() # both for getting certian rows
top-n() # to get top rows these 3 are interchangeable
View(newdftd)