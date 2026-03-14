
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
  expect_is(c, "htmlwidget")
})

mtcars$cyl <- as.factor(mtcars$cyl)



test_that("coloring by group works in c3plot()",{

  g <- c3plot(mtcars$hp, mtcars$mpg, col.group = mtcars$cyl)

  expect_is(g, "c3Scatter")
  expect_is(g, "htmlwidget")

})

test_that("c3plot() throws an invalid color error",{
  expect_error(c3plot(x = mtcars$mpg, y = mtcars$qsec, col = "fakecolor"), "Invalid colors")
})


test_that("c3plot() works with a list of color names", {
  mtcars$cyl <- as.factor(mtcars$cyl)
  cg <- c3plot(mtcars$disp, mtcars$mpg, col.group = mtcars$cyl, col = c("blue", "red", "black"))

  expect_is(cg, "c3Scatter")
  expect_is(cg, "htmlwidget")
})



context("c3plot.lm")

test_that("c3plot.lm() creates an html widget",{
  lm.SR <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings)
  l <- c3plot(lm.SR)

  expect_is(l, "c3Scatter")
  expect_is(l, "htmlwidget")
  }
)


context("c3plot.function")

test_that("c3plot.function() works",{
  q <- c3plot(qnorm)

  expect_is(q, "c3Scatter")
  expect_is(q, "htmlwidget")
})
