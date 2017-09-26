# estcondmin

The goal of estcondmin is to estimate the conditional minn of y give X.

## Example

This is a basic example which shows you how to solve a common problem:

```R
library(estcondmin)
d <- gen_dat()
estcondmin(d$y, d$X, lambda = 0.1)
...
```
