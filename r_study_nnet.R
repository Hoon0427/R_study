library(nnet)

m<-nnet(Species ~., data=iris, size=3)
predict(m,newdata=iris)

predict(m,newdata=iris, type="class")

class.ind(iris$Species)

m2<-nnet(iris[,1:4],class.ind(iris$Species),size=3,softmax=TRUE)
predict(m2,newdata=iris[,1:4],type="class")
