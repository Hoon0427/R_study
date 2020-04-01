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

name_countries <- c(codelist$country.name, "Taiwan", "UK", "Russia", "Venezuela",
                    "Slovenija", "Caribbean", "Netherlands (Holland)", "Europe", "Central America", "MS North Africa")
table_items[description %in% name_countries, category := "region"]

table_items[grepl("Region", description), category := "region"]
head(table_items)

table_items[, list(n_items = .N), by = category]

which_train <- sample(x = c(TRUE, FALSE),
                      size = nrow(ratings_matrix),
                      replace = TRUE,
                      prob = c(0.8, 0.2))
recc_data_train <- ratings_matrix[which_train, ]
recc_data_test <- ratings_matrix[!which_train, ]

recc_model <- Recommender(data = recc_data_train,
                          method = "IBCF",
                          parameter = list(method = "Jaccard"))

class(recc_model@model$sim)
dim(recc_model@model$sim)

image(recc_model@model$sim)

range(recc_model@model$sim)

dist_rating <- as(recc_model@model$sim, "matrix")

dist_category <- table_items[, 1 - dist(category == "product")]
class(dist_category)

dist_category <- as(dist_category, "matrix")

dim(dist_category)
dim(dist_rating)

rownames(dist_category) <- table_items[, id]
colnames(dist_category) <- table_items[, id]

vector_items <- rownames(dist_rating)
dist_category <- dist_category[vector_items, vector_items]

identical(dim(dist_category), dim(dist_rating))
identical(rownames(dist_category), rownames(dist_rating))
identical(colnames(dist_category), colnames(dist_rating))

image(dist_category)

weight_category <- 0.25
dist_tot <- dist_category * weight_category + dist_rating * (1 - weight_category)

image(dist_tot)

recc_model@model$sim <- as(dist_tot, "dgCMatrix")

n_recommended <- 10
recc_predicted <- predict(object = recc_model,
                          newdata = recc_data_test,
                          n = n_recommended)

head(recc_predicted@itemLabels)

table_labels <- data.frame(id = recc_predicted@itemLabels)
table_labels <- merge(table_labels, table_items,
                      by = "id", all.x = TRUE, all.y = FALSE,
                      sort = FALSE)
descriptions <- as(table_labels$description, "character")

head(table_labels)

recc_user_1 <- recc_predicted@items[[1]]
items_user_1 <- descriptions[recc_user_1]
head(items_user_1)

recc_matrix <- sapply(recc_predicted@items, function(x){
  recommended <- descriptions[x]
  c(recommended, rep("", n_recommended - length(recommended)))
})
dim(recc_matrix)

head(recc_matrix[, 1:3])
