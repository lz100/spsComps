
# UI
uiProgress <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("Progress display components"),
      column(
        6,
        box(
          title = "pgPaneUI & pgPaneUpdate", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              - A draggable progress panel: `pgPaneUI` creates a panel that displays
              multiple progress items. Use `pgPaneUpdate` on server side to update
              the progress.
              - Hold the panel to drag, and use <i class="fa fa-minus text-primary"></i> button to minify it.
              - A overall progress is automatically calculated on the bottom for you.
              - When a progress is complete, the progress icon will become green.
              - Try to drag the value for `progress c` below 0, and see what happens.
              ')
          ),
          h4("You can drag the progress panel to any place. ->"),
          actionButton(ns("a"), "progress a"),
          actionButton(ns("b"), "progress b"),
          sliderInput(ns("c"), min = -100,
                      max = 100, value = 0,
                      label = "progress c"),
          pgPaneUI(
            pane_id = ns("thispg"),
            titles = c("this a", "this b", " this c"),
            pg_ids = c(ns("a"), ns("b"), ns("c")),
            title_main = "Example Progress",
            opened = TRUE,
            top = "55%",
            right = "60%"
          ),
          spsCodeBtn(
            ns("code_pgPaneUI"),
            show_span = TRUE,
            '
            # try to slide c under 0
            ui <- fluidPage(
                h4("you need to open up the progress
                                        tracker, it is collapsed ->"),
                actionButton("a", "a"),
                actionButton("b", "b"),
                sliderInput("c", min = -100,
                            max = 100, value = 0,
                            label = "c"),
                pgPaneUI(
                    pane_id = "thispg",
                    titles = c("this a", "this b", " this c"),
                    pg_ids = c("a", "b", "c"),
                    title_main = "Example Progress",
                    opened = TRUE,
                    top = "30%",
                    right = "50%"
                )

            )
            server <- function(input, output, session) {
                observeEvent(input$a, {
                    for(i in 1:10){
                        pgPaneUpdate("thispg", "a", i*10)
                        Sys.sleep(0.3)
                    }
                })
                observeEvent(input$b, {
                    for(i in 1:10){
                        pgPaneUpdate("thispg", "b", i*10)
                        Sys.sleep(0.3)
                    }
                })
                observeEvent(input$c, pgPaneUpdate("thispg", "c", input$c))
            }
            shinyApp(ui, server)
            '
          )
        )
      ),
      column(
        6,
        box(
          title = "spsTimeline & updateSpsTimeline", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            - `spsTimeline` creates a horizontal timeline with different time points inside.
            - Use `updateSpsTimeline` to update time points\' status, label and text.
            '
            )
          ),
          spsTimeline(
            ns("timeline"),
            up_labels = c("2000", "2001", "2003", "2004", "2005", "2006"),
            down_labels = c("step 1", "step 2", "step 3", "step 4", "step 5", "step 6"),
            icons = list(icon("table"), icon("gear"), icon("gear"), icon("gear"), icon("gear"), icon("gear")),
            completes = c(FALSE, TRUE, FALSE, FALSE, FALSE, FALSE)
          ),
          actionButton(ns("timeline_finish"), "complete step 1"),
          actionButton(ns("timeline_unfinish"), "uncomplete step 1"),
          actionButton(ns("timeline_all"), "complete 3-6 each in 1s"),
          actionButton(ns("timeline_unall"), "uncomplete 6-3 each in 1s"),
          br(),
          spsCodeBtn(
            ns("code_timeline"),
            show_span = TRUE,
            '
            ui <- fluidPage(
                column(6,
                       spsTimeline(
                           "b",
                           up_labels = c("2000", "2001"),
                           down_labels = c("step 1", "step 2"),
                           icons = list(icon("table"), icon("gear")),
                           completes = c(FALSE, TRUE)
                       )
                ),
                column(6,
                       actionButton("a", "complete step 1"),
                       actionButton("c", "uncomplete step 1"))

            )

            server <- function(input, output, session) {
                observeEvent(input$a, {
                    updateSpsTimeline(session, "b", 1, up_label = "0000", down_label = "Finish")
                })
                observeEvent(input$c, {
                    updateSpsTimeline(session, "b", 1, complete = FALSE,
                                      up_label = "9999", down_label = "Step 1")
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
serverProgress <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(input$a, {
        for(i in 1:10){
          pgPaneUpdate("thispg", "a", i*10)
          Sys.sleep(0.3)
        }
      })
      observeEvent(input$b, {
        for(i in 1:10){
          pgPaneUpdate("thispg", "b", i*10)
          Sys.sleep(0.3)
        }
      })
      observeEvent(input$c, pgPaneUpdate("thispg", "c", input$c))

      observeEvent(input$timeline_finish, {
        updateSpsTimeline(session, "timeline", 1, up_label = "0000", down_label = "Finish")
      })
      observeEvent(input$timeline_unfinish, {
        updateSpsTimeline(session, "timeline", 1, complete = FALSE,
                          up_label = "9999", down_label = "Step 1")
      })
      observeEvent(input$timeline_all, {
        for(i in 3:6) {updateSpsTimeline(session, "timeline", i, complete = TRUE); Sys.sleep(1)}
      })
      observeEvent(input$timeline_unall, {
        for(i in 6:3) {updateSpsTimeline(session, "timeline", i, complete = FALSE); Sys.sleep(1)}
      })

    }
  )
}
