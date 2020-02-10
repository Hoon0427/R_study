(m<-lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data=iris)) 

summary(m) 

(m<-lm(Sepal.Length ~ ., data=iris)) 
summary(m) 


model.matrix(m)[c(1, 51, 101), ]



anova(m) 


with(iris, plot(Sepal.Width, Sepal.Length, 
                cex=.7,
                pch=as.numeric(Species)))
as.numeric(iris$Species) 


m<-lm(Sepal.Length ~ Sepal.Width + Species, data=iris) 
coef(m)



abline(2.25, 0.80, lty=1) 
abline(2.25+1.45,0.80,lty=2)
abline(2.25+1.94,0.80,lty=3)

legend("topright", levels(iris$Species), pch=1:3, bg="white")
levels(iris$Species)


with(iris, plot(Sepal.Width, Sepal.Length, 
                cex=.7,
                pch=as.numeric(Species)))

coef(m)
abline(2.25, 0.80, lty=1) 
abline(2.25 + 1.45, 0.80, lty=2) 
abline(2.25 + 1.94, 0.80, lty=3) 
legend("topright", levels(iris$Species), pch=1:3, bg="white")


x<-1:1000
y<-x^2 + 3 * x + 5 + rnorm(1000) 
lm(y ~ I(x^2) + x) 


lm(y ~ x^2) 


x1 <- 1:1000 
x2 <- 3 * x1 
y <- 3 * (x1 + x2) + rnorm(1000) 
lm(y ~ I(x1 + x2)) 



lm(y ~ x1 + x2) 

x<-101:200
y<-exp(3 * x + rnorm(100))
lm(log(y) ~ x)


x<-101:200
y<-log(x) + rnorm(100)
lm(y ~ log(x))



data(Orange)
Orange

with(Orange,
     plot(Tree, circumference, xlab="tree", ylab="corcumference"))

with(Orange, interaction.plot(age, Tree, circumference))


m<-lm(circumference ~ fTree * age, data=Orange)
anova(m)


head(model.matrix(m))


mm<-model.matrix(m)
mm[,grep("age",colnames(mm))]
