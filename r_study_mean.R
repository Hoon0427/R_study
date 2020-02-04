mean(1:5)
var(1:5)
sum((1:5-mean(1:5))^2)/(5-1)
sd(1:5)


fivenum(1:11)
summary(1:11)


fivenum(1:4)
summary(1:4)


(x <- factor(c("a", "b", "c", "c", "c", "d", "d")))
table(x)
which.max(table(x))
names(table(x))[3]

