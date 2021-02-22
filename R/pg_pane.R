#' @rdname pgPaneUpdate
#' @importFrom shinydashboardPlus timelineBlock timelineLabel
#' @importFrom shinyWidgets progressBar
#'
#' @param titles labels to display for each progress, must have the same length
#' as `pg_ids`
#' @param pg_ids a character vector of IDs for each progress. Don't forget
#' to use `ns` wrap each ID.
#' @param title_main If not specified and pane_id contains 'plot', title will be
#' 'Plot Prepare'; has 'df' will be 'Data Prepare', if neither will be
#' "Progress"
#' @param top css style off set to the current windown top
#' @param right css style off set to the current windown right
#' @param opened bool, if this panel is opened at start
#'
#' @export
pgPaneUI <-function(
    pane_id,
    titles,
    pg_ids,
    title_main = NULL,
    opened = FALSE,
    top = "3%",
    right = "2%"
    ) {

    if(is.null(title_main)) {
        title_main <- pane_id %>% {
            if(str_detect(., "plot")) "Plot Prepare"
            else if(str_detect(., "df")) "Data Prepare"
            else("Progress")
        }
    }
    assert_that(is.character(titles))
    assert_that(is.character(pg_ids))
    assert_that(length(titles) == length(pg_ids))

    lapply(seq_along(pg_ids), function(i) {
        tags$li(style = "margin-bottom: 0;",
                tags$i(id = glue("{pg_ids[i]}-icon"),
                       class = "fa fa-times bg-red"),
                div(class = "timeline-item",
                    h3(class = "timeline-header no-border", titles[i]),
                    div(class="timeline-body", style = "padding: 0px;",
                        shinyWidgets::progressBar(
                            glue("{pg_ids[i]}-pg"), striped = TRUE,
                            status = "primary", 0
                        )
                    )
                )
        )
    }) %>% {
        shinydashboardPlus::timelineBlock(reversed = FALSE,
                                          id = glue("{pane_id}-timeline"),
                                          .,
                                          shinydashboardPlus::timelineLabel(
                                              id = glue("{pane_id}-pg-label"),
                                              "Ready",
                                              color = "orange"),
                                          div(style = "margin-left: 60px; margin-right: 15px;",
                                              shinyWidgets::progressBar(
                                                  glue("{pane_id}-pg-all"), striped = TRUE,
                                                  status = "primary", 0
                                              )
                                          )
        )
    } %>% {
        div(class = "tab-pane", id = glue("{pane_id}-pg-container"),
            absolutePanel(
                top = top, right = right, draggable = TRUE, width = "310",
                height = "auto", class = "control-panel", cursor = "inherit",
                style = "background-color: white; z-index:999;",
                fluidRow(
                    column(3),
                    column(7, h4(title_main)),
                    column(2,
                           HTML(glue('<button class="action-button ',
                                     'bttn bttn-simple bttn-xs bttn-primary ',
                                     'bttn-no-outline"',
                                     'data-target="#{pane_id}-pg-collapse"',
                                     ' data-toggle="collapse">',
                                     '<i class="fa fa-minus"></i></button>')))
                ),
                div(class = if(opened) "collapse in" else "collapse",
                    id = glue("{pane_id}-pg-collapse"), .)
            ),
            spsDepend("shinydashboard", js = FALSE),
            spsDepend("AdminLTE", js = FALSE),
            spsDepend("update_pg"),
            spsDepend("font-awesome"),
            spsDepend("bttn"),
            spsDepend("toastr")
        )
    }
}

#' A draggable progress panel
#' @description  Creates a panel that displays multiple progress items.
#' Use [pgPaneUI] on UI side and use `pgPaneUpdate` to update it.
#' The UI only
#' renders correctly inside [shinydashboard::dashboardPage()] or
#' [shinydashboardPlus::dashboardPagePlus()].
#'
#' A overall progress is automatically calculated on the bottom.
#' @param pane_id Progress panel main ID, use `ns` wrap it on `pgPaneUI` but not
#' on `pgPaneUpdate` if using shiny module
#' @param pg_id a character string of ID indicating which progress within this
#' panel you want to update.
#'  Do not use `ns(pg_id)` to wrap it on server
#' @param value 0-100 number to update the progress you use `pg_id` to
#' choose
#' @param session current shiny session
#' @importFrom shinyWidgets updateProgressBar
#' @return HTML elements
#' @export
#' @examples
#' if(interactive()){
#'     # try to slide c under 0
#'     ui <- fluidPage(
#'         h4("you need to open up the progress
#'                                 tracker, it is collapsed ->"),
#'         actionButton("a", "a"),
#'         actionButton("b", "b"),
#'         sliderInput("c", min = -100,
#'                     max = 100, value = 0,
#'                     label = "c"),
#'         pgPaneUI(
#'             pane_id = "thispg",
#'             titles = c("this a", "this b", " this c"),
#'             pg_ids = c("a", "b", "c"),
#'             title_main = "Example Progress",
#'             opened = TRUE,
#'             top = "30%",
#'             right = "50%"
#'         )
#'
#'     )
#'     server <- function(input, output, session) {
#'         observeEvent(input$a, {
#'             for(i in 1:10){
#'                 pgPaneUpdate("thispg", "a", i*10)
#'                 Sys.sleep(0.3)
#'             }
#'         })
#'         observeEvent(input$b, {
#'             for(i in 1:10){
#'                 pgPaneUpdate("thispg", "b", i*10)
#'                 Sys.sleep(0.3)
#'             }
#'         })
#'         observeEvent(input$c, pgPaneUpdate("thispg", "c", input$c))
#'     }
#'     shinyApp(ui, server)
#' }
pgPaneUpdate <- function(pane_id, pg_id, value,
                         session = getDefaultReactiveDomain()){
    shinyCatch({
        assert_that(is.character(pane_id))
        assert_that(is.character(pg_id))
        assert_that(value >= 0 & value <= 100,
                    msg = "Progress value needs to be 0-100")
        shinyWidgets::updateProgressBar(session,
                                        id = glue("{pg_id}-pg"),
                                        value = value)
        if(inherits(session, "session_proxy")){
            pane_id <- session$ns(pane_id)
            pg_id <- session$ns(pg_id)
        }
        session$sendCustomMessage(
            type = "sps-update-pg",
            message = list(
                panel_id = pane_id,
                which_pg = pg_id,
                value = value
            ))
    }, blocking_level = "error")
}
