?t.test

twosided, less, greatr

twosided testing for true or FALSE

less testing for less than 

bpdate = read.csv(bpdate.csv)

t.test(x=bpdate$DP, mu=120)

small p value strong evidence against the null

not at risk



t.test(x=bpdate$DP, mu=120 alternative = 'less')
lower bound so -Inf to 116.0991

sufficient evidence to reject the null hypothesis

this group is not at risk


when you increase the interval it gets wider and wider

