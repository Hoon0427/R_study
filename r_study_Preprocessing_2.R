
install.packages("caret")
library(caret)
library(mlbench)
data(Soybean)
nearZeroVar(Soybean, saveMetrics=TRUE)

nearZeroVar(Soybean)
mySoybean <- Soybean[, -nearZeroVar(Soybean)]

library(mlbench)
library(caret)
data("Vehicle")
findCorrelation(cor(subset(Vehicle, select=-c(Class))))

cor(subset(Vehicle,select=-c(Class)))[c(3,8,11,7,8,2),c(3,8,11,7,9,2)]

myVehicle<-Vehicle[,-c(3,8,11,7,9,2)]


install.packages("FSelector")
library(FSelector)
