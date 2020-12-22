context("c3barplot")




test_that("c3barplot() works for a simple example", {
  b <- c3barplot(c(100, 30), names.arg = c("Red Sox", "Yankees"), ylab = "% Awesome", main = "Awesomeness of Baseball Teams")

  expect_is(b, "c3barplot")
  expect_is(b, "htmlwidget")

})

test_that("c3barplot() works with a named color", {
  c <- c3barplot(c(100, 30), names.arg = c("Red Sox", "Yankees"), ylab = "% Awesome", col = "red", main = "Awesomeness")

  expect_is(c, "c3barplot")
  expect_is(c, "htmlwidget")
})


test_that("c3barplot() works with a hex color", {
  h <- c3barplot(c(100, 30), names.arg = c("Red Sox", "Yankees"), ylab = "% Awesome", col = "#FF2800", main = "Awesomeness")

  expect_is(h, "c3barplot")
  expect_is(h, "htmlwidget")
})


context("c3plot.factor")

test_that("c3plot.factor works", {
  mtcars <- mtcars
  mtcars$cyl <- as.factor(mtcars$cyl)

  f <- c3plot(mtcars$cyl)

  expect_is(f, "c3barplot")
  expect_is(f, "htmlwidget")

})
