
# Exercises 6: the proximal gradient method

The culmination of the first four exercises was _stochastic gradient descent_, which is one of the core algorithms that powers modern data science.  Over the next few sets of exercises, we will build up to two other such core algorithms: the proximal gradient method, and ADMM, which stands for the _alternating direction method of multipliers._  These algorithms are broadly useful for optimizing objective functions f(x) in statistics that have either or both of the following two features:  
- f(x) is a sum of two terms, one of which measures fit to the data, and the other of which penalizes model complexity.  
- f(x) is not everywhere smooth, so that we cannot assume derivatives exist.  

Both features come up in problems where we wish to impose sparsity on a parameter in a statistical model (i.e. the lasso of the previous exercises).  

In this set of exercises, we begin our study of scalable algorithms that can handle sparsity, with the proximal gradient method.


### Optional reading

These exercises are fairly self contained.  Nonetheless, if you want a very detailed reference on the proximal gradient algorithm, and many related algorithms, I highly recommend [this review paper](http://web.stanford.edu/~boyd/papers/prox_algs.html) by Parikh and Boyd.