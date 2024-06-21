#' @title Destroy a 'Lottie' Animation
#'
#' @description Permanently destroy a specific 'Lottie' animation or all 'Lottie' animations.
#'
#' @param name A character string specifying the name of the 'Lottie' animation to destroy.
#' The default of "\code{all}" will destroy all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details Sends a custom session message \code{"lottie_js_destroy"} containing the function arguments.
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
#'   actionButton("destroy", "Destroy Animation")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$destroy, {
#'     lottie_destroy("my_animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_destroy <- function(name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_destroy", list(name = name))
}
