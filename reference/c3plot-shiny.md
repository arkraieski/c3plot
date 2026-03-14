# Shiny bindings for c3plot

Output and render functions for using c3plot within Shiny applications
and interactive Rmd documents.

## Usage

``` r
c3plotOutput(outputId, width = "100%", height = "400px")

renderc3plot(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- outputId:

  output variable to read from

- width, height:

  Must be a valid CSS unit (like `'100%'`, `'400px'`, `'auto'`) or a
  number, which will be coerced to a string and have `'px'` appended.

- expr:

  An expression that generates a c3Scatter

- env:

  The environment in which to evaluate `expr`.

- quoted:

  Is `expr` a quoted expression (with
  [`quote()`](https://rdrr.io/r/base/substitute.html))? This is useful
  if you want to save an expression in a variable.
