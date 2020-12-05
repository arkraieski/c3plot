
<!-- README.md is generated from README.Rmd. Please edit that file -->

# c3plot

The goal of c3plot is provide to a base ‘graphics’-like interface to the
[C3.js](https://c3js.org/) JavaScript charting library. The main
`c3plot()` function is an s3 generic like the base `plot()` function
with methods for various base R objects.

Besides `htmlwidgets`, it has minimal R dependencies.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("arkraieski/c3plot")
```

## Example

Here’s some example code for a basic scatter plot using R’s `airquality` dataset:

``` r
library(c3plot)
air <- airquality
c3plot(air$Ozone, air$Solar.R, 
       main = "New York Air Quality Measurements", 
       xlab = "Ozone (ppb)",
       ylab = "Solar Radiation (lang)",
       col = "red")
```



## Methods

To see a list of S3 methods:

``` r
methods(c3plot)
#> [1] c3plot.default*  c3plot.density*  c3plot.function*
#> see '?methods' for accessing help and source code
```

More are on the way\! The goal is to replicate the behavior of base R
`plot()` methods as closely as possible while also getting the benefits
of using C3.

## Testing

Basic tests are implemented, but this is a WIP.
