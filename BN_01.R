# install.packages("bnlearn")
# install.packages("BayesianNetwork")
# https://www.r-bloggers.com/bayesian-network-in-r-introduction/
library(bnlearn)
library(tidyverse)

BayesianNetwork::BayesianNetwork()


diabetes <- read_excel('C:/Users/LENOVO/Desktop/엔사이크 사업관련/6. 모아젠/df_clean_deci_phase_d-bmi+index_color_w02.xlsx', 
                       sheet = "total")
diabetes <- subset(diabetes, select= -id)  # hc 함수가 chr 안먹힘


bn_df <- data.frame(diabetes)
sum(is.na(bn_df))
head(bn_df)
res <- hc(bn_df)   # Hierarchical Clustering 함수


plot(res)

res.fit()
