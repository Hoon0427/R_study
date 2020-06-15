# https://www.r-bloggers.com/bayesian-network-example-with-the-bnlearn-package/
# install.packages("gapminder")

library(bnlearn)
library(ggplot2)
library(gapminder)

diabetes <- read_excel('C:/Users/LENOVO/Desktop/엔사이크 사업관련/6. 모아젠/df_clean_deci_phase_d-bmi+index_color_w02.xlsx', 
                       sheet = "total")
diabetes <- subset(diabetes, select= -id)

