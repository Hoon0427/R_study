library(dplyr)
library(readxl)

data_01 <- read_excel('/Users/LENOVO/Downloads/diff_each_phase_02 (1).xlsx', sheet = 1)
head(data_01)

y <- c(data_01$hsi_721,data_01$hsi_732,data_01$hsi_743,data_01$hsi_754,data_01$hsi_765,data_01$hsi_776...9)
y

length(data_01$hsi_721)

n <- rep(57, 6)
n
group <- rep(1:6, n)
group

y
group_df <- data.frame(y,group)
group_df

sapply(group_df, class)

group_df <- transform(group_df, group = factor(group))
sapply(group_df, class)

attach(group_df)

bartlett.test(y ~ group, data = group_df)
