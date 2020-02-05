table(c("a", "b", "b", "b", "c", "c", "d")) 

d<-data.frame(x=c("1", "2", "2", "1"),
              y=c("A", "B", "A", "B"), 
              num=c(3, 5, 8, 7)) 

(xtabs(num ~ x + y, data=d)) 


(d2<-data.frame(x=c("A", "A", "A", "B", "B"))) 

(xtabs(~ x, d2)) 


xt<-(xtabs(num ~ x + y, data=d)) 
xt

margin.table(xt, 1)  # 3 + 7 = 10, 8 + 5 = 13 
margin.table(xt, 2)  # 3 + 8 = 11, 7 + 5 = 12 
margin.table(xt)     # 3 + 7 + 8 + 5 = 23 
prop.table(xt, 1)  # xt의 각 행을 각각 10(= 3 + 7), 13(= 8 + 5)로 나눈 값 
prop.table(xt, 2)  # xt의 각 열을 각각 11(= 3 + 8), 12(= 7 + 5)로 나눈 값 
prop.table(xt)     # xt의 각 셀을 전체 데이터의 합 23(= 3 + 7 + 8 + 5)로 나눈 값 


library(MASS) 
data(survey) 
str(survey) 

head(survey[c("Sex", "Exer")]) 


xtabs(~ Sex + Exer, data=survey)

chisq.test(xtabs(~ Sex + Exer, data=survey)) 



xtabs(~ W.Hnd + Clap, data=survey) 
chisq.test(xtabs(~ W.Hnd + Clap, data=survey))


fisher.test(xtabs(~ W.Hnd + Clap, data=survey)) 



## Agresti (1990), p. 350. 
## Presidential Approval Ratings. 
## Approval of the President's performance in office in two 
## surveys, one month apart, for a random sample of 1600 
## voting-age Americans. 
Performance<-
  matrix(c(794, 86, 150, 570), 
         nrow = 2, 
         dimnames = list(
           "1st Survey" = c("Approve", "Disapprove"), 
           "2nd Survey" = c("Approve", "Disapprove"))) 
Performance
mcnemar.test(Performance)


binom.test(86, 86 + 150, .5) 
