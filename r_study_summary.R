str(mtcars)

describe(mtcars)

summary(mtcars)


summary(mpg ~ cyl + hp, data=mtcars)  # method의 기본값은 response다.

summary(cyl ~ mpg + hp, data=mtcars, method="reverse")

summary(mpg ~ cyl + hp, data=mtcars, fun=var)

summary(mpg ~ cyl + hp, data=mtcars, method="cross") 

plot(iris)
plot(iris$Sepal.Length)
plot(iris$Species)

plot(Species ~ Sepal.Length, data=iris)


with(iris,{
  plot(Sepal.Length, Sepal.Width,pch=as.numeric(Species))
  legend("topright",legend=levels(iris$Species),pch=1:3)})

install.packages("caret")
library(caret)
featurePlot(iris[,1:4],iris$Species,"ellipse")
