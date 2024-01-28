library(oplot)
library(htmltools)

oplot()

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
