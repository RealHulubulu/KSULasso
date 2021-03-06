## Simulation DataSet Explanation  ##


#Data type : Rdata
#Dataset name :  sim1_sig3_our.RData / sim2_sig3_our.RData  / sim3_sig3_our.RData / sim4_sig3_our.RData
#i : iteration (from 1 to 10)

#training set variables :  x, y
#validataion set variables : x.val, y.val
#testing set variables : x.test, y.test
#covariance matrix : cov_x

options(scipen = 999)

setwd("~/Dropbox/KSULasso/R/Package/test")
#load("res/sim1_sig3_our.RData")
load("res/sim2_sig3_our.RData")
#load("res/sim3_sig3_our.RData")
#load("res/sim4_sig3_our.RData")

n_iter <- 1

for (i in 1:n_iter) {
  y <- sim_data[[i]][2]
  y <- unlist(y)
  y <- matrix(y, ncol = 1)

  x <- sim_data[[i]][3]
  x <- unlist(x[1])
  x <- matrix(x, ncol = n_feature, byrow = FALSE)

  y.test <- sim_data[[i]][4]
  y.test <- unlist(y.test)
  y.test <- matrix(y.test, ncol = 1)

  x.test <- sim_data[[i]][5]
  x.test <- unlist(x.test[1])
  x.test <- matrix(x.test, ncol = n_feature, byrow = FALSE)

  y.val  <- sim_data[[i]][6]
  y.val <- unlist(y.val)
  y.val <- matrix(y.val, ncol = 1)

  x.val  <- sim_data[[i]][7]
  x.val <- unlist(x.val[1])
  x.val <- matrix(x.val, ncol = n_feature, byrow = FALSE)

  cov_x <- sim_data[[i]][8]
  cov_x <- unlist(cov_x[1])
  cov_x <- matrix(cov_x, ncol = n_feature, byrow = FALSE)

  n_feature <- ncol(x)
  colnames(x)      <- paste('P', seq(1:n_feature), sep = '')
  colnames(x.val)  <- paste('P', seq(1:n_feature), sep = '')
  colnames(x.test) <- paste('P', seq(1:n_feature), sep = '')
}

rm(RandomLasso)
detach("package:RandomLasso", unload = TRUE)
install.packages("~/Dropbox/KSULasso/R/Package/RandomLasso/", repos = NULL,
                 type = "source")
library(RandomLasso)
RandomLasso(x, y,  bootstraps = 300, alpha = c(1, 1), verbose = TRUE)

part1 <- SteppedRandomLasso(x, y, bootstraps = 300, alpha = 1, verbose = TRUE)
part2 <- SteppedRandomLasso(x, y, importance = part1, bootstraps = 300, alpha = 1, verbose = TRUE)
