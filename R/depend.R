# SPS add HTML dependency functions

#' Add commonly used HTML dependencies
#' @description Mostly used in SPS internal development
#' @param dep dependency names, see details
#' @param js bool, use only javascript from this resource if there are both js and css files?
#' @param css bool, use only CSS from this resource if there are both js and css files?
#' @details For `dep`, current options are:
#'
#' - basic: spsComps basic css and js
#' - shinydashboard: shinydashboard package, css and js
#' - AdminLTE: shinydashboard package, often used together with "shinydashboard", css and js
#' - update_pg: spsComps [pgPaneUpdate] function required, js only
#' - update_timeline: spsComps [spsTimeline] function required, js only
#' - font-awesome: font-awesome, css only
#' - bttn: comes from shinyWidgets package, bttn.css, css only
#' - toastr: comes from shinytoastr package, toastr.js, css and js
#' - pop-tip: enable enhanced bootstrap popover and tips, required for [bsHoverPopover] function
#' - gotop: required by [spsGoTop] function
#'
#' @return [htmltools::htmlDependency] object
#' @export
#'
#' @examples
#' spsDepend("basic")
#' # shinydashboard has both js and css and if we only want to use css:
#' spsDepend("shinydashboard", css = FALSE)
#' # Then add it to your shiny app
#' if(interactive()){
#'     library(shiny)
#'
#'     ui <- fluidPage(
#'       tags$i(class = "fa fa-home"),
#'       spsDepend("font-awesome")
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'
#'     shinyApp(ui, server)
#' }
spsDepend <- function(dep, js = TRUE, css = TRUE) {
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
            "shinydashboard" = {
                js_file <- htmltools::htmlDependency(
                    name = "shinydashboard-js",
                    version = packageVersion("shinydashboard"),
                    src = c(file = system.file(package = "shinydashboard")),
                    script = "shinydashboard.js"
                )
                css_file <- htmltools::htmlDependency(
                    name = "shinydashboard-css",
                    version = packageVersion("shinydashboard"),
                    src = c(file = system.file(package = "shinydashboard")),
                    stylesheet = "shinydashboard.css"
                )
                list(
                    if (js) js_file else NULL,
                    if (css) css_file else NULL
                )
            },
            "AdminLTE" = {
                js_file <- htmltools::htmlDependency(
                    name = "AdminLTE-js",
                    version = "2.0.6",
                    src = c(file = system.file("AdminLTE", package = "shinydashboard")),
                    script = "app.min.js",
                )
                css_file <- htmltools::htmlDependency(
                    name = "AdminLTE-css",
                    version = "2.0.6",
                    src = c(file = system.file("AdminLTE", package = "shinydashboard")),
                    stylesheet = "AdminLTE.css"
                )
                list(
                    if (js) js_file else NULL,
                    if (css) css_file else NULL
                )
            },
            "update_pg" = htmltools::htmlDependency(
                name = "sps-update-pg",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/sps_update_pg.js",
                all_files = FALSE
            ),
            "update_timeline" = htmltools::htmlDependency(
                name = "sps-update-timeline",
                version = packageVersion("spsComps"),
                src = c(href = "spsComps", file = system.file("assets", package = "spsComps")),
                script = "js/sps_update_timeline.js",
                all_files = FALSE
            ),
            "font-awesome" = htmltools::findDependencies(icon("")),
            "bttn" = htmltools::findDependencies(shinyWidgets::actionBttn("", ""))[2],
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
            )
    )
}
