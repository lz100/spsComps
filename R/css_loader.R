

#' Create a variety of CSS loaders on UI
#' @description CSS loaders can improve user experience by adding a small
#' animation icon to a HTML element. spsComps provides you 12 different
#' looking CSS loaders. Unlike other Shiny packages, you have full control
#' of the CSS loader here, like position, color, size, opacity, etc.
#'
#' @param type string, one of  "circle", "dual-ring", "facebook", "heart",
#' "ring", "roller", "default", "ellipsis", "grid", "hourglass", "ripple",
#' "spinner", "gif", default is "default".
#' @param src string, online URL or local path of the gif animation file if
#' you would like to upload your own loader.
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
#'       icon =  cssLoader(type = "hourglass", is_icon = TRUE, color = "#667db6", inline = TRUE)
#'     )
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
#' # use your own
#' if (interactive()){
#'   library(shiny)
#'   spinner <- "https://github.com/lz100/spsComps/blob/master/examples/demo/www/spinner.gif?raw=true"
#'   eater <- "https://github.com/lz100/spsComps/blob/master/examples/demo/www/bean_eater.gif?raw=true"
#'   ui <- fluidPage(
#'     cssLoader(
#'       "gif", spinner, height = "50px"
#'     ),
#'     cssLoader(
#'       "gif", spinner, height = "100px"
#'     ),
#'     cssLoader(
#'       "gif", eater, height = "150px"
#'     ),
#'     cssLoader(
#'       "gif", eater, height = "200px"
#'     ),
#'     actionButton(
#'       "btn-custom1", "",
#'       icon =  cssLoader(
#'         type = "gif", src = spinner,
#'         is_icon = TRUE, inline = TRUE
#'       )
#'     ),
#'     actionButton(
#'       "btn-custom2", "A button",
#'       icon =  cssLoader(
#'         type = "gif", src = eater,
#'         is_icon = TRUE, inline = TRUE
#'       )
#'     )
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
cssLoader <- function(
  type = "default",
  src = "",
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
  if(type == "gif") stopifnot(is.character(src) && length(src) == 1)
  if (is.null(src)) src <- ""
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
          $("#@{id}@").prepend(chooseLoader("@{id}@", "@{type}@", "@{src}@", "@{color}@", "@{width}@", "@{height}@"));
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
    "spinner",
    "gif"
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
#' if (interactive()){
#'   ui <- fluidPage(
#'     h4("Use buttons to show and hide loaders with different methods"),
#'     spsDepend("css-loader"), # required
#'     tags$b("Replace"), br(),
#'     actionButton("b_re_start", "Replace"),
#'     actionButton("b_re_stop", "stop replace"),
#'     br(), tags$b("Inline"), br(),
#'     actionButton("b_in_start", "Inline"),
#'     actionButton("b_in_stop", "stop inline"),
#'     br(), tags$b("Full screen"), br(),
#'     actionButton("b_fs_start", "Full screen 2s"), br(),
#'     h4("Add loaders to a big HTML chunk"),
#'     actionButton("chunk_start", "Chunk loader"),
#'     actionButton("chunk_stop", "Stop"), br(),
#'     column(6,
#'            id = "chunk",
#'            style = "background-color: #eee",
#'            h5("Here are some text 12345"),
#'            tags$hr(),
#'            icon("home"),
#'            p("blablablablablablablablablablablablablablablablablablablabla"),
#'            p("blablablablablablablablablablablablablablablablablablablabla"),
#'            p("blablablablablablablablablablablablablablablablablablablabla"),
#'            p("blablablablablablablablablablablablablablablablablablablabla")
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     # Init loaders
#'     loader_replace <- addLoader$new("b_re_start", type = "facebook")
#'     loader_inline <- addLoader$new("b_in_start", color = "green", method = "inline")
#'     loader_fs <- addLoader$new(
#'       "b_fs_start", color = "pink", method = "full_screen",
#'       bg_color = "#eee", height = "30rem", type = "heart"
#'     )
#'     loader_chunk <- addLoader$new(
#'       "chunk", type = "spinner", color = "orange",
#'       footer = h5("chunk loader")
#'     )
#'
#'     # toggle loaders
#'     ## replace
#'     observeEvent(input$b_re_start, {
#'       loader_replace$show()
#'     })
#'     observeEvent(input$b_re_stop, {
#'       loader_replace$hide()
#'     })
#'     ## inline
#'     observeEvent(input$b_in_start, {
#'       loader_inline$show()
#'     })
#'     observeEvent(input$b_in_stop, {
#'       loader_inline$hide()
#'     })
#'     ## full screen
#'     observeEvent(input$b_fs_start, {
#'       loader_fs$show()
#'       Sys.sleep(2)
#'       loader_fs$hide()
#'     })
#'     ## chunk
#'     observeEvent(input$chunk_start, {
#'       loader_chunk$show()
#'     })
#'     observeEvent(input$chunk_stop, {
#'       loader_chunk$hide()
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' if (interactive()){
#'   ui <- bootstrapPage(
#'     spsDepend("css-loader"), # required
#'     h4("Add loaders to Shiny `render` events"),
#'     tags$b("Replace"), br(),
#'     selectizeInput(inputId = "n_re",
#'                    label = "Change this to render the following plot",
#'                    choices = c(10, 20, 35, 50)),
#'     plotOutput(outputId = "p_re"),
#'     br(), tags$b("Full screen"), br(),
#'     selectInput(inputId = "n_fs",
#'                 label = "Change this to render the following plot",
#'                 choices = c(10, 20, 35, 50)),
#'     plotOutput(outputId = "p_fs")
#'   )
#'
#'   server <- function(input, output, session) {
#'     # create loaders
#'     l_re <- addLoader$new("p_re")
#'     l_fs <- addLoader$new(
#'       "p_fs", color = "pink", method = "full_screen",
#'       bg_color = "#eee", height = "30rem", type = "grid",
#'       footer = h4("Replotting...")
#'     )
#'     # use loaders in rednering
#'     output$p_re <- renderPlot({
#'       on.exit(l_re$hide())
#'       # to make it responsive
#'       # (always create a new one by calculating the new height and width)
#'       l_re$recreate()$show()
#'       Sys.sleep(1)
#'       hist(faithful$eruptions,
#'            probability = TRUE,
#'            breaks = as.numeric(input$n_re),
#'            xlab = "Duration (minutes)",
#'            main = "Geyser eruption duration")
#'     })
#'     output$p_fs <- renderPlot({
#'       on.exit(l_fs$hide())
#'       l_fs$show()
#'
#'       Sys.sleep(1)
#'       hist(faithful$eruptions,
#'            probability = TRUE,
#'            breaks = as.numeric(input$n_fs),
#'            xlab = "Duration (minutes)",
#'            main = "Geyser eruption duration")
#'     })
#'   }
#'   shinyApp(ui, server)
#' }
addLoader <- R6::R6Class(
  classname = "spsComps_loader",
  public = list(
    #' @description create a loader object
    #' @param target_selector string, which Shiny component you want to add the
    #' loader to? a shiny component ID or a valid CSS selector if `isID = FLASE`.
    #' for example, you have a button and want to add animation to it:
    #' ```
    #' actionButton(inputId = "btn")
    #' ```
    #'
    #' This function is used in server only, so if you are in shiny module,
    #' use `ns()` for ID on UI but **DO NOT** add the `ns()` wrapper on server.
    #'
    #' UI
    #' ```
    #' actionButton(inputId = ns("btn"))
    #' ```
    #'
    #' server
    #' ```
    #' addLoader$new(target_selector = "btn", ...)
    #' ```
    #'
    #' @param isID bool, is your selector an ID?
    #' @param type string, one of  "circle", "dual-ring", "facebook", "heart",
    #' "ring", "roller", "default", "ellipsis", "grid", "hourglass", "ripple",
    #' "spinner", "gif", default is "default".
    #' @param src string, online URL or local path of the gif animation file if
    #' you would like to upload your own loader.
    #' @param id string, the unqiue ID for the loader, if not provided, a random
    #' ID will be given. If you are using shiny modules, DO NOT use `session$ns('YOUR_ID')`
    #' to wrap it. Loaders live on the top level of the document.
    #' @param height string, (r)em, "1.5rem", "1.5em", or pixel, like "10px".
    #' Default is `NULL`, will be automatically calculated based on the target
    #' component. It is recommend to use `NULL` for "replace" and "inline" method
    #' to let it automatically be calculated, but required for "full_screen" method.
    #' @param width string, default is the same as `height` to make it square.
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
    #' a title `h1("load title")`. `inline` method does not have a footer.
    #' @param z_index number, only works for "full_screen" method, what CSS layer
    #' should the overlay be places. In HTML, all elements have the default of 0.
    #' @param alert bool, should alert if target cannot be found or other javascript
    #' errors? mainly for debugging
    #' @param session shiny session
    #' @return A R6 loader object
    #' @details
    #' #### Methods
    #' - `replace`: use a HTML `div` with the same CSS styles to **replace the original**
    #'   **target**, but add the loader inside and remove original content inside. When the
    #'   loader is `hide`, show the original `div` and hide this loader `div`. Height
    #'   and width is the original `div`'s height unless specially specified. Good
    #'   example of this will be some plot outputs.
    #' - `inline`: append the loader as the first child of target HTML container.
    #'   loader's height and width is the original `div`'s height unless specially specified.
    #'   In addition, this methods will **disable** all inputs and buttons inside the
    #'   target container, so this method can be useful on some buttons.
    #' - `full_screen`: Do not change anything of the target HTML container, add
    #'   an overlay to **cover the whole page** when `show` and hide the overlay when `hide`.
    #'   This method requires the `height` to be specified manually. Under this method,
    #'   `bg_color` and `z_index` can also be changed.
    #'
    #' #### New container
    #' `addLoader$new()` method only stores the loader information, the loader is
    #' add to your docuement upon the first time `addLoader$show()` is called.
    #'
    #' #### Required javascript and css files
    #' Unfortunately, js and css required by this function cannot be added automatically from
    #' the server end. These files have to be added before app start. Add
    #' `spsDepend('css-loader')` somewhere in your UI to add the dependency.
    initialize = function(
      target_selector = "",
      isID = TRUE,
      type = "default",
      src = "",
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
      if(type == "gif") stopifnot(is.character(src) && length(src) == 1)
      if (is.null(src)) src <- ""

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

      private$data <- list(
        selector = selector,
        id = id,
        type = type,
        src = src,
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
      )
      private$session <- session
      invisible(self)

    },
    #' @description show the loader
    #' @param alert bool, if the target selector or loader is not found,
    #' alert on UI? For debugging purposes.
    #' @details
    #' Make sure your target element is visible when the time you call this `show`
    #' method, otherwise, you will not get it if height and width is rely on
    #' auto-calculation for "replace" and "inline" method. "full_screen" method
    #' is not affected.
    show = function(alert = FALSE){
      if (private$detroyed) {
        shinyCatch(msg("Loader is destroyed, use `recreate` method to create a new one"))
        return(invisible(self))
      }

      shinyCatch({
        if(!is.logical(alert) || length(alert) != 1)
          stop("Alert needs to be TRUE or FALSE")
      }, blocking_level = "error")


      private$session$sendCustomMessage('sps-add-loader', message = private$data)
      private$session$sendCustomMessage(
        'sps-toggle-loader', message = append(private$data, list(state = "show"))
      )
      invisible(self)
    },
    #' @description hide the loader
    #' @param alert bool, if the target selector or loader is not found,
    #' alert on UI? For debugging purposes.
    hide = function(alert = FALSE){
      if (private$detroyed) {
        shinyCatch(msg("Loader is destroyed, use `recreate` method to create a new one"))
        return(invisible(self))
      }
      shinyCatch({
        if(!is.logical(alert) || length(alert) != 1)
          stop("Alert needs to be TRUE or FALSE")
      }, blocking_level = "error")

      private$session$sendCustomMessage(
        'sps-toggle-loader', message = append(private$data, list(state = "hide"))
      )
      invisible(self)
    },

    #' @description Destroy current loader
    #' @param alert bool, if the target selector or loader is not found,
    #' alert on UI? For debugging purposes.
    #' @details hide and remove current loader from the current document
    destroy = function(alert = FALSE) {
      self$hide(alert)
      private$session$sendCustomMessage('sps-remove-loader', message = list(
        id = private$data$id
      ))
      private$detroyed <- TRUE
      invisible(self)
    },

    #' @description recreate the loader
    #' @details This method will first disable then destroy (remove) current loader,
    #' and finally store new information of the new loader.
    #'
    #' **Note:**: this method only refresh loader object on the server, the loader
    #' is **not** recreated until the next time `show` method is called.
    #' @param type string, one of  "circle", "dual-ring", "facebook", "heart",
    #' "ring", "roller", "default", "ellipsis", "grid", "hourglass", "ripple",
    #' "spinner", "gif", default is "default".
    #' @param src string, online URL or local path of the gif animation file if
    #' you would like to upload your own loader.
    #' @param id string, the unqiue ID for the loader, if not provided, a random
    #' ID will be given. If you are using shiny modules, DO NOT use `session$ns('YOUR_ID')`
    #' to wrap it. Loaders live on the top level of the document.
    #' @param height string, (r)em, "1.5rem", "1.5em", or pixel, like "10px".
    #' Default is `NULL`, will be automatically calculated based on the target
    #' component. It is recommend to use `NULL` for "replace" and "inline" method
    #' to let it automatically be calculated, but required for "full_screen" method.
    #' @param width string, default is the same as `height` to make it square.
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
    #' a title `h1("load title")`. `inline` method does not have a footer.
    #' @param z_index number, only works for "full_screen" method, what CSS layer
    #' should the overlay be places. In HTML, all elements have the default of 0.
    #' @param alert bool, should alert if target cannot be found or other javascript
    #' errors? mainly for debugging
    recreate = function(
      type = "default",
      src = NULL,
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
      alert = FALSE
    ) {
      stopifnot(is.character(bg_color) && length(bg_color) == 1)
      stopifnot(is.logical(alert) && length(alert) == 1)
      stopifnot(is.logical(center) && length(center) == 1)
      stopifnot(is.numeric(z_index) && length(z_index) == 1)
      if(!is.null(footer)) stopifnot(inherits(footer, "shiny.tag") && length(footer) == 3)
      if(!is.null(height)) stopifnot(is.character(height) && length(height) == 1)
      if(!is.null(width)) stopifnot(is.character(width) && length(width) == 1)

      type <- .validateLoader(
        type = type, id = id, color = color,
        opacity = opacity
      )
      if(type == "gif") stopifnot(is.character(src) && length(src) == 1)
      if (is.null(src)) src <- ""

      method <- match.arg(method, c("replace", "inline", "full_screen"))
      if ((method == "full_screen") && (is.null(height) || is.null(width)))
        stop("Loader: height and width cannot by NULL for full screen method.")

      id <- if (id == "") paste0('spsloader-', glue::glue_collapse(sample(9, 9))) else id

      footer <- if(method != "inline") htmltools::doRenderTags(footer) else NULL
      z_index <- floor(z_index)

      # hide and destroy
      if(!private$detroyed) self$destroy(alert)
      # update data
      data <- private$data
      selector <- data$selector
      private$data <- list(
        selector = selector,
        id = id,
        type = type,
        src = src,
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
      )
      private$detroyed <- FALSE
      invisible(self)
    }
  ),
  private = list(
    data = list(),
    session = NULL,
    detroyed = FALSE
  )
)
