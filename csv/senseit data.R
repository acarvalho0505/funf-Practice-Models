library(readr)
library(ggplot2)
senseit_3_5 <- read_csv("senseit_3_5.csv")
sep<- split(senseit_3_5, f=senseit_3_5[, "Sensor"])
orientation=sep$`0`
location=sep$`1`
accelometer=sep$`2`
light=sep$`3`
sound=sep$`4`

location$Z = NULL
colnames(location)[2] = "latitude" #add column names
colnames(location)[3] = "longitude"

fd1<- location %>% filter(latitude<-33.911994 & longitude>18.418049)
foundry_data.frame<- filter(fd1, latitude> -33.912778 & longitude<18.419229)
foundry_data.frame

rowcheck  <- function(foundry_data.frame, location){
  xx <- apply(foundry_data.frame, 1, paste, collapse = "")
  yy <- apply(location, 1, paste, collapse = "")
  zz <- xx %in% yy
  return(zz)
}

match<- rowcheck(location, foundry_data.frame)
match = as.data.frame(match)
location = cbind(location, match)
colnames(location)[4] = "area"
location = location %>% mutate(area = ifelse(area == TRUE, "Foundry", "NA"))

ggplot(location, aes(x = latitude, y = longitude, color = area)) + geom_point(alpha = 0.5)
ggplot(location, aes(x = area, fill = area)) + geom_bar() #we can visualize how much time a person spends at a 

#using Google Map API
library(ggmap)
cape_town = get_map(location = c(18.37,-33.92,18.470,-33.905), maptype = "roadmap")
ggmap(cape_town) + geom_point(aes(x = longitude, y = latitude, color = area), data = location, size = 1)

