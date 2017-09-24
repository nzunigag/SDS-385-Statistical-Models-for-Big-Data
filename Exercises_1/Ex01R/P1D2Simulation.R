# Simulation of some silly data from the linear model
# for a range of values of N and P
set.seed(12345)

library(microbenchmark) # Library to benchmarck the performance

# Function to tests different scenarios
scenario <- function(N,P,e){
  # Create silly data using random normal distribution
  # e is the sparsity level
  X = matrix(rnorm(N*P), nrow=N)
  mask = matrix(rbinom(N*P,1,e), nrow=N) # Used to create an sparse matrix
  X = mask*X
  y = rnorm(N)
  W = diag(N) # Asumming that the weights w_i are all 1
  # Using microbenchmark and evaluating the expression 5L (obtained as "double")
  m1=mean(unlist(microbenchmark(inv.method(X, y, W), times=5L), use.names = FALSE)[6:10])/10^6
  m2=mean(unlist(microbenchmark(my.method(X, y, W), times=5L), use.names = FALSE)[6:10])/10^6
  m3=mean(unlist(microbenchmark(mysparse.method(X, y, W), times=5L), use.names = FALSE)[6:10])/10^6
  mbm = c(m1, m2, m3) # Computational time (ms) for each method
  return(mbm)
}

e = c(0.05, 0.50, 0.75) # Scenarios - Range of sparcity level (e)
for (j in 1:length(e)){
  P = c(100,1000,1750) # Scenarios - Range of P
  m1 <- vector("logical",0); m2 <- vector("logical",0); m3 <- vector("logical",0);
  for (i in 1:length(P)){
    r = scenario(2000,P[i],e[j])
    m1 <- c(m1,r[1]); m2 <- c(m2,r[2]); m3 <- c(m3,r[3])
  }
  N = c(200,750,2000) # Scenarios - Range of N
  n1 <- vector("logical",0); n2 <- vector("logical",0); n3 <- vector("logical",0);
  for (i in 1:length(N)){
    r = scenario(N[i],100,e[j])
    n1 <- c(n1,r[1]); n2 <- c(n2,r[2]); n3 <- c(n3,r[3])
  }
  # Plot the Results
  png(filename=paste('P1DPe',e[j],'.png'),width=15,height=12,units="cm",res=200)
  plot(P,m1,type="l",col="black",xlab="P", ylab="Computational time (ms)",ylim=c(0, max(m1,m2,m3)))
  points(P,m2,type="l",col="blue",lty=2)
  points(P,m3,type="l",col="red",lty=4)
  legend('topleft', legend=c("Inverse Method", "My Method", "My Sparse Method"),col=c("black", "blue","red"), lty=c(1,2,4), cex=0.8)
  dev.off()
  png(filename=paste('P1DNe',e[j],'.png'),width=15,height=12,units="cm",res=200)
  plot(N,n1,type="l",col="black",xlab="N", ylab="Computational time (ms)",ylim=c(0, max(n1,n2,n3)))
  points(N,n2,type="l",col="blue",lty=2)
  points(N,n3,type="l",col="red",lty=4)
  legend('topleft', legend=c("Inverse Method", "My Method", "My Sparse Method"),col=c("black", "blue","red"), lty=c(1,2,4), cex=0.8)
  dev.off()
}

