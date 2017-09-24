# Simulation of some silly data from the linear model
# for a range of values of N and P
set.seed(12345)

library(microbenchmark) # Library to benchmarck the performance

# Function to tests different scenarios
scenario <- function(N,P){
  # Create silly data using random normal distribution
  X = matrix(rnorm(N*P), nrow=N) 
  y = rnorm(N)
  W = diag(N) # Asumming that the weights w_i are all 1
  # Using microbenchmark and evaluating the expression 5L (obtained as "double")
  m1=mean(unlist(microbenchmark(inv.method(X, y, W), times=5L), use.names = FALSE)[6:10])/10^6
  m2=mean(unlist(microbenchmark(my.method(X, y, W), times=5L), use.names = FALSE)[6:10])/10^6
  mbm = c(m1, m2) # Computational time (ms) for each method
  return(mbm)
}

P = c(100,500,1000,1750) # Scenarios - Range of P
m1 <- vector("logical",0); m2 <- vector("logical",0)
for (i in 1:length(P)){
  r = scenario(2000,P[i])
  m1 <- c(m1,r[1]); m2 <- c(m2,r[2]);
}
N = c(200,500,1000,2000) # Scenarios - Range of N
n1 <- vector("logical",0); n2 <- vector("logical",0);
for (i in 1:length(N)){
  r = scenario(N[i],100)
  n1 <- c(n1,r[1]); n2 <- c(n2,r[2]);
}
# Plot the Results
png(filename=paste('P1CP.png'),width=15,height=15,units="cm",res=200)
plot(P,m1,type="l",col="black",xlab="P", ylab="Computational time (ms)",ylim=c(0, max(m1,m2)))
points(P,m2,type="l",col="blue",lty=2)
legend('topleft', legend=c("Inverse Method", "My Method"),col=c("black", "blue"), lty=1:2, cex=0.8)
dev.off()
png(filename=paste('P1CN.png'),width=15,height=15,units="cm",res=200)
plot(N,n1,type="l",col="black",xlab="N", ylab="Computational time (ms)",ylim=c(0, max(n1,n2)))
points(N,n2,type="l",col="blue",lty=2)
legend('topleft', legend=c("Inverse Method", "My Method"),col=c("black", "blue"), lty=1:2, cex=0.8)
dev.off()
