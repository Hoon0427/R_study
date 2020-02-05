sample(1:10,5)

sample(1:10,5,replace=TRUE)

sample(1:10, 5, replace=TRUE, prob=1:10)
sample(1:10, 5, replace=TRUE, prob=1:10)
sample(1:10, 5, replace=TRUE, prob=1:10)

install.packages("sampling")

library(sampling)
(x<-strata(c("Species"), size=c(3, 3, 3), method="srswor", data=iris))
getdata(iris, x)

strata(c("Species"), size=c(3, 1, 1), method="srswr", data=iris)


iris$Species2 <- rep(1:2, 75) # 1, 2, 1, 2, ..., 1, 2
strata(c("Species", "Species2"), size=c(1, 1, 1, 1, 1, 1), method="srswr", data=iris)
