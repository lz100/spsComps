

#' Create a variety of CSS loaders on UI
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

  type <- .validateLoader(
    type = type, id = id, height = height, width = width, color = color,
    opacity = opacity, inline = inline, is_icon = is_icon
  )
  if (id == "") id <- paste0('spsloader-', glue::glue_collapse(sample(9, 9)))
  element <- if (is_icon) tags$i else tags$div
  display <- if (inline) "inline-block" else "block"

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

.validateLoader <- function(
  type = "default",
  id = "",
  height = "1.5rem",
  width = height,
  color = "#337ab7",
  opacity = 1,
  inline = FALSE,
  is_icon = FALSE,
  isID = TRUE
) {

  stopifnot(is.character(type) && length(type) == 1)
  stopifnot(is.character(id) && length(id) == 1)
  stopifnot(is.character(height) && length(height) == 1)
  stopifnot(is.character(width) && length(width) == 1)
  stopifnot(is.character(color) && length(color) == 1)
  stopifnot(is.numeric(opacity) && opacity >=0 && opacity <= 1)
  stopifnot(is.logical(inline) && length(inline) == 1)
  stopifnot(is.logical(is_icon) && length(is_icon) == 1)
  stopifnot(is.logical(isID) && length(isID) == 1)

  match.arg(type, c(
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
}

########################### Server side funcs #############################

#' Add CSS loaders from server
#' @description Add/remove CSS loaders from server to any Shiny/HTML component.
#' It is useful to indicate busy status when some code is running in the server
#' and when it finishes, remove the loader to indicate clear status.
#' @return CSS load in R6 class
#' @export
#'
#' @examples
addLoader <- R6::R6Class(
  classname = "spsComps_loader",
  public = list(
    #' @description
    #' @param target_selector string, which Shiny component you want to add the
    #' loader to? a shiny component ID or a valid CSS selector if `isID = FLASE`.
    #' for example, you have a button and want to add animation to it:
    #' ```
    #' actionButton(inputId = "btn")
    #' ```
    #'
    #' This function is used in server only, so if you are in shiny module,
    #' **DO NOT** add the `ns()` wrapper.
    #'
    #' @param isID bool, is your selector an ID?
    #' @param type string, one of  "circle", "dual-ring", "facebook", "heart",
    #' "ring", "roller", "default", "ellipsis", "grid", "hourglass", "ripple",
    #' "spinner", default is "default".
    #' @param id string, the unqiue ID for the loader, if not provided, a random
    #' ID will be given. If you are using shiny modules, use `session$ns('YOUR_ID')`
    #'to wrap it.
    #' @param height string, (r)em, "1.5rem", "1.5em", or pixel, like "10px".
    #' Default is `NULL`, will be automatically calculated based on the target
    #' component. It is recommend to use `NULL` for "replace" and "inline" method
    #' to let it automatically be calculated, but required for "full_screen" method.
    #' @param width string, default is the same as `height` to make it sequare.
    #' @param color string, any valid CSS color name, or hex color code
    #' @param opacity number, between 0-1
    #' @param method one of "replace", "inline", "full_screen", see details
    #' @param block bool, for some input components, once the loader starts,
    #' it can also block user interaction with the component, very useful for
    #' "inline" method, eg. prevent users from clicking the button while some
    #' process is still running.
    #' @param center bool, try to place the load to the center of the target for
    #' "inline" and "replace" and center of the screen for "full_screen".
    #' @param bg_color string, any valid CSS color name, or hex color code. Only
    #' works for "full_screen" method.
    #' @param footer Additional Shiny/HTML component to add below the loader, like
    #' a title `h1("load title")`.
    #' @param z_index number, only works for "full_screen" method, what CSS layer
    #' should the overlay be places. In HTML, all elements have the default of 0.
    #' @param alert bool, should alert if target cannot be found or other javascript
    #' errors? mainly for debugging
    #' @param session shiny session
    initialize = function(
      target_selector = "",
      isID = TRUE,
      type = "default",
      id = "",
      height = NULL,
      width = height,
      color = "#337ab7",
      opacity = 1,
      method = "replace",
      block = TRUE,
      center = TRUE,
      bg_color = "#eee",
      footer = NULL,
      z_index = 2000,
      alert = FALSE,
      session = shiny::getDefaultReactiveDomain()
    ){
      if(!inherits(session, c("ShinySession", "session_proxy")))
        stop("Cannot find current Shiny session")

      stopifnot(is.character(target_selector) && length(target_selector) == 1)
      stopifnot(is.character(bg_color) && length(bg_color) == 1)
      stopifnot(is.logical(alert) && length(alert) == 1)
      stopifnot(is.logical(center) && length(center) == 1)
      stopifnot(is.numeric(z_index) && length(z_index) == 1)
      if(!is.null(footer)) stopifnot(inherits(footer, "shiny.tag") && length(footer) == 3)
      if(!is.null(height)) stopifnot(is.character(height) && length(height) == 1)
      if(!is.null(width)) stopifnot(is.character(width) && length(width) == 1)

      type <- .validateLoader(
        type = type, id = id, color = color,
        opacity = opacity, isID = isID
      )

      method <- match.arg(method, c("replace", "inline", "full_screen"))
      if ((method == "full_screen") && (is.null(height) || is.null(width)))
        stop("Loader: height and width cannot by NULL for full screen method.")

      selector <- if(isID) {
        paste0("#", if(inherits(session, "session_proxy")) session$ns(target_selector) else target_selector)
      } else {
        target_selector
      }
      id <- if (id == "") paste0('spsloader-', glue::glue_collapse(sample(9, 9))) else id

      footer <- if(method != "inline") htmltools::doRenderTags(footer) else NULL
      z_index <- floor(z_index)

      session$sendCustomMessage('sps-add-loader', message = list(
        selector = selector,
        id = id,
        type = type,
        height = height,
        width = width,
        method = method,
        color = color,
        opacity = opacity,
        block = block,
        center = center,
        footer = footer,
        zIndex = z_index,
        bgColor = bg_color,
        alert = alert
      ))

      private$selector <- selector
      private$id <- paste0(id, "-container")
      private$block <- block
      private$method <- method
      private$session <- session

    },
    show = function(alert = FALSE){
      shinyCatch({
        if(!is.logical(alert) || length(alert) != 1)
          stop("Alert needs to be TRUE or FALSE")
      }, blocking_level = "error")

      private$session$sendCustomMessage('sps-toggle-loader', message = list(
        selector = private$selector,
        id = private$id,
        state = "show",
        method = private$method,
        block = private$block,
        alert = alert
      ))
    },
    hide = function(alert = FALSE){
      shinyCatch({
        if(!is.logical(alert) || length(alert) != 1)
          stop("Alert needs to be TRUE or FALSE")
      }, blocking_level = "error")

      private$session$sendCustomMessage('sps-toggle-loader', message = list(
        selector = private$selector,
        id = private$id,
        state = "hide",
        method = private$method,
        block = private$block,
        alert = alert
      ))
    }
  ),
  private = list(
    selector = NULL,
    id = NULL,
    block = NULL,
    method = NULL,
    session = NULL
  )
)
