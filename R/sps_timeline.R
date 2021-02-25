# credits to Abhi Sharma @ https://codepen.io/abhisharma2/pen/vEKWVo/

#' A shiny timeline component
#' @description This timeline is horizontal, use **spsTimeline** to define it and
#' use **updateSpsTimeline** on server to update it.
#' @param id html ID of the timeline if you are using shiny modules:
#' use namespace function to create the ID but DO NOT use namespace function
#' on server.
#' @param up_labels a vector of strings, text you want to display on top of each
#' timeline item, usually like year number. If you do not want any text for a
#' certain items, use `""` to occupy the space.
#' @param down_labels a vector of strings, text you want to display at the
#' bottom of each timeline item.
#' @param icons a list of icon objects. If you do not want an icon for certain
#' items, use `div()` to occupy the space.
#' @param completes a vector of TRUE or FALSE, indicating if the items are
#' completed or not. Completed items will become green.
#' @return returns a shiny component
#' @export
#' @details `up_labels`, `down_labels`, `icons`, `completes` must have the same
#' length.
#' @examples
#' if(interactive()){
#'     ui <- fluidPage(
#'         column(6,
#'                spsTimeline(
#'                    "b",
#'                    up_labels = c("2000", "2001"),
#'                    down_labels = c("step 1", "step 2"),
#'                    icons = list(icon("table"), icon("gear")),
#'                    completes = c(FALSE, TRUE)
#'                )
#'         ),
#'         column(6,
#'                actionButton("a", "complete step 1"),
#'                actionButton("c", "uncomplete step 1"))
#'
#'     )
#'
#'     server <- function(input, output, session) {
#'         observeEvent(input$a, {
#'             updateSpsTimeline(session, "b", 1, up_label = "0000", down_label = "Finish")
#'         })
#'         observeEvent(input$c, {
#'             updateSpsTimeline(session, "b", 1, complete = FALSE,
#'                               up_label = "9999", down_label = "Step 1")
#'         })
#'     }
#'
#'     shinyApp(ui, server)
#' }
spsTimeline <- function(
    id, up_labels, down_labels,
    icons, completes){
    assert_that(is.character(up_labels))
    assert_that(is.character(down_labels))
    assert_that(is.list(icons))
    assert_that(length(up_labels) == length(down_labels))
    assert_that(length(up_labels) == length(icons))
    assert_that(length(up_labels) == length(completes))
    lapply(seq_along(up_labels), function(i){
        tags$li(
            class = if(completes[i]) "li complete" else "li",
            id = paste0(id, "-", i),
            div(
                class = "sps-timestamp",
                span(up_labels[i])
            ),
            div(
                class = "timeline-i",
                icons[[i]]
            ),
            div(
                class = "status",
                h4(down_labels[i])
            )
        )
    }) %>% {
        tags$ul(
            class = "sps-timeline", id = id,
            style = "white-space: nowrap;",
            .,
            spsDepend("basic"),
            spsDepend("update_timeline")
        )
    }
}

#' @rdname spsTimeline
#'
#' @param session current shiny session
#' @param item_no integer, which item number counting from left to right you
#' want to update
#' @param up_label the `item_no` associated up label to update
#' @param down_label the `item_no` associated down label to update
#' @param complete bool, is this item completed or not
#'
#' @export
updateSpsTimeline <-function(
    session,
    id,
    item_no,
    complete = TRUE,
    up_label = NULL,
    down_label = NULL
    ) {


    assert_that(is.numeric(item_no))
    assert_that(is.character(id))
    assert_that(length(id) == 1)
    if (not_empty(up_label)) assert_that(is.character(up_label) && length(up_label) == 1)
    if (not_empty(down_label)) assert_that(is.character(down_label) && length(down_label) == 1)
    assert_that(item_no > 0)
    item_no <- as.integer(item_no)
    if (inherits(session, "session_proxy")) {
        id <- session$ns(id)
    }
    session$sendCustomMessage(
        type = "sps-update-timeline",
        message = list(
            id = paste0("#", id, "-", item_no),
            complete = complete,
            upLabel = up_label,
            downLabel = down_label
    ))
}

