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
