

#' Create a variety of CSS loaders
#' @description CSS loaders can improve user experience by adding a small
#' animation icon to a HTML element. spsComps provides you 12 different
#' looking CSS loaders. Unlike other Shiny packages, you have full control
#' of the CSS loader here, like position, color, size, opacity, etc.
#'
#' @param type string, one of  "circle", "dual-ring", "facebook", "heart",
#' "ring", "roller", "default", "ellipsis", "grid", "hourglass", "ripple",
#' "spinner"
#' @param id string, optional, ID for the component, if not given, a random
#' ID will be given.
#' @param height string, pixel, like "10px"; or (r)em, "1.5rem", "1.5em".
#' Default is "1.5rem".
#' @param width string, default is the same as `height`. For most loader, you
#' want to keep width = height for a square shape.
#' @param color string, any valid CSS color name, or hex color code
#' @param opacity number, between 0-1
#' @param inline bool, do you want the loader be inline? This is useful to turn on if
#' you want to add the loader to a [shiny::actionButton], so the loader and button
#' label will be on the same line. See examples.
#' @param is_icon bool, default uses the HTML `div` tag, turn on this option will
#' use the `i` tag for icon. Useful if you want to add the loader as `icon` argument
#' for the [shiny::actionButton]. See examples.
#' @param ... other shiny tags or HTML attributes you want to add to the loader.
#'
#' @return returns a css loader component.
#' @details
#' #### 'rem' unit
#' For most modern web apps, including Shiny, 1rem = 10px
#' @export
#'
#' @examples
#' if (interactive()){
#'   library(shiny)
#'   heights <- paste0(c(1.5, 3, 5, 8, 10, 15, 20), "rem")
#'   colors <- list(
#'     colorRampPalette(c("#00d2ff", "#3a7bd5"))(7),
#'     colorRampPalette(c("#59C173", "#a17fe0", "#5D26C1"))(7),
#'     colorRampPalette(c("#667db6", "#0082c8", "#5D26C1", "#667db6"))(7),
#'     colorRampPalette(c("#f2709c", "#ff9472"))(7),
#'     colorRampPalette(c("#FC5C7D", "#6A82FB"))(7),
#'     colorRampPalette(c("#4568DC", "#B06AB3"))(7)
#'   )
#'   types <- c("circle", "dual-ring", "facebook", "heart",
#'              "ring", "roller", "default", "ellipsis",
#'              "grid", "hourglass", "ripple", "spinner")
#'   ui <- fluidPage(
#'     lapply(seq_along(types), function(i){
#'       div(
#'         h4(types[i]), br(),
#'         lapply(1:7, function(x){
#'           cssLoader(
#'             types[i], height = heights[x],
#'             color = colors[[if(i > 6) i - 6 else i]][x],
#'             inline = TRUE
#'           )
#'         }),
#'         br()
#'       )
#'     })
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
#'
#' # use with buttons
#' if (interactive()){
#'   library(shiny)
#'   ui <- fluidPage(
#'     actionButton(
#'       "btn-a", "",
#'       ## `inline = TRUE` is important if you want loader and
#'       ## text in the same line.
#'       icon =  cssLoader(is_icon = TRUE, inline = TRUE, color = "#3a7bd5"
#'       )
#'     ),
#'     actionButton(
#'       "btn-b", "Loading",
#'       icon =  cssLoader(is_icon = TRUE, color = "#667db6", inline = TRUE)
#'     )
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
cssLoader <- function(
  type = "default",
  id = "",
  height = "1.5rem",
  width = height,
  color = "#337ab7",
  opacity = 1,
  inline = FALSE,
  is_icon = FALSE,
  ...
) {
  stopifnot(is.character(type) && length(type) == 1)
  stopifnot(is.character(id) && length(id) == 1)
  stopifnot(is.character(height) && length(height) == 1)
  stopifnot(is.character(width) && length(width) == 1)
  stopifnot(is.character(color) && length(color) == 1)
  stopifnot(is.numeric(opacity) && opacity >=0 && opacity <= 1)
  stopifnot(is.logical(inline) && length(inline) == 1)
  stopifnot(is.logical(is_icon) && length(is_icon) == 1)

  if (id == "") id <- paste0('spsloader-', glue::glue_collapse(sample(9, 7)))

  element <- if (is_icon) tags$i else tags$div
  display <- if (inline) "inline-block" else "block"

  type <- match.arg(type, c(
    "circle",
    "dual-ring",
    "facebook",
    "heart",
    "ring",
    "roller",
    "default",
    "ellipsis",
    "grid",
    "hourglass",
    "ripple",
    "spinner"
  ))

  element(
    id = id,
    class = "sps-cssloader",
    style = glue::glue(
      '
      height: {height}; width: {width}; display: {display}; opacity: {opacity};
      '
    ),
    tags$script(glue(.open = "@{", .close = "}@",
      '\n
        $(function(){
          $("#@{id}@").prepend(chooseLoader("@{id}@", "@{type}@", "@{color}@", "@{width}@", "@{height}@"));
        });
      \n'
    )),
    spsDepend("css-loader"),
    ...
  )
}
