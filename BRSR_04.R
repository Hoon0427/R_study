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

table_recomm_per_item <- table(recc_matrix)
recomm_per_item <- as(table_recomm_per_item, "numeric")

bin_recomm_per_item <- cut(recomm_per_item, breaks = c(0, 10, 20, 100, max(recomm_per_item)))

qplot(bin_recomm_per_item) + ggtitle("Recommendations per item")

recomm_per_item_sorted <- sort(table_recomm_per_item, decreasing = TRUE)
recomm_per_item_top <- head(recomm_per_item_sorted, n = 4)
table_top <- data.frame(name = names(recomm_per_item_top),
                        n_recomm = recomm_per_item_top)
table_top[, c(1,3)]

evaluateModel <- function(
  # 입력데이터
  ratings_matrix, # 평점 매트릭스(rating matrix)
  table_items, # 아이템 설명 정보 테이블
  #K-fold 매개변수
  n_fold = 10, # 겹의 개수
  items_to_keep = 4, # TEST 데이터 세트에 포함할 아이템 개수
  # 모델 매개변수
  number_neighbors = 30, # 최근접 이웃의 수
  weight_description = 0.2, # 아이템 설명 정보 기반 거리에 대한 가중치
  items_to_recommend = 10 # 추천 아이템의 개수
){
  # 평가 (evalueate) 모델 파트
  set.seed(1)
  eval_sets <- evaluationScheme(data = ratings_matrix,
                                method = "cross-validation",
                                k = n_fold,
                                given = items_to_keep)
  
  recc_model <- Recommender(data = getData(eval_sets, "train"),
                            method = "IBCF",
                            parameter = list(method = "Jaccard",
                                             k = number_neighbors))
  dist_ratings <- as(recc_model@model$sim, "matrix")
  vector_items <- rownames(dist_ratings)
  
  dist_category <- table_items[, 1 - as.matrix(dist(category == "product"))]
  rownames(dist_category) <- table_items[, id]
  colnames(dist_category) <- table_items[, id]
  dist_category <- dist_category[vector_items, vector_items]
  
  dist_tot <- dist_category * weight_description + dist_ratings * (1 - weight_description) 
  recc_model@model$sim <- as(dist_tot, "dgCMatrix")
  
  eval_prediction <- predict(object = recc_model,
                             newdata = getData(eval_sets, "known"),
                             n = items_to_recommend,
                             type = "topNList")
  
  eval_accuracy <- calcPredictionAccuracy(x = eval_prediction,
                                          data = getData(eval_sets, "unknown"),
                                          byUser = FALSE,
                                          given = items_to_recommend)
  
  return(eval_accuracy)
}

model_evaluation <- evaluateModel(ratings_matrix = ratings_matrix,
                                  table_items = table_items)
model_evaluation

nn_to_test <- seq(4, 80, by = 2)

list_performance <- lapply(X = nn_to_test, FUN = function(nn){
  evaluateModel(ratings_matrix = ratings_matrix,
                table_items = table_items,
                number_neighbors = nn,
                weight_description = 0)
})

list_performance[[1]]

sapply(list_performance, "[[", "precision")

table_performance <- data.table(
  nn = nn_to_test,
  precision = sapply(list_performance, "[[", "precision"),
  recall = sapply(list_performance, "[[", "recall")
  )

weight_precision <- 0.5
table_performance[, perfomance := precision * weight_precision + recall * (1 - weight_precision)]

head(table_performance)

convertIntoPercent <- function(x){
  paste0(round(x*100), "%")
}

qplot(table_performance[, nn],
      table_performance[, precision]) + geom_smooth() + scale_y_continuous(labels = convertIntoPercent)

qplot(table_performance[, nn],
      table_performance[, recall]) + geom_smooth() + scale_y_continuous(labels = convertIntoPercent)

qplot(table_performance[, nn],
      table_performance[, perfomance]) + geom_smooth() + scale_y_continuous(labels = convertIntoPercent)

row_best <- which.max(table_performance$perfomance)
number_neighbors_opt <- table_performance[row_best, nn]
number_neighbors_opt

wd_to_try <- seq(0, 1, by = 0.05)

list_performance <- lapply(
  X = wd_to_try, FUN = function(wd){
    evaluateModel(ratings_matrix = ratings_matrix,
                  table_items = table_items,
                  number_neighbors = number_neighbors_opt,
                  weight_description = wd)
})
