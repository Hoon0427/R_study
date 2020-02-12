library(nnet)
m <- nnet(Species ~., data=iris, size=3) # 은닉층 노드 수 = 3

predict(m, newdata=iris)
predict(m, newdata=iris, type="class")

class.ind(iris$Species)

m2 <- nnet(iris[, 1:4], class.ind(iris$Species), size=3,
           softmax=TRUE)
predict(m2, newdata=iris[, 1:4], type="class")


install.packages("kernlab")
library(kernlab)
(m <- ksvm(Species ~ ., data=iris))

head(predict(m, newdata=iris))

ksvm(Species ~., data=iris, kernel="vanilladot")

(m <- ksvm(Species ~., data=iris, kernel="polydot", kpar=list(degree=3)))

install.packages("e1071")
library(e1071)
tune(svm, Species ~., data=iris, gamma=2^(-1:1), cost=2^(2:4))

attributes(result)

result$best.parameters

result$best.parameters["gamma"]

result$best.parameters["cost"]