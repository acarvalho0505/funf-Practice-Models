library(readr)
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

fd1<- location %>% filter(latitude>-33.911994 & longitude>18.418049)
foundry_data.frame<- filter(fd1, latitude> -33.912778 & longitude<18.419229)
foundry_data.frame

rowcheck  <- function(foundry_data.frame, location){
  xx <- apply(foundry_data.frame, 1, paste, collapse = "")
  yy <- apply(location, 1, paste, collapse = "")
  zz <- xx %in% yy
  return(zz)
}

match<- rowcheck(location, foundry_data.frame)

match

as.numeric(match)


location[which(location[,3]< 234, arr.ind = TRUE), 5]<- "Foundry"

location[which(location[,3]>233, arr.ind = TRUE), 5]<- NA

mydata[which(mydata[,3]>500, arr.ind=TRUE), 3] <- NA
       mydata[mydata$var3 > 500, 3] <- NA 

#Write a function to see if you are within Foundry boundaries!

