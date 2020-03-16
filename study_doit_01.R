library(ggplot2)
str(midwest)
head(midwest,5)

library(dplyr)
midwest <- rename(midwest, total=poptotal)
midwest <- rename(midwest, asian=popasian)

midwest$백분율 <- ((midwest$asian/midwest$total)*100)
str(midwest)

mid_mean <- mean(midwest$백분율)

size_midwest <- ifelse(midwest$백분율>= mid_mean, "lagrge","small")
hist(midwest$백분율)

midwest$size <- size_midwest

str(midwest)

table(midwest$size)
