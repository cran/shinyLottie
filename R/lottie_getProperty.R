#' @title Get a Property of a 'Lottie' Animation
#'
#' @description Get a property from a specific 'Lottie' animation or all 'Lottie' animations.
#'
#' @param property A character string specifying the name of the property to retrieve.
#' @param name A character string specifying the name of the 'Lottie' animation to query.
#' The default of "\code{all}" will retrieve the specified property from all animations within the 'shiny' application.
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @details Sends a custom session message \code{"lottie_js_getProperty"} containing the function arguments.
#'
#' @return The return value(s) can be retrieved from within a reactive context by accessing the input
#' object of the 'shiny' session, where the value has been assigned as the property name. For example, if accessing the
#' \code{playCount} property, the return value can be retrieved via \code{input$playCount}.
#'
#' If \code{name = "all"} has been specified, then the return object will be a list, with named elements
#' corresponding to the animation names.
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
#'   actionButton("getProperty", "Update Play Count"),
#'   textOutput("playCountOutput")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$getProperty, {
#'     lottie_getProperty(name = "my_animation", property = "playCount")
#'   })
#'
#'   observe({
#'     req(input$playCount)
#'     output$playCountOutput <- renderText({
#'       paste("Play Count:", input$playCount)
#'     })
#'   })
#' }
#'
#'  shinyApp(ui, server)
#'
#' @export
lottie_getProperty <- function(property, name = "all", session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("lottie_js_getProperty", list(property = property, name = name))
  session$input[[property]]
}

