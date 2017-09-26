# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

hello <- function() {
  print("Hello, world!")
}

#'
#'  Data Generate
#'
#'  This a a simple function to create some test data for our model.
#'  The model generate the dat set is that: \deqn{y = \sum_{i = 0}^p \beta_i x_i  + e }{ y = \sum_{i = 0}^p \beta_i x_i  + e }
#'
#'
#' @param n A integer that gives the sample size
#'
#' @param beta A vector gives the coeficients of the true model
#'
#' @return This function returns a list of two element \code{y} and \code{X}
#'
#' @examples
#' gen_dat(n = 100, beta = c(1,1))
#'
#' @export

gen_dat <- function(n = 100, beta = c(1,1)){
  p <- length(beta) -1
  e <- rexp(n, rate =1)
  x <- matrix(rnorm(n*p), ncol = p)
  X <- cbind(rep(1,n), x)
  y <- beta %*% t(X) + e
  list(y = drop(y), X = X)
}

#'
#' Function to optimize
#'
#' This is a function of estimate the coeficients of some sufficient condition
#' from the dataset.
#'
#' @param y A vector that gives the predict variable
#'
#' @param X A matrix that gives the samples of features
#'
#' @param lambda A number to penalize the complexity of the model
#'
#' @return A coeficient of selected feature form the sufficient condition.
#'
#' @examples
#' d = gen_dat()
#' estcondmin(d$y, d$X, lambda = 0.1)
#'
#' @import lpSolveAPI
#' @import magrittr
#'
#' @export
estcondmin <- function(y, X, lambda = 0){
  p <- ncol(X)
  n <- nrow(X)
  c <- colMeans(X)
  w = c(-c, rep(lambda,p))
  A <- cbind(rbind(X, -diag(1,nrow = p), diag(1, nrow = p)),
             rbind(matrix(0,n,p), -diag(1,nrow = p), -diag(1, nrow = p)))
  b <- c(y, rep(0, 2*p))

  library(lpSolveAPI)
  library(magrittr)
  lps.model <- make.lp(n+ 2*p, 2*p)
  for (i in 1:(2*p)) {
    set.column(lps.model, i, A[,i])
  }
  set.constr.type(lps.model, rep("<=", n + 2*p))
  set.rhs(lps.model, b = b)
  set.bounds(lps.model,lower=rep(-Inf, 2*p),upper=rep(Inf, 2*p))
  set.objfn(lps.model,obj=w)
  solve(lps.model)
  get.variables(lps.model) %>%
    matrix(ncol = 2) %>%
    (function(dat) dat[,1])
}
