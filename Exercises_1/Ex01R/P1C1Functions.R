# Implementation of functions to calculate the 
# Weighted Least Squares (WLS) solution
rm(list=ls())

# Function 1. Inversion Method
inv.method <- function(X,y,W){
  # X is an N x P matrix
  # y is the N-vector of response
  # W is the N x N diagonal matrix of weights
  # The output is b.hat, the unknown P-vector of regression coefficients
  # Let's solve b.hat=A^(-1)B where A=X^TWX and B=X^TWy
  A.inv = solve(crossprod(X,diag(W)*X))
  B = crossprod(X,diag(W)*y)
  return(crossprod(A.inv, B)) # Solving for b.hat
}

# Function 2. My Method (using Cholesky Decomposition)
my.method <- function(X,y,W){
  # X is an N x P matrix
  # y is the N-vector of response
  # W is the N x N diagonal matrix of weights
  # The output is b.hat, the unknown P-vector of regression coefficients 
  # Let's solve A(b.hat)=B where A=X^TWX=C^TC and B=X^TWy
  C = chol(crossprod(X,diag(W)*X)) 
  # Using the Cholesky Decomposition C^TC
  # for A=X^TWX where C is upper tringle
  B = crossprod(X,diag(W)*y)
  z = forwardsolve (t(C), B) # Solving for z in C^Tz=X^TWy 
  # Where C^T is lower tringle 
  b.hat = backsolve(C,z) # Solving for b.hat in C(b.hat)=z
  # Where C is upper triangle 
  return(b.hat)
}