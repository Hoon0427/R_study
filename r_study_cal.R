1:5*2+1

x<-c(1,2,3,4,5)
x+1

x<-c(1,2,3,4,5)
x+x
x==x
x==c(1,2,3,5,5)

c(T,T,T)&c(T,F,T)

x<-c(1,2,3,4,5)
sum(x)
median(x)
mean(x)

x<-c(1,2,3,4,5)
ifelse(x %% 2==0, "even", "odd")

(d<-data.frame(x=c(1,2,3,4,5), y=c("a","b","c","d","e")))
d[c(TRUE, FALSE, TRUE, FALSE, TRUE),]

d[d$x %% 2==0,]

NA&TRUE
NA+1

sum(c(1,2,3,NA))
sum(c(1,2,3,NA), na.rm=TRUE)

(x<-data.frame(a=c(1,2,3),b=c("a",NA,"c"),c=c("a","b",NA)))
na.fail(x)
na.omit(x)
na.exclude(x)
na.pass(x)

