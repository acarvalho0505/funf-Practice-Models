sep<- split(senseit_3_5, f=senseit_3_5[,"col1"])
orientation=split$'0'
location=sep$`1`
accelometer=sep$`2`
light=sep$`3`
sound=sep$`4`

fd1<- location %>% filter(col3>-33.911994 & col4>18.418049)
foundry_data.frame<- filter(fd1, col3> -33.912778 & col4<18.419229)
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

