# Fit a logistic regression model by Gradient Descent
rm(list=ls())

# Function 1. Estimate the Sucess Probability
wi.estimate <- function(b, X){
  # Inputs:
  # b regression parameter P x 1
  # X Matrix of features N x P
  # Output:
  # wi Sucess Probability N x 1
  
  # wi=1/(1+exp(-x^T*B))
  w <- 1/(1+exp(-X %*% b)) # Sucess probability
  w = pmax(w, 1E-6); w = pmin(w, 1-1E-6); # Avoid numerical consecuences
  return(w)
}
  
# Function 2. Estimate the negative log likelihood
Negll <- function(b, y, X, m){
  # Input:
  # b regression parameter P x 1
  # y vector of response N x 1
  # X Matrix of features N x P
  # m number of trial for the ith case
  # Output:
  # Negative log likelihood of binomial distribution
  
  ll <- -sum(dbinom(y, m, wi.estimate(b, X), log = TRUE))
  return(ll)
}

# Function 3. Estimate the gradient of the negative log likelihood
Gradll <- function(b, y, X, m){
  # Output:
  # gradient of l(b) P x 1 
  
  grad.ll <- array(NA, dim = length(beta))
  grad.ll <- -apply(X * as.numeric(y - m * wi.estimate(b, X)), 2, sum)
  return(grad.ll)
}

# Function 4. Gradient Descent
GradDes <- function(y, X, beta, m, iter, epsilon){
  # Input:
  # iter is the maximum iterations allowed if it doesn't converge
  # epsilon is the minimum error allowed for convergency creteria
  # Output:
  # Negative log likelihood per iteration
  # b regression parameter P x 1

  # Initial Iteration (GUESS)
  betas = array(NA, dim=c(iter, ncol(X)))
  betas[1,] = beta
  ll = array(NA, dim = iter)
  ll[1] = Negll(betas[1,], y, X, m)
  
  # Iterations
  for (i in 2:iter){
    alpha = 0.025 
    # Gradient Descent b=b-alpha*gradient
    betas[i,] <- betas[i-1,] - alpha * Gradll(betas[i-1,], y, X, m) 
    ll[i] <- Negll(betas[i,], y, X, m)
    
    # Checking for Convergence
    error = abs((ll[i] - ll[i-1])/(ll[i-1] + epsilon))
    if (error < epsilon){
      cat('Gradient Descend has converged in iterations:',i)
      ll <- ll[1:i]
      betas <- betas[1:i,]
      break;
      }
    else if (i == iter & error >= epsilon){
      print('Gradient Descend has not converged')
      break;
    }
  } # for loop
  return(list("Negll" = ll, "beta" = betas[i,])) 
}


# Function 5. Estimate the Hessian of the negative log likelihood
Hessll <- function(b, y, X, m){
  # Input:
  # b regression parameter P x 1
  # y vector of response N x 1
  # X Matrix of features N x P
  # m number of trial for the ith case
  # Output:
  # Hessian of l(b) P x 1 
  
  w <- as.numeric(wi.estimate(b, X))
  W <- m * w * (1 - w) # Diagonal Matrix of weights
  hess <- t(X) %*% diag(W) %*% X
  return(hess)
}


# Function 6. Newton Method
NewtonM <- function(y, X, beta, m, iter, epsilon){
  # Input:
  # iter is the maximum iterations allowed if it doesn't converge
  # epsilon is the minimum error allowed for convergency creteria
  # Output:
  # Negative log likelihood per iteration
  # b regression parameter P x 1
  
  # Initial Iteration (GUESS)
  betas = array(NA, dim=c(iter, ncol(X)))
  betas[1,] = beta
  ll = array(NA, dim = iter)
  ll[1] = Negll(betas[1,], y, X, m)
  
  # Iterations
  for (i in 2:iter){
    
    hess <- Hessll(betas[i-1,], y, X, m) 
    grad <- Gradll(betas[i-1,], y, X, m) 
    
    # Improvement direction = Hessian^-1*gradient
    dir <- qr.solve(hess, grad) # Using QR decomposition
    
    # Newton Method b=b-Hessian^-1*gradient
    betas[i,] <- betas[i-1,] -  dir
    ll[i] <- Negll(betas[i,], y, X, m)
    
    # Checking for Convergence
    error = abs((ll[i] - ll[i-1])/(ll[i-1] + epsilon))
    if (error < epsilon){
      cat('Newton Method has converged in iterations:',i)
      ll <- ll[1:i]
      betas <- betas[1:i,]
      break;
    }
    else if (i == iter & error >= epsilon){
      print('Newton Method has not converged')
      break;
    }
  } # for loop
  return(list("Negll" = ll, "beta" = betas[i,])) 
}


######################################################################

# Simulation

# Inputs
wdbc = read.csv("wdbc.csv", header = FALSE) # Open cvs file
# Select response vector and convert into binary where Malignant is 1
y = as.matrix((wdbc[ , 2] == "M") * 1) 
X = scale(as.matrix(wdbc[ , 3:12])) # Select only 10 features and scale it
X = as.matrix(cbind(rep(1, nrow(X)), X)) # Add a column of 1's
beta = as.matrix(rep(0, ncol(X))) # Initial guess of beta
iter = 50000 # Maximum iterations allowed
epsilon = 1E-10
m = 1

# Gradient Descent Results
gd = GradDes(y, X, beta, m, iter, epsilon)
llGD = as.matrix(unlist(gd[1], use.names = FALSE))
betaGD = as.matrix(unlist(gd[2], use.names = FALSE))

nm = NewtonM(y, X, beta, m, iter, epsilon)
llNM = as.matrix(unlist(nm[1], use.names = FALSE))
betaNM = as.matrix(unlist(nm[2], use.names = FALSE))

# Plot the Results
png(filename=paste('P2B1.png'),width=15,height=15,units="cm",res=200)
plot(1:length(llGD),llGD,type="l",col="black",xlab="Iterations (Log-Scale)", ylab="Negative Log-Likelihood", log="x")
dev.off()

png(filename=paste('P2B2.png'),width=15,height=15,units="cm",res=200)
plot(1:length(llNM),llNM,type="l",col="black",xlab="Iterations", ylab="Negative Log-Likelihood")
dev.off()

# Checking Results
glm.coef <- glm(y ~ X[, c(-1)], family = "binomial")
summary(glm.coef)

