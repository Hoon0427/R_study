x<-c(20,11,33,50,47)
sort(x)
sort(x,decreasing = TRUE)
x

order(x)
order(x,decreasing = TRUE)
iris[order(iris$Sepal.Length),]
iris[order(iris$Sepal.Length,iris$Petal.Length),]
