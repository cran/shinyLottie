#' Add Event Listener to 'Lottie' Animation
#'
#' Adds an event listener to a 'Lottie' animation within a 'shiny' application.
#' It is also possible to apply multiple event listeners to a single animation.
#'
#' @param animation A 'Lottie' animation object created by the \code{lottie_animation} function or its name.
#' @param event The event to listen for (e.g. \code{"mouseenter"}, \code{"mouseleave"} etc.).
#' @param target The target for the event listener, either \code{"animation"} or \code{"container"}.
#' @param ... Additional optional event listener properties, including:
#'   \describe{
#'     \item{\code{state}}{A character string corresponding to an animation state (either \code{"play"}, \code{"pause"}, or \code{"stop"}).}
#'     \item{\code{loop}}{Logical value indicating whether the animation should loop.}
#'     \item{\code{speed}}{A numeric specifying the desired animation speed.}
#'     \item{\code{direction}}{Either \code{1} for forward playback or \code{-1} for reverse playback.}
#'     \item{\code{setSubFrame}}{A logical value specifying whether a 'Lottie' animation should loop (\code{TRUE}) or not (\code{FALSE}).}
#'     \item{\code{playSegments}}{A numeric vector or list of numeric vectors indicating the segment(s) to be played.}
#'     \item{\code{forceFlag}}{Logical value indicating whether to force the animation to play the specified segments immediately (\code{TRUE}) or wait until the current animation completes (\code{FALSE}).}
#'     \item{\code{custom_js}}{Custom 'JavaScript' to execute when the event is triggered.}
#'     \item{\code{functionName}}{Optional name for the event handler function (can be useful when referencing the event listener, such as with \code{\link{lottie_removeEventListener}}).}
#'   }
#' @param session The 'shiny' session object. Defaults to the current reactive domain.
#'
#' @details
#' This function has several usage options:
#' \itemize{
#'   \item Supplying an animation object created by the \code{\link{lottie_animation}} function, and placing the resultant list object in the 'shiny' UI.
#'   \item Outside of a reactive context, supplying the name of the animation and placing the resultant \code{script} object in the 'shiny' UI.
#'   \item Within a reactive context, supplying the name of the animation.
#' }
#'
#' When run within a reactive context, sends a custom session message \code{"lottie_js_runJS"} containing the function arguments.
#'
#' \strong{Target Options}
#' \itemize{
#'   \item \code{"animation"}: Attaches the event listener directly to the 'Lottie' animation instance. This is necessary when using a Lottie-specific event (e.g. "onComplete"). See \url{https://airbnb.io/lottie/#/web} for further details.
#'   \item \code{"container"}: Attaches the event listener to the container div of the 'Lottie' animation. This should be used when using a generic HTML event, such as "mouseenter" or "mouseleave".
#' }
#'
#' @return If used within a reactive context, the function will execute the necessary 'JavaScript'. Otherwise, it will return a \code{script} tag containing the 'JavaScript'.
#'
#' @note Using the \code{custom_js} argument, it is possible to assign 'shiny' input values when an event is triggered, see \code{\link{lottie_removeEventListener}} for an example.
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(shinyLottie)
#'
#' ui <- fluidPage(
#'   include_lottie(),
#'   # Create an 'animation' event listener that prints a message to the
#'   # browser console after each loop
#'   lottie_animation(
#'     path = "shinyLottie/example.json",
#'     name = "my_animation"
#'   ) |>
#'   lottie_addEventListener(
#'     event = "loopComplete",
#'     target = "animation",
#'     custom_js = "console.log('Animation Complete!');"
#'   ),
#'   # Create a 'container' event listener that plays an animation when
#'   # hovering over the button, and another that pauses the animation
#'   # when hovering stops
#'   lottie_animation(
#'     path = "shinyLottie/example.json",
#'     name = "button",
#'     width = "200px",
#'     height = "100px",
#'     loop = TRUE,
#'     autoplay = FALSE,
#'   ) |> lottie_button(inputId = "lottieButton", label = "Lottie",
#'                      height = "200px", width = "200px") |>
#'     lottie_addEventListener("mouseenter", "container", state = "play") |>
#'     lottie_addEventListener("mouseleave", "container", state = "pause")
#' )
#'
#' server <- function(input, output, session) {}
#'
#' shinyApp(ui, server)
#'
#' @export
lottie_addEventListener <- function(animation, event, target, ..., session = shiny::getDefaultReactiveDomain()) {

  args <- list(...)
  target <- match.arg(target, c("animation", "container"))

  # Define animation name
  if (is.character(animation)) {
    name <- animation
  } else if ("button" %in% names(animation)) {
    name <- gsub("_div", "", animation$button$attribs$anim_id)
  } else {
    name <- gsub("_div", "", animation$div$attribs$id)
  }

  # Define function name
  if (!is.null(args$functionName)) {
    functionName_f <- glue::glue("window.{event}_{name}_{args$functionName}")
  } else {
    functionName_f <- glue::glue("window.{event}_{name}_Handler")
  }

  # Define eventListener properties
  js <- event_listener_properties(name = name, functionName_f = functionName_f, ...)

  # Determine eventListener target (animation or container)
  if (target == "container") {
    js <- glue::glue("const div = document.getElementById('{name}_div');
                let container = div.closest('button') || div;

                {js}

                container.addEventListener('{event}', {functionName_f});")
  } else {
    js <- glue::glue("{js} \n window.lottieInstances['{name}'].addEventListener('{event}', {functionName_f});")
  }

  # Determine what to do with script
  if (shiny::isRunning()) {
    # If 'shiny' is running, execute script
    session$sendCustomMessage("lottie_js_runJS", js)
  } else {
    # Otherwise, wrap script in a `DOMContentLoaded` eventListener
    js <- glue::glue("document.addEventListener('DOMContentLoaded', function() {{\n {js} \n}});")

    if (is.list(animation)) {
      # If animation object was input, append eventListener
      animation[[functionName_f]] <- htmltools::tags$script(htmltools::HTML(js))
      animation
    } else {
      # If animation was referenced by name, return script
      htmltools::tags$script(htmltools::HTML(js))
    }
  }
}

