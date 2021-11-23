
# UI
uiServerCol <- function(id) {
  ns <- NS(id)
  fluidRow(
      tabTitle("Shiny server end components"),
      column(
        6,
        box(
          title = "shinyCatch", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              ### Shiny exception handling
              Exception in Shiny apps can crash the app. Most time we don\'t
              want the app to crash but just stop this code block, inform
              users and continue with other code blocks. This
              function is designed to handle these issues.
              - You can choose how the functions catch exceptions and blocks following code
              at `message` (info), `warning` or `error` levels.
              - The blocking power is ranked by levels message > warning > error, meaning
              `message` blocks code at all 3 levels, `warning` blocks warnings and
              errors, and `error` only blocks errors.
              - Blocking level can also by empty. Then even your code has error,
              the app will not crash, the expression just returns `NULL` and continue.
              - If there is an exception, the  exception text will be logged on both server
              end and displayed to users on UI (dual-end logging). Of couse, you
              can choose to mute the user end.

              ')
          ),
          spsHr(),
          h4("Imagine following buttons do some data process and then render some text to users:"),
          tags$label("Error blocks the rest of the code in the same reactive context"), br(),
          actionButton(ns("btn1"),"error and blocking"),
          br(), tags$label("Error happens but code contonues, you should see 'I am not blocked by error' below"), br(),
          actionButton(ns("btn2"),"error no blocking"),
          br(), tags$label("catch warnings and continues, you should see 'warning returns' below"), br(),
          actionButton(ns("btn3"),"warning but still returns value"),
          br(), tags$label("catch warnings but block, you should NOT see 'warning and blocked' below"), br(),
          actionButton(ns("btn4"),"warning but blocking returns"),
          br(), tags$label("catch some message and continue, nothing blocked, you should see 'some message' below"), br(),
          actionButton(ns("btn5"),"message"),
          h4("Here is the final results:"),
          verbatimTextOutput(ns("text")),
          h4("Here is what has been logged on shiny server:"),
          verbatimTextOutput(ns("log")),
          spsCodeBtn(
            ns("code_shinycatch"),
            show_span = TRUE,
            '
            ui <- fluidPage(
              spsDepend("shinyCatch"), # optional
              h4("Run this example on your own computer to better understand exception
                     catch and dual-end logging", class = "text-center"),
              column(
                6,
                actionButton("btn1","error and blocking"),
                actionButton("btn2","error no blocking"),
                actionButton("btn3","warning but still returns value"),
                actionButton("btn4","warning but blocking returns"),
                actionButton("btn5","message"),
              ),
              column(
                6,
                verbatimTextOutput("text")
              )
            )
            server <- function(input, output, session) {
              fn_warning <- function() {
                warning("this is a warning!")
                return("warning returns")
              }
              observeEvent(input$btn1, {
                shinyCatch(stop("error with blocking"), blocking_level = "error")
                output$text <- renderPrint("You shouldn\'t see me")
              })
              observeEvent(input$btn2, {
                shinyCatch(stop("error without blocking"))
                output$text <- renderPrint("I am not blocked by error")
              })
              observeEvent(input$btn3, {
                return_value <- shinyCatch(fn_warning())
                output$text <- renderPrint("warning and blocked")
              })
              observeEvent(input$btn4, {
                return_value <- shinyCatch(fn_warning(), blocking_level = "warning")
                print(return_value)
                output$text <- renderPrint("other things")
              })
              observeEvent(input$btn5, {
                shinyCatch(message("some message"))
                output$text <- renderPrint("some message")
              })
            }
            shinyApp(ui, server)
            '
          )
        ),
        box(
          title = "shinyCheckPkg", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              A server end function to check package namespace for some required
              packages of users\' environment. If all packages are installed,
              a successful message will be displayed on the bottom-right.
              If not, pop up a message box in shiny to tell users how to install
              the missing packages.
              ')
          ),
          tags$label('Check if package "pkg1", "pkg2", "bioxxx",
                    github package "user1/pkg1" are installed'), br(),
          actionButton(ns("check_random_pkg"), "check random_pkg"),
          br(), spsHr(),
          tags$label('We can combine `spsValidate` to block server code to prevent
                     crash if some packages are not installed.'), br(),
          tags$label('If "shiny" is installed, make a plot of 1.'), br(),
          actionButton(ns("check_shiny"), "check shiny"), br(),
          tags$label('If "ggplot99" is installed, make a plot of 99.'), br(),
          actionButton(ns("check_gg99"), "check ggplot99"), br(),
          plotOutput(ns("plot_pkg")),
          spsCodeBtn(
            ns("code_shinycheckpkg"),
            show_span = TRUE,
            '
            library(shiny)

            ui <- fluidPage(
              tags$label(\'Check if package "pkg1", "pkg2", "bioxxx",
            github package "user1/pkg1" are installed\'), br(),
              actionButton("check_random_pkg", "check random_pkg"),
              br(), spsHr(),
              tags$label(\'We can combine `spsValidate` to block server code to prevent
            crash if some packages are not installed.\'), br(),
              tags$label(\'If "shiny" is installed, make a plot.\'), br(),
              actionButton("check_shiny", "check shiny"), br(),
              tags$label(\'If "ggplot99" is installed, make a plot.\'), br(),
              actionButton("check_gg99", "check ggplot99"), br(),
              plotOutput("plot_pkg")
            )

            server <- function(input, output, session) {
              observeEvent(input$check_random_pkg, {
                shinyCheckPkg(session, cran_pkg = c("pkg1", "pkg2"), bioc_pkg = "bioxxx", github = "user1/pkg1")
              })
              observeEvent(input$check_shiny, {
                spsValidate(verbose = FALSE, {
                  if(!shinyCheckPkg(session, cran_pkg = c("shiny"))) stop("Install packages")
                })
                output$plot_pkg <- renderPlot(plot(1))
              })
              observeEvent(input$check_gg99, {
                spsValidate({
                  if(!shinyCheckPkg(session, cran_pkg = c("ggplot99"))) stop("Install packages")
                })
                output$plot_pkg <- renderPlot(plot(99))
              })
            }

            shinyApp(ui, server)
            '
          )
        )
      ),
      column(
        6,
        box(
          title = "spsValidate", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            In shiny apps, users often have the option to upload the data to server
            and  the app do some data process. The random uploaded data needs to be
            validated. This function provides the ability to help developers validate
            the input or any kind of expression. This function is similar to `shiny::validate`,
            but has better UI display and adds console logging.

            - `verbose`: If you turn on this option, users will be informed with a
            success message if validation passed. Otherwise, mute the success message,
            but any `message`, `warning` and `error` will still be caught and `error` will
            result the validation to fail.
            ')
          ),
          spsHr(),
          column(
            6,
            h3("click below to make the plot"),
            p("this button will succeed, verbose on"),
            actionButton(ns("vd1"), "make plot 1"),
            plotOutput(ns("p1"), height = "300px")
          ),
          column(
            6,
            h3("click below to make the plot"),
            p("this button will succeed, verbose off"),
            actionButton(ns("vd2"), "make plot 2"),
            plotOutput(ns("p2"), height = "300px")
          ),
          column(
            6,
            h3("click below to make the plot"),
            p("this button will fail, no plot will be made"),
            actionButton(ns("vd3"), "make plot 3"),
            plotOutput(ns("p3"), height = "200px")
          ),
          column(
            6,
            h3("click below to make the plot"),
            p("this button will fail, but the message is hidden from users"),
            actionButton(ns("vd4"), "make plot 4"),
            plotOutput(ns("p4"), height = "200px")
          ),
          spsCodeBtn(
            ns("code_"),
            show_span = TRUE,
            '
            ui <- fluidPage(
                spsDepend("spsValidate"), # optional
                column(
                    4,
                    h3("click below to make the plot"),
                    p("this button will succeed, verbose on"),
                    actionButton("vd1", "make plot 1"),
                    plotOutput("p1")
                ),
                column(
                    4,
                    h3("click below to make the plot"),
                    p("this button will succeed, verbose off"),
                    actionButton("vd2", "make plot 2"),
                    plotOutput("p2")
                ),
                column(
                    4,
                    h3("click below to make the plot"),
                    p("this button will fail, no plot will be made"),
                    actionButton("vd3", "make plot 3"),
                    plotOutput("p3")
                ),
                column(
                    4,
                    h3("click below to make the plot"),
                    p("this button will fail, but the message is hidden from users"),
                    actionButton("vd4", "make plot 4"),
                    plotOutput("p4")
                )
            )
            server <- function(input, output, session) {
                mydata <- datasets::iris
                observeEvent(input$vd1, {
                    spsUtil::spsOption("verbose", TRUE) # use global sps verbose setting
                    spsValidate({
                        is.data.frame(mydata)
                    }, vd_name = "Is dataframe")
                    output$p1 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
                })
                observeEvent(input$vd2, {
                    spsValidate({
                        is.data.frame(mydata)
                    },
                    vd_name = "Is dataframe",
                    verbose = FALSE) # use in-function verbose setting
                    output$p2 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
                })
                observeEvent(input$vd3, {
                    spsValidate({
                        is.data.frame(mydata)
                        if(nrow(mydata) <= 200) stop("Input needs more than 200 rows")
                    })
                    print("other things blocked")
                    output$p3 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
                })
                observeEvent(input$vd4, {
                    spsValidate({
                        is.data.frame(mydata)
                        if(nrow(mydata) <= 200) stop("Input needs more than 200 rows")
                    }, shiny = FALSE)
                    print("other things blocked")
                    output$p4 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
                })
            }
            shinyApp(ui, server)
            '
          )
        ),
        box(
          title = "Reactive numeric inline-operation", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              `incRv`, `multRv`, `diviRv` enables you to use numeric inline-operation that
              can be done in other programming languages, like `i += 1`, `i *= 1`, `i /= 1` on
              `reactiveVal` objects.

              If you want apply this operation on `reactiveValues` or normal R objects,
              check the similar operations `inc`, `mult` and `divi`
              in [spsUtil{blk}](https://systempipe.org/sps/funcs/spsutil/reference/)
              package.
              ')
          ),
          spsHr(),
          tags$label("Increase/Decrease by 1"), br(),
          textOutput(ns("rv")),
          actionButton(ns("inc"), "Increase"),
          actionButton(ns("des"), "Decrease"), br(),
          spsCodeBtn(
            ns("code_incrv"),
            show_span = TRUE,
            '
            library(shiny)
            ui <- fluidPage(
              textOutput("text"),
              actionButton("b", "increase by 1"),
              actionButton("c", "decrease by 1")
            )
            server <- function(input, output, session) {
              rv <- reactiveVal(0)
              observeEvent(input$b, incRv(rv))
              observeEvent(input$c, incRv(rv, -1))
              output$text <- renderText({
                paste("current value is", rv())
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
serverServerCol <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ## shinCatch server ----
      fn_warning <- function() {
        warning("this is a warning!")
        return("warning returns")
      }
      capLog <- function(expr){
        capture.output(try(expr))[1]
      }
      mylog <- reactiveVal(NULL)
      output$log <- renderPrint(cat(mylog()))
      output$text <- renderPrint("")
      observeEvent(input$btn1, {
        output$text <- renderPrint(cat(""))
        mylog(capLog(shinyCatch(stop("error with blocking"), blocking_level = "error")))
        shinyCatch(stop("error with blocking"), blocking_level = "error")
        output$text <- renderPrint("You shouldn't see me")
      })
      observeEvent(input$btn2, {
        output$text <- renderPrint(cat(""))
        mylog(capLog(shinyCatch(stop("error without blocking"), blocking_level = "error")))
        shinyCatch(stop("error without blocking"))
        output$text <- renderPrint("I am not blocked by error")
      })
      observeEvent(input$btn3, {
        output$text <- renderPrint(cat(""))
        return_value <- shinyCatch(fn_warning())
        mylog(capLog(shinyCatch(fn_warning())))
        output$text <- renderPrint("warning and blocked")
      })
      observeEvent(input$btn4, {
        output$text <- renderPrint(cat(""))
        mylog(capLog(shinyCatch(fn_warning(), blocking_level = "warning")))
        return_value <- shinyCatch(fn_warning(), blocking_level = "warning")
        print(return_value)
        output$text <- renderPrint("other things")
      })
      observeEvent(input$btn5, {
        output$text <- renderPrint(cat(""))
        mylog(capLog(shinyCatch(message("some message"))))
        shinyCatch(message("some message"))
        output$text <- renderPrint("some message")
      })

      ## spsValidate server ----
      mydata <- datasets::iris
      observeEvent(input$vd1, {
        spsUtil::spsOption("verbose", TRUE) # use global sps verbose setting
        spsValidate({
          is.data.frame(mydata)
        }, vd_name = "Is dataframe")
        output$p1 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
      })
      observeEvent(input$vd2, {
        spsValidate({
          is.data.frame(mydata)
        },
        vd_name = "Is dataframe",
        verbose = FALSE) # use in-function verbose setting
        output$p2 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
      })
      observeEvent(input$vd3, {
        spsValidate({
          is.data.frame(mydata)
          if(nrow(mydata) <= 200) stop("Input needs more than 200 rows")
        })
        print("other things blocked")
        output$p3 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
      })
      observeEvent(input$vd4, {
        spsValidate({
          is.data.frame(mydata)
          if(nrow(mydata) <= 200) stop("Input needs more than 200 rows")
        }, shiny = FALSE)
        print("other things blocked")
        output$p4 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
      })

      ## check pkg ----
      observeEvent(input$check_random_pkg, {
        shinyCheckPkg(session, cran_pkg = c("pkg1", "pkg2"), bioc_pkg = "bioxxx", github = "user1/pkg1")
      })
      observeEvent(input$check_shiny, {
        spsValidate(verbose = FALSE, {
          if(!shinyCheckPkg(session, cran_pkg = c("shiny"))) stop("Install packages")
        })
        output$plot_pkg <- renderPlot(plot(1))
      })
      observeEvent(input$check_gg99, {
        spsValidate({
          if(!shinyCheckPkg(session, cran_pkg = c("ggplot99"))) stop("Install packages")
        })
        output$plot_pkg <- renderPlot(plot(99))
      })

      ## inc ----
      rv <- reactiveVal(0)
      observeEvent(input$inc, incRv(rv))
      observeEvent(input$des, incRv(rv, -1))
      output$rv <- renderPrint({
        paste("current value is", rv())
      })
    }
  )
}
