install.packages("mlbench")

library(mlbench)
data(BreastCancer)
table(BreastCancer$Class)


install.packages("caret")
library(caret)
x <- upSample(subset(BreastCancer, select=-Class), BreastCancer$Class)
table(BreastCancer$Class)
table(x$Class)

NROW(x)
NROW(unique(x))

install.packages("rpart")

library(party)
# Id는 식별자므로 피처로는 적절치 않아 제외한다. 그렇지 않으면 Id에 따라 예측을 수행하는
# 의미 없는 모델이 만들어진다.
data<-subset(BreastCancer,Select=-Id)
parts<-createDataPartition(data$Class,p=.8)# 80%의 훈련 데이터와 20%의 테스트 데이터
data.train <- data[parts$Resample1,]
data.test <- data[-parts$Resample1, ]
m <- rpart(Class ~., data=data.train)
confusionMatrix(data.test$Class,
                predict(m,newdata=data.test,type="class"))
                

data.up.train <- upSample(subset(data.train, select=-Class),
                          data.train$Class)
m <- rpart(Class ~., data=data.up.train)
confusionMatrix(data.test$Class,
                predict(m, newdata=data.test, type="class"))


data(iris)
data<-iris[,c(1,2,5)]
data$Species<-factor(ifelse(data$Species=="setosa","rare","common"))
table(data$Species)

install.packages("DMwR")
library(DMwR)
newData<-SMOTE(Species ~., data, perc.over=600, perc.under=100)
table(newData$Species)
