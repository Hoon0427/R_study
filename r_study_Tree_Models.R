install.packages("rpart") 
library(rpart)
(m <- rpart(Species ~., data=iris))

plot(m, compress=TRUE, margin=.2)
text(m, cex=1.5)

install.packages("rpart.plot")
library(rpart.plot)
prp(m, type=4, extra=2, digits=3)

head(predict(m, newdata=iris, type="class"))


install.packages("party")
library(party)
(m <- ctree(Species ~., data=iris))

plot(m)

levels(iris$Species)


install.packages("randomForest")
library(randomForest)
m <- randomForest(Species ~., data=iris)

m

head(predict(m, newdata=iris))

m <- randomForest(iris[,1:4], iris[,5])

m <- randomForest(Species ~., data=iris, importance=TRUE)
importance(m)

varImpPlot(m, main="varImpPlot of iris")


(grid <- expand.grid(ntree=c(10, 100, 200), mtry=c(3, 4)))

library(cvTools)
library(foreach)
library(randomForest)
set.seed(719)
K = 10
R = 3
cv <- cvFolds(NROW(iris), K=K, R=R)
grid <- expand.grid(ntree=c(10, 100, 200), mtry=c(3, 4))
result <- foreach(g=1:NROW(grid), .combine=rbind) %do% {
  foreach(r=1:R, .combine=rbind) %do% {
    foreach(k=1:K, .combine=rbind) %do% {
      validation_idx <- cv$subsets[which(cv$which == k), r]
      train <- iris[-validation_idx, ]
      validation <- iris[validation_idx, ]
      # 모델 훈련
      m <- randomForest(Species ~.,
                        data=train,
                        ntree=grid[g, "ntree"],
                        mtry=grid[g, "mtry"])
      # 예측
      predicted <- predict(m, newdata=validation)
      # 성능 평가
      precision <- sum(predicted == validation$Species) / NROW(predicted)
      return(data.frame(g=g, precision=precision))
    }
  }
}

result


library(plyr)
ddply(result, .(g), summarize, mean_precision=mean(precision))


grid[c(4, 6), ]
