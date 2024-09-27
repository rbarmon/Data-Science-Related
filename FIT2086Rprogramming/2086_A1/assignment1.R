#########################################################
# R script: assignment1.R
# Project: Assignment 1
#
# Date: 09/08/2023
# Author: Rian Barrett
#
# Purpose: Introductory script for Assignment 1
#########################################################

#for console
setwd("/Users/rianb/Rprogramming/2086_A1")


lambda_estimate <- function(x)
{
  n = length(x)
  
  retval = list()
  
  # Calculate the sample mean
  retval$mu_ml = sum(x)/n
  
  lambda_hat = sum(x)/n
  
  print(lambda_hat)
  return(retval)
}

covid <- read.csv("covid.2023.csv", header = TRUE)

est = lambda_estimate(covid$Days)

ppois(10,lambda)

table(covid)
#or 
order(dpois(0:40, lambda), decreasing = TRUE)[1:3]


#3. 
plot(x=covid$Days, y=rep(0,1000), ylim=c(0,100), xlim=c(0,40), 
     ylab="Number of Patients", xlab="Days to Recover")
xv = seq(from=0, to=40, length.out=10000)
lines(xv, dpois(xv, est$mu_ml, sqrt(est$var_ml)), lwd=2.5, col="red")
lines(xv, dnorm(xv, est$mu_ml, sqrt(est$var_u)), lwd=2.5, col="blue")


plot(dpois)


> lambda * 5
[1] 77.78
> lambda
[1] 15.556
a

plot(dpois(covid$Days, lambda))

plot(ppois(covid$Days, lambda))

plot(covid$Days)


2c

sum(dpois(12:16, lambda))
> plot(dpois(12:16, lambda))

P(X1 + X2 = k) = (e^-(λ1 + λ2) * (λ1 + λ2)^k) / k!

ppois(80,lambda * 5)
  
ppois(80,lambda * 5) - ppois(60,lambda * 5)
[1] 0.6058841
> ppois(80,lambda * 5) - ppois(59,lambda * 5)
[1] 0.6115397


2d
sum(dpois(14:40, lambda))

pbinom(2, size = 5, 1  - ppois(13, lambda), lower.tail = FALSE)

1 - pbinom(2, size = 5, 1  - ppois(13, lambda))

1 - pbinom(2, 5, 1  - ppois(13, lambda))





3
plot(covid$Days)
plot(dpois(0:40, lambda))

proportions <- table(covid$Days) / length(covid$Days)

probabilities <- dpois(0:40, lambda)
 
probabilities <- plot(dpois(covid$Days, lambda))

plot(proportions)

plot(proportions, col = "blue",  xlab = "Days to Recovery", ylab = "Proportion", main = "Recovery Data vs. Poisson Distribution")

plot(proportions, col = "blue",  xlab = "Days to Recovery", ylab = "Proportion", main = "Recovery Data vs. Poisson Distribution")


plot(proportions, col = "blue", ylim = c(0, max(probabilities)), xlab = "Days to Recovery", ylab = "Proportion", main = "Recovery Data vs. Poisson Distribution")


plot(1:40, proportions, type = "bar", col = "blue", ylim = c(0, max(probabilities)),
     xlab = "Days to Recovery", ylab = "Proportion", main = "Recovery Data vs. Poisson Distribution")

plot(proportions, col = "blue", ylim = c(0, max(probabilities)), xlab = "Days to Recovery", ylab = "Proportion", main = "Recovery Data vs. Poisson Distribution")

points(0:40, probabilities, col = "red", pch = 16)

legend("topright", legend = c("Data", "Prediction"), col = c("blue", "red"), pch = c(15, 16))

# Add the predicted probabilities to the plot
points(0:40, probabilities, col = "red", pch = 16)

plot(points(0:40, probabilities, col = "red", pch = 16))
legend("topright", legend = c("Observed", "Predicted"), col = c("blue", "red"), pch = c(15, 16))

