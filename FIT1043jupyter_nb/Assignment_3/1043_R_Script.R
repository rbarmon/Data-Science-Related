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
setwd("/Users/rianb/Assignment_3")
#########################################################

#A3
#3
output <- read.csv("output.csv", header = TRUE)

#4
png("bar_chart.png", width = 1200, height = 600)
barplot(output$Count, names.arg = output$Range, xlab = "Range", ylab = "Count", main = "Number of Twitter Users in each Follower Range")
dev.off()

#A4
#3
output2 <- read.csv("output2.csv", header = TRUE)

#4
install.packages("dplyr")
library(dplyr)
bindeddf <- bind_rows(output %>% mutate(Source = "All Tweets"), output2 %>% mutate(Source = "Non-Retweets"))
bindeddf

library(ggplot2)  # For creating the bar chart
plot <- ggplot(bindeddf, aes(Range, Count, fill=Source))
plot <- plot + guides(fill=guide_legend(title=NULL)) 
plot <- plot + ggtitle("Counts of All Tweets vs. Non-Retweets")
plot <- plot + geom_bar(stat = "identity", position = 'dodge')
plot
