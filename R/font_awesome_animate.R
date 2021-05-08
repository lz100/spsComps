#' Font awesome animated icons
#' @description Greatly enhance the [shiny::icon] with animations. Built on top
#' of [font-awesome-animation](https://github.com/l-lin/font-awesome-animation).
#' @param name string, the name of the font-awesome icon
#' @param animation what kind of animation you want, one of "wrench", "ring",
#' "horizontal", "horizontal-reverse", "vertical", "flash", "bounce", "bounce-reverse",
#' "spin", "spin-reverse", "float", "pulse", "shake", "tada", "passing", "passing-reverse",
#' "burst", "falling", "falling-reverse", "rising"s
#' See our online demo for details.
#' @param speed string, one of "fast", "slow"
#' @param hover bool, trigger animation on hover?
#' @param color string, color of the icon, a valid color name or hex code
#' @param size string, change font-awesome icon size, one of "xs", "sm", "lg", "2x", "3x",
#' "5x", "7x", "10x". See examples.
#' @param ... append additional attributes you want to the icon
#' @return a icon tag
#' @export
#' @details If you don't specify any animation, it will work the same as the original
#' [shiny::icon] function. Fully compatible with any shiny functions that
#' requires an icon as input.
#' @examples
#' if(interactive()){
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     style = "text-align: center;",
#'     tags$label("same as original icon function"), br(),
#'     animateIcon("home"),  br(),
#'     tags$label("Change animation and color"), br(),
#'     animateIcon(
#'       name = "home", animation = "horizontal", speed = "slow", color ="red"
#'     ), br(),
#'     tags$label("work in a button"), br(),
#'     actionButton(
#'       "a", "a", icon = animateIcon("spinner", "spin", "fast")
#'     ), br(),
#'     tags$label("hover your mouse on the next one"), br(),
#'     animateIcon(
#'       name = "wrench", animation = "wrench", hover = TRUE, color ="green"
#'     ), br(),
#'     tags$label("change size"), br(),
#'     animateIcon("home"),
#'     animateIcon("home", size = "xs"),
#'     animateIcon("home", size = "sm"),
#'     animateIcon("home", size = "lg"),
#'     animateIcon("home", size = "2x"),
#'     animateIcon("home", size = "3x"),
#'     animateIcon("home", size = "5x"),
#'     animateIcon("home", size = "7x"),
#'     animateIcon("home", size = "10x")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
animateIcon <- function(
  name,
  animation=NULL,
  speed = NULL,
  hover=FALSE,
  color = "",
  size = NULL,
  ...
  ){

  tags$i(
    class = "fa",
    class = .genAnimationString(animation, speed, hover, name, size),
    style = glue::glue('color: {color};'),
    spsDepend("animation", js = FALSE),
    spsDepend("font-awesome"),
    ...
  )
}



#' Add/remove animation to any HTML/shiny component
#' @description Add animation to a HTML or component and remove it
#' @param selector string, a shiny component ID or a valid CSS selector if `isID = FLASE`.
#' for example, you have a button and want to add animation to it:
#' ```
#' actionButton(inputId = "btn")
#' ```
#'
#' Then the selector is "btn" `selector = 'btn'`. If you are using shiny modules,
#' use `ns()` to wrap it in UI for the button `actionButton(inputId = ns("btn"))`,
#' and also add `ns()` to selector `selector = ns('btn')` for the [animateUI]
#' function. If you are using the server side functions [animateServer] and [animationRemove],
#' **DO NOT** add the `ns()` wrapper.
#' @param animation what kind of animation you want, one of "wrench", "ring",
#' "horizontal", "horizontal-reverse", "vertical", "flash", "bounce", "bounce-reverse",
#' "spin", "spin-reverse", "float", "pulse", "shake", "tada", "passing", "passing-reverse",
#' "burst", "falling", "falling-reverse", "rising"s
#' See our online demo for details.
#' or our online demo for details.
#' @param speed string, one of "fast", "slow"
#' @param hover bool, trigger animation on hover?
#' @param isID bool, is your selector an ID?
#' @param session the current shiny session
#' @param alert bool, for [animationRemove] only: if the component is not found or it
#' does not contain any animation or the animation is not added by spsComps,
#' alert on UI? More like for debugging purposes.
#' @return see details
#' @details
#' - animateUI: use on the UI side, which means add the animation when UI loads
#' complete.
#' - animateServer: use on the server side. Use server to trigger the animation
#' on a component at some point.
#' - animationRemove: use on the server side, to remove animation on a certain
#' component.
#'
#' #### Selector
#' Usually for beginners use the shiny component ID is enough, but sometimes
#' a HTML element may not has the 'id' attribute. In this case, you can still
#' animate the element by advanced CSS selector. For these selectors, turn off
#' the `isID = FALSE` and provide the selector in a single string.
#' Google "CSS selector" to learn more.
#'
#' #### only server functions
#' If you use [animateServer] or [animationRemove] on the server, you need
#' to add `spsDepend("animation")` somewhere
#' in your UI to load the required CSS and javascript, inside `tags$head()` is preferred.
#' see examples.
#' @export
#'
#' @examples
#' if(interactive()){
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     spsDepend("animation"),
#'     column(
#'       6,
#'       h3("Adding animations from UI"),
#'       tags$label("to a button"), br(),
#'       actionButton("btn1", "random button"), br(),
#'       animateUI("btn1", animation = "ring"),
#'       tags$label("to some text"), br(),
#'       p(id = "mytext", class = "text-red", "some move text"), br(),
#'       animateUI("mytext", animation = "horizontal", speed = "fast"),
#'       tags$label("on hover, move mouse on the red thumb"), br(),
#'       actionButton(
#'         "btn2", "",
#'         icon = icon(id = "myicon", "thumbs-o-up"),
#'         style = "color: red; boarder: initial; border-color: transparent;"
#'       ), br(),
#'       animateUI("btn2", animation = "bounce", speed = "fast", hover = TRUE),
#'       tags$label("on a plot"), br(),
#'       plotOutput("plot1"),
#'       animateUI("plot1", animation = "float", speed = "fast")
#'     ),
#'     column(
#'       6,
#'       h3("Adding/removing animations from server"),
#'       tags$label("use a button to control"), br(),
#'       actionButton("btn3", "animate itself"),
#'       actionButton("btn4", "stop animation"), br(),
#'       tags$label("advanced selector in for complex group"), br(),
#'       sliderInput(
#'         "myslider",
#'         label = "animating if less than 5",
#'         value = 0,
#'         min = 0, max = 10,
#'         step = 1
#'       ),
#'       sliderInput(
#'         "myslider2",  min = 0, max = 10, value = 10,
#'         label = "this one will not be selected"
#'       )
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$plot1 <- renderPlot(plot(1:10, 10:1))
#'     observeEvent(input$myslider, {
#'       if (input$myslider <= 5) {
#'         animateServer(
#'           # the slider container does not has the ID, it is inside
#'           selector = ".shiny-input-container:has(#myslider)",
#'           animation = "horizontal", speed = "slow", isID = FALSE
#'         )
#'       } else {
#'         animationRemove(
#'           selector = ".shiny-input-container:has(#myslider)",
#'           isID = FALSE
#'         )
#'       }
#'     })
#'     observeEvent(input$btn3, {
#'       animateServer("btn3", animation = "flash", speed = "slow")
#'     })
#'     observeEvent(input$btn4, {
#'       animationRemove("btn3")
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#' }
animateUI <- function(
  selector,
  animation,
  speed = NULL,
  hover = FALSE,
  isID = TRUE
){
  stopifnot(is.character(selector) && length(selector) == 1)
  stopifnot(is.logical(isID) && length(isID) == 1)

  selector <- if(isID) paste0("#", selector) else selector
  add_class <- .genAnimationString(animation, speed, hover)

  tagList(
    tags$script(glue(
      '
      addSpsAnimation("{selector}", "{add_class}")
      '
    )),
    spsDepend("animation")
  )
}


#' @rdname animateUI
#' @export
animateServer <- function(
  selector,
  animation = NULL,
  speed = NULL,
  hover = FALSE,
  isID = TRUE,
  session = shiny::getDefaultReactiveDomain()
){
  stopifnot(is.character(selector) && length(selector) == 1)
  stopifnot(is.logical(isID) && length(isID) == 1)

  selector <- if(isID) {
    paste0("#", if(inherits(session, "session_proxy")) session$ns(selector) else selector)
  } else {
    selector
  }
  add_class <- .genAnimationString(animation, speed, hover)

  session$sendCustomMessage('sps-add-animation', message = list(
    selector = selector,
    addClass = add_class
  ))
}


#' @rdname animateUI
#' @export
animationRemove <- function(
  selector,
  isID = TRUE,
  alert = FALSE,
  session = shiny::getDefaultReactiveDomain()
){
  stopifnot(is.character(selector) && length(selector) == 1)
  stopifnot(is.logical(isID) && length(isID) == 1)
  stopifnot(is.logical(alert) && length(alert) == 1)

  selector <- if(isID) {
    paste0("#", if(inherits(session, "session_proxy")) session$ns(selector) else selector)
  } else {
    selector
  }
  session$sendCustomMessage('sps-remove-animation', message = list(
    selector = selector,
    alert = alert
  ))
}


#' Append animation to a Shiny element
#'
#' @param element the shiny element to append, must have "shiny.tag" class for
#' `animateAppend` and can be either "shiny.tag" or "shiny.tag.list" for `animateAppendNested`.
#' @param animation what kind of animation you want, one of "wrench", "ring",
#' "horizontal", "horizontal-reverse", "vertical", "flash", "bounce", "bounce-reverse",
#' "spin", "spin-reverse", "float", "pulse", "shake", "tada", "passing", "passing-reverse",
#' "burst", "falling", "falling-reverse", "rising"s
#' See our online demo for details.
#' @param speed string, one of "fast", "slow"
#' @param hover bool, trigger animation on hover?
#' @details
#' #### `animateAppend`
#' Append the animation directly to the element you provide, but can only apply
#' one type of animation
#' #### `animateAppendNested`
#' Append multiple animations to the element you provide by creating a wrapper
#' around the element. Animations are applied on the wrappers. This may cause some
#' unknown issues, especially on the display property. Try change the display may
#' fix the issues. It is **safer** to use `animateAppend`.
#'
#' Read more about CSS display: https://www.w3schools.com/cssref/pr_class_display.asp
#' @return returns a Shiny element
#' @export
#'
#' @examples
#' if (interactive()){
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     icon("home") %>%
#'       animateAppend("ring"),
#'     h2("Append animation", class = "text-primary") %>%
#'       animateAppend("pulse"),
#'     br(),
#'     h2("Nested animations", class = "text-primary") %>%
#'       animateAppendNested("ring") %>%
#'       animateAppendNested("pulse") %>%
#'       animateAppendNested("passing"),
#'     tags$span("Other things"),
#'     h2("Nested animations display changed", class = "text-primary") %>%
#'       animateAppendNested("ring") %>%
#'       animateAppendNested("pulse", display = "block", style = "width: 30%"),
#'     tags$span("Other things")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
animateAppend <- function(
  element,
  animation,
  speed = NULL,
  hover = FALSE
) {
  stopifnot(inherits(element, "shiny.tag"))

  add_class <- .genAnimationString(animation, speed, hover)
  tagList(
    htmltools::tagAppendAttributes(element, class = add_class),
    spsDepend("animation")
  )
}

#' @rdname animateAppend
#' @param display string, CSS display method for the out-most wrapper, one of the v
#' alid css display method, like "block", "inline", "flex", default is "inline-block".
#' @param ... other attributes add to the wrapper, for `animateAppendNested` only
#' @export
animateAppendNested <- function(
  element,
  animation,
  speed = NULL,
  hover = FALSE,
  display = "inline-block",
  ...
) {
  stopifnot(inherits(element, c("shiny.tag", "shiny.tag.list")))
  stopifnot(is.character(display) && length(display) == 1)

  add_class <- .genAnimationString(animation, speed, hover)
  tagList(
    div(
      style = paste0("display: ", display, ";"),
      class = add_class,
      ...,
      element
    ),
    spsDepend("animation")
  )
}

.genAnimationString <- function(
  animation,
  speed,
  hover,
  name = "",
  size=NULL
  ){
  stopifnot(is.character(name) && length(name) == 1)
  stopifnot(is.logical(hover) && length(name) == 1)

  animation <- match.arg(animation, c(
    "",
    "wrench",
    "ring",
    "horizontal",
    "horizontal-reverse",
    "vertical",
    "flash",
    "bounce",
    "bounce-reverse",
    "spin",
    "spin-reverse",
    "float",
    "pulse",
    "shake",
    "tada",
    "passing",
    "passing-reverse",
    "burst",
    "falling",
    "falling-reverse",
    "rising"
  ))
  animation <- stringr::str_split(animation, "-", simplify = TRUE)
  animation_class <- if(!"" %in% animation) paste0("faa-", animation) else ""
  animation_class <- glue::glue_collapse(animation_class, " ")

  speed <- match.arg(speed, c("", "fast", "slow"))
  speed_class <- if(speed != "") paste0("faa-", speed) else ""

  hover_class <- if(hover) "animated-hover" else "animated"

  name_class <- if(name != "") paste0("fa-", name) else ""

  size <- match.arg(size, c(
    "",
    "xs",
    "sm",
    "lg",
    "2x",
    "3x",
    "5x",
    "7x",
    "10x"
  ))
  size_class <- if(size != "") paste0("fa-", size) else ""

  glue::glue('sps-animation {name_class} {size_class} {animation_class} {hover_class} {speed_class}')
}


