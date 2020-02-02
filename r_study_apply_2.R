lapply(iris[,1:4], mean)

sapply(iris[,1:4], mean)

class(sapply(iris[,1:4], mean))  

x<-sapply(iris[,1:4], mean)

as.data.frame(x)

as.data.frame(t(x))

sapply(iris,class)

y<-sapply(iris[,1:4], function(x) {x>3})
class(y)

head(y)

tapply(1:10, rep(1,10), sum)

tapply(1:10, 1:10 %% 2 == 1, sum)

tapply(iris$Sepal.Length, iris$Species, mean)

m<-matrix(1:8,
          ncol=2,
          dimnames=list(c("spring","summer","fall","winter"),
                        c("male","female")))
m

tapply(m,list(c(1,1,2,2,1,1,2,2),
              c(1,1,1,1,2,2,2,2)),sum)

rnorm(10, 0, 1)

mapply(rnorm,
       c(1,2,3),
       c(0,10,100),
       c(1,1,1))

mapply(mean, iris[, 1:4])
