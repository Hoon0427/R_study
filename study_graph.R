str(iris)
plot(iris)

plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width")

plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",main="iris")

plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch="20")

plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch="+")

plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch=20,cex=.5)

plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch=20,cex=2, col="blue")

min(iris$Sepal.Length)
max(iris$Sepal.Length)
min(iris$Sepal.Width)
max(iris$Sepal.Width)


plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch=20,cex=2,
     xlim=c(4,8.5),ylim=c(1.5,5))


plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch=20,cex=2, 
     xlim=c(min(iris$Sepal.Length),max(iris$Sepal.Length)),ylim=c(min(iris$Sepal.Width),max(iris$Sepal.Width)))




plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch=20,cex=2, xlim=c(4,8.5),ylim=c(1.5,5),type="l")
plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch=20,cex=2, xlim=c(4,8.5),ylim=c(1.5,5),type="b")
plot(iris$Sepal.Length, iris$Sepal.Width,xlab="Sepal.Length",ylab="Sepal.width",pch=20,cex=2, xlim=c(4,8.5),ylim=c(1.5,5),type="o")

data(cars)
str(cars)
plot(cars)

plot(cars,type="l")
