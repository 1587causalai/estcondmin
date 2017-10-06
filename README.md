# estcondmin

![Travis badge](https://travis-ci.org/HeyangGong/estcondmin.svg?branch=master)


The goal of estcondmin is to estimate the conditional minn of y give X.

To get started, read the details of this data analysis package in vignette

## Example

This is a basic example which shows you how to solve a common problem:

```R
library(estcondmin)
d <- gen_dat()
estcondmin(d$y, d$X, lambda = 0.1)
...
```
