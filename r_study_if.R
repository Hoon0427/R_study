if(TRUE){
  print("TRUE")
  print("hello")
}else{
  print("FALSE")
  print("world")
}


x<-c(1,2,3,4,5)
ifelse(x %%2==0, "even","odd")

for(i in 1:10){print(i)}

i<-1
while(i<=10){
  print(i)
  i<-i+1
  }

help("while")

i<-1
while(i<=10){
  print(i)
  i<-i+1
}

i<-0
while(i<=9){
  i<-i+1
  if (i %% 2!=0){
    next
  }
  print(i)
}

i<-1
repeat{
  print(i)
  if ( i>=10){
    break
  }
  i<-i+1
}

