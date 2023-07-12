#### SETUP ####
library(tidyverse)
library(xml2)

df <- read.csv("Dec_lsoa_grocery.csv")

#### WORKING WITH XML ####
selected_cols <- c("area_id", "fat", "saturate", "salt", "protein", "sugar", "carb", "fibre", "alcohol")

df[selected_cols]

#extract first row
row1 <- df |> slice(1)

# create root node
tesco_data_xml <- xml_new_root("data", .encoding = "UTF-8")
tesco_data_xml

# extract the first row
row1 <- df %>% slice(1)

# the encoding is not compulsory
temp <- xml_new_root("data")
temp

# create new XML node
area_node <- xml_new_root("area", area_id = row1 |> pull(area_id))
area_node

# create new XML node PART 4
nutrient_node <- xml_new_root("nutrient", nutrient_name = row1 |> pull(nutrient_name))

# add children to node
for(nutrient_name in selected_cols[-1]){
  xml_add_child(area_node, nutrient_name, row1 |> pull(nutrient_name))
}

area_node

# add area node as a child to root
xml_add_child(tesco_data_xml, area_node)

# saving the file
write_xml(tesco_data_xml, "sample_tesco_data.xml")

get_area_node <- function(row){
  row <- data.frame(row)
  area_node <- xml_new_root("area", area_id = row |> pull(area_id))
  
  for(nutrient_name in selected_cols[-1]){
    xml_add_child(area_node, nutrient_name, row |> pull(nutrient_name))
  }
  
  return(area_node)
}

# part 3 
tesco_data_xml2 <- xml_new_root("data", .encoding = "UTF-8")
for(i in 1:10 ){
  tesco_data_xml2 |> xml_add_child(get_area_node(df[i, ]))
}

write_xml(tesco_data_xml2, "sample_tesco_data2.xml")

tesco_data_xml2
tesco_data_xml3 <- read_xml("sample_tesco_data.xml")
tesco_data_xml3

