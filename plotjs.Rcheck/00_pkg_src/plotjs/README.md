
<!-- README.md is generated from README.Rmd. Please edit that file -->

# plotjs

![GitHub Workflow
Status](https://img.shields.io/github/actions/workflow/status/arkraieski/plotjs/check-standard.yaml)

The goal of plotjs is provide to a base ‘graphics’-like interface to the
[Chart.js](https://www.chartjs.org/) JavaScript charting library. The main
`plotjs()` function is an S3 generic like the base `plot()` function
with methods for various base R objects.

Besides `htmlwidgets`, it has minimal R dependencies. Tidyverse not
required!

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("arkraieski/plotjs")
```

## Example

Here’s some example code for a basic scatter plot using R’s `airquality`
dataset:

``` r
library(plotjs)
air <- airquality
plotjs(air$Ozone, air$Solar.R, 
       main = "New York Air Quality Measurements", 
       xlab = "Ozone (ppb)",
       ylab = "Solar Radiation (lang)",
       col = "red")
```

## Methods

To see a list of S3 methods:

``` r
library(plotjs)
methods(plotjs)
#> [1] plotjs.default*  plotjs.density*  plotjs.factor*   plotjs.function*
#> [5] plotjs.lm*      
#> see '?methods' for accessing help and source code
```

More are on the way! The goal is to replicate the behavior of base R
`plot()` methods as closely as possible while also getting the benefits
of using a Chart.js-backed interactive widget. Each method has its own help page that
can be accessed for additional information.

## Testing

The package is tested on Windows, Linux, and MacOS.
