library(readr)
library(ggplot2)
library(RColorBrewer)
senseit_3_5 <- read_csv("senseit_3_5.csv") #load senseit csv file into a dataframe
sep<- split(senseit_3_5, f=senseit_3_5[, "Sensor"]) #split the data frame by sensor type
#renaming the sensor tables
orientation=sep$`0`
location=sep$`1`
accelometer=sep$`2`
light=sep$`3`
sound=sep$`4`

#working with the location data
location$Z = NULL #removes blank Z column
colnames(location)[2] = "latitude" #add column names
colnames(location)[3] = "longitude"

#filter out the rows where the location is within the longitude and the latitude of the foundry
fd1<- location %>% filter(latitude<-33.911994 & longitude>18.418049)
foundry_data.frame<- filter(fd1, latitude> -33.912778 & longitude<18.419229)
foundry_data.frame

#function that checks each row in the found_data.frame to make see whether the location is in the foundry or not
rowcheck  <- function(foundry_data.frame, location){
  xx <- apply(foundry_data.frame, 1, paste, collapse = "")
  yy <- apply(location, 1, paste, collapse = "")
  zz <- xx %in% yy
  return(zz)
}

match<- rowcheck(location, foundry_data.frame) #creates a logical ath sees whether the location is in the foundry or not
match = as.data.frame(match) #makes the match into a dataframe
location = cbind(location, match) #cbinds the location data with the match data
colnames(location)[4] = "area" #rename the 4th column
location = location %>% mutate(area = ifelse(area == TRUE, "Foundry", "NA")) #changes TRUE to Foundry, and FALSE to NA

#add a column for the seconds
location$seconds = 0
for(i in 1:nrow(location)){ 
  location$seconds[i] = i
}
ggplot(location, aes(x = latitude, y = longitude, color = area)) + geom_point(alpha = 0.5) #scatterplot of latitude and longitude colored by area
ggplot(location, aes(x = area, fill = area)) + geom_bar() #bar graph of the count of each area

#using Google Map API
library(ggmap)
cape_town = get_map("Cape Town") #as an introduction to ggmap to show you can grab any city from Google Maps
ggmap(cape_town) #to plot a map from GGmap
cape_town = get_map(location = c(18.37,-33.92,18.470,-33.905), maptype = "roadmap") #import grid map around the Foundry
ggmap(cape_town) + geom_point(aes(x = longitude, y = latitude, color = area), data = location, size = .5) #plot the locations on the grid map of the Foundry
time_stamp = ggmap(cape_town) + geom_point(aes(x = longitude, y = latitude, color = seconds), data = location, size = .5) #plots the locations on the grid map of the foundry and the change over time
time_stamp + scale_color_gradientn(colors = rainbow(2)) #changes the color gradient to see the change in time better


#working with accelerometer data
View(accelometer)
acc = ggplot(accelometer, aes(x = X, y = Y, color = Z)) + geom_point() #making plot for the aceelerometer
acc + scale_color_gradientn(colors = rainbow(7)) #plotting the accelerometer with a color_gradient for the accelerometer

#working with sound data
sound$Y = NULL
sound$Z = NULL
colnames(sound)[2] = "decibles" #add column name decibles
sound$seconds = 0
for(i in 1:nrow(sound)){ 
  sound$seconds[i] = i
} #adding seconds to the decibles column

ggplot(sound, aes(x= seconds, y = decibles, color = decibles)) + geom_point(alpha = 0.5) #plotting the sound data



