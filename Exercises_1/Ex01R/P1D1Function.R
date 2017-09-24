# Implementation of functions to calculate the 
# Weighted Least Squares (WLS) solution in a highly sparse matrix

library(Matrix) # Library to use in sparse matrices

# Function 3. My Sparse Method (using Cholesky Decomposition)
mysparse.method <- function(X,y,W){
  # X is an N x P matrix and y is the N-vector of response
  # W is the N x N diagonal matrix of weights
  # The output is b.hat, the unknown P-vector of regression coefficients 
  # Let's solve A(b.hat)=B where A=X^TWX=C^TC and B=X^TWy
  # In addition we have that X is an sparse matrix so we exploit its sparsity
  X = Matrix(X, sparse=TRUE) # Sparsity
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