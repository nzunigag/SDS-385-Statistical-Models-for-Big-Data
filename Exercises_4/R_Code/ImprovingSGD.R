# Exercise 4 Part I Improving SGD

rm(list=ls())
set.seed(12345) # Reproducibility

#------------------------------------------------------------------
# Function 1. Estimate the Sigmoid function of X
sigmoid <- function(x) {
  # Inputs:
  # x Matrix 
  # Output:
  # Sigmoid function of X
  
  1 / (1 + exp(-x))
}

#------------------------------------------------------------------
# Function 2. Estimate the Success Probability
w_estimate <- function(b, X) {
  # Inputs:
  # b regression parameter P x 1
  # X Matrix of features N x P
  # Output:
  # wi Sucess Probability N x 1
  
  sigmoid(drop(X %*% b))
}

#------------------------------------------------------------------
# Function 3. Estimate the negative log likelihood
negll <- function(b, y, X, m, lambda) {
  # Input:
  # b regression parameter P x 1
  # y vector of response N x 1
  # X Matrix of features N x P
  # m number of trial for the ith case
  # Output:
  # Negative log likelihood of binomial distribution
  
  w <- w_estimate(b, X)
  -sum(y * log(w) + (m - y) * log(1 - w)) + lambda*sum(abs(b))
}

#------------------------------------------------------------------
# Function 4. Estimate the gradient of the negative log likelihood
gradll <- function(b, y, X, m, lambda) {
  # Input:
  # b regression parameter P x 1
  # y vector of response N x 1
  # X Matrix of features N x P
  # m number of trial for the ith case
  # lamda: penalization factor 
  # Output:
  # gradient of l(b) P x 1
  
  w <- w_estimate(b, X)
  ll_part <- -drop(crossprod(X, y - m * w))
  penaly_part <- lambda * sign(b) # QUESTION
  ll_part + penaly_part # Penalty function
}

#------------------------------------------------------------------
# Simulation Data
N <- 100
P <- 150
X <- matrix(rnorm(N * P), ncol = P)
beta_true <- rnorm(P)
y <- rbinom(N, 1, w_estimate(beta_true, X))
batch_size <- 1
m = 1
lambda = 0.1
step <- 1 / N 
iter = 10000

#------------------------------------------------------------------
# Stochastic Gradient Descend 

# Initial Guess
beta = rep(0, P) 
ll <- negll(beta, y, X, m, lambda)

# SGD Loop
for (i in 2:iter){
  r <- sample(nrow(X), batch_size) #SGD
  grad <- gradll(beta, y[r], X[r, , drop = FALSE], m, lambda)
  beta <- beta - step * grad / batch_size
  ll <- c(ll, negll(beta, y, X, m, lambda))
}
plot(ll, type = "l",  xlab="Iterations (Log-Scale)", 
     ylab="Negative Log-Likelihood")


