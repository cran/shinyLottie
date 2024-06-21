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
#      name = "my_animation"
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
#    lottie_animation(
#      path = "shinyLottie/example.json",
#      name = "my_animation",
#      height = "100px",
#      width = "100px"
#    ) |> lottie_button(inputId = "my_button")
#  )
#  
#  server <- function(input, output, session) {
#    observeEvent(input$my_button, {
#      print("Button pressed")
#    })
#  }
#  
#  shinyApp(ui, server)

