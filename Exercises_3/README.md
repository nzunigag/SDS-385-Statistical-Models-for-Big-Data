


# Exercises 3: Better online learning (preliminaries_

[The goal in this exercise](exercises03/exercises03-SDS385.pdf) is to set the stage for some big improvements to stochastic gradient descent.  To do so, we'll need to revisit our two batch optimizers from before: ordinary gradient descent, and Newton's method.  These exercises will have you implement backtracking line search and the BFGS method for logistic regression.  Both of these ideas will carry forward, with some modifications, to the online-learning setting.  

PCA, which is closely related to the [singular value decomposition](https://en.wikipedia.org/wiki/Singular_value_decomposition) of a matrix.  

In this set of exercises, you will explore an approach for computing a modified PCA-like factorization of a matrix.  Specifically, you will incorporate regularization on the principal components, in the form of a penalty function.  This leads to a [biconvex](https://en.wikipedia.org/wiki/Biconvex_optimization) optimization problem that can be solved quite rapidly.   

Readings for this week:
- A review of principal components analysis in [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/), Section 10.2.  
- The paper ["A penalized matrix decomposition, with applications to sparse principal components and canonical correlation analysis"](https://faculty.washington.edu/dwitten/Papers/pmd.pdf), by Witten, Tibshirani, and Hastie.   
- Optional: [more background](https://www.cs.cmu.edu/~venkatg/teaching/CStheory-infoage/book-chapter-4.pdf) on the singular value decomposition.  
