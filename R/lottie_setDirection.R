#' @title Adjust 'Lottie' Animation Direction
#'
#' @description Adjust the playback direction of an existing 'Lottie' animation.
#'
#' @param direction Either \code{1} for forward playback or \code{-1} for reverse playback.
#' @param name A character string specifying the name of the 'Lottie' animation to control.
#' The default of "\code{all}" will control all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details Sends a custom session message \code{"lottie_js_setDirection"} containing the function arguments.
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
#'   actionButton("forwards", "Play Forwards"),
#'   actionButton("backwards", "Play Backwards")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$forwards, {
#'     lottie_setDirection(direction = 1, name = "my_animation")
#'   })
#'
#'   observeEvent(input$backwards, {
#'     lottie_setDirection(direction = -1, name = "my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_setDirection <- function(direction = 1, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_setDirection", list(direction = direction, name = name))
}
