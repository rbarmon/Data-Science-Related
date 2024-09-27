
#########################################################
# R script:  studio1.R
# Project:  Studio 1
#
# Date:  28/07/2023
# Author:  Rian Barrett
#
# Purpose:  Introductory script for Studio 1
#########################################################

print("hello")

i = 45
cat("The value of i is:", i, "\n")

#6 Flow Control and Functions
#6.1. Implement a loop that prints out all the odd numbers from 1 to 15.
for (x in 1:15) {
  if (x %% 2 != 0) {
    print(x)
  }
}


#6.2. Write a function that takes an argument n, calculates the factorial of n, and returns it.
myfunc <- function(n){
  num <- n
  sum <- 1
  while (num > 0) {
    sum <- sum*num
    num <- num - 1
  }
  return(sum)
}

funcresult <- myfunc(5)
print(funcresult)

#6.3. Write a function that takes a vector of numbers and returns the minimum and maximum number, and the difference between the maximum and minimum (i.e., the range) of the vector.

retval = list()
retval$a = 1
retval$b = "you can store strings too"
retval$c = list()
retval$c$g = "You can store lists inside lists"
print(retval)

#7 Basic Examination of a Dataset in R
data("ToothGrowth")



#8 Categorical Data
#8.1
mush = read.csv("mushroom.csv", header=T, stringsAsFactors=T)

#8.2
tab = table(mush$cap.shape)
pie(tab)

#9 More descriptive statistics for numeric variables
