
# Exercises 2: Online learning

The goal in this exercise is to get some working code -- not necessarily fast or efficient code -- that fits a logistic-regression model by stochastic gradient descent (SGD).  The idea of SGD is to fit the model in such a way that we process only one observation at a time (or possibly a small handful of observations, called minibatches). This contrasts sharply with ordinary gradient descent or Newton's method, both of which are _batch methods_: they require that we process the entire data set as a batch in order to take a single step.  In future applications -- not quite yet -- SGD will even allow us to fit a model in such a way that we never have to load a full data set into your computer's working memory.  Instead we can just read it a chunk at a time off the hard drive.  This is very handy if you have more data than memory!

But as we'll see, getting stochastic-gradient descent right is tricky.  We'll learn the basics now, recognize the key issues, and save the more advanced stuff (for addressing those issues) for the next two sets of exercises.  


# Comments for the Peer-Reviewer

- The solution is presented in a [PDF](solution02-SDS385.pdf) document along with the [Latex](solution02-SDS385.tex) files used. This document presents a detailed description of the solution for each exercise, and it also includes the description of the code I used.

- In this exercise, I followed Mauricio's recommendation of using R-Markdown to describe better my R code. Thus, I present my code in an [R-Markdown file](solution02-SDS385_RCode.Rmd) and I also present its results in a [PDF](solution02-SDS385_RCode.pdf) file. 

- In addition, I present the [database](Ex01R/wdbc.csv) used for the exercise, which is the same used in [Exercise 1](https://github.com/nzunigag/SDS-385-Statistical-Models-for-Big-Data/tree/master/Exercises_1) Part 2.
