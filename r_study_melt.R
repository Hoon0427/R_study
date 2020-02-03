install.packages("reshape2")
library(reshape2)

head(french_fries)

m<-melt(french_fries,id.vars = 1:4)
head(m)

library(plyr)
ddply(m,.(variable),summarise,mean=mean(value,na.rm=TRUE))

french_fries[!complete.cases(french_fries), ]

m<-melt(id=1:4, french_fries, na.rm=TRUE)
head(m)

m<-melt(french_fries, id.vars=1:4)
r<-dcast(m, time + treatment + subject + rep ~ ...)
rownames(r) <- NULL
rownames(french_fries) <- NULL
identical(r, french_fries)

m<-melt(french_fries, id.vars=1:4)
dcast(m, time ~ variable)

dcast(m, time ~ variable, mean, na.rm=TRUE)

dcast(m, time ~ treatment + variable, mean, na.rm=TRUE)



ddply(m, .(time, treatment, variable), function(rows) {
  return(mean(rows$value, na.rm=TRUE))
})
