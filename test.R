library(ggplot2)
library(readxl)

data = read_excel('/Users/Mango/Downloads/df_clean_deci_phase_d-bmi+index_color.xlsx')

head(data)
is.na(data)
sum(is.na(data))

data_02 <- na.omit(data)

head(data_02)
sum(is.na(data_02))

data_02$dm

data_02$dm[331]
data_02$dm[332]

data_03 <- data_02[data_02$dm=='1',]
data_03
summary(data_03)


boxplot(data_03$age)

        