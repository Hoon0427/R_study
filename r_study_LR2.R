table(survey$W.Hnd)
chisq.test(table(survey$W.Hnd), p=c(.3, .7))


shapiro.test(rnorm(1000))


ks.test(rnorm(100), rnorm(100))

ks.test(rnorm(100), runif(100))

ks.test(rnorm(1000), "pnorm", 0, 1)


x<-rnorm(1000, mean=10, sd=1)
qqnorm(x)
qqline(x,lty=2)


x<-runif(1000)
qqnorm(x)
qqline(x,lwd=2)


qqplot(runif(1000, min=1, max=10), 1:10)
