data(Orange)
m<-lm(circumference~age+I(age^2),data=Orange)
rstudent(m)


data(Orange)
Orange<-rbind(Orange,
              data.frame(Tree=as.factor(c(6,6,6)),
                         age=c(118,484,664),
                         circumference=c(177,50,30)))
tail(Orange)

install.packages("car")

m<-lm(circumference~age+I(age^2), data=Orange)
outlierTest(m)
