library(nnet)
(m<-multinom(Species ~., data=iris))

head(fitted(m))

predict(m, newdata=iris[c(1, 51, 101), ], type="class")

predict(m, newdata=iris, type="probs")

predicted <- predict(m, newdata=iris)
sum(predicted == iris$Species) / NROW(predicted)

xtabs(~ predicted + iris$Species)
