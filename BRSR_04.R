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

table_users[, chunk_user := cumsum(category == "C")]
head(table_users)

table_long <- table_users[, list(user = value[1], item = value[-1]), by = "chunk_user"]
head(table_long)

table_long[, value := 1]
table_wide <- reshape(data = table_long,
                      direction = "wide",
                      idvar = "user",
                      timevar = "item",
                      v.names = "value")
head(table_wide[, 1:5, with = FALSE])

vector_users <- table_wide[, user]
table_wide[, user := NULL]
table_wide[, chunk_user := NULL]

setnames(x = table_wide,
         old = names(table_wide),
         new = substring(names(table_wide), 7))

matrix_wide <- as.matrix(table_wide)
rownames(matrix_wide) <- vector_users
head(matrix_wide[, 1:6])

matrix_wide[is.na(matrix_wide)] <- 0
ratings_matrix <- as(matrix_wide, "binaryRatingMatrix")
ratings_matrix

image(ratings_matrix[1:50, 1:50], main = "Binary rating matrix")

n_users <- colCounts(ratings_matrix)
qplot(n_users) + stat_bin(binwidth = 100) +
  ggtitle("Distribution of the number of users")

qplot(n_users[n_users < 100]) + stat_bin(binwidth = 10) +
  ggtitle("Distribution of the number of users")

ratings_matrix <- ratings_matrix[, colCounts(ratings_matrix) >=5]
ratings_matrix

sum(rowCounts(ratings_matrix) == 0)

ratings_matrix <- ratings_matrix[rowCounts(ratings_matrix) >= 5, ]
ratings_matrix

table_in <- data.table(table_in)
table_items <- table_in[V1 == "A"]
head(table_items)

table_items <- table_items[, c(2,4,5), with = FALSE]
setnames(table_items, 1:3, c("id", "description", "url"))
table_items <- table_items[order(id)]
head(table_items)

table_items[, category := "product"]

name_countries <- c(countrycode_data$country.name.en, "Taiwan", "UK", "Russia", "Venezuela",
                    "Slovenija", "Caribbean", "Netherlands (Holland)", "Europe", "Central America", "MS North Africa")
