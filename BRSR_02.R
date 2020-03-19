# if(!"recommenderlab" %in% rownames(install.packages())){
#   install.packages("recommenderlab")
# }

library(recommenderlab)
help(package = "recommenderlab")

set.seed(1)

data_package <- data(package = "recommenderlab")
data_package$results[,"Item"]

data("MovieLense")
MovieLense

class(MovieLense)

methods(class = class(MovieLense))

object.size(MovieLense)
object.size(as(MovieLense, "matrix"))

object.size(as(MovieLense, "matrix")) / object.size(MovieLense)

similarity_users <- similarity(MovieLense[1:4,], method = "cosine",
                               which = "users")

class(similarity_users)

as.matrix(similarity_users)

image(as.matrix(similarity_users), main = "User similarity")

similarity_items <- similarity(MovieLense[, 1:4],
                               method = "cosine", which = "items")
as.matrix(similarity_items)

image(as.matrix(similarity_items), main = "Item similarity")

recommender_models <- recommenderRegistry$get_entries(dataType = "realRatingMatrix")

names(recommender_models)

lapply(recommender_models, "[[", "description")

recommender_models$IBCF_realRatingMatrix$parameters

library(recommenderlab)
library(ggplot2)
data("MovieLense")
class(MovieLense)

dim(MovieLense)

slotNames(MovieLense)

class(MovieLense@data)
dim(MovieLense)

vector_ratings <- as.vector(MovieLense@data)
unique(vector_ratings)

table_ratings <- table(vector_ratings)
table_ratings

vector_ratings <- vector_ratings[vector_ratings != 0]

vector_ratings <- factor(vector_ratings)
qplot(vector_ratings) + ggtitle("Distribution of the ratings")

views_per_movie <- colCounts(MovieLense)

table_views <- data.frame(movie = names(views_per_movie),
                         views = views_per_movie)
table_views <- table_views[order(table_views$views, decreasing = TRUE), ]

ggplot(table_views[1:6, ], aes(x = movie, y = views)) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Number of views of the top movies")

average_ratings <- colMeans(MovieLense)

qplot(average_ratings) + stat_bin(binwidth = 0.1) +
  ggtitle("Distribution of the average movie rating")

average_ratings_relevant <- average_ratings[views_per_movie > 100]

qplot(average_ratings_relevant) +
  stat_bin(binwidth = 0.1) +
  ggtitle(paste("Distribution of the relevant average ratings"))

image(MovieLense, main = "Heatmap of the rating matrix")

image(MovieLense[1:10, 1:15], main = "Heatmap of the first rows and columns")

min_n_movies <- quantile(rowCounts(MovieLense), 0.99)
min_n_users <- quantile(colCounts(MovieLense), 0.99)
min_n_movies
min_n_users

image(MovieLense[rowCounts(MovieLense) > min_n_movies,
                 colCounts(MovieLense) > min_n_users],
      main = "Heatmap of the top users and movies")

ratings_movies <- MovieLense[rowCounts(MovieLense)>50,
                             colCounts(MovieLense)>100]
ratings_movies

#상위 조건 반영
min_movies <- quantile(rowCounts(ratings_movies), 0.98)
min_users <- quantile(colCounts(ratings_movies), 0.98)

image(ratings_movies[rowCounts(ratings_movies) > min_movies,
                     colCounts(ratings_movies) > min_users],
      main = "Heatmap of the top users and movies")

average_ratings_per_user <- rowMeans(ratings_movies)

qplot(average_ratings_per_user) +
  stat_bin(binwidth = 0.1) +
  ggtitle("Distribution of the average rating per user")

ratings_movies_norm <- normalize(ratings_movies)

sum(rowMeans(ratings_movies_norm) > 0.00001)

#정규화된 매트릭스를 시각화
image(ratings_movies_norm[rowCounts(ratings_movies_norm) > min_movies,
                          colCounts(ratings_movies_norm) > min_users],
      main = "Heatmap of the top users and movies")

ratings_movies_watched <- binarize(ratings_movies, minRating = 1)

min_movies_binary <- quantile(rowCounts(ratings_movies), 0.95)
min_users_binary <- quantile(colCounts(ratings_movies), 0.95)

image(ratings_movies_watched[rowCounts(ratings_movies) > min_movies_binary,
                             colCounts(ratings_movies) > min_users_binary],
      main = "Heatmap of the top users and movies")

ratings_movies_good <- binarize(ratings_movies, minRating = 3)

image(ratings_movies_good[rowCounts(ratings_movies) > min_movies_binary,
                          colCounts(ratings_movies) > min_users_binary],
      main = "Heatmpa of the top users and movies")

which_train <- sample(x = c(TRUE, FALSE), size = nrow(ratings_movies),
                      replace = TRUE, prob = c(0.8, 0.2))
head(which_train)

recc_data_train <- ratings_movies[which_train, ]
recc_data_test <-  ratings_movies[!which_train, ]

which_set <- sample(x = 1:5, size = nrow(ratings_movies), replace = TRUE)
for(i_model in 1:5){
  which_train <- which_set == i_model
  recc_data_train <- ratings_movies[which_train, ]
  recc_data_test <- ratings_movies[!which_train, ]
#Recommender 구성하기
}

recommender_models <- recommenderRegistry$get_entries(dataType = "realRatingMatrix")
recommender_models$IBCF_realRatingMatrix$parameters

recc_model <- Recommender(data = recc_data_train, method = "IBCF",
                          parameter = list(k = 30))
recc_model
class(recc_model)

model_details <- getModel(recc_model)
model_details$description

class(model_details$sim)

dim(model_details$sim)

n_items_top <- 20

image(model_details$sim[1:n_items_top, 1:n_items_top],
      main = "Heatmap of the first rows and columns")

model_details$k
row_sums <- rowSums(model_details$sim > 0)
table(row_sums)

col_sums <- colSums(model_details$sim > 0)

qplot(col_sums) + stat_bin(binwidth = 1) + ggtitle("Distribution of the column count")

which_max <- order(col_sums, decreasing = TRUE)[1:6]
rownames(model_details$sim)[which_max]

n_recommender <- 6

recc_predicted <- predict(object = recc_model, newdata = recc_data_test,
                          n = n_recommender)
recc_predicted

class(recc_predicted)
slotNames(recc_predicted)

recc_predicted@items[[1]]

recc_user_1 <- recc_predicted@items[[1]]
movies_user_1 <- recc_predicted@itemLabels[recc_user_1]
movies_user_1

recc_matrix <- sapply(recc_predicted@items, function(x){colnames(ratings_movies)[x]})
dim(recc_matrix)

recc_matrix[, 1:4]

number_of_items <- factor(table(recc_matrix))
chart_title <- "Distribution of the number of items for IBCF"

qplot(number_of_items) + ggtitle(chart_title)

number_of_items_sorted <- sort(number_of_items, decreasing = TRUE)
number_of_items_top <- head(number_of_items_sorted, n = 4)
table_top <- data.frame(names(number_of_items_top), number_of_items_top)
table_top

recommender_models <- recommenderRegistry$get_entries(dataType = "realRatingMatrix")
recommender_models$UBCF_realRatingMatrix$parameters
