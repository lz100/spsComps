
# UI
uiPoptip <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("Bootstrap3 tooltip and popover"),
      div(
        class = "text-minor",
        style = "padding: 25px",
        markdown(
        '
        ### Add tooltips and popovers
        Add tooltips and popovers to any Shiny element you want with
        pipe `%>%`. You can customize each individual of them with different color,
        text size, font weight, background color and more.

        `bsPopover` and `bsTooltip` are lower level functions which allow you to
        do detailed customization. `bsPop` and `bsTip` are higher level wrappers
        with **pre-set** color and background, which allow you to genereate tooltip
        and popover easier.
        ')
      ),
      column(
        6,
        box(
          title = "bsTooltip & bsTip", solidHeader = TRUE, status = "primary", width = 12,
          h3("bsTooltip"),
          tags$b("Hover mouse on buttons"), br(),
          actionButton("", "Tooltip on the left") %>%
            bsTooltip("Tooltip on the left", "left"),
          actionButton("", "Tooltip on the top") %>%
            bsTooltip("Tooltip on the top", "top"),
          actionButton("", "Tooltip on the right") %>%
            bsTooltip("Tooltip on the right", "right"),
          actionButton("", "Tooltip on the bottom") %>%
            bsTooltip("Tooltip on the bottom", "bottom"),
          br(), br(),
          actionButton("", "primary color") %>%
            bsTooltip("primary color", bgcolor = "#0275d8"),
          actionButton("", "danger color") %>%
            bsTooltip("danger color", bgcolor = "#d9534f"),
          actionButton("", "warning color") %>%
            bsTooltip("warning color", bgcolor = "#f0ad4e"),
          br(), br(),
          actionButton("", "9px") %>%
            bsTooltip("9px", fontsize = "9px"),
          actionButton("", "14px") %>%
            bsTooltip("14px", fontsize = "14px"),
          actionButton("", "20px") %>%
            bsTooltip("20px", fontsize = "20px"),
          br(), br(),
          lapply(c("100", "400", "600", "900"), function(x) {
            actionButton("", paste0("weight ", x)) %>% bsTooltip(paste0("weight ", x), fontweight = x)
          }), br(), br(),
          lapply(c(0.2, 0.5, 0.8, 1), function(x) {
            actionButton("", paste0("opacity ", x)) %>% bsTooltip(paste0("opacity ", x), opacity = x)
          }), br(), br(),
          actionButton("", "allow html: 'abc<b>del</b>abc' ") %>%
            bsTooltip('abc<b>del</b>abc', html = TRUE, bgcolor = "#0275d8"),
          actionButton("", "allow html: '<s>del content</s>' ") %>%
            bsTooltip('<s>del content</s>', html = TRUE, bgcolor = "#d9534f"),
          br(), br(),
          spsCodeBtn(
            ns("code_tooltip"),
            show_span = TRUE,
            '
            library(magrittr)
            ui <- fluidPage(
              br(), br(), br(), br(), br(), br(), column(2),
              actionButton("", "Tooltip on the left") %>%
                bsTooltip("Tooltip on the left", "left"),
              actionButton("", "Tooltip on the top") %>%
                bsTooltip("Tooltip on the top", "top"),
              actionButton("", "Tooltip on the right") %>%
                bsTooltip("Tooltip on the right", "right"),
              actionButton("", "Tooltip on the bottom") %>%
                bsTooltip("Tooltip on the bottom", "bottom"),
              br(), br(), column(2),
              actionButton("", "primary color") %>%
                bsTooltip("primary color", bgcolor = "#0275d8"),
              actionButton("", "danger color") %>%
                bsTooltip("danger color", bgcolor = "#d9534f"),
              actionButton("", "warning color") %>%
                bsTooltip("warning color", bgcolor = "#f0ad4e"),
              br(), br(), column(2),
              actionButton("", "9px") %>%
                bsTooltip("9px", fontsize = "9px"),
              actionButton("", "14px") %>%
                bsTooltip("14px", fontsize = "14px"),
              actionButton("", "20px") %>%
                bsTooltip("20px", fontsize = "20px"),
              br(), br(), column(2),
              lapply(c("100", "400", "600", "900"), function(x) {
                actionButton("", paste0("weight ", x)) %>% bsTooltip(paste0("weight ", x), fontweight = x)
              }),
              br(), br(), column(2),
              lapply(c(0.2, 0.5, 0.8, 1), function(x) {
                actionButton("", paste0("opacity ", x)) %>% bsTooltip(paste0("opacity ", x), opacity = x)
              }),
              br(), br(), column(2),
              actionButton("", "allow html: \'abc<b>del</b>abc\' ") %>%
                bsTooltip(\'abc<b>del</b>abc\', html = TRUE, bgcolor = "#0275d8"),
              actionButton("", "allow html: \'<s>del content</s>\' ") %>%
                bsTooltip(\'<s>del content</s>\', html = TRUE, bgcolor = "#d9534f")
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          ),
          spsHr(),
          h3("Clickable content"),
          markdown(
            '
            Sometimes we want to add clickable content inside the message,
            for example, the message is too long and we want to have users click
            on a link and go to other places to continue reading. In this case, the
            `click_inside` option will be very useful.

            Normally, the message will be gone after mouse leaving the element.
            When you move mouse over the message, it will be disappeared very fast.
            This option allow users to click inside the message. However, the
            triggering mothod of this can only be hover (actually mouse moving
            events, but you can treat it as "hover").

            To add clickable content, `html = TRUE` option usually is also required.
            See the example below.
            '
          ),
          actionButton("", "Clickable with links") %>%
            bsTooltip(
              "<div>This message has a <a href='https://google.com'>link</a></div>", "bottom",
              html = TRUE, click_inside = TRUE, bgcolor = "orange"
            ),
          br(), br(),
          spsCodeBtn(
            ns("code_tooltip_click"),
            '
            library(magrittr)
            ui <- fluidPage(
              actionButton("", "Clickable with links") %>%
                bsTooltip(
                  "<div>This message has a <a href=\'https://google.com\'>link</a></div>", "bottom",
                  # `html` and `click_inside` should be combined to  create links
                  html = TRUE, click_inside = TRUE, bgcolor = "orange"
                )
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          ),
          spsHr(),
          h3("bstip"),
          actionButton("", "primary") %>%
            bsTip("primary", status = "primary"),
          actionButton("", "info") %>%
            bsTip("info", status = "info"),
          actionButton("", "success") %>%
            bsTip("success", status = "success"),
          actionButton("", "warning") %>%
            bsTip("warning", status = "warning"),
          actionButton("", "danger") %>%
            bsTip("danger", status = "danger"), br(),
          spsCodeBtn(
            ns("code_tip"),
            show_span = TRUE,
            '
            library(magrittr)
            ui <- fluidPage(
              br(), br(), br(), br(), br(), br(), column(2),
              actionButton("", "primary") %>%
                bsTip("primary", status = "primary"),
              actionButton("", "info") %>%
                bsTip("info", status = "info"),
              actionButton("", "success") %>%
                bsTip("success", status = "success"),
              actionButton("", "warning") %>%
                bsTip("warning", status = "warning"),
              actionButton("", "danger") %>%
                bsTip("danger", status = "danger")
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          )
        )
      ),
      column(
        6,
        box(
          title = "bsPopover & bsPop", solidHeader = TRUE, status = "primary", width = 12,
          h3("bsPopover"),
          tags$b("Hover mouse on buttons"), br(),
          actionButton("", "Popover on the left") %>%
            bsPopover("Popover on the left", "content", "left"),
          actionButton("", "Popover on the top") %>%
            bsPopover("Popover on the top", "content", "top"),
          actionButton("", "Popover on the right") %>%
            bsPopover("Popover on the right", "content", "right"),
          actionButton("", "Popover on the bottom") %>%
            bsPopover("Popover on the bottom", "content", "bottom"),
          br(), br(),
          actionButton("", "primary color") %>%
            bsPopover(
              "primary color", "content", bgcolor = "#0275d8",
              titlecolor = "white", contentcolor = "#0275d8"),
          actionButton("", "danger color") %>%
            bsPopover(
              "danger color",  "content", bgcolor = "#d9534f",
              titlecolor = "white", contentcolor = "#d9534f"),
          actionButton("", "warning color") %>%
            bsPopover(
              "warning color", "content", bgcolor = "#f0ad4e",
              titlecolor = "white", contentcolor = "#f0ad4e"),
          br(), br(),
          actionButton("", "9px & 14px") %>%
            bsPopover("9px", "14", titlesize = "9px", contentsize = ),
          actionButton("", "14px & 12px") %>%
            bsPopover("14px", "12", titlesize = "14px"),
          actionButton("", "20px & 9px") %>%
            bsPopover("20px", "9", titlesize = "20px"),
          br(), br(),
          actionButton("", "weight 100 & 800") %>%
            bsPopover("weight 100", "800", titleweight =  "100", contentweight = "800"),
          actionButton("", "weight 400 & 600") %>%
            bsPopover("weight 400", "600", titleweight =  "400", contentweight = "600"),
          actionButton("", "weight 600 & 400") %>%
            bsPopover("weight 600", "400", titleweight =  "600", contentweight = "400"),
          actionButton("", "weight 900 & 200") %>%
            bsPopover("weight 900", "200", titleweight =  "900", contentweight = "200"),
          br(), br(),
          actionButton("", "opacity 0.2") %>%
            bsPopover("opacity 0.2", opacity = 0.2),
          actionButton("", "opacity 0.5") %>%
            bsPopover("opacity 0.5", opacity = 0.5),
          actionButton("", "opacity 0.8") %>%
            bsPopover("opacity 0.8", opacity = 0.8),
          actionButton("", "opacity 1") %>%
            bsPopover("opacity 1", opacity = 1),
          br(), br(),
          actionButton("f1", "allow html: 'abc<span class='text-danger'>danger</span>'") %>%
            bsPopover(HTML("abc<span class='text-danger'>danger</span>"), html = TRUE, bgcolor = "#0275d8"),
          actionButton("f2", "allow html: '<s>del content</s>'") %>%
            bsPopover(HTML("<s>del content</s>"), html = TRUE, bgcolor = "#d9534f"),
          br(), spsCodeBtn(
            ns("code_popover"),
            show_span = TRUE,
            '
            library(magrittr)
            ui <- fluidPage(
              br(), br(), br(), br(), br(), br(), column(2),
              actionButton("", "Popover on the left") %>%
                bsPopover("Popover on the left", "content", "left"),
              actionButton("", "Popover on the top") %>%
                bsPopover("Popover on the top", "content", "top"),
              actionButton("", "Popover on the right") %>%
                bsPopover("Popover on the right", "content", "right"),
              actionButton("", "Popover on the bottom") %>%
                bsPopover("Popover on the bottom", "content", "bottom"),
              br(), br(), column(2),
              actionButton("", "primary color") %>%
                bsPopover(
                  "primary color", "content", bgcolor = "#0275d8",
                  titlecolor = "white", contentcolor = "#0275d8"),
              actionButton("", "danger color") %>%
                bsPopover(
                  "danger color",  "content", bgcolor = "#d9534f",
                  titlecolor = "white", contentcolor = "#d9534f"),
              actionButton("", "warning color") %>%
                bsPopover(
                  "warning color", "content", bgcolor = "#f0ad4e",
                  titlecolor = "white", contentcolor = "#f0ad4e"),
              br(), br(), column(2),
              actionButton("", "9px & 14px") %>%
                bsPopover("9px", "14", titlesize = "9px", contentsize = ),
              actionButton("", "14px & 12px") %>%
                bsPopover("14px", "12", titlesize = "14px"),
              actionButton("", "20px & 9px") %>%
                bsPopover("20px", "9", titlesize = "20px"),
              br(), br(), column(2),
              actionButton("", "weight 100 & 800") %>%
                bsPopover("weight 100", "800", titleweight =  "100", contentweight = "800"),
              actionButton("", "weight 400 & 600") %>%
                bsPopover("weight 400", "600", titleweight =  "400", contentweight = "600"),
              actionButton("", "weight 600 & 400") %>%
                bsPopover("weight 600", "400", titleweight =  "600", contentweight = "400"),
              actionButton("", "weight 900 & 200") %>%
                bsPopover("weight 900", "200", titleweight =  "900", contentweight = "200"),
              br(), br(), column(2),
              actionButton("", "opacity 0.2") %>%
                bsPopover("opacity 0.2", opacity = 0.2),
              actionButton("", "opacity 0.5") %>%
                bsPopover("opacity 0.5", opacity = 0.5),
              actionButton("", "opacity 0.8") %>%
                bsPopover("opacity 0.8", opacity = 0.8),
              actionButton("", "opacity 1") %>%
                bsPopover("opacity 1", opacity = 1),
              br(), br(), column(2),
              actionButton("f1", "allow html: \'abc<span class=\'text-danger\'>danger</span>\'") %>%
                bsPopover(HTML("abc<span class=\'text-danger\'>danger</span>"), html = TRUE, bgcolor = "#0275d8"),
              actionButton("f2", "allow html: \'<s>del content</s>\'") %>%
                bsPopover(HTML("<s>del content</s>"), html = TRUE, bgcolor = "#d9534f")
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          ),
          spsHr(),
          h3("Clickable content"),
          p("See details of clickable content of bsTooltip on the left."),
          actionButton("", "Clickable with links") %>%
            bsPopover(
              title = "Clickable with links",
              content = "<div>This message has a <a href='https://google.com'>link</a></div>", "bottom",
              html = TRUE, click_inside = TRUE, bgcolor = "orange"
            ),
          br(), br(),
          spsCodeBtn(
            ns("code_popover_click"),
            '
            library(magrittr)
            ui <- fluidPage(
              actionButton("", "Clickable with links") %>%
                bsPopover(
                   title = "Clickable with links",
                   content = "<div>This message has a <a href=\'https://google.com\'>link</a></div>", "bottom",
                   html = TRUE, click_inside = TRUE, bgcolor = "orange"
                 )
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          ),
          spsHr(),
          h3("bsPop"),
          actionButton("", "primary") %>%
            bsPop("primary", "primary", status = "primary"),
          actionButton("", "info") %>%
            bsPop("info", "info", status = "info"),
          actionButton("", "success") %>%
            bsPop("success", "success", status = "success"),
          actionButton("", "warning") %>%
            bsPop("warning", "warning", status = "warning"),
          actionButton("", "danger") %>%
            bsPop("danger", "danger", status = "danger"),
          br(), spsCodeBtn(
            ns("code_bspop"),
            show_span = TRUE,
            '
            library(magrittr)
            ui <- fluidPage(
              br(), br(), br(), br(), br(), br(), column(2),
              actionButton("", "primary") %>%
                bsPop("primary", "primary", status = "primary"),
              actionButton("", "info") %>%
                bsPop("info", "info", status = "info"),
              actionButton("", "success") %>%
                bsPop("success", "success", status = "success"),
              actionButton("", "warning") %>%
                bsPop("warning", "warning", status = "warning"),
              actionButton("", "danger") %>%
                bsPop("danger", "danger", status = "danger")
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          )
        )
      )
  )
}

# Server
serverPoptip <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
    }
  )
}
