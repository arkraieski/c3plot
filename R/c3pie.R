#' C3 Pie Charts
#'
#' Draw an interactive pie chart using 'C3.js'
#'
#' @param x a vector of non-negative numerical quantities. The values in x are displayed as the areas of pie slices.
#' @param labels character vector giving names for the slices.
#' @param col character vector of colors to be used in filling the slices. Can be a hex value or an R built-in color name.
#' @param main a main title for the plot.
#' @param width width of the widget to create for the plot. The default is NULL, which results in automatic resizing based on the plot's container.
#' @param height height of the widget to create for the plot. The default is NULL, which results in automatic resizing based on the plot's container.
#' @param elementId Use an explicit element ID for the widget, rather than an automatically generated one.
#' @import htmlwidgets
#' @importFrom gplots col2hex
#' @importFrom grDevices colors
#' @examples
#'
#' pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
#' names(pie.sales) <- c("Blueberry", "Cherry",
#'                     "Apple", "Boston Cream", "Other", "Vanilla Cream")
#' c3pie(pie.sales)
#' c3pie(pie.sales, col = c("purple", "violetred1", "green3",
#'                       "cornsilk", "cyan", "white"))
#'
#' @export
c3pie <- function(x, labels = names(x), col = NULL, main = NULL,
                  width = NULL, height = NULL, elementId = NULL) {
  if(length(x) !=  length(labels)){
    stop("x and labels must be the same length")
  }
  if(!is.null(col)){
    if(!is.character(col)){
      stop("col must be a character vector", call. = FALSE)
    }
    if(length(col) != length(x)){
      stop("col is not same length as x")
    }
    col_hexes <- ifelse(col %in% colors(),
                        col2hex(col),
                        col)
    if(any(!grepl("^#(?:[0-9a-fA-F]{3}){1,2}$", col_hexes))){
      stop("Invalid colors in col. Run colors() to see all supported color names", call. = FALSE)
    }
  } else(
    col_hexes <- NULL
  )
  # forward options using x
  x <-  list(
    labels = labels,
    values = unname(x),
    colors = col_hexes,
    main = main
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'c3pie',
    x,
    width = width,
    height = height,
    package = 'c3plot',
    elementId = elementId
  )
}

#' Shiny bindings for c3pie
#'
#' Output and render functions for using c3pie within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a c3pie
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name c3pie-shiny
#'
#' @export
c3pieOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'c3pie', width, height, package = 'c3plot')
}

#' @rdname c3pie-shiny
#' @export
renderC3pie <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, c3pieOutput, env, quoted = TRUE)
}
