
# UI
uiButtons <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("Buttons and group of buttons"),
      column(
        6,
        box(
          title = "hrefTab & hrefTable", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              Display a list of links in a row of buttons with `hrefTab` and
              a table of buttons with links with `hrefTable`.

              If the button has no link attached, you cannot click it and there
              is no hover effect.
              ')
          ),
          hrefTab(
            title = "Default",
            label_texts = c("Bar Plot", "PCA Plot", "Scatter Plot"),
            hrefs = c("https://google.com/", "", "")
          ),
          hrefTab(
            title = "Different background",
            label_texts = c("Bar Plot", "PCA Plot", "Scatter Plot"),
            hrefs = c("https://google.com/", "", ""),
            bg_colors = c("#eee", "orange", "green")
          ),
          hrefTab(
            title = "Different background and text colors",
            label_texts = c("Bar Plot", "Disabled", "Scatter Plot"),
            hrefs = c("https://google.com/", "", ""),
            bg_colors = c("green", "#eee", "orange"),
            text_colors = c("#caffc1", "black", "blue")
          ),
          tags$br(),
          spsCodeBtn(
            ns("code_hrefTab"),
            show_span = TRUE,
            '
              ui <- fluidPage(
                  hrefTab(
                      title = "Default",
                      label_texts = c("Bar Plot", "PCA Plot", "Scatter Plot"),
                      hrefs = c("https://google.com/", "", "")
                  ),
                  hrefTab(
                      title = "Different background",
                      label_texts = c("Bar Plot", "PCA Plot", "Scatter Plot"),
                      hrefs = c("https://google.com/", "", ""),
                      bg_colors = c("#eee", "orange", "green")
                  ),
                  hrefTab(
                      title = "Different background and text colors",
                      label_texts = c("Bar Plot", "Disabled", "Scatter Plot"),
                      hrefs = c("https://google.com/", "", ""),
                      bg_colors = c("green", "#eee", "orange"),
                      text_colors = c("#caffc1", "black", "blue")
                  )
              )

              server <- function(input, output, session) {

              }
              shinyApp(ui, server)
              '
          ), spsHr(),
          hrefTable(
            title = "default",
            item_titles = c("workflow 1", "unclickable"),
            item_labels = list(c("tab 1"), c("tab 3", "tab 4")),
            item_hrefs = list(c("https://www.google.com/"), c("", ""))
          ),
          hrefTable(
            title = "Change button color and text color",
            item_titles = c("workflow 1", "No links"),
            item_labels = list(c("tab 1"), c("tab 3", "tab 4")),
            item_hrefs = list(c("https://www.google.com/"), c("", "")),
            item_bg_colors =  list(c("blue"), c("red", "orange")),
            item_text_colors =  list(c("black"), c("yellow", "green"))
          ),
          hrefTable(
            title = "Change row name colors and width",
            item_titles = c("Green", "Red", "Orange"),
            item_labels = list(c("tab 1"), c("tab 3", "tab 4"), c("tab 5", "tab 6", "tab 7")),
            item_hrefs = list(
              c("https://www.google.com/"),
              c("", ""),
              c("https://www.google.com/", "https://www.google.com/", "")
            ),
            item_title_colors = c("green", "red", "orange"),
            style = "width: 50%"
          ),
          spsCodeBtn(
            ns("code_hrefTabble"),
            show_span = TRUE,
            '
          ui <- fluidPage(
              hrefTable(
                  title = "default",
                  item_titles = c("workflow 1", "unclickable"),
                  item_labels = list(c("tab 1"), c("tab 3", "tab 4")),
                  item_hrefs = list(c("https://www.google.com/"), c("", ""))
              ),
              hrefTable(
                  title = "Change button color and text color",
                  item_titles = c("workflow 1", "No links"),
                  item_labels = list(c("tab 1"), c("tab 3", "tab 4")),
                  item_hrefs = list(c("https://www.google.com/"), c("", "")),
                  item_bg_colors =  list(c("blue"), c("red", "orange")),
                  item_text_colors =  list(c("black"), c("yellow", "green"))
              ),
              hrefTable(
                  title = "Change row name colors and width",
                  item_titles = c("Green", "Red", "Orange"),
                  item_labels = list(c("tab 1"), c("tab 3", "tab 4"), c("tab 5", "tab 6", "tab 7")),
                  item_hrefs = list(
                      c("https://www.google.com/"),
                      c("", ""),
                      c("https://www.google.com/", "https://www.google.com/", "")
                  ),
                  item_title_colors = c("green", "red", "orange"),
                  style = "width: 50%"
              )

          )

          server <- function(input, output, session) {

          }

          shinyApp(ui, server)
          '
          )
        )
      ),
      column(
        6,
        box(
          title = "spsGoTop", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            A go top button, when users scroll the page down more than 50 pixels,
            the button will be displayed. When the button is clicked, scroll all
            the way to the button.

            #### This demo
            When you are on this tab, 3 `spsGoTop` buttons has enabled. so **now scroll**
            **the page** and you should see then.

            - top-left: position, icon, color changed
            - middle-center: position, icon, color changed
            - bottom-right: **default**
            ')
          ),
          spsGoTop(ns("default")),
          spsGoTop(ns("mid"), right = "50%",  bottom= "50%", icon = icon("home"), color = "red"),
          spsGoTop(ns("up"), right = "75%",  bottom= "90%", icon = icon("arrow-up"), color = "green"),
          spsCodeBtn(
            ns("code_spsGoTop"),
            show_span = TRUE,
            '
            library(shiny)

            ui <- fluidPage(
                h1("Scroll the page..."),
                lapply(1: 100, function(x) br()),
                spsGoTop("default"),
                spsGoTop("mid", right = "50%",  bottom= "50%", icon = icon("home"), color = "red"),
                spsGoTop("up", right = "95%",  bottom= "95%", icon = icon("arrow-up"), color = "green")
            )

            server <- function(input, output, session) {

            }

            shinyApp(ui, server)
            '
          ),
          # lapply(1: 50, function(x) br())
        )
      )
  )
}

# Server
serverButtons <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
    }
  )
}
