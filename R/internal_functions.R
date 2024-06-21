utils::globalVariables(c("state", "loop", "speed", "direction", "setSubFrame", "playSegments", "forceFlag", "custom_js", "functionName"))

# Generate animation body
generate_animation_body <- function(path, name, loop, autoplay, renderer) {
  glue::glue("var animation = bodymovin.loadAnimation({{
          container: document.getElementById('{name}_div'),
          renderer: '{renderer}',
          loop: {jsonlite::toJSON(loop, auto_unbox = TRUE)},
          autoplay: {jsonlite::toJSON(autoplay, auto_unbox = TRUE)},
          path: '{path}'
        }});")
}

# Append additional animation options
append_animation_options <- function(js, ...) {
  args <- list(...)

  # setSpeed
  if (!is.null(args$speed)) {
    stopifnot(is.numeric(args$speed))
    js <- glue::glue("{js} \n animation.setSpeed({jsonlite::toJSON(args$speed, auto_unbox = TRUE)});")
  }

  # setDirection
  if (!is.null(args$direction)) {
    stopifnot(args$direction == 1 | args$direction == -1)
    js <- glue::glue("{js} \n animation.setDirection({args$direction});")
  }

  # setSubFrame
  if (!is.null(args$setSubFrame)) {
    stopifnot(is.logical(args$setSubFrame))
    js <- glue::glue("{js} \n animation.setSubFrame({jsonlite::toJSON(args$setSubFrame, auto_unbox = TRUE)});")
  }

  # playSegments
  if (!is.null(args$playSegments)) {
    stopifnot(is.list(args$playSegments))

    if (is.null(args$forceFlag)) {
      args$forceFlag <- TRUE
    } else {
      stopifnot(is.logical(args$forceFlag))
    }

    js <- glue::glue("{js} \n animation.addEventListener('data_ready', function() {{
              animation.playSegments({jsonlite::toJSON(args$playSegments)}, {jsonlite::toJSON(args$forceFlag, auto_unbox = TRUE)});
            }});")
  }

  js
}


# Define event listener properties
event_listener_properties <- function(name, functionName_f, ...) {
  args <- list(...)

  js <- glue::glue("{functionName_f} = function(e) {{")

  # Play / Pause / Stop
  if (!is.null(args$state)) {
    state <- match.arg(args$state, c("play", "pause", "stop"))
    js <- glue::glue("{js} \n window.lottieInstances['{name}'].{state}();")
  }

  # setLoop
  if (!is.null(args$loop)) {
    stopifnot(is.logical(args$loop))
    js <- glue::glue("{js} \n window.lottieInstances['{name}'].setLoop({jsonlite::toJSON(args$loop, auto_unbox = TRUE)});")
  }

  # setSpeed
  if (!is.null(args$speed)) {
    stopifnot(is.numeric(args$speed))
    js <- glue::glue("{js} \n window.lottieInstances['{name}'].setSpeed({args$speed});")
  }

  # setDirection
  if (!is.null(args$direction)) {
    stopifnot(is.numeric(args$direction))
    js <- glue::glue("{js} \n window.lottieInstances['{name}'].setDirection({args$direction});")
  }

  # setSubFrame
  if (!is.null(args$setSubFrame)) {
    stopifnot(is.logical(args$setSubFrame))
    js <- glue::glue("{js} \n window.lottieInstances['{name}'].setSubFrame({jsonlite::toJSON(args$setSubFrame, auto_unbox = TRUE)});")
  }

  # playSegments
  if (!is.null(args$playSegments)) {
    stopifnot(is.list(args$playSegments))

    if (is.null(args$forceFlag)) {
      args$forceFlag <- TRUE
    } else {
      stopifnot(is.logical(args$forceFlag))
    }

    js <- glue::glue("{js} \n window.lottieInstances['{name}'].playSegments({jsonlite::toJSON(args$playSegments)}, {jsonlite::toJSON(args$forceFlag, auto_unbox = TRUE)});")
  }

  # Custom JS
  if (!is.null(args$custom_js)) {
    js <- glue::glue("{js} \n {args$custom_js}")
  }

  glue::glue("{js} \n }};")
}
