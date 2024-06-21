#' @title Play Specific Segments of a 'Lottie' Animation
#'
#' @description Play specific segments of a 'Lottie' animation.
#'
#' @param segments A numeric vector or list of numeric vectors indicating the segment(s) to be played.
#' @param forceFlag Logical value indicating whether to force the animation to play the specified segments immediately (\code{TRUE}) or wait until the current animation completes (\code{FALSE}).
#' @param name A character string specifying the name of the 'Lottie' animation to control.
#' The default of "\code{all}" will control all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details Sends a custom session message \code{"lottie_js_playSegments"} containing the function arguments.
#'
#' @note To play a single segment, \code{segments} should be a numeric vector of length 2 that represents the start and end frames.
#' To play multiple segments, provide a list containing multiple numeric vectors of length 2. Note that if the animation
#' is set to be looped, only the final segment will be repeated.
#'
#' @seealso \code{\link{lottie_animation_methods}} for similar methods.
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(shinyLottie)
#'
#' ui <- fluidPage(
#'   include_lottie(),
#'   lottie_animation(
#'     path = "shinyLottie/example.json",
#'     name = "my_animation",
#'     loop = FALSE,
#'     speed = 0.5 # Slowed to make effects clearer
#'   ),
#'   actionButton("playSegments1", "Play Frames 1 - 10"),
#'   # Will not work if animation has less than 40 frames
#'   actionButton("playSegments2", "Play Frames 1 - 10 and 30 - 40")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$playSegments1, {
#'     lottie_playSegments(segments = c(1, 10), forceFlag = TRUE,
#'       name = "my_animation")
#'   })
#'
#'   observeEvent(input$playSegments2, {
#'     lottie_playSegments(segments = list(c(1, 10), c(30, 40)),
#'       forceFlag = TRUE, name = "my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_playSegments <- function(segments, forceFlag = TRUE, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_playSegments", list(segments = segments, forceFlag = forceFlag, name = name))
}
