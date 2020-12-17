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
#' @param xlim the x limits (x1, x2) of the plot.
#' @param ylim the y limits of the plot.
#' @param main a main title for the plot.
#' @param xlab a label for the x axis, defaults to a description of x.
#' @param ylab a label for the y axis, defaults to a description of y.
#' @param zoom logical; should the zooming feature (controlled my mouse wheel event) be enabled for the plot?
#' @param col.group optionally, a factor the same length as \code{x} by which to group and color points.
#' @param col The colors for the lines and points. If \code{col.group} is specified, this can be a vector of colors to use for each group in the data. If \code{NULL}, the C3 default colors are used.
#' @param legend.title a title for the legend.
#' @param sci.x logical indicating whether scientific notation should be used for the x-axis.
#' @param sci.y logical indicating whether scientific notation should be used for the x-axis.
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
c3plot.default <- function(x, y, type  = "p", xlim = NULL, ylim = NULL, main = NULL, xlab = NULL,
                           ylab = NULL, zoom = TRUE, col.group = NULL,
                           col = NULL, legend.title = NULL, sci.x = FALSE,
                           sci.y = FALSE, ...){
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

  if(!is.null(xlim) && (xlim[1] > xlim[2] || length(xlim) != 2) ) stop("xlim must be either NULL or a length 2 numeric vector where the second element is greater than the first")

  if(!is.null(ylim) && (ylim[1] > ylim[2] || length(ylim) != 2)) stop("ylim must be either NULL or a length 2 numeric vector where the second element is greater than the first")

  # function to split data by col.group
  split_data_groups <- function(x, y, col.group) {
    data_by_group <- split(data.frame(x, y)[!(is.na(x) & is.na(y)),], col.group)
    group_names <<- names(data_by_group) # sorry

    grouped_data <- list(x = list(), y = list())
    for(i in group_names){
      grouped_data$x[[i]] <- data_by_group[[i]]$x
      grouped_data$y[[i]] <- data_by_group[[i]]$y
    }
    grouped_data
  }



  if(is.null(xlab)) xlab <- deparse(substitute(x))
  if(is.null(ylab)) ylab <- deparse(substitute(y))

  if(!is.null(col)){
    if(!is.character(col)){
      stop("col must be a character vector")
    }
    if(length(col) == 1) {


      group_names <- NULL
      grouped_data <- NULL

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

          r_colors <- colors()
          col_parsed <-  ifelse(col %in% r_colors,
                                col2hex(col),
                                col)
          if(any(!grepl("^#(?:[0-9a-fA-F]{3}){1,2}$", col_parsed))){
            stop("Invalid colors in col. Run colors() to see all supported color names", call. = FALSE)
          }


          group_names <- NULL # function call below will assign a value to this variable
          grouped_data <- split_data_groups(x, y, col.group)

          col_hex <- col_parsed

        }

  } else if(is.null(col) & !is.null(col.group)) {
    group_names <- NULL # function call below will assign value to this variable
    grouped_data <- split_data_groups(x, y, col.group)
    col_hex <- NULL
  }
    else {
    col_hex <- NULL
    group_names <- NULL
    grouped_data <- NULL
    }

  if(is.null(legend.title) & !is.null(col.group)) legend.title <- deparse(substitute(col.group))

  data <- list(x = x,
               y = y,
               plot_type = plot_type,
               xlim = xlim,
               ylim = ylim,
               title = main,
               xlab = xlab,
               ylab = ylab,
               show_points = show_points,
               zoom = zoom,
               col_hex = col_hex,
               group_names = group_names,
               grouped_data = grouped_data,
               leg = legend.title,
               sci_x = sci.x,
               sci_y = sci.y)

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

#' C3 Plot Diagnostics for an lm Object
#'
#'a plot of residuals against fitted values
#'
#' @param x an "lm" object
#' @param which 1 is the only supported value currently. This argument is included for consistency with the base \code{plot.lm()} method.
#' @param ... arguments passed to other methods.
#' @method c3plot lm
#' @export
#' @import stats
c3plot.lm <- function(x, which = 1, ...){

  if (!inherits(x, "lm")) {
    stop("use only with \"lm\" objects")
    }


  r <- if(inherits(x, "glm")) residuals(x, type="pearson") else residuals(x)
  yh <- predict(x) # != fitted() for glm
  w <- weights(x)
  # if(!is.null(w)) { # drop obs with zero wt: PR#6640
  #   wind <- w != 0
  #   r <- r[wind]
  #   yh <- yh[wind]
  #   w <- w[wind]
  #   labels.id <- labels.id[wind]
  # }

  l.fit <- if (inherits(x, "glm")) "Predicted values" else "Fitted values"

  c3plot.default(x = unname(yh), y = unname(r), xlab = l.fit, ylab = "Residuals",
                 main = "Residuals vs. Fitted",
                 type = "p", ...)


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
