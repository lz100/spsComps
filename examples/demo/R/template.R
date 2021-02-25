
# UI
uiXx <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle(""),
      column(
        6,
        box(
          title = "XXX", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '

              ')
          ),
          ##xxx
          spsCodeBtn(
            ns("code_"),
            show_span = TRUE,
            '

              '
          )
        )
      ),
      column(
        6,
        box(
          title = "XXX", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '

            ')
          ),
          ##xxx
          spsCodeBtn(
            ns("code_"),
            show_span = TRUE,
            '

            '
          )
        )
      )
  )
}

# Server
serverXx <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
    }
  )
}
