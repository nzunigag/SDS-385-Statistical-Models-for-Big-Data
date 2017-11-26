


# Exercises 7: Introduction to ADMM

## Reading

In this set of exercises, there is a lot of reading.  The main reference is a review paper called [Distributed Optimization and Statistical Learning via the Alternating Direction Method of Multipliers](http://stanford.edu/~boyd/papers/admm_distr_stats.html), by Boyd et al.  This is a truly excellent review paper -- and a popular one, as its citation count on Google Scholar reveals.  For this set of exercises I ask that you read Sections 1-6 of this paper.

You may or may not be familiar with some of the basic concepts in convex optimization used in the paper.  If you're not, you can find some very useful background material on Lagrangians and duality in Chapter 5 (and for background, 3.3) of [Convex Optimization](http://stanford.edu/~boyd/cvxbook/), by Boyd and Vandeberghe (see the Download link at the bottom of this linked page).  

## Exercises

The assignment this week is simple: implement ADMM for fitting the lasso regression model, and compare it to your proximal gradient implementation from last week.  The application of ADMM to the lasso model is described in Section 6.4 of the Boyd et. al. paper.  I encourage you to try to derive these steps yourself from the generic ADMM recipe, and then check against Section 6.4.  

In the exercises to follow, we'll use ADMM again for several other problems, including spatial smoothing.  

