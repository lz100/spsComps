
# UI
uiOther <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("All uncategorized components"),
      column(
        6,
        box(
          title = "bsAlert", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              Add a dismissable alert messages to UI with `bsAlert`
              ')
          ), br(),
          bsAlert(tags$b("Success: "), "You made it", status = "success"),
          bsAlert(tags$b("Info: "), "Something happened", status = "info"),
          bsAlert(tags$b("Warning: "), "Something is not right", status = "warning"),
          bsAlert(tags$b("Danger: "), "Oh no...", status = "danger"),
          br(),
          spsCodeBtn(
            ns("code_bsalert"),
            show_span = TRUE,
            '
            library(shiny)
            ui <- fluidPage(
              bsAlert(tags$b("Success: "), "You made it", status = "success"),
              bsAlert(tags$b("Info: "), "Something happened", status = "info"),
              bsAlert(tags$b("Warning: "), "Something is not right", status = "warning"),
              bsAlert(tags$b("Danger: "), "Oh no...", status = "danger")
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          )
        ),
        box(
          title = "spsHr", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              Add a colorful horizontal line to UI with `spsHr`
              ')
          ), br(),
          tags$b("Different status"),
          spsHr("info"),
          spsHr("primary"),
          spsHr("success"),
          spsHr("warning"),
          spsHr("danger"),
          tags$b("custom color"),
          spsHr(other_color = "purple"),
          spsHr(other_color = "pink"),
          tags$b("Different width"),
          lapply(1:5, function(x) spsHr(width = x)),
          tags$b("Different type"),
          c("solid", "dotted", "dashed", "double", "groove", "ridge", "inset", "outset") %>%
            lapply(function(x) spsHr(type = x, width = 3)),
          tags$b("Different opacity"),
          lapply(seq(0.2, 1, 0.2), function(x) spsHr(opacity = x)),
          br(),
          spsCodeBtn(
            ns("code_spshr"),
            show_span = TRUE,
            '
            library(magrittr)
            ui <- fluidPage(
              tags$b("Different status"),
              spsHr("info"),
              spsHr("primary"),
              spsHr("success"),
              spsHr("warning"),
              spsHr("danger"),
              tags$b("custom color"),
              spsHr(other_color = "purple"),
              spsHr(other_color = "pink"),
              tags$b("Different width"),
              lapply(1:5, function(x) spsHr(width = x)),
              tags$b("Different type"),
              c("solid", "dotted", "dashed", "double", "groove", "ridge", "inset", "outset") %>%
                lapply(function(x) spsHr(type = x, width = 3)),
              tags$b("Different opacity"),
              lapply(seq(0.2, 1, 0.2), function(x) spsHr(opacity = x))
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          )
        )
      ),
      column(
        6,
        box(
          title = "heightMatcher", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            Match the height of one element to the second element. If the height
            of second element change, the height of first element will
            change to match the height of the first one.

            - This function runs on only UI, no server required
            ')
          ),
          fluidRow(
            style = "padding: 10px",
            column(
              4, id = ns("el-a"),
              style = "border: 5px solid #eee; border-radius: 10px; background-color: gray;",
              tags$b("This block's height is matched with orange one")
            ),
            shinyjqui::jqui_resizable(column(
              4, id = ns("el-b"),
              style = "border: 5px solid #eee; border-radius: 10px; background-color: orange; height: 150px;",
              tags$b("drag the bottom-right corner"),
              HTML("<b style='font-size: 5rem'>&#8600;</b>")
            )),
            column(
              4, id = ns("el-c"),
              style = "border: 5px solid #eee; border-radius: 10px; background-color: red;",
              tags$b("This block is not matched with others")
            )
          ),
          heightMatcher(ns("el-a"), ns("el-b")),
          spsCodeBtn(
            ns("code_heightmatch"),
            show_span = TRUE,
            '
            library(shiny)
            library(shinyjqui)
            ui <- fluidPage(
                column(
                    3, id = "a",
                    style = "border: 1px black solid; background-color: gray;",
                    p("This block\'s height is matched with orange one")
                ),
                shinyjqui::jqui_resizable(column(
                    2, id ="b",
                    style = "border: 1px black solid; background-color: orange;",
                    p("drag the bottom-right corner")
                )),
                column(
                    3, id = "c",
                    style = "border: 1px black solid; background-color: red;",
                    p("This block is not matched with others")
                ),
                heightMatcher("a", "b")
            )

            server <- function(input, output, session) {

            }
            # Try to drag `b` from bottom right corner and see what happens to `a`
            shinyApp(ui, server)
            '
          )
        ),
        box(
          title = "spsTitle", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              Add a colorful custom title to UI with `spsTitle`
              ')
          ), br(),
          tags$b("Different status"),
          c("primary", "info", "success", "warning", "danger") %>%
            lapply(function(x) spsTitle(x, "3", status = x)),
          tags$b("custom color"),
          spsTitle("purple", "4", other_color = "purple"),
          spsTitle("pink", "4", other_color = "pink"),
          tags$b("Different levels"),
          lapply(as.character(1:6), function(x) spsTitle(paste0("H", x), x)),
          tags$b("Different opacity"),
          lapply(seq(0.2, 1, 0.2), function(x) spsTitle(as.character(x), opacity = x)),
          br(),
          spsCodeBtn(
            ns("code_spstitle"),
            show_span = TRUE,
            '
            library(shiny)
            library(magrittr)
            ui <- fluidPage(
              tags$b("Different status"),
              c("primary", "info", "success", "warning", "danger") %>%
                lapply(function(x) spsTitle(x, "4", status = x)),
              tags$b("custom color"),
              spsTitle("purple", "4", other_color = "purple"),
              spsTitle("pink", "4", other_color = "pink"),
              tags$b("Different levels"),
              lapply(as.character(1:6), function(x) spsTitle(paste0("H", x), x)),
              tags$b("Different opacity"),
              lapply(seq(0.2, 1, 0.2), function(x) spsTitle(as.character(x), opacity = x))
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          )
        )
      )
  )
}

# Server
serverOther <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
    }
  )
}
