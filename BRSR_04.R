library(data.table)
library(ggplot2)
library(recommenderlab)
library(countrycode)

file_in <- "anonymous-msweb.test"

table_in <- read.csv(file_in, header = FALSE)
head(table_in)

table_users <- table_in[, 1:2]

table_users <- data.table(table_users)

setnames(table_users, 1:2, c("category", "value"))
table_users <- table_users[category %in% c("C", "V")]
head(table_users)
