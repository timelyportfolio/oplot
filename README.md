# oplot - Crude Observable Plot htmlwidget

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN status](https://www.r-pkg.org/badges/version/oplot)](https://CRAN.R-project.org/package=oplot)
<!-- badges: end -->

Currently `oplot` is in a very alpha experimental (slightly embarrassing) form where we pass JavaScript through the `htmlwidgets` wrapper and then just `eval` on the JavaScript side.  While this works I know we can do so much better, but the design of Observable Plot with functions at the core poses some difficult challenges.  This all started with this [issue](https://github.com/ramnathv/htmlwidgets/issues/484) requesting a Plot wrapper.

## Installation

You can install the development version of oplot like so:

``` r
remotes::install_github("timelyportfolio/oplot")
```

## Example

### htmlwidget

Below you will see how ugly this looks in R, but we do get the plot that we expect as output.

``` r
library(oplot)
library(htmltools)

oplot('Plot.plot({
  marks: [
    Plot.frame(),
    Plot.text(["Hello, world!"], {frameAnchor: "middle"})
  ]
})')

# using sprintf with jsonlite we can provide data from R to JS
#  but of course this gets messy
#  be careful with % since they should be %% inside sprintf
oplot(HTML(
  sprintf(
'{ //# enclose in {} to prevent mtcars leakage into global/window
  let mtcars = %s
  Plot.dot(mtcars, {x: "hp", y: "mpg", fill: "cyl"}).plot()
}',
    jsonlite::toJSON(mtcars, auto_unbox = TRUE, dataframe = "rows")
  )
))
```
### dependencies

If you are just looking for the convenience of locally installed JS dependencies for Rmd/Md/HTML usage, then this package provides a helper function `oplot_dependencies()`.

**md/Rmd**

Add this bit of code anywhere in the `md`/`Rmd`.

``` r
htmltools::attachDependencies(htmltools::tagList(), oplot::oplot_dependencies())
```

**HTML**

``` r
tagList(
  oplot::oplot_dependencies()
  ... html ...
)
```
