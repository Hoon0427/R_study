set.seed(1)
library(recommenderlab)
library(ggplot2)

data(MovieLense)
ratings_movies <- MovieLense[rowCounts(MovieLense) > 50,
                             colCounts(MovieLense) > 100]
ratings_movies

percentage_training <- 0.8

min(rowCounts(ratings_movies))

items_to_keep <- 15

rating_threshold <- 3

n_eval <- 1

eval_sets <- evaluationScheme(data = ratings_movies, method = "split",
                              train = percentage_training, given = items_to_keep,
                              goodRating = rating_threshold, k = n_eval)
eval_sets

getData(eval_sets, "train")

nrow(getData(eval_sets, "train")) / nrow(ratings_movies)

getData(eval_sets, "known")
getData(eval_sets, "unknown")

nrow(getData(eval_sets, "known")) / nrow(ratings_movies)

unique(rowCounts(getData(eval_sets, "known")))

qplot(rowCounts(getData(eval_sets, "unknown"))) +
  geom_histogram(binwidth = 10) +
  ggtitle("unknown items by the users")

percentage_training <- 0.8
items_to_keep <- 15
rating_threshold <- 3
n_eval <- 1
eval_sets <- evaluationScheme(data = ratings_movies, method = "bootstrap",
                              train = percentage_training, given = items_to_keep,
                              goodRating = rating_threshold, k = n_eval)
