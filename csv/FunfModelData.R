library(readr)
library(dplyr)
library(ggplot2)
library(caret)
calls <- read_csv("~/Desktop/Gravity/funf-Practice-Models/csv/calls.csv")
total_calls = 13035
messages <- read_csv("~/Desktop/Gravity/funf-Practice-Models/csv/messages.csv")
presences <- read_csv("~/Desktop/Gravity/funf-Practice-Models/csv/presences.csv")

#playing with calls
calls_incoming = calls[calls$direction == "Incoming", c("user", "duration")]
total_incom_calls = 3167
summary(calls_incoming)

calls_outgoing = calls[calls$direction == "Outgoing", c("user", "duration")]
total_out_calls = 8044
summary(calls_outgoing)

calls_missed = calls[calls$direction == "Missed", c("user", "duration")]
total_missed_calls = 1824


summary(calls$duration)

#playing with messages
msgs_incoming = messages[messages$direction == "Incoming", c("user", "length")]
total_incoming_msgs = 43839
summary(msgs_incoming)

msgs_outgoing = messages[messages$direction == "Outgoing", c("user", "length")]
total_out_msgs = 39703
summary(msgs_outgoing)

summary(messages$length)

#change messages$direction into numeric
calls = calls %>% mutate(direction = (ifelse(direction == "Incoming", 0, ifelse(calls$direction == "Outgoing", 1, 2))))
calls$direction = as.numeric(calls$direction)

#ggplot
ggplot(calls, aes(x = direction, y = duration, color = direction)) + geom_point(alpha = 0.5) + labs(title = "Duration of Calls Per Direction", x = "Direction", y = "Duration")

Call_Duration = ggplot(calls, aes(x = duration, y = user, color = duration)) + geom_point(alpha = 0.5) + labs(title = "Duration of Phone Calls Per User", x = "Duration of call in seconds", y = "User")
Call_Duration+scale_color_gradient(low="blue", high="red")

ggplot(callstest, aes(x = direction, y = duration, color = direction)) + geom_point(alpha = 0.5) +labs(title = "Duration of Phone Calls Per User")

class(calls$user)

#Attempts to plot precences
View(presences)
ggplot(presences, aes(x = name)) + geom_bar() 

#Models
lm_test = lm(duration ~ direction, calls)

ggplot(calls, aes(x = user, stat = "count", fill = user)) + geom_bar() + coord_flip() + labs(title = "Total Calls Per User", x = "User", y = "Amount of Calls")
Calls_Count + scale_color_gradient(low = "blue", high = "red")


ggplot(calls, aes(x = user,fill = cut)) +
  geom_density(position = "stack")

geom_bar(aes(fill = drv), position = position_stack(reverse = TRUE)) +
  coord_flip() +
  theme(legend.position = "top")

#mssgs
ggplot(messages, aes(x = direction, y = length, color = direction)) + geom_point(alpha = 0.5) + labs(title = "Length of Msgs Per Direction", x = "Direction", y = "Number of Charcters")
