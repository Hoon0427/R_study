library(tidyverse)

library(ggplot2)
library(plotly)

library(rpart)
library(rpart.plot)
library(caret)
library(randomForest)
training_set <- read.csv("train.csv")
test_set <- read.csv("test.csv")

str(training_set)

training_set$Pclass<-as.factor(training_set$Pclass)
training_set$Name <- as.character(training_set$Name)
training_set$Ticket <- as.character(training_set$Ticket)
training_set$Cabin <- as.character(training_set$Cabin)

str(training_set)

test_set$Pclass <- as.factor(test_set$Pclass)
test_set$Name <- as.character(test_set$Name)
test_set$Ticket <- as.character(test_set$Ticket)
test_set$Cabin <- as.character(test_set$Cabin)

str(test_set)

sapply(test_set, function(x){
  sum(is.na(x))
})

mean(test_set$Age, na.rm = T)

test_set$Age[is.na(test_set$Age)] <- mean(test_set$Age, na.rm = T)

sapply(test_set, function(x){
  sum(is.na(x))
})

summary(training_set)

mean(training_set$Age, na.rm = T)

sum(is.na(training_set))

sapply(training_set, function(x){
  sum(is.na(x))
})

training_set <- na.omit(training_set)
sum(is.na(training_set))

training_set <- training_set %>% 
  mutate(Ages = case_when(
    Age < 10 ~ "Under 10",
    Age < 20 ~ "10 ~ 20",
    Age < 30 ~ "20 ~ 30",
    Age < 40 ~ "30 ~ 40",
    Age < 50 ~ "40 ~ 50",
    Age < 60 ~ "50 ~ 60",
    TRUE ~ "over 60"
  )) 

training_set$Ages <- 
  factor(training_set$Ages,
         levels = c("Under 10", "10 ~ 20", "20 ~ 30", "30 ~ 40", "40 ~ 50", "50 ~ 60", "over 60"))

ggplot(training_set, aes(x = Ages)) +
  geom_bar() +
  theme(axis.text.x = element_text(size=10)) +
  theme(axis.text.y = element_text(size=10))

ggplot(training_set, aes(x=Survived, fill = Sex)) +
  geom_bar() +
  ggtitle("성별에 따른 생존 여부") +
  theme_bw()


ggplot_data<- ggplot(training_set, aes(x=Survived, fill = Sex)) +
  geom_bar() +
  ggtitle("성별에 따른 생존 여부") +
  theme_bw()

ggplotly(ggplot_data, height = 500, width=600)

ggplot_data <- ggplot(training_set, aes(x = Survived, fill = Pclass)) +
  geom_bar() +
  ggtitle(" Pclass에 따른 생존 여부 ") +
  theme_bw()

ggplotly(ggplot_data, height = 500, width = 600) 

ggplot_data <- training_set %>% 
  ggplot(aes(x = Survived, fill = Ages)) +
  geom_bar() +
  ggtitle(" 나이에 따른 생존 여부 ") +
  theme_bw() 

ggplotly(ggplot_data, height = 500, width = 600)


ggplot_data <- training_set %>% 
  ggplot(aes( x = Survived, fill = factor(SibSp))) +
  geom_bar() +
  ggtitle( "같이 탑승한 배우자 또는 형제에 따른 생존여부") +
  theme_bw()

ggplotly(ggplot_data, height = 500, width = 600)

ggplot_data <- training_set %>% 
  ggplot(aes( x = Survived, fill = factor(Parch))) +
  geom_bar() +
  ggtitle( "함께 탑승한 부모 또는 자녀의 수에 따른 생존여부") +
  theme_bw()


ggplotly(ggplot_data, height = 500, width = 800)

training_set$Survived <- as.factor(training_set$Survived)
str(training_set)
?rpart
rpart_m <- rpart(Survived ~ Pclass + Age + Sex, training_set)
prp(rpart_m, type=4, extra=2, digits = 3)

rpart_p <- predict(rpart_m, newdata=test_set, type="class")

rf_m <- randomForest(Survived ~ Pclass + Age + Sex, data=training_set)
rf_info <- randomForest(Survived ~ Pclass + Age + Sex, data=training_set, importance=T)

importance(rf_info)

varImpPlot(rf_info)

rf_p <- predict(rf_m, newdata = test_set, type = "class")
rf_p
