
# UI
uiWelcome <- function(id) {
  ns <- NS(id)
  fluidRow(
    h1("systemPipeShiny Components", class = "text-center text-primary text-bold"),
    tags$img(src = "https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true",
             style = "user-select: none; -webkit-user-drag: none;",
             class = "home-logo") %>%
      animateAppend("float"),
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

    For more details, read the documents on [our website{blk}](https://systempipe.org/sps/dev/spscomps/).

    <p class="text-primary">If you <b >like</b> this package, remember to give us a
    <a href="https://github.com/lz100/spsComps" target="_blank"> star<i class="fa fa-star text-red faa-pulse animated"></i> on github.</a>
    </p>

    <br>
    <h3 class="text-center">Other packages in systemPipeShiny</h3>
    <br>

    | Package | Description | Documents | Function reference | Demo |
    | --- | --- | --- | :---: | --- |
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/sps_small.png?raw=true" align="right" height="30" width="30"/>[systemPipeShiny{blk}](https://github.com/systemPipeR/systemPipeShiny) | SPS main package |[website{blk}](https://systempipe.org/sps/)|[link{blk}](https://systempipe.org/sps/funcs/sps/reference/)  | [demo{blk}](https://tgirke.shinyapps.io/systemPipeShiny/)|
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spscomps.png?raw=true" align="right" height="30" width="30" />[spsComps{blk}](https://github.com/lz100/spsComps) | SPS UI and server components |[website{blk}](https://systempipe.org/sps/dev/spscomps/)|[link{blk}](https://systempipe.org/sps/funcs/spscomps/reference/)  | [demo{blk}](https://lezhang.shinyapps.io/spsComps)|
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/drawer.png?raw=true" align="right" height="30" width="30" />[drawer{blk}](https://github.com/lz100/drawer) | SPS interactive image editing tool |[website{blk}](https://systempipe.org/sps/dev/drawer/)|[link{blk}](https://systempipe.org/sps/funcs/drawer/reference/)  | [demo{blk}](https://lezhang.shinyapps.io/drawer)|
    |<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spsutil.png?raw=true" align="right" height="30" width="30" />[spsUtil{blk}](https://github.com/lz100/spsUtil) | SPS utility functions |[website{blk}](https://systempipe.org/sps/dev/spsutil/)|[link{blk}](https://systempipe.org/sps/funcs/spsutil/reference/)  | NA|

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
