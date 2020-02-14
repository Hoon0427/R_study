library(append)
?append


a<-c(print(i))
b<-c(print(j))



for(j in 1:10){
  if (j%%5==0){
    print(j)
  }
}

for(i in 1:10){
  if(i%%3==0){
    print(i)
  }
}

data.frame(print(i),print(j))

for(i in 1:10){
  if(i%%3==0){
    print(i)
    a<-print(i)
    a<-append(c(a,i))
  }
}
