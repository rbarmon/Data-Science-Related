setwd("/Users/rianb/Downloads/tutorial_10")
df <- read.table('data/california_wind.txt', header = TRUE)
head(df)
tail(df)
summary(df$Sample.Measurement)