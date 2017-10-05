## ------------------------------------------------------------------------
set.seed(1)
library(magrittr)
d <- estcondmin::gen_dat(n = 100, beta = c(1,1, 0, 0, 0))
knitr::kable(head(data.frame(y= d$y, d$X)))

## ------------------------------------------------------------------------
estcondmin::estcondmin(y = d$y, X = d$X, lambda = 0.3)

