#########################################################
# R script: assignment3.R
# Project: Assignment 3
#
# Date: 19/10/2023
# Author: Rian Barrett
#
# Purpose: Introductory script for Assignment 3
#########################################################

#for console
setwd("/Users/rianb/FIT2086Rprogramming/2086_A3")
#########################################################


#Question 1
#1.1
setwd("/Users/rianb/FIT2086Rprogramming/2086_A3")
housing <- read.csv("housing.2023.csv", header = TRUE)
#The “medv ˜.” is shorthand for using all variables other than medv to predict medv the housing data.
#Use summary() to examine the fitted model.
fit = lm(medv~., data=housing)
summary(fit)

#1.4
#stepwise selection procedure, with the BIC criterion (use direction="both")
fit_bic = step(fit, k = log(length(housing$medv)),direction="both")
summary(fit_bic)
#get the regression equation
fit_bic$coefficients

#1.6
#Get variance
var(housing$medv)

#Get size of n
length(housing$medv)

#1.7
fullmod = glm(medv~. , data=housing)
try.mod = glm(medv~. + rm * dis, data = housing)
summary(fullmod)
summary(try.mod)

#Question 2
rm(list=ls())

setwd("/Users/rianb/FIT2086Rprogramming/2086_A3")

#heart.train.2023.csv
#heart.test.2023.csv
source("my.prediction.stats.R")
source("wrappers.R")
library(glmnet)
library(rpart)
library(randomForest)
library(pROC)

#2.1
heart.train = read.csv("heart.train.2023.csv")
heart.test = read.csv("heart.test.2023.csv")
summary(heart.train)

#tree.diabetes = rpart(Y ~ ., diabetes.train)
#tree.diabetes

heart.train = read.csv("heart.train.2023.csv")
#specify 10 folds and 5, 000 repetitions
cv = learn.tree.cv(HD~.,data=heart.train,nfolds=10,m=5000)
# We can look at the new tree in the console
cv$best.tree 

#2.2
#We can plot the tree as specified
plot(cv$best.tree)
text(cv$best.tree,pretty=12)

#2.3
tree.heart = rpart(HD ~ ., heart.train)
tree.heart
plot(tree.heart)
text(tree.heart, pretty=12)

#2.5
#Use the glm() function to fit a logistic regression model to the heart data
fullmod = glm(as.factor(HD)~. , data=heart.train, family=binomial)
#stepwise selection with the BIC score to prune the model (use direction="both"). 
step.fit.bic = step(fullmod, k = log(nrow(heart.train)), direction="both", trace=0)
summary(step.fit.bic)

#2.6
#get the regression equation
step.fit.bic$coefficients

#2.7
heart.test = read.csv("heart.test.2023.csv")
#Using the my.pred.stats() function compute the prediction statistics 
my.pred.stats(predict(cv$best.tree,heart.test)[,2], as.factor(heart.test$HD))
my.pred.stats(predict(step.fit.bic,heart.test,type="response"), as.factor(heart.test$HD))


#2.8
#specify 69
predict(cv$best.tree, heart.test[69,])
predict(step.fit.bic, type='response', heart.test[69,])


#2.9
library(boot)

boot.auc = function(formula, data, indices)
{
  # Create a bootstrapped version of our data
  d = data[indices,]
  
  # Fit a logistic regression to the bootstrapped data
  fit = glm(formula, d, family=binomial)
  
  # Compute the AUC and return it
  target = heart.test[69,]
  
  rv = predict(fit, target, type='response')
  
  return(rv)
}

bs = boot(data=heart.train, statistic=boot.auc, R=5000, formula = as.factor(HD) ~ CP + THALACH + OLDPEAK + CA + THAL)
boot.ci(bs,conf=0.95,type="bca")


#Question 3
rm(list=ls())
setwd("/Users/rianb/FIT2086Rprogramming/2086_A3")
ms.measured = read.csv("ms.measured.2023.csv")
ms.truth = read.csv("ms.truth.2023.csv")
library(kknn)
library(boot)

#3.1

#k = 1, . . . , 25,
k <- 1:25
y <- c()
for (i in k){
  # use k-NN to estimate the values of the spectrum at each of the MZ values in ms.truth$MZ.
  ytest.hat = fitted(kknn(intensity ~ ., ms.measured, ms.truth,kernel = "optimal", k=i) )
  
  #compute the mean-squared error between your estimates of the spectrum, and the true values in ms.truth$intensity.
  ms.error = mean((ytest.hat - ms.truth$intensity)^2)
  
  #get values for plot
  y = c(y,ms.error)
}
x <- c(1:25)
#Produce a plot of these errors against the various values of k
plot(x,y, xlab='k', ylab='mean-squared error', main='Mean-squared error for each value of k = 1, . . . , 25')


#3.2

#k = 2
k2.hat = fitted(kknn(intensity ~ ., ms.measured, ms.truth,kernel = "optimal", k=2) )
plot(ms.truth$MZ,ms.truth$intensity, xlab='Mass/Charge (MZ)', ylab='Relative Intensity', main='True vs Estimated Spectrum produced by the k-NN method for k=2', type='l', col='orange')
lines(ms.measured$MZ, ms.measured$intensity, type='l', col='blue')
lines(ms.truth$MZ, k2.hat, type='l', col='black')
legend('topright', legend=c('training data points', 'true spectrum', 'estimated spectrum'),
col=c('blue','orange','black'), lwd=2, lty=c(1,1))

#k = 5
k5.hat = fitted(kknn(intensity ~ ., ms.measured, ms.truth,kernel = "optimal", k=5) )
plot(ms.truth$MZ,ms.truth$intensity, xlab='Mass/Charge (MZ)', ylab='Relative Intensity', main='True vs Estimated Spectrum produced by the k-NN method for k=5', type='l', col='orange')
lines(ms.measured$MZ, ms.measured$intensity, type='l', col='blue')
lines(ms.truth$MZ, k5.hat, type='l', col='black')
legend('topright', legend=c('training data points', 'true spectrum', 'estimated spectrum'),
       col=c('blue','orange','black'), lwd=2, lty=c(1,1))
#k = 10 
k10.hat = fitted(kknn(intensity ~ ., ms.measured, ms.truth,kernel = "optimal", k=10) )
plot(ms.truth$MZ,ms.truth$intensity, xlab='Mass/Charge (MZ)', ylab='Relative Intensity', main='True vs Estimated Spectrum produced by the k-NN method for k=10', type='l', col='orange')
lines(ms.measured$MZ, ms.measured$intensity, type='l', col='blue')
lines(ms.truth$MZ, k10.hat, type='l', col='black')
legend('topright', legend=c('training data points', 'true spectrum', 'estimated spectrum'),
       col=c('blue','orange','black'), lwd=2, lty=c(1,1))
#k = 25. 
k25.hat = fitted(kknn(intensity ~ ., ms.measured, ms.truth,kernel = "optimal", k=25) )
plot(ms.truth$MZ,ms.truth$intensity, xlab='Mass/Charge (MZ)', ylab='Relative Intensity', main='True vs Estimated Spectrum produced by the k-NN method for k=25', type='l', col='orange')
lines(ms.measured$MZ, ms.measured$intensity, type='l', col='blue')
lines(ms.truth$MZ, k25.hat, type='l', col='black')
legend('topright', legend=c('training data points', 'true spectrum', 'estimated spectrum'),
       col=c('blue','orange','black'), lwd=2, lty=c(1,1))

#3.3

mean((k2.hat - ms.truth$intensity)^2)
mean((k5.hat - ms.truth$intensity)^2)
mean((k10.hat - ms.truth$intensity)^2)
mean((k25.hat - ms.truth$intensity)^2)

#3.5
#Use the cross-validation functionality in the kknn package to select an estimate of the best value of k (make sure you still use the optimal kernel).
knn = train.kknn(intensity ~ ., data = ms.measured, kmax=25, kernel='optimal')
knn$best.parameters$k

mean((k6.hat - ms.truth$intensity)^2)
k7.hat = fitted(kknn(intensity ~ ., ms.measured, ms.truth,kernel = "optimal", k=7) )
mean((k7.hat - ms.truth$intensity)^2)

#3.6
#Apply standard deviation formula
k6.hat = fitted( kknn(intensity ~ ., ms.measured, ms.truth,kernel = 'optimal', k = 6) )
mean = mean(k6.hat-ms.measured$intensity)
val = k6.hat-ms.measured$intensity
sqrt(sum((val - mean)^2)/(443-1))

#3.7
k6.hat = fitted( kknn(intensity ~ ., ms.measured, ms.truth,kernel = 'optimal', k = 6) )
max.estimate = which.max(k6.hat)
ms.truth$MZ[max.estimate]


#3.8
#Using the bootstrap procedure (use at least 5, 000 bootstrap replications)
library(boot)

boot.abu = function(data, indices, value)
{
  # Create a bootstrapped version of our data
  d = data[indices,]
  
  target = ms.truth[which.max(k6.hat),]
  
  rv = fitted( kknn(intensity ~ ., d, target, kernel = 'optimal', k = value) )
  
  return(rv)
}

bs = boot(data=ms.measured, statistic=boot.abu, R=5000, value= 3)
boot.ci(bs,conf=0.95,type="basic")

bs = boot(data=ms.measured, statistic=boot.abu, R=5000, value= 6)
boot.ci(bs,conf=0.95,type="basic")

bs = boot(data=ms.measured, statistic=boot.abu, R=5000, value= 20)
boot.ci(bs,conf=0.95,type="basic")



