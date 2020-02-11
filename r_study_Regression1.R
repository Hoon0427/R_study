predicted<-c(1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1)
actual<-c(1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1)

xtabs( ~ predicted + actual)

sum(predicted == actual) / NROW(actual)

library(caret)
library(lattice)
library(ggplot2)


confusionMatrix(predicted, actual)
f_predicted <- as.factor(predicted)
f_actual <- as.factor(actual)
confusionMatrix(f_predicted, f_actual)
install.packages("e1071")
library(e1071)
confusionMatrix(f_predicted, f_actual)


set.seed(137)
probs<-runif(100)
labels<-as.factor(ifelse(probs>.5&runif(100)<.4,"A","B"))


install.packages("ROCR")
library(ROCR)
pred <- prediction(probs, labels)

plot(performance(pred, "tpr", "fpr"))

# x.measure의 기본값이 cutoff므로 plot(performance(pred, "acc"))로 해도 결과는 같다.
plot(performance(pred, "acc", "cutoff"))


performance(pred, "auc")
