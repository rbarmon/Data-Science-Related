#########################################################
# R script:  studio3.R
# Project:  Studio 3
#
# Date:  09/08/2023
# Author:  Rian Barrett
#
# Purpose:  Introductory script for Studio 3
#########################################################

maxlikelihood <- function(x)
{
  muMLE
  
  for (i in 1:length(x))
  {
    S = S+x[i]
    mu[i] = S/i
  }
  
  sigmaMLE
  
  varianceMLE 
  
  
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