fibo<-function(n){
  if(n==1||n==2){
    return(1)
  }
  return(fibo(n-1)+fibo(n-2))
}
fibo(1)
fibo(5)

f<-function(x,y){
  print(x)
  print(y)
}
f(1,2)
f(y=1,x=2)

f<-function(...){
  args<-list(...)
  for(a in args){
    print(a)
  }
}
f('3','4')

f<-function(x,y){
  print(x)
  print(y)
}
g<-function(z,...){
  print(z)
  f(...)
}
g(1,2,3)

f<-function(x,y){
  print(x)
  g<-function(y){
    print(y)
  }
  g(y)
}
f(1,2)


f<-function(x1){
  return(function(x2){
    return(x1+x2)
  })
}

g<-f(1)
g(2)
g2<-f(2)
g2(2)
