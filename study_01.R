# install.packages("readxl")
# install.packages("dplyr")
library(readxl)
library(dplyr)

test <- read_excel("C:/Users/LENOVO/Desktop/test.xlsx")


head(test)

summary(test)

colnames(test)

colnames(test) <- c("01","당뇨","03","04","05","06","07","08","09","10","11",
                    "12","13","14","15","16","17","18","19","20")

head(test)
test <- test[-1,]
test <- test[,-1]
test <- test[-2,]

is.na(test)
test <- na.omit(test)

is.na(test)

head(test)
tail(test)

test_01 <- data.frame(test)

str(test_01)

fit <- lm( 당뇨 ~. , data = test)
plot(당뇨~., data=test)
plot(fit)
summary(fit)

as.matrix(test)

str(test)

