library(testthat)
library(estcondmin)

test_that("hello, test", {
  expect_that("a", is_a("character"))
})

test_that("gen_dat test", {
  expect_that(gen_dat(), is_a("list"))
})
