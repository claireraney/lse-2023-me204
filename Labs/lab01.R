#### SETUP ####
df <- read.csv("Dec_lsoa_grocery.csv")

View(df)

#### FILTER ####
a <- df[df["area_id"] == "E01004735", ]

b <- c("area_id", "population", "avg_age", "area_sq_km", "carb", "sugar", "alcohol", "saturate", "fat")
newdf <- df[b]
View(newdf)

df2 <- newdf[order(newdf$alcohol), ]

df3 <- newdf[order(newdf$sugar), ]
