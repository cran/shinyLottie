#' @title Navigate to a Specific Animation Frame
#'
#' @description Navigate to a specific frame or time and either stop or play the animation.
#'
#' @param value A numeric value specifying the frame or time to go to.
#' @param isFrame A logical value indicating whether \code{value} is a frame number (\code{TRUE}) or time (\code{FALSE}).
#' @param name A character string specifying the name of the 'Lottie' animation to control.
#' The default of "\code{all}" will control all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#' @name lottie_navigate_frame
#'
#' @return These functions are called for a side effect, and so there is no return value.
#'
#' @details
#' \code{lottie_goToAndStop} moves the animation to a specific frame or time, then stops it.
#' Sends a custom session message \code{"lottie_js_goToAndStop"} containing the function arguments.
#'
#' \code{lottie_goToAndPlay} moves the animation to a specific frame or time, then continues playback.
#' Sends a custom session message \code{"lottie_js_goToAndPlay"} containing the function arguments.
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
#'     name = "my_animation"
#'   ),
#'   actionButton("goToAndStop", "Go To Frame 10 And Stop"),
#'   actionButton("goToAndPlay", "Go To Frame 10 And Play")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$goToAndStop, {
#'     lottie_goToAndStop(value = 10, isFrame = TRUE, name = "my_animation")
#'   })
#'
#'   observeEvent(input$goToAndPlay, {
#'     lottie_goToAndPlay(value = 10, isFrame = TRUE, name = "my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @rdname lottie_navigate_frame
#' @export
lottie_goToAndStop <- function(value, isFrame = TRUE, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_goToAndStop", list(value = value, isFrame = isFrame, name = name))
}

#' @rdname lottie_navigate_frame
#' @export
lottie_goToAndPlay <- function(value, isFrame = TRUE, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_goToAndPlay", list(value = value, isFrame = isFrame, name = name))
}
