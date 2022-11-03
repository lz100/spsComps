# All input components

#' A clearable text inputInput control
#' @description An UI component with a "X" button in the end to clear the entire
#' entered text. It works the same as `Textinput`.
#'
#' @param inputId ID
#' @param label text label above
#' @param value default value
#' @param placeholder place holder text when value is empty
#' @param style additional CSS styles you want to apply
#' @return a shiny component
#' @export
#'
#' @examples
#' if(interactive()){
#'
#'     ui <- fluidPage(
#'         clearableTextInput("input1", "This is a input box", style = "width: 50%;"),
#'         verbatimTextOutput("out1")
#'     )
#'
#'     server <- function(input, output, session) {
#'         output$out1 <- renderPrint(input$input1)
#'     }
#'
#'     shinyApp(ui, server)
#' }
clearableTextInput <- function(
  inputId,
  label = "",
  value = "",
  placeholder = "",
  style = "width: 100%;") {

  force(inputId)
  tagList(tags$div(
    style = style,
    tags$label(label, `for` = inputId),
    tags$span(
      class = "form-control text-input-clearable",
      style = "background-color: #fff;",
      tags$input(
        id = inputId,
        type = "text",
        value = value,
        placeholder = placeholder
      ),
      HTML('<span class="glyphicon glyphicon-remove"></span>')
    )
  ),
  tags$script(glue("clearText('{inputId}')")),
  spsDepend("basic")
  )
}

#' Bootstrap 3 text input group
#' @description Text input group and custom widgets append to left ar/and right
#' @param textId text box id
#' @param label text label for this input group
#' @param value default value for the text input
#' @param placeholder default placeholder text for the text input if no value
#' @param left_text text or icon add to the left side
#' @param right_text text or icon add to the right side
#' @param style additional style add to the group
#'
#' @return text input group component
#' @details If no text is specified for both left and right, the return is almost
#' identical to [clearableTextInput]
#' @export
#'
#' @examples
#' if(interactive()){
#'
#'     ui <- fluidPage(
#'         textInputGroup("id1", "left", left_text = "a"),
#'         textInputGroup("id2", "right", right_text = "b"),
#'         textInputGroup("id3", "both", left_text = "$", right_text = ".00"),
#'         textInputGroup("id4", "none"),
#'         textInputGroup("id5", "icon", left_text = icon("house")),
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'
#'     shinyApp(ui, server)
#' }
textInputGroup <-function(
  textId,
  label = "",
  value = "",
  placeholder = "enter text",
  left_text = NULL,
  right_text = NULL,
  style = "width: 100%;"){

  if (all(!emptyIsFalse(left_text), !emptyIsFalse(right_text))) {
    form_style = "display: block;"
  } else {
    form_style = ""
  }

  div(
    style = style,
    tags$label(label, `for` = textId),
    div(
      class="input-group",
      style = form_style,
      if (emptyIsFalse(left_text)) tags$span(class="input-group-addon", left_text) else "",
      tags$span(
        class = "form-control text-input-clearable",
        style = "width: 100%;",
        tags$input(
          id = textId,
          type = "text",
          value = value,
          placeholder = placeholder
        ),
        HTML('<span class="glyphicon glyphicon-remove"></span>')
      ),
      tags$script(glue("clearText('{textId}')")),
      if (emptyIsFalse(right_text)) tags$span(class="input-group-addon", right_text) else "",
    ),
    spsDepend("basic")
  )
}



#' Text input with an action button
#' @description One kind of bootstrap3 input group: a textinput and a button attached
#' to the end
#' @param textId the text input ID
#' @param btnId the button ID, if not specified, it is "textId" + "_btn" like, `textId_btn`
#' @param label label of the whole group, on the top
#' @param text_value initial value of the text input
#' @param placeholder placeholder text of the text input
#' @param btn_icon a [shiny::icon] of the button
#' @param btn_label text on the button
#' @param style additional CSS style of the group
#' @param tooltip a tooltip of the group
#' @param placement where should the tooltip go?
#' @param ... additional args pass to the button, see [shiny::actionButton]
#' @export
#' @return a shiny input group
#'
#' @examples
#' if(interactive()){
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     column(
#'       6,
#'       textButton(textId = "tbtn_default", label = "default"),
#'       textButton(
#'         textId = "tbtn-icon",
#'         label = "change icon and color",
#'         btn_icon = icon("house"),
#'         class = "btn-warning" # pass to the button
#'       ),
#'       textButton(
#'         textId = "tbtn_style",
#'         label = "change styles",
#'         style = "color: red; border: 2px dashed green;"
#'       ),
#'       textButton(
#'         textId = "tbtn_submit",
#'         label = "interact with shiny server",
#'         btn_label = "Submit",
#'         placeholder = "type and submit",
#'         class = "btn-primary"),
#'       verbatimTextOutput("tbtn_submit_out")
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     # watch for the button ID "tbtn_submit" + "_btn"
#'     observeEvent(input$tbtn_submit_btn, {
#'       output$tbtn_submit_out <- renderPrint(isolate(input$tbtn_submit))
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
textButton <- function(
  textId,
  btnId = paste0(textId, "_btn"),
  label = "",
  text_value ="",
  placeholder = "",
  tooltip = "",
  placement = "bottom",
  btn_icon = NULL,
  btn_label = "btn",
  style = "",
  ...
  ){
  stopifnot(is.character(textId) && length(textId) == 1)
  stopifnot(is.character(btnId) && length(btnId) == 1)
  stopifnot(is.character(label) && length(label) == 1)
  stopifnot(is.character(text_value) && length(text_value) == 1)
  stopifnot(is.character(placeholder) && length(placeholder) == 1)
  stopifnot(is.character(tooltip) && length(tooltip) == 1)
  stopifnot(is.character(placement) && length(placement) == 1)
  stopifnot(is.character(btn_label) && length(btn_label) == 1)

  div(
    style = style,
    tags$label(label, `for` = textId),
    div(
      class = "input-group",
      `data-toggle`="tooltip",
      title = tooltip,
      `data-placement` = placement,
      tags$span(
        class = "form-control text-input-clearable",
        style = "width: 100%;",
        tags$input(
          id = textId,
          type = "text",
          value = text_value,
          placeholder = placeholder
        ),
        HTML('<span class="glyphicon glyphicon-remove"></span>')
      ),
      tags$span(
        class="input-group-btn",
        actionButton(btnId, btn_label, icon = btn_icon, ...)
      ),
      tags$script(glue("clearText('{textId}')")),
      spsDepend("basic"),
      spsDepend('pop-tip')
    )
  )
}

