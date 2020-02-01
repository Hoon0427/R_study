sum(1:10)
d<-matrix(1:9, ncol=3)
d

apply(d,1,sum)
apply(d,2,sum)

head(iris)
apply(iris[, 1:4], 2, sum)

colSums(iris[, 1:4])

(result<-lapply(1:3, function(x) { x*2 }))
result[[1]]

unlist(result)

(x<-list(a=1:3, b=4:6))
lapply(x,mean)

lapply(iris[, 1:4], mean)

colMeans(iris[, 1:4])

d<-as.data.frame(matrix(unlist(lapply(iris[, 1:4], mean)), 
                         ncol=4, byrow=TRUE))
names(d) <- names(iris[, 1:4])
d

data.frame(do.call(cbind, lapply(iris[, 1:4], mean)))

x<-list(data.frame(name="foo", value=1),
        data.frame(name="bar", value=2))
unlist(x)

x<-list(data.frame(name="foo", value=1),
        data.frame(name="bar", value=2))
do.call(rbind,x)
