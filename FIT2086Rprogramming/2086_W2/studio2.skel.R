####################################################################################
#	Script-file:   studio2.skel.R
#	Project:       FIT2086 - Studio 2
#
# Purpose:  	   Skeleton for questions in Studio 2
####################################################################################

# Q3

# Q3.1

#a
mu <- 0
sigma <- 1

probability_within_one_std <- pnorm(mu + sigma, mean = mu, sd = sigma) - pnorm(mu - sigma, mean = mu, sd = sigma)

#b
probability_greater_than_2 <- 1 - pnorm(2)

#c
probability_greater_than_2_with_sd_4 <- 1 - pnorm(2, mean = 0, sd = 4)


#Q4.2
#a
(4^1 * exp(-4))/factorial(1)
#b
(4^2 * exp(-4))/factorial(2)
#c
4^0 * exp(-4) / factorial(0) + 4^1 * exp(-4) / factorial(1)


#Q4.3
#a
dpois(x, lambda, log = FALSE)
dpois(1, 4, log = FALSE)
#b
dpois(2, 4, log = FALSE)

#c
dpois(0,4) + dpois(1,4) 
ppois(1,4) 
#d
1 - ppois(5,4)

#4.5
#a
ppois(2,6)
#b
dpois(1, 6/7)
#c
1 - dpois(0, 6/7)



# Q6 Weak Law of Large Numbers

# Q6.1 Running mean
runningmean <- function(x)
{
  mu = vector(mode = "numeric", length = length(x))
  
  ## Insert code to compute running mean here ...
  # ...
  
  S = 0
  for (i in 1:length(x))
  {
    S = S+x[i]
    mu[i] = S/i
  }

  return(mu)
}

# Q6.2
# Generate data and plot
plot(1:1000, rep(0,1000), col="black",type="l",xlab="Samples",ylab="Sample mean")


lines(1:1000,runningmean(rnorm(1000,0,1)), type="l", col="red")

# Use "lines" to add new lines to an existing plot ...
lines(1:1000, runningmean(rnorm(1000,0,1)), col = "green")
lines(1:1000, runningmean(rnorm(1000,0,1)), col = "blue")

# Q6.3
# Do the same for binomial data -- you should use the ylim=c(0,1) option 
# to set the yaxis to be from 0 to 1 (i.e. the complete parameter space of the binomial)
# ...

plot(1:1000, rep(1/2,1000), col="black",type="l", ylim=c(0,1), ylab="Samples", xlab="Sample mean")
lines(1:1000, rep(0.9,1000), col="black")
lines(1:1000, runningmean(rbinom(1000,1,0.5)), col="red", ylim=c(0,1))
lines(1:1000, runningmean(rbinom(1000,1,0.9)), col="blue", ylim=c(0,1))