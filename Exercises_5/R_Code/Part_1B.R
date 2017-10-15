rm(list=ls())
set.seed(1234)
# Soft thresholding to enforce sparsity
N <- 100
#__________________________________________________________________
# Create sparse vector theta and sigma vector
theta_estimate <- function(N, K){
  # Create sparse vector theta iid in N(0, 10)
  # Input:
  # N = vector size (constant)
  # K = sparsity level (constant)
  # Output:
  # theta = sparse vector (vector N)
  theta <- rnorm(N, 0, 10)
  mask <- rbinom(N, 1, K)
  theta <- theta * mask  
}
sigma <- rep(1, N) # Assumed equal to 1
#__________________________________________________________________
# Simulate a data point for each theta
y_estimate <- function(theta, sigma){
  # Simulate vector of observations
  # Inputs:
  # theta = sparse vector (vector N)
  # sigma = standard deviation (vector N)
  # Output:
  # y = vector of observations (vector N)
  rnorm(length(theta), theta, sigma)
}
#__________________________________________________________________
# Create a function to obtain S lambda (estimated theta)
S_lambda <- function(y, lambda){
  # Estimate theta using the soft-thresholding operator
  # Input:
  # y = vector of observations (vector N)
  # lambda = complexity parameter (constant)
  # Output:
  # Theta = estimated theta vector (vector N)
  sign(y) * pmax(abs(y) - lambda, rep(0, N))
}
#__________________________________________________________________
# Estimate theta using S lambda with different lambdas 
# and sparsity levels
N <- 100
lambda <- c(0, 1, 2, 5)
K <- c(.3, .5, .9)
for (j in 1:length(K)){
  theta <- theta_estimate(N, K[j])
  y <- y_estimate(theta, sigma)
  for (i in 1:length(lambda)){
    theta.hat <- S_lambda(y, lambda[i] * sigma ^ 2)
    png(filename=paste('P1B_K_',K[j],'_l_', lambda[i],'.png', sep = ""), 
        width = 15, height = 12, units = "cm", res = 200)
    plot(theta, theta.hat, xlab="Theta", ylab="Estimated Theta",
         col="black", ylim=c(-15,15), xlim=c(-15,15))
    abline(a = 0, b = 1, col='red', lty=2)
    dev.off()
  }
}
#__________________________________________________________________
# Plot the MSE of lambda
K <- c(.3, .5, .9)
lambda <- seq(0,5,length=100) # More lambdas
for (j in 1:length(K)){
  theta <- theta_estimate(N, K[j])
  y <- y_estimate(theta, sigma)
  MSE <- array(NA, dim = length(lambda))
  for (i in 1:length(lambda)){
    theta.hat <- S_lambda(y, lambda[i] * sigma ^ 2)
    MSE[i] <- mean((theta.hat - theta)^2)
  }
  png(filename=paste('P1BB_K_',K[j],'.png', sep = ""), 
      width = 15, height = 12, units = "cm", res = 200)
  plot(lambda, MSE,xlab="Lambda", ylab="MSE", type = "l",
       col="black", ylim=c(0,20), xlim=c(0,5))
  lambda.min <- lambda[which.min(MSE)]
  print(lambda.min)
  abline(v = lambda.min, col='red', lty=2)
  dev.off()
}

