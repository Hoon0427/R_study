install.packages("cvTools")
library(cvTools)
cvFolds(10,K=5,type="random")

cvFolds(10, K=5,type="consecutive")
cvFolds(10,K=5,type="interleaved")

set.seed(719)
(cv<-cvFolds(NROW(iris),K=10,R=3))

head(cv$which,20)
head(cv$subset)

(validation_idx <- cv$subset[which(cv$which == 1), 1])

train <- iris[-validation_idx, ]
validation <- iris[validation_idx, ]


library(foreach)
set.seed(719)
R = 3
K = 10
cv <- cvFolds(NROW(iris), K=K, R=R)
foreach(r=1:R) %do% {
  foreach(k=1:K,combine=c)%do%{
    validation_idx<-cv$subsets[which(cv$which==k),r]
    train<-iris[-validation_idx,]
    validation<-iris[validation_idx]
    # 데이터 전처리
    
    #모델 훈련
    
    #예측
    
    #성능 평가
    return(성능 값)
  }
}
#foreach의 반환 값으로부터 성능이 가장 뛰어난 모델링 방법 식별
#아이리스 데이터 전체에 대해 해당 방법으로 모델 생성


library(caret)
(parts<-createDataPartition(iris$Species,p=0.8))
table(iris[parts$Resample1, "Species"])

table(iris[-parts$Resample1, "Species"])

createFolds(iris$Species, k=10)

createMultiFolds(iris$Species, k=10, times=3)


k<-10
times<-3
set.seed(137)
cv<-createMultiFolds(iris$Species,k,times)
for(i in 1: times){
  for (j in 1:k){
    train_idx<-cvNaN
    iris.train<-iris[train_idx, ]
    iris.validation<-iris[-train_idx, ]
    #모델링 수행
    
    #평가
    
  }
}