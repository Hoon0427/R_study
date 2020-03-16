x1 <- rnorm(30)
x2 <- rnorm(30)
Euc_dist = dist(rbind(x1, x2), method = "euclidean")

vec1 = c(1,1,1,0,0,0,0,0,0,0,0,0)
vec2 = c(0,0,1,1,1,1,1,0,1,0,0,0)
#install.packages("lsa")
library(lsa)
cosine(vec1, vec2)

Coef = cor(mtcars, method = "pearson")

#PCA

data("USArrests")
rownames(USArrests)
names(USArrests)

#USArrests 데이터 세트의 열에 apply 함수를 사용해 각각의 변수가 어떻게 퍼져 있는지 보기 위해 분산을 구해본다.
apply(USArrests, 2, var)

#Assault가 가장 큰 분산을 가지고 있음을 확인할 수 있다. PCA를 적용하는 동안 정규화는 중요한 단계임을 유의한다.

#정규화 작업을 거친 후 PCA를 적용한다
pca <- prcomp(USArrests, scale = TRUE)
pca

#PCA 결과 값들에 대해 알아본다.
names(pca)

#pca$rotation을 통해 각 변수들의 비율을 설명하는 주성분들의 로딩 매트릭스를 확인할 수 있다.
#이제 biplot 그래프를 이용해 pca의 결과를 해석해본다. biplot은 각 변수들의 두 개 주성분의 비율을 사용한다.
#다음 코드는 biplot의 방향을 변경한다. 만약 다음 두 줄의 코드를 포함하지 않으면 그래프는 거울에 비친 것처럼 마주 볼 것이다.

pca$rotation = -pca$rotation
pca$x = -pca$x
biplot(pca, scale = 0)

#K-평균 클러스터링
library(cluster)
data(iris)
iris$Species = as.numeric(iris$Species)
kmeans <- kmeans(x = iris, center = 5)
clusplot(iris, kmeans$cluster, color = TRUE, shade = TRUE, labels = 13, lines = 0)

library(ggplot2)
data("iris")
iris$Species = as.numeric(iris$Species)
cost_df <- data.frame()
for (i in 1:!00){
  kmeans <- kmeans(x = iris, centers = i, iter.max = 50)
  cost_df <- rbind(cost_df, cbind(i, kmeans$tot.withinss))
}
names(cost_df) <- c("cluster", "cost")

str(cost_df)

#Elbow 기법으로 유휴한 클러스터의 수를 식별한다.
#비용 그래프
ggplot(data = cost_df, aes(x = cluster, y = cost, group = 1 )) +
  theme_bw(base_family = "Garamond") +
  geom_line(colour = "darkgreen") +
  theme(text = element_text(size = 20)) +
  ggtitle("Reduction In Cost For Values of `k`\n") +
  xlab("\nClusters") +
  ylab("Within-Cluster Sum of Squares \n")

#SVM
library(e1071)
data("iris")
sample = iris[sample(nrow(iris)),]
train = sample[1:105,]
test = sample[106:150,]
tune = tune(svm, Species~., data = train, kernel = "radial", scale = FALSE,
            ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))

tune$best.model

summary(tune)

model = svm(Species~., data=train, kernel = "radial", cost = 10, scale = FALSE)

pred = predict(model, test)

#install.packages("tree")
library(tree)
sample = iris[sample(nrow(iris)),]
train = sample[1:105,]
test = sample[106:150,]
model = tree(Species~.,train)
summary(model)

#의사결정 나무 표 그리기
plot(model)
text(model)
pred = predict(model, test[,-5], type="class")
pred

#randomForest
library(randomForest)
data("iris")
sample = iris[sample(nrow(iris)),]
train = sample[1:105,]
test = sample[106:150,]
model = randomForest(Species~.,data=train, mtry = 2, importance = TRUE, proximity = TRUE)
model

pred = predict(model, newdata = test[,-5])
pred

#R에서의 부스팅
#install.packages("gbm")
library(gbm)
data(iris)
sample = iris[sample(nrow(iris)),]
train = sample[1:105,]
test = sample[106:150,]
model = gbm(Species~.,data = train, distribution = "multinomial",
            n.trees = 5000, interaction.depth = 4)
summary(model)

#위의 요약 내용은 모델의 변수들이 가지는 상대적 중요성을 나타낸다.
pred = predict(model, newdata = test[,-5], n.trees = 5000)
pred[1:5,,]

#apply(..,1, which.max) 함수를 실행해 pred 매트릭스로부터 가장 높은 확률을 가진 값을 응답으로 선택한다
p.pred <- apply(pred, 1, which.max)
p.pred