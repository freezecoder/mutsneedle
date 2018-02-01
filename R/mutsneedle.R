#' Mutsneedle
#'
#' Interactive mutation lolipop chart from the Muts-Needle-Plot package from R
#'
#' @examples
#' Example - with data
#'
#'
#' #Get some mutation and region data
#
#' data <- exampleMutationData()
#'
#' regiondata <- exampleRegionData()
#'
#' #Make the lolipop chart
#
#' mutsneedle(mutdata=data,domains=regiondata)
#'@examples
#'
#' # Example 2 - in a Shiny app
#'
#'
#' library(shiny)
#' shinyApp(
#'   ui = mutsneedleOutput("id",width=800,height=500),
#'   server = function(input, output) {
#'     output$id <- renderMutsneedle(
#'        data <- exampleMutationData()
#'        regiondata <- exampleRegionData()
#'       mutsneedle(mutdata=data,domains=regiondata)
#'     )
#'   }
#' )
#'
#' @import htmlwidgets
#'
#' @export
mutsneedle <- function(title=" Mutation Needle Plot",domains=NULL, mutdata=NULL,colorMap=NULL,gene="TP53",transcript="ENST032423423",maxlength=800,width = NULL, height = NULL, elementId = NULL,xlab=NULL,ylab=NULL) {

  if (!is.data.frame(mutdata)) {
    stop("mutsneedle: 'mutdata' must be a data.frame with 'coord', 'category' and 'value' cols ",
         call. = FALSE)
  }

  if (!is.null(mutdata))
    mutdata = dataframeToD3(mutdata)
  if (!is.null(colorMap))
    colorMap = dataframeToD3(colorMap)
  if (!is.null(domains))
    domains = dataframeToD3(domains)

  # forward options to javascript using named 'opts'
  opts = list(
    message =title,
    mutdata=mutdata,
    transcript=transcript,
    colorMap=colorMap,
    gene=gene,
    domains=domains,
    max=maxlength,
    xlab=xlab,
    ylab=ylab
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'mutsneedle',
    opts,
    width = width,
    height = height,
    package = 'mutsneedle',
    elementId = elementId
  )
}

#' Shiny bindings for mutsneedle
#'
#' Output and render functions for using mutsneedle within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a mutsneedle
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name mutsneedle-shiny
#'
#' @export
mutsneedleOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'mutsneedle', width, height, package = 'mutsneedle')
}

#' @rdname mutsneedle-shiny
#' @export
renderMutsneedle <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, mutsneedleOutput, env, quoted = TRUE)
}

#' @rdname mutsneedle-shiny
#' @export
dataframeToD3 <- function(df) {
  if (missing(df) || is.null(df)) {
    return(list())
  }
  if (!is.data.frame(df)) {
    stop("timevis: the input must be a dataframe", call. = FALSE)
  }

  row.names(df) <- NULL
  apply(df, 1, function(row) as.list(row[!is.na(row)]))
}

#' @rdname mutsneedle-shiny
#' @export
exampleRegionData<-function(){
 return(data.frame(
    coord=c("7-10","34-60","300-500"),
    name=c("tetramer","dmainx","Box Domain")
  ))
}

#' @rdname mutsneedle-shiny
#' @export
exampleMutationData<-function(){
  return(data.frame(
    coord=c("31","300","399","500"),
    category=c("missense_variant","missense_variant","missense_variant","frameshift_variant"),
    value=c(120,12,30,45)
  ))
}


