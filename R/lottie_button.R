#' Convert a 'Lottie' Animation to a Button
#'
#' Wraps a 'Lottie' animation within a button element for use in 'shiny' applications.
#'
#' @param animation A 'Lottie' animation created by \code{\link{lottie_animation}}.
#' @param inputId The 'shiny' \code{input} slot that will be used to access the value.
#' @param label Optional text label to display below the animation inside the button.
#' @param width Width of the button. This is validated using \code{\link[htmltools:validateCssUnit]{validateCssUnit}}.
#' @param height Height of the button. This is validated using \code{\link[htmltools:validateCssUnit]{validateCssUnit}}.
#' @param ... Additional named attributes to pass to the button element. Same behaviour as \code{\link[shiny:actionButton]{actionButton}}.
#'
#' @return An HTML button element enclosing the \code{animation} input object.
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(shinyLottie)
#'
#' ui <- fluidPage(
#'   include_lottie(),
#'   lottie_animation(
#'     path = "shinyLottie/example.json",
#'     name = "my_animation",
#'     height = "100px",
#'     width = "100px"
#'   ) |> lottie_button(inputId = "my_button")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$my_button, {
#'     print("Button pressed")
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_button <- function(animation,
                          inputId,
                          label = NULL,
                          width = NULL,
                          height = NULL,
                          ...) {

  value <- shiny::restoreInput(id = inputId, default = NULL)

  output <-
    list(
      button =
        htmltools::tags$button(
          id = inputId,
          style = htmltools::css(
            width = htmltools::validateCssUnit(width),
            height = htmltools::validateCssUnit(height),
            display = "flex",
            flexDirection = "column",
            alignItems = "center",
            justifyContent = "center",
            textAlign = "center"
          ),
          type = "button",
          class = "btn btn-default action-button",
          `data-val` = value,
          htmltools::tags$div(
            style = htmltools::css(
              flex = "1",
              display = "flex",
              alignItems = "center",
              justifyContent = "center"
            ),
            animation
          ),
          if (!is.null(label)) htmltools::tags$div(style = "margin-top: auto;", label),
          anim_id = animation$div$attribs$id,
          ...
        )
    )

  output
}
