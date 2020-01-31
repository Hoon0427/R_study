rbind(c(1,2,3),c(4,5,6))

(x<-data.frame(id=c(1,2),name=c("a","b"),stringsAsFactors=F))
str(x)
(y<-rbind(x,c(3,"c")))

cbind(c(1,2,3),c(4,5,6))

(y<-cbind(x,greek=c("alpha","beta")))
str(y)

y<-cbind(x, greek=c("alpha", "beta"), stringsAsFactors=F)
str(y)
