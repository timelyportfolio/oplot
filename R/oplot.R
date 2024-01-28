#' Observable Plot 'htmlwidget'
#'
#' Simple barebones functions to create \href{https://observablehq.com/plot/}{Observable plot}
#'   \code{htmlwidget} from 'R' for use in 'HTML', 'rmarkdown', 'quarto', and 'Shiny'.
#'
#' @param spec \code{list} with Observable plot 'spec' in 'R' form
#' @param height,width  height and width of sunburst 'htmlwidget' containing 'div'
#'          specified in any valid \code{CSS} size unit.
#' @param elementId string id as a valid \code{CSS} element id.
#'
#' @import htmlwidgets
#'
#' @export
#' @return \code{htmlwidget}
oplot <- function(
  x = NULL,
  width = NULL,
  height = NULL,
  elementId = NULL
) {

  # at this point do nothing
  #   just pass on JS code provided as x
  #   and eval the whole thing
  #   I think we can do better

  # create widget
  htmlwidgets::createWidget(
    name = 'oplot',
    x = x,
    width = width,
    height = height,
    package = 'oplot',
    elementId = elementId
  )
}

#' Shiny bindings for oplot
#'
#' Output and render functions for using oplot within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a oplot
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name oplot-shiny
#'
#' @export
oplotOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'oplot', width, height, package = 'oplot')
}

#' @rdname oplot-shiny
#' @export
renderOplot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, oplotOutput, env, quoted = TRUE)
}


#' 'oplot' 'JavaScript' Dependencies
#'
#' @return \code{list} of \code{htmltools} dependencies
#' @seealso \link[htmltools]{htmlDependencies}
#' @export

oplot_dependencies <- function() {
  Filter(
    function(x) {x$name %in% c('d3', 'plot')},
    htmlwidgets::getDependency('oplot','oplot')
  )
}
