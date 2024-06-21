#' @title Adjust 'Lottie' Animation Speed
#'
#' @description Adjust the speed of an existing 'Lottie' animation.
#'
#' @param speed A numeric specifying the desired animation speed.
#' @param name A character string specifying the name of the 'Lottie' animation to control.
#' The default of "\code{all}" will control all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details Sends a custom session message \code{"lottie_js_setSpeed"} containing the function arguments.
#'
#' @note A speed of 1 will apply the default animation speed. Use a value between 0 and 1 for a slower animation speed.
#' Applying a negative speed will also reverse the playback direction.
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
#'   numericInput("speed", "Speed", value = 1),
#'   actionButton("updateSpeed", "Update Speed")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$updateSpeed, {
#'     lottie_setSpeed(speed = input$speed, name = "my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_setSpeed <- function(speed = 1, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_setSpeed", list(speed = speed, name = name))
}
