library(dplyr)
library(readxl)

data_02 <- read_excel('/Users/LENOVO/Downloads/diff_each_phase_02 (1).xlsx', sheet = 2)
head(data_02)

y <- c(data_02$hsi_621,data_02$hsi_632,data_02$hsi_643,data_02$hsi_654,data_02$hsi_665)

length(data_02$hsi_621)

n <- rep(73, 5)

group <- rep(1:5, n)

group_df <- data.frame(y,group)

sapply(group_df, class)

group_df <- transform(group_df, group = factor(group))
sapply(group_df, class)

attach(group_df)

bartlett.test(y ~ group, data = group_df)
