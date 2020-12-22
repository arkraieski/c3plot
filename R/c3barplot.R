#' C3 Bar Plots
#'
#' Creates a bar plot using 'C3.JS'
#'
#' @param heights a vector of values describing the bars that make up the plot
#' @param width width of the widget to create for the plot. The default is NULL, which results in automatic resizing based on the plot's container.
#' @param height height of the widget to create for the plot. The default is NULL, which results in automatic resizing based on the plot's container.
#' @param elementId Use an explicit element ID for the widget, rather than an automatically generated one.
#' @import htmlwidgets
#'
#' @export
c3barplot <- function(heights, width = NULL, height = NULL, elementId = NULL) {



  # forward options using x
  x = list(
    height = heights
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'c3barplot',
    x,
    width = width,
    height = height,
    package = 'c3plot',
    elementId = elementId
  )
}

#' Shiny bindings for c3barplot
#'
#' Output and render functions for using c3barplot within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a c3barplot
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name c3barplot-shiny
#'
#' @export
c3barplotOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'c3barplot', width, height, package = 'c3plot')
}

#' @rdname c3barplot-shiny
#' @export
renderC3barplot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, c3barplotOutput, env, quoted = TRUE)
}
