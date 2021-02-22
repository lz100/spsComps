
# UI
uiWelcome <- function(id) {
  div(
    h1("systemPipeShiny Components (spsComps)", class = "text-center text-primary text-bold"),
    tags$img(src = "https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true",
             style = ""),
    markdown(
    '

    ')
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


