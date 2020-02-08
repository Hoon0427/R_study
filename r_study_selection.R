install.packages("mlbench")
library(mlbench)
data(BostonHousing)
m<-lm(medv~., data=BostonHousing)
m2<-step(m, direction="both")

formula(m2)


step(m,direction="both")


m2<-step(m,direction="both")
formula(m2)


install.packages("leaps")
library(leaps)
library(mlbench)
data("BostonHousing")
m<-regsubsets(medv~., data=BostonHousing)
summary(m)

summary(m)$bic
summary(m)$adjr2

plot(m,scale="adjr2")
plot(m,scale="bic")
