
#' Enhanced Bootstrap popover
#' @description enhanced Bootstrap 3 popover by hovering, clicking
#' or other methods. Default is by "hover". Original bootstrap3 method only works with
#' "click" on buttons.
#' @param tag [htmltools::tag], like htmltools::tags$button() or htmltools::tags$a(),
#' or [shiny::actionButton()]
#' @param title character, title for the popover, generally text
#' @param content character, content for the popover body, can be HTML
#' @param placement character, placement of the popover with respect to `tag`, one
#' of "top", "right", "bottom", and "left"
#' @param trigger trigger method, default "hover", one of click , hover ,
#' focus , manual.
#' @importFrom bsplus bs_embed_popover
#' @return shiny element, tag
#' @export
#' @details
#' [bsHoverPopover] is the old name of  [bsPopover], the same function.
#'
#' Read more about popover here: https://getbootstrap.com/docs/3.3/javascript/#popovers
#' @examples
#' if(interactive()){
#'     library(shiny)
#'     library(magrittr)
#'     ui <- fluidPage(
#'         column(2),
#'         column(
#'             8,
#'             actionButton('a', 'On button') %>%
#'                 bsPopoverEnhance(
#'                     title = "title a",
#'                     content = "popover works on a button",
#'                     placement = "bottom"
#'                 ),
#'             tags$a("On link") %>%
#'                 bsPopoverEnhance(
#'                     title = "title b",
#'                     content = "popover works on a link",
#'                     placement = "bottom"
#'                 ),
#'             div(
#'               tags$b("general element"),
#'               style =
#'                 '
#'               height: 100px;
#'               background-color: cornflowerblue;
#'             '
#'             ) %>%
#'               bsPopoverEnhance(
#'                 title = "general element",
#'                 content = "popover works on a 'div'",
#'                 placement = "right"
#'               )
#'         )
#'
#'     )
#'     server <- function(input, output, session) {}
#'     shinyApp(ui, server)
#' }
bsHoverPopover <- function(
  tag,
  title,
  content = "",
  placement = "top",
  trigger="hover"){
  stopifnot(inherits(tag, "shiny.tag"))
  stopifnot(is.character(title) && length(title) == 1)
  stopifnot(is.character(content) && length(content) == 1)
  placement <- match.arg(placement, c('top', 'right', 'bottom', 'left' ))
  trigger <- match.arg(trigger, c('click', 'hover', 'focus', 'manual'))

  tag %>%
    tagAppendAttributes(
      `data-toggle` = "popover",
      `data-content` = content,
      title = title,
      `data-placement` = placement
    ) %>% {
      if(trigger == "hover") tagAppendAttributes(., `pop-toggle` = trigger)
      else tagAppendAttributes(., `data-trigger` = trigger)
    } %>%
    htmltools::tagAppendChild(spsDepend("pop-tip"))

}

#' @rdname bsHoverPopover
#' @export
bsPopover <- bsHoverPopover

#' Enhanced Bootstrap tooltip
#' @description Add tooltip to any Shiny element you want. You can also customize
#' color, font size, background color, trigger event for each individual tooltip.
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
#'  click | hover | focus | manual.
#' @return shiny tag
#' @details
#' For trigger methods read: https://getbootstrap.com/docs/3.3/javascript/#tooltips-options.
#'
#' @examples
#' if(interactive()){
#'   library(shiny)
#'   library(magrittr)
#'   ui <- fluidPage(
#'     br(), br(), br(), br(), br(), br(), column(2),
#'     actionButton("a", "Tooltip on the left") %>%
#'       bsTip("Tooltip on the left", "left"),
#'     actionButton("b", "Tooltip on the top") %>%
#'       bsTip("Tooltip on the top", "top"),
#'     actionButton("c", "Tooltip on the right") %>%
#'       bsTip("Tooltip on the right", "right"),
#'     actionButton("d", "Tooltip on the bottom") %>%
#'       bsTip("Tooltip on the bottom", "bottom"),
#'     br(), br(), column(2),
#'     actionButton("e", "primary color") %>%
#'       bsTip("primary color", bgcolor = "#0275d8"),
#'     actionButton("f", "danger color") %>%
#'       bsTip("danger color", bgcolor = "#d9534f"),
#'     actionButton("g", "warning color") %>%
#'       bsTip("warning color", bgcolor = "#f0ad4e"),
#'     br(), br(), column(2),
#'     actionButton("h", "9px") %>%
#'       bsTip("9px", fontsize = "9px"),
#'     actionButton("i", "14px") %>%
#'       bsTip("14px", fontsize = "14px"),
#'     actionButton("j", "20px") %>%
#'       bsTip("20px", fontsize = "20px"),
#'     br(), br(), column(2),
#'     actionButton("k", "combined") %>%
#'       bsTip(
#'         "custom tooltip", "bottom",
#'         "#0275d8", "#eee", "15px"
#'       )
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
bsTip <- function(
  tag,
  title = "",
  placement = "top",
  bgcolor = "black",
  textcolor = "white",
  fontsize = "12px",
  trigger = "hover focus"){

  stopifnot(inherits(tag, "shiny.tag"))
  stopifnot(is.character(title) && length(title) == 1)
  stopifnot(is.character(bgcolor) && length(bgcolor) == 1)
  stopifnot(is.character(textcolor) && length(textcolor) == 1)
  stopifnot(is.character(fontsize) && length(fontsize) == 1)
  stopifnot(is.character(trigger) && length(trigger) == 1)
  placement <- match.arg(placement, c('top', 'right', 'bottom', 'left'))
  tipid <- paste0("bstip", paste0(sample(seq(0, 9), 8, replace = TRUE), collapse = ""))
  tag %>%
    tagAppendAttributes(
      `data-tipid` = tipid
    ) %>%
    htmltools::tagAppendChildren(
      spsDepend("pop-tip"),
      tags$script(glue('bsTooltip("{tipid}", "{placement}", "{title}", "{bgcolor}", "{textcolor}", "{fontsize}", "{trigger}")'))
    )
}











