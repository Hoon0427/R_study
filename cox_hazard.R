# install.packages("survival")
# iinstall.packages("survminer")

# if(!require(devtools)) install.packages("devtools")
# devtools::install_github("kassambara/survminer")

library(survival)
library(survminer)
library(readxl)

diabetes <- read_excel('C:/Users/LENOVO/Desktop/엔사이크 사업관련/6. 모아젠/df_clean_deci_phase_d-bmi+index_color.xlsx')


colnames(diabetes)


coxph.fit <- coxph(Surv(dm) ~ sex + age + glu + tchl + tg + bmigr + hsi + fib4 + homa + 
                     hba1c + nafld + AS1_CREATININE + AS1_ALBUMIN + AS1_R_GTP + AS1_HDL + 
                     AS1_PLAT_N + AS1_FLI, data=diabetes)
summary(coxph.fit)

# 데이터를 다시 짜야함함
# phase 시기별로 해야함 >> as1, as2 등등 
