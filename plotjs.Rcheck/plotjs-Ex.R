pkgname <- "plotjs"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('plotjs')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("plotjs")
### * plotjs

flush(stderr()); flush(stdout())

### Name: plotjs
### Title: Generic Plotting with 'Chart.js'
### Aliases: plotjs

### ** Examples

data(mtcars)
plotjs(mtcars$disp, mtcars$hp, main = "Displacement vs. HP in mtcars")
plotjs(qnorm)



cleanEx()
nameEx("plotjs.default")
### * plotjs.default

flush(stderr()); flush(stdout())

### Name: plotjs.default
### Title: The Default plotjs Scatterplot Function
### Aliases: plotjs.default

### ** Examples

data(mtcars)
plotjs(mtcars$hp, mtcars$qsec)
plotjs(mtcars$disp, mtcars$hp, main = "Displacement vs. HP in mtcars")



cleanEx()
nameEx("plotjs.factor")
### * plotjs.factor

flush(stderr()); flush(stdout())

### Name: plotjs.factor
### Title: Factor Variable Bar Plots
### Aliases: plotjs.factor

### ** Examples

mtcars <- mtcars
mtcars$cyl <- as.factor(mtcars$cyl)
plotjs(mtcars$cyl)



cleanEx()
nameEx("plotjs.function")
### * plotjs.function

flush(stderr()); flush(stdout())

### Name: plotjs.function
### Title: Draw Function Plots with 'Chart.js'
### Aliases: plotjs.function

### ** Examples

plotjs(qnorm)
plotjs(sin, -pi, 2 * pi)



cleanEx()
nameEx("plotjs.lm")
### * plotjs.lm

flush(stderr()); flush(stdout())

### Name: plotjs.lm
### Title: plotjs Diagnostics for an lm Object
### Aliases: plotjs.lm

### ** Examples

lm.SR <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings)
plotjs(lm.SR)



cleanEx()
nameEx("plotjspie")
### * plotjspie

flush(stderr()); flush(stdout())

### Name: plotjspie
### Title: plotjs Pie Charts
### Aliases: plotjspie

### ** Examples


pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry",
                    "Apple", "Boston Cream", "Other", "Vanilla Cream")
plotjspie(pie.sales)
plotjspie(pie.sales, col = c("purple", "violetred1", "green3",
                         "cornsilk", "cyan", "white"))




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
