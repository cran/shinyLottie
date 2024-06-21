## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
#  library(shiny)
#  library(shinyLottie)
#  
#  ui <- fluidPage(
#    include_lottie(),
#    lottie_animation(
#      path = "shinyLottie/example.json",
#      name = "my_animation",
#      width = "200px",
#      height = "100px",
#      loop = TRUE,
#      autoplay = FALSE,
#    ) |> lottie_button(inputId = "lottieButton", label = "Lottie") |>
#      lottie_addEventListener("mouseenter", "container", state = "play") |>
#      lottie_addEventListener("mouseleave", "container", state = "pause")
#  )
#  
#  server <- function(input, output, session) {}
#  
#  shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
#  library(shiny)
#  library(shinyLottie)
#  
#  ui <- fluidPage(
#    include_lottie(),
#    lottie_animation(
#      path = "shinyLottie/example.json",
#      name = "my_animation"
#    ) |>
#    lottie_addEventListener(
#      event = "loopComplete",
#      target = "animation",
#      custom_js = "console.log('Animation Complete!');"
#    )
#  )
#  
#  server <- function(input, output, session) {}
#  
#  shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
#  library(shiny)
#  library(shinyLottie)
#  
#  ui <- fluidPage(
#    include_lottie(),
#    # Create an 'animation' event that updates the 'playCount' input value
#    # value after each loop
#    lottie_animation(
#      path = "shinyLottie/example.json",
#      name = "my_animation"
#    ) |>
#    lottie_addEventListener(
#      event = "loopComplete",
#      target = "animation",
#      custom_js = "Shiny.setInputValue('playCount',
#        lottieInstances.my_animation.playCount, {priority: 'event'});"
#    ),
#    actionButton("removeEventListener", "Remove Event Listener")
#  )
#  
#  server <- function(input, output, session) {
#    # Notifications demonstrate that eventListener is active
#    observeEvent(input$playCount, {
#      showNotification(paste("Animation played", input$playCount, "times"), duration = 1)
#    })
#  
#    # Removing the event listener ceases the notifications
#    observeEvent(input$removeEventListener, {
#      lottie_removeEventListener(name = "my_animation", event = "loopComplete",
#                                 target = "animation")
#    })
#  }
#  
#  shinyApp(ui, server)

