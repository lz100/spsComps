
# UI
uiText <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("Text control components in spsComps"),
      column(
        6,
        box(
          title = "clearableTextInput", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
          A text input box with a button in the end to clear all text.
          Similarly can use `input$id` to get the text from server.
          ')
          ),
          clearableTextInput(ns("text_clear"), "This is a input box", placeholder = "type some thing"),
          verbatimTextOutput(ns("text_clear_out")),
          spsCodeBtn(
            ns("code_text_clear"),
            show_span = TRUE,
            '
          ui <- fluidPage(
              clearableTextInput("input1", "This is a input box", style = "width: 50%;"),
              verbatimTextOutput("out1")
          )

          server <- function(input, output, session) {
              output$out1 <- renderPrint(input$input1)
          }

          shinyApp(ui, server)
          '
          )
        ),
        box(
          title = "renderDesc", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              Render some text description in markdown format inside a collapsoble block
              ')
          ),
          renderDesc(id = ns("desc"),
          '
          # Some desc
          - xxxx
          - bbbb

          This is a [link](https://www.google.com/).

          `Some other things`
          > other markdown things

          1. aaa
          2. bbb
          3. ccc
          '),
          spsCodeBtn(
            ns("code_desc"),
            show_span = TRUE,
            '
            renderDesc(id = "desc",
            "
            # Some desc
            - xxxx
            - bbbb

            This is a [link](https://www.google.com/).

            `Some other things`
            > other markdown things

            1. aaa
            2. bbb
            3. ccc
            ")
            '
          )
        )
      ),
      column(
        6,
        box(
          title = "textInputGroup", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
            Text input group and custom widgets append to left ar/and right
            Similarly can use `input$id` to get the text from server.
            ')
            ),
            textInputGroup(ns("id1"), "left", left_text = "a"),
            textInputGroup(ns("id2"), "right", right_text = "b"),
            textInputGroup(ns("id3"), "both", left_text = "$", right_text = ".00"),
            textInputGroup(ns("id4"), "none"),
            textInputGroup(ns("id5"), "icon", left_text = icon("home")),
            spsCodeBtn(
              ns("code_text_group"),
              show_span = TRUE,
              '
              textInputGroup("id1", "left", left_text = "a"),
              textInputGroup("id2", "right", right_text = "b"),
              textInputGroup("id3", "both", left_text = "$", right_text = ".00"),
              textInputGroup("id4", "none"),
              textInputGroup("id5", "icon", left_text = icon("home"))
              '
            )
        )
      )
    )
}

# Server
serverText <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$text_clear_out <- renderPrint(input$text_clear)
    }
  )
}
