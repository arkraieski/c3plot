#' Generic Plotting with 'C3.js'
#'
#' This is a generic function for plotting 'R' objects using the \href{http://c3js.org/}{C3.js} charting library. The syntax is similar to that of the \code{plot()} generic function.
#'
#' For simple scatter and line plots, \code{\link{c3plot.default}} will be used. However, there are \code{c3plot} methods for various 'R' objects. Use \code{methods(c3plot)} and the documentation for these.
#'
#' @param x x coordinates for points or any 'R' object with a \code{c3plot} method.
#' @param ... arguments passed to methods.
#'
#'
#' @details
#' Plots created with this are interactive \code{\link[htmlwidgets:htmlwidgets-package]{htmlwidgets}} that can be used in the RStudio Viewer or embedded into 'R Markdown' documents, 'Shiny' web applications, etc.
#'
#' For the default method, the argument \code{y} with the y coordinates of points is required. For some methods, such as \code{\link{c3plot.density}} and \code{\link{c3plot.function}}, \code{y} is not required because those methods can compute or extract y coordinates from the \code{x} object
#'
#' @examples
#' data(mtcars)
#' c3plot(mtcars$disp, mtcars$hp, main = "Displacement vs. HP in mtcars")
#'
#'
#' c3plot(qnorm)
#' @export
c3plot <- function(x, ...) {
  UseMethod("c3plot")
}

#' The Default C3 Scatterplot Function
#'
#' Draw an interactive scatterplot or line plot using 'C3.js'.
#'
#' @param x the x coordinates for the plot.
#' @param y the y coordinates for the plot.
#' @param type 1-character string giving the type of plot desired. The following values are possible: "p" for points, "l" for lines, and "b" for both points and lines.
#' @param main a main title for the plot.
#' @param xlab a label for the x axis, defaults to a description of x.
#' @param ylab a label for the y axis, defaults to a description of y.
#' @param zoom should the zooming feature (controlled my mouse wheel event) be enabled for the plot?
#' @param col.group optionally, a factor the same length as \code{x} by which to group and color points
#' @param col a color for plotting the points.
#' @param ... arguments passed to \code{\link[htmlwidgets:createWidget]{htmlwidgets::createWidget()}}: \code{width}, \code{height}, and \code{elementId}. These arguments default to NULL.
#'
#' @method c3plot default
#'
#' @examples
#' data(mtcars)
#' c3plot(mtcars$hp, mtcars$qsec)
#' c3plot(mtcars$disp, mtcars$hp, main = "Displacement vs. HP in mtcars")
#' @export
#' @importFrom grDevices colors
#' @importFrom gplots col2hex
c3plot.default <- function(x, y, type  = "p", main = NULL, xlab = NULL, ylab = NULL, zoom = TRUE, col.group = NULL, col = NULL, ...){
  if(type == "p"){
    plot_type <- "scatter"
    show_points <- TRUE

  } else if(type == "l"){
    plot_type <- "line"
    show_points <- FALSE

  } else if(type == "b"){
    plot_type <- "line"
    show_points <- TRUE

  } else {
    stop('type must be "p", "l", or "b"', call. = FALSE)
  }

  if(is.null(xlab)) xlab <- deparse(substitute(x))
  if(is.null(ylab)) ylab <- deparse(substitute(y))

  if(!is.null(col)){
    if(!is.character(col)){
      stop("col must be a character vector", call. = FALSE)
    }
    if(length(col) == 1) {
      if(grepl("^#(?:[0-9a-fA-F]{3}){1,2}$", col)){
        col_hex <- col
        } else if(col %in% colors()) {
        col_hex <- col2hex(col)
        } else {
          stop("Invalid colors in col. Run colors() to see all supported color names", call. = FALSE)
        }
      } else {
          if(is.null(col.group)){
            stop("Argument col.groups must be specified to use multiple colors", call. = FALSE)
          }
          col_parsed <-  ifelse(col %in% colors(),
                                col2hex(col),
                                col)
          if(any(!grepl("^#(?:[0-9a-fA-F]{3}){1,2}$", col_parsed))){
            stop("Invalid colors in col. Run colors() to see all supported color names", call. = FALSE)
          }

          data_by_group <- split(data.frame(x, y), col.group)
          group_names <- names(data_by_group)

          grouped_data <- list(x = list(), y = list())
          for(i in group_names){
            grouped_data$x[[i]] <- data_by_group[[i]]$x
            grouped_data$y[[i]] <- data_by_group[[i]]$y
          }

          col_hex <- col_parsed

        }

  } else {
    col_hex <- NULL
    group_names <- NULL
    grouped_data <- NULL
  }

  data <- list(x = x,
               y = y,
               plot_type = plot_type,
               title = main,
               xlab = xlab,
               ylab = ylab,
               show_points = show_points,
               zoom = zoom,
               col_hex = col_hex,
               group_names = group_names,
               grouped_data = grouped_data)

  c3Scatter(data, ...)
}


#' c3plot Method for  Kernel Density Estimation
#'
#' The \code{c3plot} method for density objects
#'
#' @param x a "density" object
#' @param main a main title for the plot.
#' @param xlab label for the x axis
#' @param ylab a label for the y axis, defaults to a description of y.
#' @param type 1-character string giving the type of plot desired. The following values are possible: "p" for points, "l" for lines, and "b" for both points and lines.
#' @param ... arguments passed to other methods
#'
#' @method c3plot density
#'
#' @export
c3plot.density <- function(x, main = NULL, xlab = NULL,  ylab = "Density", type = "l", ...){

  if(is.null(xlab))
    xlab <- paste("N =", x$n, "  Bandwidth =", formatC(x$bw))
  if(is.null(main)) main <- deparse(x$call)
  c3plot.default(x = x$x, y = x$y, main = main, xlab = xlab, ylab = ylab, type = type, ...)

}

#' Draw Function Plots with 'C3.js'
#'
#' Draws a curve corresponding to a function over the interval \code{[from, to]} in an interactive plot using 'C3.js'
#'
#' @param x The name of a function.
#' @param from the lower limit of the range over which the function will be plotted.
#' @param to the upper limit of the range over which the function will be plotted.
#' @param ylab a label for the y axis, defaults to the name of the function specified in \code{x}.
#' @param ... arguments passed to other methods
#'
#' @method c3plot function
#'
#' @examples
#' c3plot(qnorm)
#'
#' c3plot(sin, -pi, 2*pi)
#' @export
c3plot.function <-function(x, from = 0, to = 1, ylab = NULL, ...){

  if(is.null(ylab)) ylab <- deparse(substitute(x))
  xlab <- "x"
  xname <- xlab

  sexpr <- substitute(x)
  if (is.name(sexpr)) {
    ## better than parse() !
    x <- call(as.character(sexpr), as.name(xname))
  } else {
    if ( !( (is.call(sexpr) || is.expression(sexpr)) &&
            xname %in% all.vars(sexpr) ))
      stop(gettextf("'expr' must be a function, or a call or an expression containing '%s'", xname), domain = NA)
    expr <- sexpr
  }

  xseq <- seq(from = from, to = to, length.out = 101)
  ll <- list(x = xseq); names(ll) <- xname
  ll$y <- eval(x, envir = ll, enclos = parent.frame())
  c3plot.default(x = ll$x, y = ll$y, xlab = xlab, ylab = ylab, type = "l", ...)

}

#' Create a C3 scatterplot
#'
#' Internal function called by c3plot methods to send data to 'C3.js'
#'
#' @import htmlwidgets
#'
#' @noRd
c3Scatter <- function(data, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
   data = data
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'c3Scatter',
    x,
    width = width,
    height = height,
    package = 'c3plot',
    elementId = elementId
  )
}

#' Shiny bindings for c3plot
#'
#' Output and render functions for using c3plot within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a c3Scatter
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name c3plot-shiny
#' @export
c3plotOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, "c3Scatter", width, height, package = 'c3plot')
}

#' @rdname c3plot-shiny
#' @export
renderC3plot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, c3plotOutput, env, quoted = TRUE)
}
