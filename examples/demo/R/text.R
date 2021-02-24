
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
        ),
        box(
          title = "textButton", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            Text input group and an action button attach to the end.
            ')
            ),
          textButton(textId = ns("tbtn_default"), label = "default"),
          textButton(
            textId = "tbtn-icon",
            label = "change icon and color",
            btn_icon = icon("home"),
            class = "btn-warning" # pass to the button
          ),
          textButton(
            textId = ns("tbtn_style"),
            label = "change styles",
            style = "color: red; border: 2px dashed green;"
          ),
          textButton(
            textId = ns("tbtn_submit"),
            label = "interact with shiny server",
            btn_label = "Submit",
            placeholder = "type and submit",
            class = "btn-primary"),
          verbatimTextOutput(ns("tbtn_submit_out")),
            spsCodeBtn(
              ns("code_textButton"),
              show_span = TRUE,
              '
              library(shiny)

              ui <- fluidPage(
                column(
                  6,
                  textButton(textId = "tbtn_default", label = "default"),
                  textButton(
                    textId = "tbtn-icon",
                    label = "change icon and color",
                    btn_icon = icon("home"),
                    class = "btn-warning" # pass to the button
                  ),
                  textButton(
                    textId = "tbtn_style",
                    label = "change styles",
                    style = "color: red; border: 2px dashed green;"
                  ),
                  textButton(
                    textId = "tbtn_submit",
                    label = "interact with shiny server",
                    btn_label = "Submit",
                    placeholder = "type and submit",
                    class = "btn-primary"),
                  verbatimTextOutput("tbtn_submit_out")
                )
              )

              server <- function(input, output, session) {
                # watch for the button ID "tbtn_submit" + "_btn"
                observeEvent(input$tbtn_submit_btn, {
                  output$tbtn_submit_out <- renderPrint(isolate(input$tbtn_submit))
                })

              }

              shinyApp(ui, server)
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
      output$tbtn_submit_out <- renderPrint("")
      observeEvent(input$tbtn_submit_btn, {
        output$tbtn_submit_out <- renderPrint(isolate(input$tbtn_submit))
      })
    }
  )
}
