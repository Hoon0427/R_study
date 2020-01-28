(x<-c(1,2,3,4,5))

(x<-c("1",2,"3"))

c(1,2,3)
c(1,2,3,c(1,2,3))

x<-c(1,3,4)
names(x)<-c("kim","seo","park")
x

x<-c("a","b","c")
x[1]
x[-2]

x<-c("a","b","c")
x[c(1,2)]
x[c(1,3)]

x<-c("a","b","c")
x[1:2]
x[1:3]

x<-c(1,3,4)
names(x)<-c("kim","seo","park")
x
x["seo"]
x[c("seo","park")]

names(x)[2]

x<-c("a","b","c")
length(x)
nrow(x)
NROW(x)

identical(c(1,2,3), c(1,2,3))
identical(c(1,2,3), c(1,2,100))

x<-c(1,2,3,4,5)
x+1
10-x
c(1,2,3)==c(1,2,100)
c(1,2,3)!=c(1,2,100)

union(c("a","b","c"), c("a","d"))
intersect(c("a","b","c"), c("a","d"))
setdiff(c("a","b","c"), c("a","d"))

setequal(c("a","b","c"), c("a","d"))
setequal(c("a","b","c"), c("a","b","c","c"))

seq(3,7)         
seq(7,3)
seq(3,7,2)
seq(3,7,3)

3:7
7:3

x<-c(2,4,6,8,10)
1:NROW(x)
seq_along(x)

rep(1:2, times=5)
rep(1:2, each=5)
rep(1:2, times=2, each=5)
