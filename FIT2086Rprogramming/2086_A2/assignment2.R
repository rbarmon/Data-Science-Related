#########################################################
# R script: assignment1.R
# Project: Assignment 2
#
# Date: 12/09/2023
# Author: Rian Barrett
#
# Purpose: Introductory script for Assignment 1
#########################################################

#for console
setwd("/Users/rianb/FIT2086Rprogramming/2086_A2")
#########################################################

Question 1
Q1.1
setwd("/Users/rianb/FIT2086Rprogramming/2086_A2")
covidA2 <- read.csv("covid.19.ass2.2023.csv", header = TRUE)
#Determine Average Number of Days to Recovery
mean(covidA2$Recovery.Time)
[1] 14.25797

#Calculate the 95% confidence interval for this estimate using the t-distribution

#Get variance
> var(covidA2$Recovery.Time)
[1] 44.15324

#Get size of n

length(covidA2$Recovery.Time)
[1] 2353

#Get qt qt(p=1-0.05/2, df=n-1) 
qt(p = 1-0.05/2, df=2353-1)

you may use R to determine the means and variances of the data,
also the R functions qt() and pnorm() 
but you must perform all the remaining steps by hand



#Q1.2

israelicovid <- read.csv("israeli.covid.19.ass2.2023.csv", header = TRUE)
#Get mean
mean(israelicovid$Recovery.Time)
[1] 14.6498
#Get variance
var(israelicovid$Recovery.Time)
[1] 30.47549


#Q1.3

#Approximate p-value
2*pnorm(-abs(-1.381397437)) 
[1] 0.1671568

#Question 2

#Q.2.1
# v = 1, y ∈ (0,10) # Axis Labelling Adding Legend
v=1
ed_pdf = function(y) {exp((-exp(-v))*y-v)}
plot(ed_pdf, xlim=c(0,10), col="red", xlab="y-values", ylab="p(y|v)", main="Plot of Exponential Probability Density Function")
# v = 0.5, y ∈ (0,10)
v=0.5
ed_pdf = function(y) {exp((-exp(-v))*y-v)}
plot(ed_pdf, xlim=c(0,10), col="black", add=TRUE)
# v = 2, y ∈ (0,10)
v=2
ed_pdf = function(y) {exp((-exp(-v))*y-v)}
plot(ed_pdf, xlim=c(0,10), col="blue", add=TRUE)
legend(x=8,y=0.3,legend=c("v = 1","v = 0.5", "v = 2"), 
       fill=c("red","black","blue") )



expd_pdf = function(y) {exp((-exp(1)**(-1))*y-1)}
ed_pdf = function(y) {exp((-exp(1)**(-v))*y-1)}
# v = 1, y ∈ (0,10) # Axis Labelling Adding Legend
plot(ed_pdf, xlim=c(0,10), col="red", xlab="Y-value of 10", ylab="y-axis", main="Probability density function for non-negative real numbers")
# v = 0.5, y ∈ (0,10)
equation = function(x) {exp((-exp(1)**(-1))*x-1)}
plot(equation, xlim=c(0,10), col="blue", add=TRUE)
# v = 2, y ∈ (0,10)
plot(equation, xlim=c(0,10), col="green", add=TRUE)

exp(exp(-v))

y(0,10) exclusive










exponential distribution is a probability distribution




#Wk 4 tut as reference
SP500 = read.csv("SP500.csv")
plot((SP500$Index), type="l", xlab="Week since 7th September, 2007", ylab="S&P Index", lwd=2.5)

# Q3.2
# If you look at the data, you will see week 58 is September 26th, 2008. 
# So first group is week 1 through 58, and second group is week 59 through 108

# First, colour the second group differently on our plot
lines(x=59:108,y=SP500$Index[59:108], col="red", lwd=2.5)

y1 = SP500$Index[1:58]
y2 = SP500$Index[59:108]

# Get our two estimates for the two groups
estG1 = calcCI(y1, alpha=0.05)
estG1
estG2 = calcCI(y2, alpha=0.05)
estG2

# Notice the two intervals do not overlap

# Q3.3 
# We need to use the approximate procedure for CI as we assume variances are unknown and not
# necessarily the same

n1 = length(y1)
n2 = length(y2)

# first get the difference
diff = estG1$mu.hat - estG2$mu.hat

# get the standard error of the difference
se.diff = sqrt( estG1$sigma2.hat/n1 + estG2$sigma2.hat/n2 )

# calculate the 95% CI
CI.diff = diff + c(-1.96*se.diff, 1.96*se.diff)

diff
CI.diff

# the interval for the difference is completely positive and very far away from zero, suggesting
# that the population difference between the two groups is not zero (i.e., there is a
# difference in S&P index pre- and post-Lehman Brothers investment bank collapse). See PDF 
# file for a stament of these results


#Q3.2
2*pnorm(-abs(3.232895436)) 

#Q3.3
binom.test(x=80,n=124,p=0.5)

#Q.3.4
2*pnorm(-abs(-3.089363849)) 

