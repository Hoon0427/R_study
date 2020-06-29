# install.packages("rpart")
# install.packages("caret")
# install.packages("tree")
# install.packages("misclass")
# install.packages("doBy")
# install.packages("RColorBrewer")
library(rattle)
library(rpart)
library(rpart.plot)
library(readxl)
library(dplyr)
library(caret)
library(tree)
library(doBy)
library(RColorBrewer)
library(party)





data <- read_excel('/Users/LENOVO/Desktop/엔사이크 사업관련/6. 모아젠/df_clean_deci_phase_d-bmi+index_color_w02.xlsx',
                   sheet='total')
head(data)

colnames(data)

# data[,["phase","hba1c","glu","fib4","AS1_HDL","AS1_FLI","alt","as1_creatinine_gr"]]
diabetes <- data[,c(2,14,5,12,19,22,7,16,24)]

# head(diabetes)
# 
# set.seed(42)
# intrain <- createDataPartition(y=diabetes$dm, p=0.7, list=FALSE)
# train <- diabetes[intrain,]
# test <- diabetes[-intrain,]
# 
# treemod <- tree(dm~. ,data = train)
# plot(treemod)
# text(treemod)
# 
# 
# prune.trees <- prune.misclass(treemod, best=10)
# plot(prune.trees)
# text(prune.trees, pretty=0)

##################################################
# train <- sampleBy(~dm, frac = 0.8, data = diabetes)
# 
# row(diabetes)
# rn <- row(train)
# test <- diabetes[-rn]
# 
# diabetes[-row(rn)]
################################################

##rpart
intrain<-createDataPartition(y=diabetes$dm, p=0.7, list=FALSE)
train <- diabetes[intrain,]
test <- diabetes[-intrain,]

party_tree = ctree(dm~.,train)
plot(party_tree)


##
trainIdx <- sample(1:nrow(diabetes),size=nrow(diabetes)*0.7)
train_diabetes <- diabetes[trainIdx,]
test_diabetes <- diabetes[-trainIdx,]

diabetesTree <- rpart(dm ~.,
                      train_diabetes,
                      method = "class")
rpart.plot(diabetesTree, cex = 0.5)

predictdiabetes <- predict(diabetesTree, test_diabetes,type="class")
confusionMatrix(predictdiabetes, test_diabetes$dm)
