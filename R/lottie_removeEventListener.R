#' Remove Event Listener from 'Lottie' Animation
#'
#' Removes an event listener from a 'Lottie' animation within a 'shiny' application.
#'
#' @param name A character string specifying the name of the 'Lottie' animation.
#' @param event The event to listen for (e.g. "\code{mouseenter}", "\code{mouseleave}" etc.).
#' @param target The target for the event listener, either \code{"animation"} or \code{"container"}.
#' @param functionName Optional name of the event handler function to remove. Should only be used if a \code{functionName} was specified when calling \code{\link{lottie_addEventListener}}.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @return This function is called for a side effect, and so there is no return value.
#'
#' @details When run within a reactive context, sends a custom session message \code{"lottie_js_runJS"} containing the function arguments.
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(shinyLottie)
#'
#' ui <- fluidPage(
#'   include_lottie(),
#'   # Create an 'animation' event that updates the 'playCount' input value
#'   # value after each loop
#'   lottie_animation(
#'     path = "shinyLottie/example.json",
#'     name = "my_animation"
#'   ) |>
#'     lottie_addEventListener(
#'       event = "loopComplete",
#'       target = "animation",
#'       custom_js = "Shiny.setInputValue('playCount',
#'       lottieInstances.my_animation.playCount, {priority: 'event'});"
#'     ),
#'   actionButton("removeEventListener", "Remove Event Listener")
#' )
#'
#' server <- function(input, output, session) {
#'   # Notifications demonstrate that eventListener is active
#'   observeEvent(input$playCount, {
#'     showNotification(paste("Animation played", input$playCount, "times"), duration = 1)
#'   })
#'
#'   # Removing the event listener ceases the notifications
#'   observeEvent(input$removeEventListener, {
#'     lottie_removeEventListener(name = "my_animation", event = "loopComplete",
#'                                target = "animation")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_removeEventListener <- function(name,
                                       event,
                                       target,
                                       functionName = NULL,
                                       session = shiny::getDefaultReactiveDomain()) {

  # Define function name
  functionName <- ifelse(
    is.null(functionName),
    glue::glue("window.{event}_{name}_Handler"),
    glue::glue("window.{event}_{name}_{functionName}")
  )

  js <- ifelse(
    target == "container",
    # If targeting a container, find the closest button or div ancestor
    glue::glue(
      "const div = document.getElementById('{name}_div');
       let target = div.closest('button') || div;

       target.removeEventListener('{event}', {functionName});"
    ),
    # Otherwise, target the animation itself
    glue::glue("lottieInstances.{name}.removeEventListener('{event}', {functionName});")
  )

  session$sendCustomMessage("lottie_js_runJS", js)
}
