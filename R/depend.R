# SPS add HTML dependency functions

#' Add commonly used HTML dependencies
#' @description Add dependencies for
#' some server end functions. For most UI functions, the dependency has been automatically
#' attached for you when you call the function. Most server functions will also
#' attach the dependency for you automatically too. However, a few server functions have
#' to append the dependency before app start like [addLoader]. So you would need
#' to call in this function somewhere in your UI. Read help of each function for
#' details.
#' @param dep dependency names, see details
#' @param js bool, use only javascript from this resource if there are both js and css files?
#' @param css bool, use only CSS from this resource if there are both js and css files?
#' @param listing bool, if your `dep` is invalid, list all options? `FALSE` will
#' mute it.
#' @details For `dep`, current options are:
#'
#' - basic: spsComps basic css and js
#' - update_pg: spsComps [pgPaneUpdate] function required, js and css
#' - update_timeline: spsComps [spsTimeline] function required, js only
#' - font-awesome: font-awesome, css only
#' - toastr: comes from shinytoastr package, toastr.js, css and js
#' - pop-tip: enable enhanced bootstrap popover and tips, required for [bsHoverPopover] function.
#' js only
#' - gotop: required by [spsGoTop] function. js and css
#' - animation:  required for animation related functions to add animations
#' for icons and other elements, like [animateServer]. js and css
#' - css-loader: required for loader functions, like [addLoader]. js and css
#' - sweetalert2: sweetalert2.js, required by [shinyCheckPkg], js only
#'
#' @return [htmltools::htmlDependency] object
#' @export
#'
#' @examples
#' # list all options
#' spsDepend("")
#' # try some options
#' spsDepend("basic")
#' spsDepend("font-awesome")
#' # Then add it to your shiny app
#' if(interactive()){
#'     library(shiny)
#'
#'     ui <- fluidPage(
#'       tags$i(class = "fa fa-house"),
#'       spsDepend("font-awesome")
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'
#'     shinyApp(ui, server)
#' }
spsDepend <- function(dep="", js = TRUE, css = TRUE, listing = TRUE) {
    stopifnot(is.character(dep) && length(dep) == 1)
    stopifnot(is.logical(js) && length(js) == 1)
    stopifnot(is.logical(css) && length(css) == 1)
    stopifnot(is.logical(listing) && length(listing) == 1)
    # fix alternative names
    dep <- switch(dep,
      "shinyCatch" = "toastr",
      "spsValidate" = "toastr",
      "addLoader" = "css-loader",
      dep
    )
    switch (dep,
            "basic" = {
                js_file <- htmltools::htmlDependency(
                    name = "spsComps-js",
                    version = packageVersion("spsComps"),
                    package = "spsComps",
                    src = c(href = "spsComps", file = "assets"),
                    script = "js/sps-comps.js",
                    all_files = FALSE
                )
                css_file <- htmltools::htmlDependency(
                    name = "spsComps-css",
                    version = packageVersion("spsComps"),
                    package = "spsComps",
                    src = c(href = "spsComps", file = "assets"),
                    stylesheet = "css/sps-comps.css",
                    all_files = FALSE
                )
                list(
                    if (js) js_file else NULL,
                    if (css) css_file else NULL
                )
            },
            "update_pg" = {
              js_file <- htmltools::htmlDependency(
                name = "sps-update-pg",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/sps_update_pg.js",
                all_files = FALSE
              )
              css_file <- htmltools::htmlDependency(
                name = "pg-panel",
                version = packageVersion("spsComps"),
                package = "spsComps",
                src = c(href = "spsComps", file = "assets"),
                stylesheet = "css/sps_pg_panel.css",
                all_files = FALSE
              )
              list(
                if (js) js_file else NULL,
                if (css) css_file else NULL
              )
            },
            "update_timeline" = htmltools::htmlDependency(
                name = "sps-update-timeline",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/sps_update_timeline.js",
                all_files = FALSE
            ),
            "font-awesome" = htmltools::findDependencies(icon("house")),
            "toastr" = {
                js_file <- htmltools::htmlDependency(
                    name = "toastr-js",
                    version = "2.1.1",
                    src = c(file = system.file("toastr", package = "shinytoastr")),
                    script = list("shinytoastr.js", "toastr.min.js"),
                )
                css_file <- htmltools::htmlDependency(
                    name = "toastr-css",
                    version = "2.1.1",
                    src = c(file = system.file("toastr", package = "shinytoastr")),
                    stylesheet = "toastr.min.css"
                )
                list(
                    if (js) js_file else NULL,
                    if (css) css_file else NULL
                )
            },
            "pop-tip" = htmltools::htmlDependency(
                name = "sps-pop-tip",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/bs3pop_tip.js",
                all_files = FALSE
            ),
            "gotop" = htmltools::htmlDependency(
                name = "sps-gotop",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/sps_gotop.js",
                all_files = FALSE
            ),
            "animation" = {
              js_file <- htmltools::htmlDependency(
                name = "spsComps-animation",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/sps_animation.js",
                all_files = FALSE
              )
              css_file <- htmltools::htmlDependency(
                name = "font-awesome-animation",
                version = '1.1.1',
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                stylesheet = "css/font-awesome-animation.min.css",
                all_files = FALSE
              )
              list(
                if (js) js_file else NULL,
                if (css) css_file else NULL
              )
            },
            "css-loader" = {
              js_file <- htmltools::htmlDependency(
                name = "spsComps-css-loader-js",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/sps_cssloader.js",
                all_files = FALSE
              )
              css_file <- htmltools::htmlDependency(
                name = "spsComps-css-loader-css",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                stylesheet = "css/css_loader.css",
                all_files = FALSE
              )
              list(
                if (js) js_file else NULL,
                if (css) css_file else NULL
              )
            },
            "sweetalert2" = htmltools::htmlDependency(
              name = "sweetalert2",
              version = "10.16.7",
              src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
              script = list("js/sweetalert2_202105.js", "js/sps_sweetalert.js"),
              all_files = FALSE
            ),
            {
              if (listing) {
                msg(glue::glue('Dependency "{dep}" not found.'), level = "warning")
                cat(glue::glue(
                  '
                - basic: spsComps basic css and js
                - css_loading: for css loaders
                - update_pg: spsComps [pgPaneUpdate] function required, js and css
                - update_timeline: spsComps [spsTimeline] function required, js only
                - font-awesome: font-awesome, css only
                - toastr: comes from shinytoastr package, toastr.js, css and js
                - pop-tip: enable enhanced bootstrap popover and tips, required for [bsHoverPopover] function
                - gotop: required by [spsGoTop] function
                - animation:  required for animation related functions to add animations
                for icons and other elements
                - css-loader: required for loader functions
                - sweetalert2: for shinyCheckPkg function
                \n'
                ))
              } else {
                  invisible(NULL)
              }
            }
    )
}


#' Internal method to append dependency from the server
#'
#' @noRd
dependServer <- function(
  dep,
  check_existing = NULL,
  js = TRUE,
  css = TRUE,
  session = getDefaultReactiveDomain()
) {
  insertUI(
    selector = "body", where = "afterBegin",
    ui = singleton(spsDepend(dep, js, css)), immediate = TRUE, session = session
  )
}
