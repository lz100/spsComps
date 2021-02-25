
# UI
uiOther <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("All uncategorized components"),
      column(
        6,
        box(
          title = "bsHoverPopover", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              Enhanced Bootstrap 3 popover by hovering of `bsplus::bs_embed_popover`.
              Similar but also works on "hover" on buttons instead of only "click".
              - Add a popover tooltip with descriptions to almost any Shiny components.
              ')
          ), br(),
          actionButton(ns('popover-btn'), 'On button') %>%
            bsHoverPopover(
              title = "title a",
              content = "popover works on a button",
              placement = "bottom"
            ), br(), br(),
          tags$a("On link") %>%
            bsHoverPopover(
              title = "title b",
              content = "popover works on a link",
              placement = "bottom"
            ),
          br(), br(),
          div(
            tags$b("general element"),
            style =
            '
              height: 100px;
              background-color: cornflowerblue;
            '
          ) %>%
            bsHoverPopover(
              title = "general element",
              content = "popover works on a 'div'",
              placement = "right"
            ),
          br(),
          spsCodeBtn(
            ns("code_bshover"),
            show_span = TRUE,
            '
            library(shiny)
            library(magrittr)
            ui <- fluidPage(
                column(2),
                column(
                    8,
                    actionButton("a", "On button") %>%
                        bsHoverPopover(
                            title = "title a",
                            content = "popover works on a button",
                            placement = "bottom"
                        ),
                    tags$a("On link") %>%
                        bsHoverPopover(
                            title = "title b",
                            content = "popover works on a link",
                            placement = "bottom"
                        ),
                    div(
                      tags$b("general element"),
                      style =
                      \'
                      height: 100px;
                      background-color: cornflowerblue;
                      \'
                    ) %>%
                      bsHoverPopover(
                        title = "general element",
                        content = "popover works on a \'div\'",
                        placement = "right"
                      )
                )

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
              tags$b("This block's is not matched with others")
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
                    p("This block\'s is not matched with others")
                ),
                heightMatcher("a", "b")
            )

            server <- function(input, output, session) {

            }
            # Try to drag `b` from bottom right corner and see what happens to `a`
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
