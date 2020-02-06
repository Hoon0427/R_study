data(cars)
head(cars)

(m<-lm(dist ~ speed, cars))

coef(m)

fitted(m)[1:4]

residuals(m)[1:4]

fitted(m)[1:4] + residuals(m)[1:4]

confint(m)

deviance(m)


(m<-lm(dist ~ speed, data=cars))
predict(m, newdata=data.frame(speed=3))
coef(m)



predict(m, newdata=data.frame(speed=c(3)), interval="confidence")

predict(m, newdata=data.frame(speed=c(3)), interval="prediction")
