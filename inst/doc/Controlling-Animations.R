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
#      speed = 2
#    ),
#    actionButton("updateSpeed", "Set Speed to 0.5")
#  )
#  
#  server <- function(input, output, session) {
#    observeEvent(input$updateSpeed, {
#      lottie_setSpeed(speed = 0.5, name = "my_animation")
#    })
#  }
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
#    ),
#    actionButton("getProperty", "Update Play Count"),
#    textOutput("playCountOutput")
#  )
#  
#  server <- function(input, output, session) {
#    observeEvent(input$getProperty, {
#      lottie_getProperty(name = "my_animation", property = "playCount")
#    })
#  
#    observe({
#      req(input$playCount)
#      output$playCountOutput <- renderText({
#        paste("Play Count:", input$playCount)
#      })
#    })
#  }
#  
#   shinyApp(ui, server)

