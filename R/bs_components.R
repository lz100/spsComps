

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

#' Colorful title element
#' @description  Add a title element to UI
#' @param title string, title text
#' @param level string, level of the title, the larger, the bigger, one of
#' "1", "2", "3", "4", "5", "6"
#' @param status string, one of "primary", "info", "success", "warning", "danger".
#' This determines the color of the line.
#' @param other_color string, if you do not like the default 5 status colors,
#' specify a valid CSS color here. If this is provided, `status` will be ignored.
#' @param opacity numeric, a number larger than 0 smaller than 1
#' @param ... other attributes and children add to this element
#'
#' @return returns a shiny tag
#' @export
#'
#' @examples
#' if(interactive()) {
#'   library(shiny)
#'   library(magrittr)
#'   ui <- fluidPage(
#'     tags$b("Different status"),
#'     c("primary", "info", "success", "warning", "danger") %>%
#'       lapply(function(x) spsTitle(x, "4", status = x)),
#'     tags$b("custom color"),
#'     spsTitle("purple", "4", other_color = "purple"),
#'     spsTitle("pink", "4", other_color = "pink"),
#'     tags$b("Different levels"),
#'     lapply(as.character(1:6), function(x) spsTitle(paste0("H", x), x)),
#'     tags$b("Different opacity"),
#'     lapply(seq(0.2, 1, 0.2), function(x) spsTitle(as.character(x), opacity = x))
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
spsTitle <- function(
  title,
  level = "2",
  status = "info",
  other_color = NULL,
  opacity = 1,
  ...
){
  if (!is.null(other_color)) {
    stopifnot(is.character(other_color) && length(other_color) == 1)
    color <- other_color
  } else {
    color <- getBsColor(status)
  }
  level <- match.arg(level, c("1", "2", "3", "4", "5", "6"))
  stopifnot(is.character(title) && length(title) == 1)
  stopifnot(is.numeric(opacity) && opacity <= 1 && opacity >= 0)
  tags[[paste0("h", level)]](
    title,
    style = glue("color: {color}; opacity: {opacity}; "),
    ...
  )
}

#' @rdname spsTitle
#' @export
tabTitle <- spsTitle


#' Create a horizontal line
#' @description Create a horizontal line of your choice
#' @param status string, one of "primary", "info", "success", "warning", "danger".
#' This determines the color of the line.
#' @param width numeric, how wide should the line be, a number larger than 0
#' @param other_color string, if you do not like the default 5 status colors,
#' specify a valid CSS color here. If this is provided `status` will be ignored.
#' @param type string, one of "solid", "dotted", "dashed", "double",
#' "groove", "ridge", "inset", "outset"
#' @param opacity numeric, a number larger than 0 smaller than 1
#'
#' @export
#' @return HTML `<hr>` element
#' @details
#' Read more about type here: https://www.w3schools.com/css/css_border.asp
#' @examples
#' if(interactive()) {
#'   library(shiny)
#'   library(magrittr)
#'   ui <- fluidPage(
#'     tags$b("Different status"),
#'     spsHr("info"),
#'     spsHr("primary"),
#'     spsHr("success"),
#'     spsHr("warning"),
#'     spsHr("danger"),
#'     tags$b("custom color"),
#'     spsHr(other_color = "purple"),
#'     spsHr(other_color = "pink"),
#'     tags$b("Different width"),
#'     lapply(1:5, function(x) spsHr(width = x)),
#'     tags$b("Different type"),
#'     c("solid", "dotted", "dashed", "double", "groove", "ridge", "inset", "outset") %>%
#'       lapply(function(x) spsHr(type = x, width = 3)),
#'     tags$b("Different opacity"),
#'     lapply(seq(0.2, 1, 0.2), function(x) spsHr(opacity = x))
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
spsHr <- function(
  status = "info",
  width = 0.5,
  other_color = NULL,
  type = "solid",
  opacity = 1
) {
  if (!is.null(other_color)) {
    stopifnot(is.character(other_color) && length(other_color) == 1)
    color <- other_color
  } else {
    color <- getBsColor(status)
  }
  type <- match.arg(type, c("solid", "dotted", "dashed", "double", "groove", "ridge", "inset", "outset"))
  stopifnot(is.character(type) && length(type) == 1)
  stopifnot(is.numeric(opacity) && opacity <= 1 && opacity >= 0)
  stopifnot(is.numeric(width) && width >= 0)
  width <- paste0(width, "px")
  tags$hr(style =glue('border: {width} {type} {color}; opacity: {opacity}'))
}
