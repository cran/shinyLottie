#' @title Control Playback of 'Lottie' Animations
#'
#' @description Control the playback of 'Lottie' animations within a 'shiny' application.
#'
#' @param name A character string specifying the name of the 'Lottie' animation to control.
#' The default of "\code{all}" will control all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#' @name lottie_playback_controls
#'
#' @return These functions are called for a side effect, and so there is no return value.
#'
#' @details Each function sends a corresponding custom session message containing the function arguments:
#'\itemize{
#'   \item Play: "\code{lottie_js_play}"
#'   \item Pause: "\code{lottie_js_pause}"
#'   \item Stop: "\code{lottie_js_stop}"
#' }
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
#'   actionButton("play", "Play Animation"),
#'   actionButton("pause", "Pause Animation"),
#'   actionButton("stop", "Stop Animation")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$play, {
#'     lottie_play(name = "my_animation")
#'   })
#'
#'   observeEvent(input$pause, {
#'     lottie_pause(name = "my_animation")
#'   })
#'
#'   observeEvent(input$stop, {
#'     lottie_stop(name = "my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
NULL

#' @rdname lottie_playback_controls
#' @export
lottie_play <- function(name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_play", list(name = name))
}

#' @rdname lottie_playback_controls
#' @export
lottie_pause <- function(name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_pause", list(name = name))
}

#' @rdname lottie_playback_controls
#' @export
lottie_stop <- function(name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_stop", list(name = name))
}
