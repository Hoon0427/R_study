d<-subset(iris,Species=="virginica"|Species=="versicolor")
str(d)

d$Species <- factor(d$Species)
str(d)

(m <- glm(Species ~ ., data=d, family="binomial"))

fitted(m)[c(1:5, 51:55)]


f<-fitted(m)
as.numeric(d$Species)
ifelse(f > .5, 1, 0) == as.numeric(d$Species) - 1

is_correct <- (ifelse(f > .5, 1, 0) == as.numeric(d$Species) - 1)
sum(is_correct)
sum(is_correct) / NROW(is_correct)

predict(m, newdata=d[c(1, 10, 55),], type="response")
