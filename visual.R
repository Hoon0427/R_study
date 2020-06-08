library(readxl)
library(dplyr)

test <- read_excel('C:/Users/LENOVO/Desktop/엔사이크 사업관련/6. 모아젠/df_clean_deci_phase_d-bmi+index_color.xlsx')

head(test)

test_01 <- na.omit(test)

head(test_01)

summary(test_01)

model_01 <- lm(dm~age+glu+tchl+tg+hsi+fib4+homa+hba1c+AS1_CREATININE+AS1_ALBUMIN+AS1_R_GTP+AS1_HDL+AS1_PLAT_N+AS1_FLI, data=test_01)
summary(model_01)

model_02 <- lm(dm~age+glu+AS1_CREATININE+AS1_ALBUMIN+AS1_FLI, data=test_01)
summary(model_02)

model_03 <- lm(dm~age+glu+AS1_CREATININE+AS1_FLI, data=test_01)
summary(model_03)

model_04 <- step(model_01,direction = "backward")
model_05 <- step(model_04,direction = "backward")
summary(model_05)

# install.packages("car")
library(car)
vif(model_03)

relweights <- function(fit,...){
  R <- cor(fit$model)
  nvar <- ncol(R)
  rxx <- R[2:nvar, 2:nvar]
  rxy <- R[2:nvar, 1]
  svd <- eigen(rxx)
  evec <- svd$vectors
  ev <- svd$values
  delta <- diag(sqrt(ev))
  lambda <- evec %*% delta %*% t(evec)
  lambdasq <- lambda ^ 2
  beta <- solve(lambda) %*% rxy
  rsquare <- colSums(beta ^ 2)
  rawwgt <- lambdasq %*% beta ^ 2
  import <- (rawwgt / rsquare) * 100
  import <- as.data.frame(import)
  row.names(import) <- names(fit$model[2:nvar])
  names(import) <- "Weights"
  import <- import[order(import),1, drop=FALSE]
  dotchart(import$Weights, labels=row.names(import),
           xlab="% of R-Square", pch=19,
           main="Relative Importance of Predictor Variables",
           sub=paste("Total R-Square=", round(rsquare, digits=3)),
           ...)
  return(import)
}

result = relweights(model_03, col="blue")


# install.packages("ggplot2")
library(ggplot2)

plotRelWeights = function(fit){
  data <- relweights(fit)
  data$Predictors <- rownames(data)
  P <- ggplot(data=data,aes(x=reorder(Predictors,Weights),y=Weights,fill=Predictors))+
    geom_bar(stat="identity",width=0.5)+
    ggtitle("Relative Importance of Predictor Variables")+
    ylab(paste0("% of R-square \n(Total R-Square=",attr(data,"R-square"),")"))+
           geom_text(aes(y=Weights-0.1,label=paste(round(Weights,1),"%")),hjust=1)+
           guides(fill=FALSE)+
           coord_flip()
  P
}

plotRelWeights(model_03)

plotRelWeights(model_01)
