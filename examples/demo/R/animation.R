animate_table <- '
<table class="animate-table">
  <thead>
    <tr>
      <th>Animation</th>
      <th>Default</th>
      <th>Fast</th>
      <th>Slow</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">wrench</code></td>
      <td><i class="fa fa-wrench faa-wrench animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-wrench faa-wrench animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-wrench faa-wrench animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">ring</code></td>
      <td><i class="fa fa-bell faa-ring animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-bell faa-ring animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-bell faa-ring animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">horizontal</code></td>
      <td><i class="fa fa-envelope faa-horizontal animated" style="font-size:2em"></i></td>
      <td><i class="fa fa-envelope faa-horizontal animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-envelope faa-horizontal animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">horizontal-reverse</code></td>
      <td><i class="fa fa-envelope faa-horizontal animated faa-reverse" style="font-size: 2em"></i></td>
      <td><i class="fa fa-envelope faa-horizontal animated faa-reverse faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-envelope faa-horizontal animated faa-reverse faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">vertical</code></td>
      <td><i class="fa fa-thumbs-o-up faa-vertical animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-thumbs-o-up faa-vertical animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-thumbs-o-up faa-vertical animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">flash</code></td>
      <td><i class="fa fa-warning faa-flash animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-warning faa-flash animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-warning faa-flash animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">bounce</code></td>
      <td><i class="fa fa-thumbs-o-up faa-bounce animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-thumbs-o-up faa-bounce animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-thumbs-o-up faa-bounce animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">bounce-reverse</code></td>
      <td><i class="fa fa-thumbs-o-down faa-bounce faa-reverse animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-thumbs-o-down faa-bounce faa-reverse animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-thumbs-o-down faa-bounce faa-reverse animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">spin</code></td>
      <td><i class="fa fa-spinner faa-spin animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-spinner faa-spin animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-spinner faa-spin animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">spin-reverse</code></td>
      <td><i class="fa fa-spinner faa-spin faa-reverse animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-spinner faa-spin faa-reverse animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-spinner faa-spin faa-reverse animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">float</code></td>
      <td><i class="fa fa-plane faa-float animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-plane faa-float animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-plane faa-float animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">pulse</code></td>
      <td><i class="fa fa-heart faa-pulse animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-heart faa-pulse animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-heart faa-pulse animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">shake</code></td>
      <td><i class="fa fa-envelope faa-shake animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-envelope faa-shake animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-envelope faa-shake animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">tada</code></td>
      <td><i class="fa fa-trophy faa-tada animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-trophy faa-tada animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-trophy faa-tada animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">passing</code></td>
      <td><i class="fa fa-space-shuttle faa-passing animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-space-shuttle faa-passing animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-space-shuttle faa-passing animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">passing-reverse</code></td>
      <td><i class="fa fa-space-shuttle faa-passing faa-reverse animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-space-shuttle faa-passing faa-reverse animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-space-shuttle faa-passing faa-reverse animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">burst</code></td>
      <td><i class="fa fa-circle-o faa-burst animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-circle-o faa-burst animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-circle-o faa-burst animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">falling</code></td>
      <td><i class="fa fa-star-o faa-falling animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-star-o faa-falling animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-star-o faa-falling animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">falling-reverse</code></td>
      <td><i class="fa fa-star-o faa-falling faa-reverse animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-star-o faa-falling faa-reverse animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-star-o faa-falling faa-reverse animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
    <tr>
      <td><code class="language-plaintext highlighter-rouge">rising</code></td>
      <td><i class="fa fa-star-o faa-rising animated" style="font-size: 2em"></i></td>
      <td><i class="fa fa-star-o faa-rising animated faa-fast" style="font-size: 2em"></i></td>
      <td><i class="fa fa-star-o faa-rising animated faa-slow" style="font-size: 2em"></i></td>
    </tr>
  </tbody>
</table>
'
# UI
uiAnimation <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("Animations"),
      column(
        6,
        box(
          title = "All animation types", solidHeader = TRUE, status = "primary", width = 12,
          div(
            hexPanel(
              ns("awesome-logo"), "Animation is modified from:",
              hex_imgs = "https://avatars.githubusercontent.com/u/5452304?v=4",
              hex_titles = "font-awesome-animation",
              hex_links = "https://l-lin.github.io/font-awesome-animation/",
              footers = "source",
              footer_links = "https://github.com/l-lin/font-awesome-animation",
              target_blank = TRUE
            ),
            HTML(animate_table)
          )
        ),
        box(
          title = "animateServer & animationRemove", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            h3("Add/Remove animations from the server"),
            tags$code("animateServer"),
            tags$span("Add animations from server side to existing UI elements"), br(),
            tags$code("animationRemove"),
            tags$span("Remove animations from server side to existing UI elements"), br(),
          ),
          tags$label("Add/Remove animation of a button"), br(),
          actionButton(ns("btn3"), "animate itself"),
          actionButton(ns("btn4"), "stop animation"), br(),
          tags$label("Remove animation that was added from UI"), br(),
          animateIcon("home", id = ns("icon-home"), "burst", color = "red"),
          actionButton(ns("btn5"), "<-stop left"), br(),
          tags$label("advanced selector in for complex group"), br(),
          sliderInput(
            ns("myslider"),
            label = "animating if less than 5",
            value = 0,
            min = 0, max = 10,
            step = 1
          ),
          sliderInput(
            ns("myslider2"),  min = 0, max = 10, value = 10,
            label = "this one will not be selected"
          ),
          spsCodeBtn(
            ns("code_animateServer"),
            show_span = TRUE,
            '
            library(shiny)

            ui <- fluidPage(
              spsDepend("animation"),
              h3("Adding/removing animations from server"),
              tags$label("use a button to control"), br(),
              actionButton("btn3", "animate itself"),
              actionButton("btn4", "stop animation"), br(),
              animateIcon("home", id = ns("icon-home"), "burst", color = "red"),
              actionButton("btn5", "<-stop left"), br(),
              tags$label("advanced selector in for complex group"), br(),
              sliderInput(
                "myslider",
                label = "animating if less than 5",
                value = 0,
                min = 0, max = 10,
                step = 1
              ),
              sliderInput(
                "myslider2",  min = 0, max = 10, value = 10,
                label = "this one will not be selected"
              )
            )

            server <- function(input, output, session) {
              observeEvent(input$myslider, {
                if (input$myslider <= 5) {
                  animateServer(
                    # the slider container does not has the ID, it is inside
                    selector = ".shiny-input-container:has(#myslider)",
                    animation = "horizontal", speed = "slow", isID = FALSE
                  )
                } else {
                  animationRemove(
                    selector = ".shiny-input-container:has(#myslider)",
                    isID = FALSE
                  )
                }
              })
              observeEvent(input$btn3, {
                animateServer("btn3", animation = "flash", speed = "slow")
              })
              observeEvent(input$btn4, {
                animationRemove("btn3")
              })
              observeEvent(input$btn5, {
                animationRemove("icon-home")
              })
            }

            shinyApp(ui, server)
            '
          ), spsHr(),
        )
      ),
      column(
        6,
        box(
          title = "animateUI, animateAppend & animateAppendNested", solidHeader = TRUE,
          status = "primary", width = 12,
          div(
            class = "text-minor",
            h3("Add animations from the UI"),
            tags$code("animateUI"),
            tags$span("Add animations to any existing UI element"), br(),
          ),
          tags$label("to a button"), br(),
          actionButton(ns("btn1"), "random button"), br(),
          animateUI(ns("btn1"), animation = "ring"),
          tags$label("to some text"), br(),
          p(id = ns("mytext"), class = "text-red", "some move text"), br(),
          animateUI(ns("mytext"), animation = "horizontal", speed = "fast"),
          tags$label("on hover, move mouse on the red thumb"), br(),
          actionButton(
            ns("btn2"), "",
            icon = icon(id = ns("myicon"), "thumbs-o-up"),
            style = "color: red; boarder: initial; border-color: transparent;"
          ), br(),
          animateUI(ns("btn2"), animation = "bounce", speed = "fast", hover = TRUE),
          tags$label("on a plot"), br(),
          plotOutput(ns("plot1")),
          animateUI(ns("plot1"), animation = "float", speed = "fast"),
          spsCodeBtn(
            ns("code_animateUI"),
            show_span = TRUE,
            '
            library(shiny)
            ui <- fluidPage(
              h3("Adding animations from UI"),
              tags$label("to a button"), br(),
              actionButton("btn1", "random button"), br(),
              animateUI("btn1", animation = "ring"),
              tags$label("to some text"), br(),
              p(id = "mytext", class = "text-red", "some move text"), br(),
              animateUI("mytext", animation = "horizontal", speed = "fast"),
              tags$label("on hover, move mouse on the red thumb"), br(),
              actionButton(
                "btn2", "",
                icon = icon(id = "myicon", "thumbs-o-up"),
                style = "color: red; boarder: initial; border-color: transparent;"
              ), br(),
              animateUI("btn2", animation = "bounce", speed = "fast", hover = TRUE),
              tags$label("on a plot"), br(),
              plotOutput("plot1"),
              animateUI("plot1", animation = "float", speed = "fast")
            )
            server <- function(input, output, session) {
              output$plot1 <- renderPlot(plot(1:10, 10:1))
            }
            shinyApp(ui, server)
            '
          ), spsHr(),
          div(
            class = "text-minor",
            tags$code("animateAppend"),
            tags$span(": add animations with pipe"), br(),
          ),
          icon("home") %>%
            animateAppend("ring"),
          br(),
          h2("Append animation", class = "text-primary") %>%
            animateAppend("pulse"),
          br(),
          spsCodeBtn(
            ns("code_animateAppend"),
            show_span = TRUE,
            '
            icon("home") %>%
              animateAppend("ring"),
            br(),
            h2("Append animation", class = "text-primary") %>%
              animateAppend("pulse")
            '
          ), spsHr(),
          div(
            class = "text-minor",
            tags$code("animateAppendNested"),
            tags$span(": multiple animations animations with pipe"), br(),
          ),
          h2("Nested animations", class = "text-primary") %>%
            animateAppendNested("ring") %>%
            animateAppendNested("pulse") %>%
            animateAppendNested("bounce"),
          tags$span("Other things"),
          h2("Nested & display changed", class = "text-primary") %>%
            animateAppendNested("ring") %>%
            animateAppendNested("pulse") %>%
            animateAppendNested("bounce", display = "block"),
          tags$span("Other things"), br(),
          spsCodeBtn(
            ns("code_animateAppendNested"),
            show_span = TRUE,
            '
            h2("Nested animations", class = "text-primary") %>%
              animateAppendNested("ring") %>%
              animateAppendNested("pulse") %>%
              animateAppendNested("bounce"),
            tags$span("Other things"),
            h2("Nested animations display changed", class = "text-primary") %>%
              animateAppendNested("ring") %>%
              animateAppendNested("bounce", display = "block"),
            tags$span("Other things")
            '
          )
        ),
        box(
          title = "animateIcon", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            h3("Enhanced font-awesome icons with animations"),
            tags$code("animateIcon"),
            tags$span(": Create icons with different size, color and animations"), br(),
            div(
              style = "text-align: center;",
              tags$label("same as original icon function"), br(),
              animateIcon("home"),  br(),
              tags$label("Change animation and color"), br(),
              animateIcon(
                name = "home", animation = "horizontal", speed = "slow", color ="red"
              ), br(),
              tags$label("work in a button"), br(),
              actionButton(
                "a", "a", icon = animateIcon("spinner", "spin", "fast")
              ), br(),
              tags$label("hover your mouse on the next one"), br(),
              animateIcon(
                name = "wrench", animation = "wrench", hover = TRUE, color ="green"
              ), br(),
              tags$label("change size"), br(),
              animateIcon("home"),
              animateIcon("home", size = "xs"),
              animateIcon("home", size = "sm"),
              animateIcon("home", size = "lg"),
              animateIcon("home", size = "2x"),
              animateIcon("home", size = "3x"),
              animateIcon("home", size = "5x"),
              animateIcon("home", size = "7x"),
              animateIcon("home", size = "10x")
            ),
            spsCodeBtn(
              ns("code_animateIcon"),
              show_span = TRUE,
              '
              library(shiny)

              ui <- fluidPage(
                style = "text-align: center;",
                tags$label("same as original icon function"), br(),
                animateIcon("home"),  br(),
                tags$label("Change animation and color"), br(),
                animateIcon(
                  name = "home", animation = "horizontal", speed = "slow", color ="red"
                ), br(),
                tags$label("work in a button"), br(),
                actionButton(
                  "a", "a", icon = animateIcon("spinner", "spin", "fast")
                ), br(),
                tags$label("hover your mouse on the next one"), br(),
                animateIcon(
                  name = "wrench", animation = "wrench", hover = TRUE, color ="green"
                ), br(),
                tags$label("change size"), br(),
                animateIcon("home"),
                animateIcon("home", size = "xs"),
                animateIcon("home", size = "sm"),
                animateIcon("home", size = "lg"),
                animateIcon("home", size = "2x"),
                animateIcon("home", size = "3x"),
                animateIcon("home", size = "5x"),
                animateIcon("home", size = "7x"),
                animateIcon("home", size = "10x")
              )

              server <- function(input, output, session) {

              }

              shinyApp(ui, server)
              '
            )
          ),
        )
      )
  )
}

# Server
serverAnimation <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$plot1 <- renderPlot(plot(1:10, 10:1))

      observeEvent(input$myslider, {
        if (input$myslider <= 5) {
          animateServer(
            # the slider container does not has the ID, it is inside
            selector = ".shiny-input-container:has(#animation-myslider)",
            animation = "horizontal", speed = "slow", isID = FALSE
          )
        } else {
          animationRemove(
            selector = ".shiny-input-container:has(#animation-myslider)",
            isID = FALSE
          )
        }
      })
      observeEvent(input$btn3, {
        animateServer("btn3", animation = "flash", speed = "slow")
      })
      observeEvent(input$btn4, {
        animationRemove("btn3")
      })
      observeEvent(input$btn5, {
        animationRemove("icon-home")
      })
    }
  )
}
