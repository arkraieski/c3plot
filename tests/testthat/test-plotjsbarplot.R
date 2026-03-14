context("plotjsbarplot")




test_that("plotjsbarplot() works for a simple example", {
  b <- plotjsbarplot(c(100, 30), names.arg = c("Red Sox", "Yankees"), ylab = "% Awesome", main = "Awesomeness of Baseball Teams")

  expect_is(b, "plotjsbarplot")
  expect_is(b, "htmlwidget")
  expect_equal(b$x$categories, c("Red Sox", "Yankees"))
})

test_that("plotjsbarplot() works with a named color", {
  c <- plotjsbarplot(c(100, 30), names.arg = c("Red Sox", "Yankees"), ylab = "% Awesome", col = "red", main = "Awesomeness")

  expect_is(c, "plotjsbarplot")
  expect_is(c, "htmlwidget")
  expect_equal(c$x$col, "#FF0000")
})


test_that("plotjsbarplot() works with a hex color", {
  h <- plotjsbarplot(c(100, 30), names.arg = c("Red Sox", "Yankees"), ylab = "% Awesome", col = "#FF2800", main = "Awesomeness")

  expect_is(h, "plotjsbarplot")
  expect_is(h, "htmlwidget")
})


context("plotjs.factor")

test_that("plotjs.factor works", {
  mtcars <- mtcars
  mtcars$cyl <- as.factor(mtcars$cyl)

  f <- plotjs(mtcars$cyl)

  expect_is(f, "plotjsbarplot")
  expect_is(f, "htmlwidget")

})
