library(dplyr)
library(readxl)

data_03 <- read_excel('/Users/LENOVO/Downloads/diff_each_phase_02 (1).xlsx', sheet = 3)
head(data_03)

y <- c(data_03$hsi_521,data_03$hsi_532,data_03$hsi_543,data_03$hsi_554)

length(data_03$hsi_521)

n <- rep(82, 4)

group <- rep(1:4, n)

group_df <- data.frame(y,group)

sapply(group_df, class)

group_df <- transform(group_df, group = factor(group))
sapply(group_df, class)

attach(group_df)

bartlett.test(y ~ group, data = group_df)
