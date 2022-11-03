
# UI
uiButtons <- function(id) {
  ns <- NS(id)
  my_code <-
    '
    # load package and data
    library(ggplot2)
    data(mpg, package="ggplot2")
    # mpg <- read.csv("http://goo.gl/uEeRGu")

    # Scatterplot
    theme_set(theme_bw())  # pre-set the bw theme.
    g <- ggplot(mpg, aes(cty, hwy))
    g + geom_jitter(width = .5, size=1) +
      labs(subtitle="mpg: city vs highway mileage",
           y="hwy",
           x="cty",
           title="Jittered Points")
    '
  html_code <-
    '
    <!DOCTYPE html>
    <html>
    <body>

    <h2>ABC</h2>

    <p id="demo">Some HTML</p>

    </body>
    </html>
    '
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
            the way to the top of the page.

            #### This demo
            When you are on this tab, 3 `spsGoTop` buttons has enabled. so **now scroll**
            **the page** and you should see then.

            - top-left: position, icon, color changed
            - middle-center: position, icon, color changed
            - bottom-right: **default**
            ')
          ),
          spsGoTop(ns("default")),
          spsGoTop(ns("mid"), right = "50%",  bottom= "50%", icon = icon("house"), color = "red"),
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
                spsGoTop("mid", right = "50%",  bottom= "50%", icon = icon("house"), color = "red"),
                spsGoTop("up", right = "95%",  bottom= "95%", icon = icon("arrow-up"), color = "green")
            )

            server <- function(input, output, session) {

            }

            shinyApp(ui, server)
            '
          ),
          # lapply(1: 50, function(x) br())
        ),
        box(
          title = "spsCodeBtn", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            A code button to let you display your code on shiny app. Sometimes we
            want users to reproduce a plot or some analysis. Use `spsCodeBtn` to
            show your code.

            - Choose open the code chunk in a modal section or a collapse section.
            - Use `shinyAce` as the code container so you can update the code dynamically
            from server. use `shinyAce::updateAceEditor` update on server,
            the code block ID is button ID + "-ace", like "my_button-ace" .
            '
            )
          ),
          tags$label("Display by modal"), br(),
          column(
            6, h4("default"),
            spsCodeBtn(id = ns("code_default"), my_code)
          ),
          column(
            6, h4("change color and shape"),
            spsCodeBtn(
              id = ns("code_color"), c(my_code, my_code),
              color = "red", shape = "circular")
          ),
          tags$label("Display by collapse"), br(),
          column(
            6, h4("collapse"),
            spsCodeBtn(id = ns("code_collapse"), my_code, display = "collapse")
          ),
          column(
            6, h4("different programming language"),
            spsCodeBtn(
              id = ns("code_language"), html_code,
              language = "html", display = "collapse")
          ),
          tags$label("Update code"), br(),
          column(
            12,
            spsCodeBtn(
              ns("update-code"),
              "# No code here",
              display = "collapse"
            ), br(),
            actionButton(ns("update"), "change code in the left `spsCodeBtn`"),
            actionButton(ns("changeback"), "change it back")
          ), spsHr(), br(),
          h3("Code to reproduce all above"),
          spsCodeBtn(
            ns("code_all"),
            '
            library(shiny)
            my_code <-
                \'
            # load package and data
            library(ggplot2)
            data(mpg, package="ggplot2")
            # mpg <- read.csv("http://goo.gl/uEeRGu")

            # Scatterplot
            theme_set(theme_bw())  # pre-set the bw theme.
            g <- ggplot(mpg, aes(cty, hwy))
            g + geom_jitter(width = .5, size=1) +
              labs(subtitle="mpg: city vs highway mileage",
                   y="hwy",
                   x="cty",
                   title="Jittered Points")
            \'
            html_code <-
            \"
            <!DOCTYPE html>
            <html>
            <body>

            <h2>ABC</h2>

            <p id="demo">Some HTML</p>

            </body>
            </html>
            \"
            ui <- fluidPage(
                fluidRow(
                    column(
                        6,
                        h3("Display by modal"),
                        column(
                            6, h4("default"),
                            spsCodeBtn(id = "a", my_code)
                        ),
                        column(
                            6, h4("change color and shape"),
                            spsCodeBtn(
                                id = "b", c(my_code, my_code),
                                color = "red", shape = "circular")
                        )
                    ),
                    column(
                        6,
                        h3("Display by collapse"),
                        column(
                            6, h4("collapse"),
                            spsCodeBtn(id = "c", my_code, display = "collapse")
                        ),
                        column(
                            6, h4("different programming language"),
                            spsCodeBtn(
                                id = "d", html_code,
                                language = "html", display = "collapse")
                        )
                    )
                ),
                fluidRow(
                    column(
                        6,
                        h3("Update code"),
                        spsCodeBtn(
                            "update-code",
                            "# No code here",
                            display = "collapse"
                        ),
                        actionButton("update", "change code in the left `spsCodeBtn`"),
                        actionButton("changeback", "change it back")
                    )
                )
            )

            server <- function(input, output, session) {
                observeEvent(input$update, {
                    shinyAce::updateAceEditor(
                        session, editorId = "update-code-ace",
                        value = "# code has changed!\\n 1+1"
                    )
                })
                observeEvent(input$changeback, {
                    shinyAce::updateAceEditor(
                        session, editorId = "update-code-ace",
                        value = "# No code here"
                    )
                })
            }

            shinyApp(ui, server)
            ',
            show_span = TRUE
          )
        )
      )
  )
}

# Server
serverButtons <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(input$update, {
        shinyAce::updateAceEditor(
          session, editorId = "update-code-ace",
          value = "# code has changed!\n 1+1"
        )
      })
      observeEvent(input$changeback, {
        shinyAce::updateAceEditor(
          session, editorId = "update-code-ace",
          value = "# No code here"
        )
      })
    }
  )
}
