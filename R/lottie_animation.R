#' Generate 'Lottie' Animation for a 'shiny' application
#'
#' Generates a 'Lottie' animation for use within a 'shiny' application.
#'
#' @param path Either a URL or local file path (see Note).
#' @param name A character string specifying the name to give to the animation.
#' @param loop Logical indicating whether the animation should loop.
#' @param autoplay Logical indicating whether the animation should autoplay.
#' @param renderer The renderer to use for the animation, either \code{"svg"}, \code{"canvas"}, or \code{"html"}.
#' @param width The width of the animation container. This is validated using \code{\link[htmltools:validateCssUnit]{validateCssUnit}}.
#' @param height The height of the animation container. This is validated using \code{\link[htmltools:validateCssUnit]{validateCssUnit}}.
#' @param ... Additional animation options, including:
#'   \describe{
#'     \item{\code{speed}}{A numeric specifying the desired animation speed.}
#'     \item{\code{direction}}{Either \code{1} for forward playback or \code{-1} for reverse playback.}
#'     \item{\code{setSubFrame}}{A logical value specifying whether a 'Lottie' animation should loop (\code{TRUE}) or not (\code{FALSE}).}
#'     \item{\code{playSegments}}{A numeric vector or list of numeric vectors indicating the segment(s) to be played.}
#'     \item{\code{forceFlag}}{Logical value indicating whether to force the animation to play the specified segments immediately (\code{TRUE}) or wait until the current animation completes (\code{FALSE}).}
#'   }
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return A list containing the following elements:
#' \describe{
#'   \item{\code{div}}{An HTML \code{div} element serving as the 'Lottie' animation container.}
#'   \item{\code{script}}{A \code{script} tag containing the 'JavaScript' to initialise the 'Lottie' animation.}
#' }
#'
#' @section Note: When using a local file path, you may need to use \code{\link[shiny:addResourcePath]{addResourcePath}}.
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(shinyLottie)
#'
#' ui <- fluidPage(
#'   include_lottie(),
#'   lottie_animation(
#'     path = "shinyLottie/example.json",
#'     name = "my_animation"
#'   )
#' )
#'
#' server <- function(input, output, session) {}
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_animation <- function(path,
                             name,
                             loop = TRUE,
                             autoplay = TRUE,
                             renderer = "svg",
                             width = "400px",
                             height = "400px",
                             ...,
                             session = shiny::getDefaultReactiveDomain()) {

  # Check inputs
  stopifnot(is.logical(loop) & is.logical(autoplay))
  renderer <- match.arg(renderer, c("svg", "canvas", "html"))

  # Generate JS body
  js <- generate_animation_body(path, name, loop, autoplay, renderer)

  # Append additional options if specified
  js <- append_animation_options(js, ...)

  # Add animation to window.lottieInstances
  js <- glue::glue("{js} \n window.lottieInstances['{name}'] = animation;")

  # If 'shiny' is not running, wrap JS in a 'DOMContentLoaded' eventListener
  if (!shiny::isRunning()) {
    js <- glue::glue("document.addEventListener('DOMContentLoaded', function() {{\n {js} \n}});")
  }

  # Return animation
  list(div = htmltools::tags$div(
    id = glue::glue("{name}_div"),
    style = glue::glue(
      "width: {validateCssUnit(width)}; height: {validateCssUnit(height)};"
    )
  ),
  script = htmltools::tags$script(htmltools::HTML(js)))
}
