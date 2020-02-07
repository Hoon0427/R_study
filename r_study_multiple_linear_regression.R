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
