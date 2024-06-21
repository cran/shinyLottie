#' @title Include 'Lottie' Functionality within 'shiny'
#'
#' @description Responsible for retrieving the 'Lottie' library and initialising the necessary 'JavaScript' library.
#' As such, this function \strong{must} be included within the UI object of a \code{\link[shiny:shinyApp]{shinyApp}} in order to enable 'shinyLottie' functionality.
#'
#' @param version A character string specifying the version of the 'Lottie' library to source via CDN.
#'
#' @return A list of HTML tags to be included within the head element of a 'shiny' application.
#'
#' @note
#' Calling this function initialises a global object "\code{window.lottieInstances}" once the DOM content is fully loaded.
#' This is used to store the 'Lottie' animations that are created using \code{\link{lottie_animation}}.
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
#'   )
#' )
#'
#' server <- function(input, output, session) {}
#'
#' shinyApp(ui, server)
#'
#' @export
include_lottie <- function(version = "5.12.2") {
  shiny::addResourcePath("shinyLottie", system.file("www", package = "shinyLottie"))

  htmltools::tagList(
    # Include 'Lottie' library from CDN
    htmltools::tags$head(
      htmltools::tags$script(src = glue::glue("https://cdnjs.cloudflare.com/ajax/libs/bodymovin/{version}/lottie.min.js")),
      # Initialise a global object to manage 'Lottie' instances
      htmltools::tags$script(htmltools::HTML(
        "document.addEventListener('DOMContentLoaded', function() {
          if (!window.lottieInstances) {
            window.lottieInstances = {};
          }
        });"
      ))
    ),
    # Include JS functions from the mapped resource path
    htmltools::tags$script(src = "shinyLottie/shinyLottie.js")
  )
}

