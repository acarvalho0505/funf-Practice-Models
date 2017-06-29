library(readr)
library(dplyr)
library(ggplot2)
calls <- read_csv("~/Desktop/funf-Practice-Models/csv/calls.csv")
messages <- read_csv("~/Desktop/funf-Practice-Models/csv/messages.csv")
presences <- read_csv("~/Desktop/funf-Practice-Models/csv/presences.csv")

#playing with calls
calls_incoming = calls[calls$direction == "Incoming", c("user", "duration")]
summary(calls_incoming)

calls_outgoing = calls[calls$direction == "Outgoing", c("user", "duration")]
summary(calls_outgoing)

#playing with messages
msgs_incoming = messages[messages$direction == "Incoming", c("user", "length")]
summary(msgs_incoming)
msgs_outgoing = messages[messages$direction == "Outgoing", c("user", "length")]
summary(msgs_incoming)

#ggplot

ggplot(callstest, aes(x = duration, y = user, color = direction)) + geom_point(alpha = 0.5)

ggplot(callstest, aes(x = direction, y = duration, color = direction)) + geom_point(alpha = 0.5)

class(calls$user)

#Attempts to plot precences
View(presences)
ggplot(presences, aes(x = name)) + geom_bar() 
ggplot(presences, aes(x = name)) + geom_bar(aes(y = ..count..), stat = "count")


