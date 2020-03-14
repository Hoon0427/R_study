#install.packages("cluster")
library(cluster)
library(ggplot2)

data("iris")
iris$Species = as.numeric(iris$Species)
cost_df <- data.frame()
for(i in 1:100){
  kmeans <- kmeans(x = iris, centers = i, iter.max = 50)
  cost_df <- rbind(cost_df, cbind(i, kmeans$tot.withinss))
}
names(cost_df) <- c("cluster", "cost")

ggplot(data=cost_df, aes(x=cluster, y=cost, group1)) +
  theme_bw(base_family = "Garamond") +
  geom_line(colour = "darkgreen") +
  theme(text = element_text(size = 20)) +
  ggtitle("Reduction In Cost For Values of `k`\n") +
  xlab("\nClusters") +
  ylab("Within-Cluster Sum of Squares\n")
