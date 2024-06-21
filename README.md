
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinyLottie

<!-- badges: start -->
<!-- badges: end -->

The ‘shinyLottie’ package allows users to easily integrate and control
‘Lottie’ animations within ‘shiny’ applications, without the need for
idiosyncratic expression or use of ‘JavaScript’. This includes utilities
for generating animation instances, controlling playback, manipulating
animation properties, and more.

## Installation

You can install the development version of ‘shinyLottie’ from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("CamHowitt/shinyLottie")
```

## Example

Introducing ‘Lottie’ animations to a ‘shiny’ app can be accomplished
using just two ‘shinyLottie’ functions:

``` r
library(shiny)
library(shinyLottie)

ui <- fluidPage(
  include_lottie(),
  lottie_animation(
    path = "shinyLottie/example.json",
    name = "my_animation"
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
```

For more advanced implementations, please refer to the following
articles:

- `vignette("shinyLottie")`

- `vignette("Controlling-Animations")`

- `vignette("Event-Listeners")`
