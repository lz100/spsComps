
# UI
uiWelcome <- function(id) {
  ns <- NS(id)
  fluidRow(
    h1("systemPipeShiny Components", class = "text-center text-primary text-bold"),
    tags$img(src = "https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true",
             class = "home-logo"),
    column(
      12, class = "text-main desc-table",
    markdown(
    '
    systemPipeShiny Components (spsComps) package provides custom HTML UI components
    that you can use in Shiny apps and other HTML documents, like R markdown. It also
    includes custom Shiny server components to enhance your app development.

    In this demo, different components are displayed in different tabs. You can
    browse them from the left sidebar.

    <br>

    For more details, read the documents on [our website](https://systempipe.org/sps/dev/ui/).

    <br>
    <h3 class="text-center">Other packages in systemPipeShiny</h3>
    <br>

    | Package | Description | Documents | Demo |
    | --- | --- | --- | --- |
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/sps_small.png?raw=true" align="right" height="25" />[systemPipeShiny](https://github.com/systemPipeR/systemPipeShiny) | SPS main package |[website](https://systempipe.org/sps/)|[demo](https://tgirke.shinyapps.io/systemPipeShiny/)|
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spscomps.png?raw=true" align="right" height="25" />[spsComps](https://github.com/lz100/spsComps) | SPS UI and server components |[website](https://systempipe.org/sps/dev/ui/)|[demo](https://lezhang.shinyapps.io/spsComps)|
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spsutil.png?raw=true" align="right" height="25" />[spsUtil](https://github.com/lz100/spsUtil) | SPS utility functions |[website](https://systempipe.org/sps/dev/general/)|NA|
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/drawr.png?raw=true" align="right" height="25" />[drawR](https://github.com/lz100/drawR) | SPS interactive image editting tool |[website](https://systempipe.org/sps/canvas/)|[demo](https://lezhang.shinyapps.io/drawR)|

    ')
    )

  )
}

# Server
serverWelcome <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

    }
  )
}
