

#' Bootstrap3 alert
#' @description Add a Bootstrap3 alert component to the UI
#' @param ... any shiny tag or tagList you want to add to the alert body, **or**
#' any additional attributes you want to add to the alert element.
#' @param status string, one of "success", "info", "warning", "danger"
#' @param closeable bool, can the alert be closed?
#'
#' @return shiny tag element
#' @export
#' @details
#' Read more here: https://getbootstrap.com/docs/3.3/components/#alerts
#' @examples
#' if(interactive()) {
#'   library(shiny)
#'   ui <- fluidPage(
#'     bsAlert(tags$b("Success: "), "You made it", status = "success"),
#'     bsAlert(tags$b("Info: "), "Something happened", status = "info"),
#'     bsAlert(tags$b("Warning: "), "Something is not right", status = "warning"),
#'     bsAlert(tags$b("Danger: "), "Oh no...", status = "danger")
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
bsAlert <- function(..., status = "success", closeable = TRUE) {
  status <- match.arg(status, c("success", "info", "warning", "danger"))
  stopifnot(is.logical(closeable) && length(closeable) == 1)
  tag_class <- paste0("alert alert-", status)
  btn <- ""
  if (closeable) {
    tag_class <- paste(tag_class, "alert-dismissible")
    btn <- HTML('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>')
  }
  div(
    class = tag_class,
    role = "alert",
    btn,
    ...
  )
}
