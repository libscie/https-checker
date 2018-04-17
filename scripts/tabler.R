#/bin/R

dat <- read.csv('db/https-summary.csv')
table(dat$force.https)
