spinner <- "https://github.com/lz100/spsComps/blob/master/examples/demo/www/spinner.gif?raw=true"
eater <- "https://github.com/lz100/spsComps/blob/master/examples/demo/www/bean_eater.gif?raw=true"

# UI
uiLoader <- function(id) {
  heights <- paste0(c(1.5, 3, 5, 7, 9, 11, 13), "rem")
  colors <- list(
    colorRampPalette(c("#00d2ff", "#3a7bd5"))(7),
    colorRampPalette(c("#59C173", "#a17fe0", "#5D26C1"))(7),
    colorRampPalette(c("#667db6", "#0082c8", "#5D26C1", "#667db6"))(7),
    colorRampPalette(c("#f2709c", "#ff9472"))(7),
    colorRampPalette(c("#FC5C7D", "#6A82FB"))(7),
    colorRampPalette(c("#4568DC", "#B06AB3"))(7)
  )
  types <- c("circle", "dual-ring", "facebook", "heart",
             "ring", "roller", "default", "ellipsis",
             "grid", "hourglass", "ripple", "spinner")
  ns <- NS(id)
  fluidRow(
      tabTitle("Loaders"),
      column(
        6,
        box(
          title = "All loader types", solidHeader = TRUE, status = "primary", width = 12,
          hexPanel(
            ns("awesome-logo"), "Loaders are modified from:",
            hex_imgs = "loading.png",
            hex_titles = "loading.io",
            hex_links = "https://loading.io/",
            footers = "source",
            footer_links = "https://github.com/loadingio/css-spinner/",
            target_blank = TRUE
          ),
          lapply(seq_along(types), function(i){
            div(
              h4(types[i]), br(),
              lapply(1:7, function(x){
                cssLoader(
                  types[i], height = heights[x],
                  color = colors[[if(i > 6) i - 6 else i]][x],
                  inline = TRUE
                )
              }),
              br()
            )
          }),
          spsCodeBtn(
            ns("code_loaders"),
            show_span = TRUE,
            '
            library(shiny)
            heights <- paste0(c(1.5, 3, 5, 8, 10, 15, 20), "rem")
            colors <- list(
              colorRampPalette(c("#00d2ff", "#3a7bd5"))(7),
              colorRampPalette(c("#59C173", "#a17fe0", "#5D26C1"))(7),
              colorRampPalette(c("#667db6", "#0082c8", "#5D26C1", "#667db6"))(7),
              colorRampPalette(c("#f2709c", "#ff9472"))(7),
              colorRampPalette(c("#FC5C7D", "#6A82FB"))(7),
              colorRampPalette(c("#4568DC", "#B06AB3"))(7)
            )
            types <- c("circle", "dual-ring", "facebook", "heart",
                       "ring", "roller", "default", "ellipsis",
                       "grid", "hourglass", "ripple", "spinner")
            ui <- fluidPage(
              lapply(seq_along(types), function(i){
                div(
                  h4(types[i]), br(),
                  lapply(1:7, function(x){
                    cssLoader(
                      types[i], height = heights[x],
                      color = colors[[if(i > 6) i - 6 else i]][x],
                      inline = TRUE
                    )
                  }),
                  br()
                )
              })
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          ), spsHr(),
          h3("Use your own GIF as loaders"),
          cssLoader(
            "gif", spinner, height = "50px"
          ),
          cssLoader(
            "gif", spinner, height = "100px"
          ),
          cssLoader(
            "gif", eater, height = "150px"
          ),
          cssLoader(
            "gif", eater, height = "200px"
          ),
          h4("custom loaders in buttons"),
          actionButton(
            ns("btn-custom1"), "",
            icon =  cssLoader(
              type = "gif", src = spinner,
              is_icon = TRUE, inline = TRUE
            )
          ),
          actionButton(
            ns("btn-custom2"), "A button",
            icon =  cssLoader(
              type = "gif", src = eater,
              is_icon = TRUE, inline = TRUE
            )
          ), br(),
          spsCodeBtn(
            ns("code_loader_custom"),
            show_span = TRUE,
            '
            spinner <- "https://github.com/lz100/spsComps/blob/master/examples/demo/www/spinner.gif?raw=true"
            eater <- "https://github.com/lz100/spsComps/blob/master/examples/demo/www/bean_eater.gif?raw=true"
            ui <- fluidPage(
              cssLoader(
                "gif", src = spinner, height = "50px"
              ),
              cssLoader(
                "gif", spinner, height = "100px"
              ),
              cssLoader(
                "gif", eater, height = "150px"
              ),
              cssLoader(
                "gif", eater, height = "200px"
              ),
              actionButton(
                "btn-custom1", "",
                icon =  cssLoader(
                  type = "gif", src = spinner,
                  is_icon = TRUE, inline = TRUE
                )
              ),
              actionButton(
                "btn-custom2", "A button",
                icon =  cssLoader(
                  type = "gif", src = eater,
                  is_icon = TRUE, inline = TRUE
                )
              )
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
          title = "cssLoader", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            Call the `cssLoader` to add loaders to the app UI. The most commonly
            used case for the loaders is within a button. Like following:
            '),
            p("A button with only the loader"),
            actionButton(
              ns("btn-a"), "",
              icon =  cssLoader(is_icon = TRUE, inline = TRUE, color = "#3a7bd5"
              )
            ),
            p("A button with the loader and some text"),
            actionButton(
              ns("btn-b"), "Loading",
              icon =  cssLoader(type = "hourglass", is_icon = TRUE, color = "#667db6", inline = TRUE)
            )
          ),
          spsCodeBtn(
            ns("code_cssLoader"),
            show_span = TRUE,
            '
            library(shiny)
            ui <- fluidPage(
              actionButton(
                "btn-a", "",
                ## `inline = TRUE` is important if you want loader and
                ## text in the same line.
                icon =  cssLoader(is_icon = TRUE, inline = TRUE, color = "#3a7bd5"
                )
              ),
              actionButton(
                "btn-b", "Loading",
                icon =  cssLoader(type = "hourglass", is_icon = TRUE, color = "#667db6", inline = TRUE)
              )
            )
            server <- function(input, output, session) {}
            shinyApp(ui, server)
            '
          )
        ),
        box(
          title = "addLoader", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              More often times, we would like to add and remove loaders when users
              click some button, the app does something, like plotting, and when
              the process is finished, remove the loader. This can be done with
              `addLoader` function.
              ')
          ),
          h3("Use button actions to show and hide loaders with different methods"),
          tags$b("Replace"), br(),
          p("Replace the orginal content with the loader and disable the element"),
          actionButton(ns("b_re_start"), "Replace"),
          actionButton(ns("b_re_stop"), "stop replace"),
          br(), tags$b("Inline"), br(),
          p("Add the loader in front of original content and disable the element"),
          actionButton(ns("b_in_start"), "Inline"),
          actionButton(ns("b_in_stop"), "stop inline"),
          br(), tags$b("Full screen"), br(),
          p("An overlay to cover the whole screen"),
          actionButton(ns("b_fs_start"), "Full screen 2s"), br(),
          h4("Add loaders to a big HTML chunk"),
          p("Apply to complex HTML components"),
          actionButton(ns("chunk_start"), "Chunk loader"),
          actionButton(ns("chunk_stop"), "Stop"), br(),
          column(12,
                 id = ns("chunk"),
                 style = "background-color: #eee",
                 h5("Here are some text 12345"),
                 tags$hr(),
                 icon("house"),
                 p("blablablablablablablablablablablablablablablablablablablabla"),
                 p("blablablablablablablablablablablablablablablablablablablabla"),
                 p("blablablablablablablablablablablablablablablablablablablabla"),
                 p("blablablablablablablablablablablablablablablablablablablabla")
          ),
          spsCodeBtn(
            ns("code_addLoader"),
            show_span = TRUE,
            '
            ui <- fluidPage(
              spsDepend("addLoader"), # optional
              h4("Use buttons to show and hide loaders with different methods"),
              tags$b("Replace"), br(),
              actionButton("b_re_start", "Replace"),
              actionButton("b_re_stop", "stop replace"),
              br(), tags$b("Inline"), br(),
              actionButton("b_in_start", "Inline"),
              actionButton("b_in_stop", "stop inline"),
              br(), tags$b("Full screen"), br(),
              actionButton("b_fs_start", "Full screen 2s"), br(),
              h4("Add loaders to a big HTML chunk"),
              actionButton("chunk_start", "Chunk loader"),
              actionButton("chunk_stop", "Stop"), br(),
              column(6,
                     id = "chunk",
                     style = "background-color: #eee",
                     h5("Here are some text 12345"),
                     tags$hr(),
                     icon("house"),
                     p("blablablablablablablablablablablablablablablablablablablabla"),
                     p("blablablablablablablablablablablablablablablablablablablabla"),
                     p("blablablablablablablablablablablablablablablablablablablabla"),
                     p("blablablablablablablablablablablablablablablablablablablabla")
              )
            )

            server <- function(input, output, session) {
              # Init loaders
              loader_replace <- addLoader$new("b_re_start", type = "facebook")
              loader_inline <- addLoader$new("b_in_start", color = "green", method = "inline")
              loader_fs <- addLoader$new(
                "b_fs_start", color = "pink", method = "full_screen",
                bg_color = "#eee", height = "30rem", type = "heart"
              )
              loader_chunk <- addLoader$new(
                "chunk", type = "spinner", color = "orange",
                footer = h5("chunk loader")
              )

              # toggle loaders
              ## replace
              observeEvent(input$b_re_start, {
                loader_replace$show()
              })
              observeEvent(input$b_re_stop, {
                loader_replace$hide()
              })
              ## inline
              observeEvent(input$b_in_start, {
                loader_inline$show()
              })
              observeEvent(input$b_in_stop, {
                loader_inline$hide()
              })
              ## full screen
              observeEvent(input$b_fs_start, {
                loader_fs$show()
                Sys.sleep(2)
                loader_fs$hide()
              })
              ## chunk
              observeEvent(input$chunk_start, {
                loader_chunk$show()
              })
              observeEvent(input$chunk_stop, {
                loader_chunk$hide()
              })

            }

            shinyApp(ui, server)
            '
          ), spsHr(),
          div(
            class = "text-minor",
            HTML("<h3>Add loaders to Shiny <code>render</code> events</h3>"),
            markdown(
            '
            Loaders can also be added to Shiny rendering events, like `renderPlot`.
            Here is a demo of `replacing` method and `full_screen` method while
            rendering the plots. `inline` would not work for rendering events
            in most cases.
            '
            )
          ),
          tags$b("Replace"), br(),
          selectInput(inputId = ns("n_re"),
                      label = "Change this to re-render the following plot",
                      choices = c(10, 20, 35, 50)),
          plotOutput(outputId = ns("p_re")),
          br(), tags$b("Full screen"), br(),
          selectInput(inputId = ns("n_fs"),
                      label = "Change this to re-render the following plot",
                      choices = c(10, 20, 35, 50)),
          plotOutput(outputId = ns("p_fs")),
          spsCodeBtn(
            ns("code_addLoader_plots"),
            show_span = TRUE,
            '
            ui <- bootstrapPage(
              spsDepend("addLoader"), # optional
              h4("Add loaders to Shiny `render` events"),
              tags$b("Replace"), br(),
              selectInput(inputId = "n_re",
                          label = "Change this to render the following plot",
                          choices = c(10, 20, 35, 50)),
              plotOutput(outputId = "p_re"),
              br(), tags$b("Full screen"), br(),
              selectInput(inputId = "n_fs",
                          label = "Change this to render the following plot",
                          choices = c(10, 20, 35, 50)),
              plotOutput(outputId = "p_fs")
            )

            server <- function(input, output, session) {
              # create loaders
              p_re <- addLoader$new("p_re", type = "facebook")
              p_fs <- addLoader$new(
                "p_fs", color = "pink", method = "full_screen",
                bg_color = "#eee", height = "30rem", type = "grid",
                footer = h4("Replotting...")
              )
              # use loaders in rednering
              output$p_re <- renderPlot({
                on.exit(p_re$hide())
                p_re$show()
                Sys.sleep(1)
                hist(faithful$eruptions,
                     probability = TRUE,
                     breaks = as.numeric(input$n_re),
                     xlab = "Duration (minutes)",
                     main = "Geyser eruption duration")
              })
              output$p_fs <- renderPlot({
                on.exit(p_fs$hide())
                p_fs$show()
                Sys.sleep(1)
                hist(faithful$eruptions,
                     probability = TRUE,
                     breaks = as.numeric(input$n_fs),
                     xlab = "Duration (minutes)",
                     main = "Geyser eruption duration")
              })
            }
            shinyApp(ui, server)
            '
          ), spsHr(),
          markdown(
            '
            ### Change loader with `addLoader$recreate()`
            For example we have a button below, we can change type, color, method
            and other things of this button.

            You can also use `addLoader$destroy()` to hide + destroy the loader
            '
          ),
          fluidRow(
            column(
              6, br(), br(), br(), br(),
              actionButton(
                ns("btn_change"), "A button", class = "center-block",
                style = "height: 100px; width: 200px"
              )
            ),
            column(
              6,
              selectInput(ns("change_type"), "Change type", c(
                "default", "dual-ring", "facebook", "heart",
                "ring", "roller", "circle", "ellipsis",
                "grid", "hourglass", "ripple", "spinner",
                "gif"
              )),

              selectInput(ns("change_method"), "Change method", c(
                "replace", "inline"
              )),
              selectInput(ns("change_color"), "Change color", c(
                "red", "orange", "yellow", "green", "blue", "indigo", "violet"
              )),
              clearableTextInput(
                ns("src"), label = "Link for your own gif, only used for 'gif' type",
                value = "https://github.com/lz100/spsComps/blob/master/examples/demo/www/bean_eater.gif?raw=true"
              ),
              sliderInput(ns("change_opacity"), label = "change opacity",
                          0, 1, 1, 0.1),
              shinyWidgets::switchInput(
                inputId = ns("destroy"),
                label = "destroyed?",
                onLabel = "Yes",
                offLabel = "No",
                value = FALSE
              )
            )
          ),
          spsCodeBtn(
            ns("code_addLoader_recreate"),
            show_span = TRUE,
            '
            ui <- fluidPage(
              spsDepend("addLoader"), # optional
              fluidRow(
                column(
                  6, br(), br(), br(), br(),
                  actionButton(
                    "btn_change", "A button", class = "center-block",
                    style = "height: 100px; width: 200px"
                  )
                ),
                column(
                  6,
                  selectInput("change_type", "Change type", c(
                    "default", "dual-ring", "facebook", "heart",
                    "ring", "roller", "circle", "ellipsis",
                    "grid", "hourglass", "ripple", "spinner"
                  )),
                  selectInput("change_method", "Change method", c(
                    "replace", "inline"
                  )),
                  selectInput("change_color", "Change color", c(
                    "red", "orange", "yellow", "green", "blue", "indigo", "violet"
                  )),
                  sliderInput("change_opacity", label = "change opacity",
                              0, 1, 1, 0.1),
                  clearableTextInput(
                    "src", label = "Link for your own gif, only used for \'gif\' type",
                    value = "https://github.com/lz100/spsComps/blob/master/examples/demo/www/bean_eater.gif?raw=true"
                  ),
                  shinyWidgets::switchInput(
                    inputId = "destroy",
                    label = "destroyed?",
                    onLabel = "Yes",
                    offLabel = "No",
                    value = FALSE
                  )
                )
              )
            )

            server <- function(input, output, session) {
              loader_change <- addLoader$new("btn_change")
              observe({
                loader_change$
                  recreate(
                    type = input$change_type,
                    src = input$src,
                    method = input$change_method,
                    opacity = input$change_opacity,
                    color = input$change_color
                  )$
                  show()
                shinyWidgets::updateSwitchInput(session, "destroy", value = FALSE)
              })
              observe({
                req(input$destroy)
                loader_change$destroy()
              })

            }

            shinyApp(ui, server)
            '
          )
        )
      )
  )
}

# Server
serverLoader <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # Init loader
      loader_change <- addLoader$new("btn_change")
      observe({
        loader_change$
          recreate(
          type = input$change_type,
          src = input$src,
          method = input$change_method,
          opacity = input$change_opacity,
          color = input$change_color
          )$
          show()
        shinyWidgets::updateSwitchInput(session, "destroy", value = FALSE)
      })
      observe({
        req(input$destroy)
        loader_change$destroy()
      })

      # Init loaders
      loader_replace <- addLoader$new("b_re_start", type = "facebook")
      loader_inline <- addLoader$new("b_in_start", color = "green", method = "inline")
      loader_fs <- addLoader$new(
        "b_fs_start", color = "pink", method = "full_screen",
        bg_color = "#eee", height = "30rem", type = "heart"
      )
      loader_chunk <- addLoader$new(
        "chunk", type = "spinner", color = "orange",
        footer = h5("chunk loader")
      )

      # toggle loaders
      ## replace
      observeEvent(input$b_re_start, {
        loader_replace$show()
      })
      observeEvent(input$b_re_stop, {
        loader_replace$hide()
      })
      ## inline
      observeEvent(input$b_in_start, {
        loader_inline$show()
      })
      observeEvent(input$b_in_stop, {
        loader_inline$hide()
      })
      ## full screen
      observeEvent(input$b_fs_start, {
        loader_fs$show()
        Sys.sleep(2)
        loader_fs$hide()
      })
      ## chunk
      observeEvent(input$chunk_start, {
        loader_chunk$show()
      })
      observeEvent(input$chunk_stop, {
        loader_chunk$hide()
      })

      # create loaders
      p_re <- addLoader$new("p_re", type = "facebook")
      p_fs <- addLoader$new(
        "p_fs", color = "pink", method = "full_screen",
        bg_color = "#eee", height = "30rem", type = "grid",
        footer = h4("Replotting...")
      )
      # use loaders in rednering
      output$p_re <- renderPlot({
        on.exit(p_re$hide())
        p_re$show()
        Sys.sleep(1)
        hist(faithful$eruptions,
             probability = TRUE,
             breaks = as.numeric(input$n_re),
             xlab = "Duration (minutes)",
             main = "Geyser eruption duration")
      })
      output$p_fs <- renderPlot({
        hist(faithful$eruptions,
             probability = TRUE,
             breaks = as.numeric(isolate(input$n_fs)),
             xlab = "Duration (minutes)",
             main = "Geyser eruption duration")
      })
      observeEvent(input$n_fs, ignoreInit = TRUE, {
        output$p_fs <- renderPlot({
          on.exit(p_fs$hide())
          p_fs$show()
          Sys.sleep(1)
          hist(faithful$eruptions,
               probability = TRUE,
               breaks = as.numeric(isolate(input$n_fs)),
               xlab = "Duration (minutes)",
               main = "Geyser eruption duration")
        })
      })

    }
  )
}
