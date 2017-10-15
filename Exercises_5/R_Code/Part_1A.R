rm(list=ls())
# Penalized likelihood and soft thresholding
#__________________________________________________________________
# Plot the Objective function with different y and lambda values
y = c(-1, 0, 5)
lambda = c(2, 5, 10)

for (i in 1:length(y)){
  for (j in 1:length(lambda)){
    # Objective Function
    png(filename=paste('P1A', y[i], lambda[j],'.png', sep = ""), 
        width = 15, height = 12, units = "cm", res = 200)
    values = list(y = y[i], lambda=lambda[j])
    curve(0.5 * (values$y - x)^2 + values$lambda * abs(x), from=-15, 
          to=15, xname="x", ylab="Objective Function", xlab="Theta")
    # S is the Soft Theresholding
    S <-  abline(v = sign(y[i]) * max(abs(y[i]) - lambda[j], 0), 
                 col=2, lty=3)
    dev.off()
  }
}
#__________________________________________________________________
# Plot the soft-thresholding and hard-thresholding functions 
# with different lambda
y <- seq(-10,10,length=1000)
lambda = c(0.5, 1, 2, 3, 5, 6)
for (j in 1:length(lambda)){
  S <- array(NA, dim = length(y))
  H <- array(NA, dim = length(y))
  for (i in 1:length(y)){
    # Softh-thresholding 
    S[i] <- sign(y[i]) * max(abs(y[i]) - lambda[j], 0)
    H[i] <- ifelse(abs(y[i])>=lambda[j], y[i], 0)
  }
  png(filename=paste('P1AA', lambda[j],'.png', sep = ""), 
      width = 15, height = 12, units = "cm", res = 200)
  plot(y, drop(S), type = "l", xlab="y", ylab="Estimated Theta",
       col="black", ylim=c(-10,10), lty=2)
  points(y, drop(H),type="l",col="blue",lty=3)
  legend('topleft',legend = c('Soft','Hard'), col=c("black", "blue"), 
         lty=1:2, cex=0.8)
  dev.off()
}
#__________________________________________________________________

