
context('c3plot.default')

mtcars <- mtcars




test_that("c3plot.default creates an htmlwidget", {

  p <- c3plot(mtcars$hp, mtcars$qsec)

  expect_is(p, "c3Scatter")
  expect_is(p, "htmlwidget")
})




test_that("c3plot.default works with an R built-in color name for col", {

  c <- c3plot(mtcars$hp, mtcars$mpg, col = "chartreuse")

  expect_is(c, "c3Scatter")
  expect_is(p, "htmlwidget")
})


