#########################################################
# R script:  studio2.R
# Project:  Studio 2
#
# Date:  04/08/2023
# Author:  Rian Barrett
#
# Purpose:  Introductory script for Studio 2
#########################################################


# 2 Binomial distribution

# 1 multiple bernouli put together. 1 coin toss bernouli
# 1-theta is the probability of failue, number of sucess

the probability of seeing n-m failures
# 2
the probability of seeing m suceesses
# 3
the number of different ways to order m sucesses and (n-m failures)
# 4

# 5

1 - pbinom(4,10,0.5)

pbinom(4,10,0.5, lower.tail=F)

1 - pbinom(4,10,0.5)
# 3 Gaussian Distribution


# 4 Poisson Distribution

# 2
(4^1 * exp(-4))/factorial(1)
dpois(1,4)
(4^2 * exp(-4))/factorial(2)
dpois(2,4)

# c

(4^0 * exp(-4))/factorial(0) + (4^1 * exp(-4))/factorial(1)
ppois(1,4)


# 3
dpois(1,4)
dpois(2,4)

ppois(2,4)
1-ppois(5,4)




# 5 The Uniform Distribution


# 3 Assignment 1


# 6 Using R and Simulation to Explore the Weak Law of Large Numbers