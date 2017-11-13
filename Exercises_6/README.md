
# Exercises 6: the proximal gradient method

The culmination of the first four exercises was _stochastic gradient descent_, which is one of the core algorithms that powers modern data science.  Over the next few sets of exercises, we will build up to two other such core algorithms: the proximal gradient method, and ADMM, which stands for the _alternating direction method of multipliers._  These algorithms are broadly useful for optimizing objective functions f(x) in statistics that have either or both of the following two features:  
- f(x) is a sum of two terms, one of which measures fit to the data, and the other of which penalizes model complexity.  
- f(x) is not everywhere smooth, so that we cannot assume derivatives exist.  

Both features come up in problems where we wish to impose sparsity on a parameter in a statistical model (i.e. the lasso of the previous exercises).  

In this set of exercises, we begin our study of scalable algorithms that can handle sparsity, with the proximal gradient method.

# Comments for the Peer-Reviewer

- The solution is presented in a [PDF](solution06-SDS385.pdf) document along with the [Latex](solution06-SDS385.tex) files used. This document presents a detailed description of the solution for each exercise, and it also includes the description of the code I used.

- The R code files can be found in this [folder](R_Code), which also includes the output figure presented in the description of the solution, and the databases for [diabetesX](R_Code/diabetesX.csv) and [diabetesY](R_Code/diabetesY.csv), used in Part 2 of the exercise.

- I also included a [literature](Literature) folder, which contains recommended and additional readings I used.

### Optional reading

These exercises are fairly self contained.  Nonetheless, if you want a very detailed reference on the proximal gradient algorithm, and many related algorithms, I highly recommend [this review paper](http://web.stanford.edu/~boyd/papers/prox_algs.html) by Parikh and Boyd.
