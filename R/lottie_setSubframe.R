#' @title Set 'Lottie' Animation Subframe Rendering
#'
#' @description Adjust the subframe rendering of a 'Lottie' animation.
#'
#' @param flag A logical value specifying whether a 'Lottie' animation should use subframe rendering (\code{TRUE}) or not (\code{FALSE}).
#' @param name A character string specifying the name of the 'Lottie' animation to control.
#' The default of "\code{all}" will control all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details Sends a custom session message \code{"lottie_js_setSubframe"} containing the function arguments.
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
#'   actionButton("subframeOn", "Subframe On"),
#'   actionButton("subframeOff", "Subframe Off")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$subframeOn, {
#'     lottie_setSubframe(flag = TRUE, name = "my_animation")
#'   })
#'
#'   observeEvent(input$subframeOff, {
#'     lottie_setSubframe(flag = FALSE, name = "my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_setSubframe <- function(flag, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_setSubframe", list(flag = flag, name = name))
}
