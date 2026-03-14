# Factor Variable Bar Plots

This function implements a bar plot method for `factor` arguments to the
[`c3plot`](c3plot.md) generic function. Bar heights will be counts for
the factor levels.

## Usage

``` r
# S3 method for class 'factor'
c3plot(x, ylab = "Count", ...)
```

## Arguments

- x:

  a factor.

- ylab:

  a label for the y axis.

- ...:

  arguments passed to [`c3barplot`](c3barplot.md).

## See also

[`c3barplot()`](c3barplot.md)

## Examples

``` r
mtcars <- mtcars
mtcars$cyl <- as.factor(mtcars$cyl)
c3plot(mtcars$cyl)

{"x":{"height":[11,7,14],"categories":["4","6","8"],"col":null,"main":null,"ylab":"Count"},"evals":[],"jsHooks":[]}
```
