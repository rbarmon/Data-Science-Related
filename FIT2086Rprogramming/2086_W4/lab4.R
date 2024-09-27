2.8
setwd("/Users/rianb/FIT2086Rprogramming/2086_W4")

souce("CIunknownvar.R")
train = read.csv("train.csv")
est = calcCI(train$heights, 0.05)
est$mu.hat

est$CI

2.9
test = read.csv("test.csv")
esttest = calcCI(test$heights, 0.05)
esttest$mu.hat


3.1
plot((sp$Index), type="l", xlab="Week since 7th September, 2007", ylab="S&P Index", lwd=2.5)

3.2

> lines(x=59:108,y=sp$Index[59:108], col="red", lwd=2.5)

> y1 = sp$Index[1:58]
> y2 = sp$Index[59:108]
> estG1 = calcCI(y1, alpha=0.05)
> estG1
$mu.hat
[1] 1381.703

$sigma2.hat
[1] 9383.026

$CI
[1] 1356.233 1407.173

> estG2 = calcCI(y2, alpha=0.05)
> estG2
$mu.hat
[1] 886.9162

$sigma2.hat
[1] 7002.371

$CI
[1] 863.1346 910.6978

3.3



