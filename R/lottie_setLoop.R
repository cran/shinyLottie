#' @title Adjust 'Lottie' Animation Looping
#'
#' @description Adjust the looping behaviour of a 'Lottie' animation.
#'
#' @param flag Logical value specifying whether a 'Lottie' animation should loop (\code{TRUE}) or not (\code{FALSE}).
#' @param name A character string specifying the name of the 'Lottie' animation to control.
#' The default of "\code{all}" will control all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details Sends a custom session message \code{"lottie_js_setLoop"} containing the function arguments.
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
#'   actionButton("play", "Play"),
#'   actionButton("loopOn", "Loop On"),
#'   actionButton("loopOff", "Loop Off")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$play, {
#'     # Non-looped animations can not be resumed without first being stopped
#'     lottie_stop(name = "my_animation")
#'     lottie_play(name = "my_animation")
#'   })
#'
#'   observeEvent(input$loopOn, {
#'     lottie_setLoop(flag = TRUE, name = "my_animation")
#'   })
#'
#'   observeEvent(input$loopOff, {
#'     lottie_setLoop(flag = FALSE, name = "my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_setLoop <- function(flag, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_setLoop", list(flag = flag, name = name))
}
