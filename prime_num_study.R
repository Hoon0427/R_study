





frime_func <- function(x) {
  prime_set <- c()
  for(j in 2:x) {
    count <- 0
    for(i in 1:j) {
      if(j %% i == 0 ) {
        count <- count + 1
      }
    }
    # print(count)
    if(count == 2) {
      # print(j)
      prime_set <- append(prime_set, j)
    }
  }
  return(prime_set)
}


system.time(frime_func(6000))


prime_set <- c()


for(j in 2:1000) {
  count <- 0
  for(i in 1:j) {
    if(j %% i == 0 ) {
      count <- count + 1
    }
  }
  # print(count)
  if(count == 2) {
    # print(j)
    prime_set <- append(prime_set, j)
  }
}

prime_set


for(i in 1:7) {
  if(7 %% i == 0 ) {
    count <- count + 1
  }
}


count
