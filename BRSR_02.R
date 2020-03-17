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
