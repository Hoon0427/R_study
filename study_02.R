# install.packages("dplyr")
library(dplyr)

## 데이터 생성 
a <- c("D1","D2","D3","D4","end","AGE1","AGE2","AGE3","AGE4")


b1<- c("1","2","3","4","3","34","35","36","37")
c1 <- c("4","5","6","34","5","23","24","25","26")
d1<- c("8","3","4","435","4","14","15","16","17")
e1 <- c("6","5","43","3","6","41","42","43","45")

asdf <- data.frame(b1, c1, d1, e1) %>% 
  t()


asdf

colnames(asdf) <- a


# 데이터 컬럼 추가 작업
add <- c()

for(i in 1:nrow(asdf)) {
  # 1~4번째 컬럼과 5번째 컬럼을 비교 하여 인덱스를 뽑음
  index_value <- which(asdf[i,1:4] == asdf[i,5])
  
  # 그 인덱스를 6번째에 더해서 필요한 값을 찾아서 add라는 벡터 생성
  add <- c(add, asdf[i,5 + index_value])
}

add

nrow(asdf)

asdf <- asdf %>% 
  as.data.frame()

# for문으로 생성된 add 데이터를 새로운 컬럼으로 생성
asdf$addcol <- add

asdf
