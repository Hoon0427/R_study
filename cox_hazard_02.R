# install.packages("survival")
# iinstall.packages("survminer")

# if(!require(devtools)) install.packages("devtools")
# devtools::install_github("kassambara/survminer")

library(survival)
library(survminer)
library(readxl)

diabetes <- read_excel('C:/Users/LENOVO/Desktop/엔사이크 사업관련/6. 모아젠/df_clean_deci_phase_d-bmi+index_color_w02.xlsx', 
                       sheet = "total_s5")


colnames(diabetes)


coxph.fit <- coxph(Surv(dm) ~ sex + age + glu + ast + alt + tchl + tg + bmigr + hsi + homa + 
                     hba1c + as1_creatinine_gr + AS1_ALBUMIN + as1_r_gtp_gr + AS1_HDL + 
                     AS1_FLI, data=diabetes)
summary(coxph.fit)

# 데이터를 다시 짜야함함
# phase 시기별로 해야함 >> as1, as2 등등 
