#Activity: Exploratory Analysis of Big Data in R
#Part A: Generating and Graphing Data

# Practice 1: To convert temperatures in degrees Celsius to Fahrenheit, multiply by 1.8 (or 9/5)
# and add 32. Generate a sequence of integers with value 0 to 100, as the degree in Celsius.
# Then write an equation to get the Fahrenheit, and plot a graph for these values.

celsius <- 0:100
farenheit <- celsius*1.8
plot(celsius, farenheit, main="Temp Plot", xlab="Celsius", ylab="Farenheit")

# Practice 2: Using the runif() command to generate two sequences of random variables
# over different ranges:
#   I. 500 random values in the range 10 to 20
#   II. 500 random values in the range 20 to 50
# Change z to be the concatenation of these two sequences.

a <- runif(1000,10,20)
b <- runif(1000,20,50)

c <- c(a,b)

mean(z)
max(z)
min(z)
sd(z)

# Practice 3: Interpret the output, e.g. relation between x and y.

linear correlation

# Practice 4: Interpret the output from the aspect of coefficients, e.g. slope, intercept, and
# Multiple R-squared. Your tutor will discuss this finding in class. Observe also statistics like
# 1st Quartile, Median, 3rd Quartile, etc. We can discuss this in your tutorial session.



#Part B: Analysing a Large Data File

# Practice 5a: How to display the last few records (the command is the same as in your
# previous Python exercises?
     

setwd("/Users/rianb/FIT2086Rprogramming/2086_W8")
tail(ozone)

# Practice 5b: How many records in this file? (For you to find out online)

nrow(ozone)
[1] 1600483

# Practice 6: How many states in the data? Does that make sense?

# Practice 7: Display the summary statistics for the column Sample Measurement.

# Practice 8: Based on this statement, name three west states, and three east states.

# Practice 9a: Is ozone pollution higher in the East or West? Does that make sense?

# Practice 9b: Write statements to remove the islands (Puerto Rico and Hawaii) and perhaps
# also Alaska. How does the mean and median of sample measurement changes?

# Practice 10: Plot a boxplot to show the distribution of the resulting data, i.e. sample
# measurement for each region.

#Part C: Investigate other Datasets

# Practice 11a: What are the different species of iris?
unique(iris$Species)
[1] setosa     versicolor virginica 

# Practice 11b: Which species has the min sepal length of iris, which has the max?

# Practice 12: Load whichever data you think looks interesting and do some initial graphing
# and analysis of it.

#Part D: Investigating other Packages

# Practice 13: Have a look at this list of useful packages to see the sorts of functionality that is
# available.