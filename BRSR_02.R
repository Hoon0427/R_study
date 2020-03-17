if(!"recommenderlab" %in% rownames(install.packages())){
  install.packages("recommenderlab")
}

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
