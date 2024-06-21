#' Call a 'Lottie' Method
#'
#' Call a method for a specific 'Lottie' animation or all 'Lottie' animations.
#'
#' @param name A character string specifying the name of the 'Lottie' animation to query.
#' The default of "\code{all}" will retrieve the specified property from all 'Lottie' animations within the 'shiny' application.
#' @param method A character string specifying the name of the method to call.
#' @param argument A character string specifying any optional arguments to pass to the method.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details Sends a custom session message \code{"lottie_js_callMethod"} containing the function arguments.
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
#'   actionButton("callMethod", "Call Method (Reverse Direction)")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$callMethod, {
#'     lottie_callMethod(name = "my_animation", method = "setDirection", argument = "-1")
#'   })
#' }
#
#' shinyApp(ui, server)
#'
#' @export
lottie_callMethod <- function(name = "all", method, argument = "", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_callMethod", list(name = name, method = method, argument = jsonlite::toJSON(argument, auto_unbox = TRUE)))
}
