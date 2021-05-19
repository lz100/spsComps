
#' Enhanced Bootstrap3 tooltip
#' @description Add tooltip to any Shiny element you want. You can also customize
#' color, font size, background color, trigger event for each individual tooltip.
#'
#' @param tag a shiny tag as input
#'
#' @param title string, tooltip text
#' @param placement string, one of "top", "bottom", "left", "right", where to put the
#' tooltip
#' @param bgcolor string, background color, valid value of CSS color name or hex value or rgb value
#' @param textcolor string, text color, valid value of CSS color name or hex value or rgb value
#' @param fontsize string, text font size, valid value of CSS font size, like "10px",
#' "1rem".
#' @param trigger string, how to trigger the tooltip, one or combination of
#' @param fontweight string, valid font weight unit:
#' https://www.w3schools.com/cssref/pr_font_weight.asp
#' @param opacity numeric, between 0 and 1
#' @param html bool, allow title contain HTML code? like `"<strong>abc</strong>"`
#'  click | hover | focus | manual.
#' @param status string, used only for wrapper [bsTip], see details
#' @return shiny tag
#' @details
#' For trigger methods read: https://getbootstrap.com/docs/3.3/javascript/#tooltips-options.
#'
#' #### Convenient wrapper function
#' [bsTip] is the convenient function for [bsTooltip], which has the background
#' and content color set to 5 different bootstrap colors, you can use `status`
#' to set, one of "primary", "info", "success", "warning", "danger"
#' @export
#' @examples
#' if(interactive()){
#'   library(shiny)
#'   library(magrittr)
#'   ui <- fluidPage(
#'     br(), br(), br(), br(), br(), br(), column(2),
#'     actionButton("", "Tooltip on the left") %>%
#'       bsTooltip("Tooltip on the left", "left"),
#'     actionButton("", "Tooltip on the top") %>%
#'       bsTooltip("Tooltip on the top", "top"),
#'     actionButton("", "Tooltip on the right") %>%
#'       bsTooltip("Tooltip on the right", "right"),
#'     actionButton("", "Tooltip on the bottom") %>%
#'       bsTooltip("Tooltip on the bottom", "bottom"),
#'     br(), br(), column(2),
#'     actionButton("", "primary color") %>%
#'       bsTooltip("primary color", bgcolor = "#0275d8"),
#'     actionButton("", "danger color") %>%
#'       bsTooltip("danger color", bgcolor = "#d9534f"),
#'     actionButton("", "warning color") %>%
#'       bsTooltip("warning color", bgcolor = "#f0ad4e"),
#'     br(), br(), column(2),
#'     actionButton("", "9px") %>%
#'       bsTooltip("9px", fontsize = "9px"),
#'     actionButton("", "14px") %>%
#'       bsTooltip("14px", fontsize = "14px"),
#'     actionButton("", "20px") %>%
#'       bsTooltip("20px", fontsize = "20px"),
#'     br(), br(), column(2),
#'     actionButton("", "combined") %>%
#'       bsTooltip(
#'         "custom tooltip", "bottom",
#'         "#0275d8", "#eee", "15px"
#'       )
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
bsTooltip <- function(
  tag,
  title = "",
  placement = "top",
  bgcolor = "black",
  textcolor = "white",
  fontsize = "12px",
  fontweight = "400",
  opacity = 1.0,
  html = FALSE,
  trigger = "hover focus"){

  stopifnot(inherits(tag, "shiny.tag"))
  stopifnot(is.character(title) && length(title) == 1)
  stopifnot(is.character(bgcolor) && length(bgcolor) == 1)
  stopifnot(is.character(textcolor) && length(textcolor) == 1)
  stopifnot(is.character(fontsize) && length(fontsize) == 1)
  stopifnot(is.character(trigger) && length(trigger) == 1)
  stopifnot(is.logical(html) && length(html) == 1)
  stopifnot(is.character(fontweight) && length(html) == 1)
  stopifnot(is.numeric(opacity) && opacity >= 0 && opacity <=1)

  placement <- match.arg(placement, c('top', 'right', 'bottom', 'left'))
  tipid <- paste0("bsTooltip", paste0(sample(seq(0, 9), 8, replace = TRUE), collapse = ""))
  html <- if(html) "true" else "false"
  title <- str_replace_all(title, '\n | \r', ' ') %>% str_replace_all('"', '\\\\"')

  tag %>%
    tagAppendAttributes(
      `data-tipid` = tipid
    ) %>%
    htmltools::tagAppendChildren(
      spsDepend("pop-tip"),
      HTML(glue('
      <script>
      bsTooltip(
        "{tipid}", "{placement}", "{title}", "{bgcolor}", "{textcolor}",
        "{fontsize}", "{trigger}", "{fontweight}", "{opacity}", {html}
      )
      </script>'))
    )
}

#' @rdname bsTooltip
#' @export
#' @examples
#' if(interactive()){
#'   library(shiny)
#'   library(magrittr)
#'   ui <- fluidPage(
#'     br(), br(), br(), br(), br(), br(), column(2),
#'     actionButton("", "primary") %>%
#'       bsTip("primary", status = "primary"),
#'     actionButton("", "info") %>%
#'       bsTip("info", status = "info"),
#'     actionButton("", "success") %>%
#'       bsTip("success", status = "success"),
#'     actionButton("", "warning") %>%
#'       bsTip("warning", status = "warning"),
#'     actionButton("", "danger") %>%
#'       bsTip("danger", status = "danger")
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
bsTip <- function(
  tag,
  title = "",
  placement = "top",
  status = "primary",
  fontsize = "12px",
  fontweight = "400",
  opacity = 1.0,
  html = FALSE,
  trigger = "hover focus"){

  textcolor <- "white"
  bgcolor <- getBsColor(status)
  bsTooltip(tag, title, placement, bgcolor, textcolor, fontsize, fontweight, opacity, html, trigger)
}


#' Enhanced Bootstrap3 popover
#' @description Add popover to any Shiny element you want. You can also customize
#' color, font size, background color, and more for each individual popover.
#'
#' @param tag a shiny tag as input
#' @param placement string, one of "top", "bottom", "left", "right", where to put the
#' tooltip
#' @param bgcolor string, background color, valid value of CSS color name or hex value or rgb value
#' @param trigger string, how to trigger the tooltip, one or combination of
#'  click | hover | focus | manual.
#' @param opacity numeric, between 0 and 1
#' @param html bool, allow title contain HTML code? like `"<strong>abc</strong>"`
#' @param title string, popover title
#' @param content string, popover cotent
#' @param titlecolor string, title text color, valid value of CSS color name or hex value or rgb value
#' @param contentcolor string, content text color, valid value of CSS color name or hex value or rgb value
#' @param titlesize string, title text font size, valid value of CSS font size, like "10px", "1rem".
#' @param contentsize string, content text font size, valid value of CSS font size, like "10px", "1rem".
#' @param titleweight string, CSS valid title font weight unit
#' @param contentweight string, CSS valid content font weight unit
#' @param status string, used only for wrapper [bsPop], see details
#' @return shiny tag
#' @details
#' 1. For trigger methods read: https://getbootstrap.com/docs/3.3/javascript/#tooltips-options.
#'
#' 2. For font weight, see: https://www.w3schools.com/cssref/pr_font_weight.asp
#'
#' 3. [bsHoverPopover] is the old name but we still keep it for backward compatibility.
#'
#' #### Convenient wrapper function
#' [bsPop] is the convenient function for [bsPopover], which has the background
#' and content color set to 5 different bootstrap colors, you can use `status`
#' to set, one of "primary", "info", "success", "warning", "danger"
#' @export
#' @examples
#' if(interactive()){
#'   library(shiny)
#'   library(magrittr)
#'   ui <- fluidPage(
#'     br(), br(), br(), br(), br(), br(), column(2),
#'     actionButton("", "Popover on the left") %>%
#'       bsPopover("Popover on the left", "content", "left"),
#'     actionButton("", "Popover on the top") %>%
#'       bsPopover("Popover on the top", "content", "top"),
#'     actionButton("", "Popover on the right") %>%
#'       bsPopover("Popover on the right", "content", "right"),
#'     actionButton("", "Popover on the bottom") %>%
#'       bsPopover("Popover on the bottom", "content", "bottom"),
#'     br(), br(), column(2),
#'     actionButton("", "primary color") %>%
#'       bsPopover(
#'         "primary color", "content", bgcolor = "#0275d8",
#'         titlecolor = "white", contentcolor = "#0275d8"),
#'     actionButton("", "danger color") %>%
#'       bsPopover(
#'         "danger color",  "content", bgcolor = "#d9534f",
#'         titlecolor = "white", contentcolor = "#d9534f"),
#'     actionButton("", "warning color") %>%
#'       bsPopover(
#'         "warning color", "content", bgcolor = "#f0ad4e",
#'         titlecolor = "white", contentcolor = "#f0ad4e"),
#'     br(), br(), column(2),
#'     actionButton("", "9px & 14px") %>%
#'       bsPopover("9px", "14", titlesize = "9px", contentsize = ),
#'     actionButton("", "14px & 12px") %>%
#'       bsPopover("14px", "12", titlesize = "14px"),
#'     actionButton("", "20px & 9px") %>%
#'       bsPopover("20px", "9", titlesize = "20px"),
#'     br(), br(), column(2),
#'     actionButton("", "weight 100 & 800") %>%
#'       bsPopover("weight 100", "800", titleweight =  "100", contentweight = "800"),
#'     actionButton("", "weight 400 & 600") %>%
#'       bsPopover("weight 400", "600", titleweight =  "400", contentweight = "600"),
#'     actionButton("", "weight 600 & 400") %>%
#'       bsPopover("weight 600", "400", titleweight =  "600", contentweight = "400"),
#'     actionButton("", "weight 900 & 200") %>%
#'       bsPopover("weight 900", "200", titleweight =  "900", contentweight = "200"),
#'     br(), br(), column(2),
#'     actionButton("", "opacity 0.2") %>%
#'       bsPopover("opacity 0.2", opacity = 0.2),
#'     actionButton("", "opacity 0.5") %>%
#'       bsPopover("opacity 0.5", opacity = 0.5),
#'     actionButton("", "opacity 0.8") %>%
#'       bsPopover("opacity 0.8", opacity = 0.8),
#'     actionButton("", "opacity 1") %>%
#'       bsPopover("opacity 1", opacity = 1),
#'     br(), br(), column(2),
#'     actionButton("f1", "allow html: 'abc<span class='text-danger'>danger</span>'") %>%
#'       bsPopover(HTML("abc<span class='text-danger'>danger</span>"),
#'                 html = TRUE, bgcolor = "#0275d8"),
#'     actionButton("f2", "allow html: '<s>del content</s>'") %>%
#'       bsPopover(HTML("<s>del content</s>"), html = TRUE, bgcolor = "#d9534f")
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
bsPopover <- function(
  tag,
  title = "",
  content = "",
  placement = "top",
  bgcolor = "#ebebeb",
  titlecolor = "black",
  contentcolor = "black",
  titlesize = "14px",
  contentsize = "12px",
  titleweight = "600",
  contentweight = "400",
  opacity = 1.0,
  html = FALSE,
  trigger = "hover focus"){

  stopifnot(inherits(tag, "shiny.tag"))
  stopifnot(is.character(title) && length(title) == 1)
  stopifnot(is.character(content) && length(content) == 1)
  stopifnot(is.character(bgcolor) && length(bgcolor) == 1)
  stopifnot(is.character(titlecolor) && length(titlecolor) == 1)
  stopifnot(is.character(contentcolor) && length(contentcolor) == 1)
  stopifnot(is.character(titlesize) && length(titlesize) == 1)
  stopifnot(is.character(contentsize) && length(contentsize) == 1)
  stopifnot(is.character(titleweight) && length(titleweight) == 1)
  stopifnot(is.character(contentweight) && length(contentweight) == 1)
  stopifnot(is.character(trigger) && length(trigger) == 1)
  stopifnot(is.logical(html) && length(html) == 1)
  stopifnot(is.numeric(opacity) && opacity >= 0 && opacity <=1)

  placement <- match.arg(placement, c('top', 'right', 'bottom', 'left'))
  popid <- paste0("bspopover", paste0(sample(seq(0, 9), 8, replace = TRUE), collapse = ""))
  html <- if(html) "true" else "false"

  content <- str_replace_all(content, '\n | \r', ' ') %>%
    str_replace_all('"', '\\\\"')
  title <- str_replace_all(title, '\n | \r', ' ') %>%
    str_replace_all('"', '\\\\"')

  tag %>%
    tagAppendAttributes(
      `data-popoverid` = popid
    ) %>%
    htmltools::tagAppendChildren(
      spsDepend("pop-tip"),
      HTML(glue('
      <script>
      bsPopover(
        "{popid}", "{placement}", `{title}`, "{content}", "{bgcolor}", "{titlecolor}",
        "{contentcolor}", "{titlesize}", "{contentsize}", "{trigger}", "{titleweight}",
        "{contentweight}", "{opacity}", {html}
      )
      </script>'))
    )
}

#' @rdname bsPopover
#' @export
bsHoverPopover <- bsPopover

#' @rdname bsPopover
#' @export
#' @examples
#' if(interactive()){
#'   library(shiny)
#'   library(magrittr)
#'   ui <- fluidPage(
#'     br(), br(), br(), br(), br(), br(), column(2),
#'     actionButton("", "primary") %>%
#'       bsPop("primary", "primary", status = "primary"),
#'     actionButton("", "info") %>%
#'       bsPop("info", "info", status = "info"),
#'     actionButton("", "success") %>%
#'       bsPop("success", "success", status = "success"),
#'     actionButton("", "warning") %>%
#'       bsPop("warning", "warning", status = "warning"),
#'     actionButton("", "danger") %>%
#'       bsPop("danger", "danger", status = "danger")
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
bsPop <- function(
  tag,
  title = "",
  content = "",
  placement = "top",
  status = "primary",
  titlesize = "14px",
  contentsize = "12px",
  titleweight = "600",
  contentweight = "400",
  opacity = 1.0,
  html = TRUE,
  trigger = "hover focus"){

  titlecolor <- "white"
  bgcolor <- contentcolor <- getBsColor(status)
  bsPopover(
    tag, title, content, placement, bgcolor, titlecolor,
    contentcolor, titlesize, contentsize, titleweight,
    contentweight, opacity, html, trigger
  )
}




