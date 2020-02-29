library("randomForest")
model <- randomForest(x = iris[, 1:4], y = iris$Species)
summary(model)

plot(model)

pred = predict(model, iris)
head(pred)

table(pred, iris$Species)

head(iris)

aggregate(data = iris, . ~ Species, FUN = "mean")

predict(model, data.frame(Sepal.Length = 6.588, 
                          Sepal.Width = 2.974,
                          Petal.Length = 5.552,
                          Petal.Width = 2.026))



model2 <- randomForest(x = iris[, 1:4], y = iris$Species, importance = TRUE)
varImpPlot(model2)
