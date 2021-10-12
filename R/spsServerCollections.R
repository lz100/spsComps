################## A Collections of server utilities############################
# Can be used in other shiny projects, no need to use under SPS framework
## use on top of shiny


#' Shiny exception handling
#' @description Exception in Shiny apps can crash the app. Most time we don't
#' want the app to crash but just stop this code block, inform users and continue
#' with other code blocks. This function is designed to handle these issues.
#' @details
#'
#' #### Blocking
#' - The blocking works
#' similar to shiny's [shiny::req()] and [shiny::validate()].
#' If anything inside fails, it will
#' block the rest of the code in your reactive expression domain.
#' - It will show error, warning, message by a toastr bar on client end and
#' also log the text on server console depending on the `blocking_level`
#' (dual-end logging).
#' - If blocks at `error` level, function will be stopped and other code in the same
#' reactive context will be blocked.
#' - If blocks at `warning` level, warning and
#' error will be blocked.
#' - `message` level blocks all 3 levels.
#' - If `blocking_level` is other than these 3, no exceptions will be block, and
#' if there is any error, `NULL` will return and following code will continue to
#' run.
#'
#' #### To use it
#' Since spsComps 0.3.1 to have the message displayed on shiny UI, you don't need
#' to attach the dependencies manually by adding `spsDepend("shinyCatch")` or
#' `spsDepend("toastr")` (old name) on UI. This becomes optional, only in the case
#' that automatic attachment is not working.
#' #### Display
#'
#' Messages will be displayed for 3 seconds, and 5s for warnings. Errors will never
#' go away on UI unless users' mouse hover on the bar or manually click it.
#'
#' #### environment
#' `shinyCatch` uses the same environment as where it is called, it means if you
#' assign a variable inside the expression, you can still get it from outside the
#' `shinyCatch`, see examples.
#' @param expr expression
#' @param position client side message bar position, one of:
#' c("top-right", "top-center", "top-left","top-full-width", "bottom-right",
#' "bottom-center", "bottom-left","bottom-full-width").
#' @param blocking_level  what level you want to block the execution, one
#' of "error", "warning", "message", default is "none", do not block following
#' code execution.
#' @param shiny bool, only show message on console log but not in Shiny app
#' when it is `FALSE`. Useful if you want to keep the exception only to the server
#' and hide from your users. You do not need to set it to `FALSE` when purely work
#' outside shiny, it will automatically detect if you are working in a Shiny
#' environment or not.
#' @param trace_back bool, added since spsComps 0.2, if the expression is blocked
#' or has errors, cat the full trace back? It will display called functions
#' and code source file and line number if possible. Default follows the
#' SPS `spsOption("traceback")` setting. You can set it by running `spsOption("traceback", TRUE)`.
#' If you do not set it, it will be `FALSE`. or you can just manually set it
#' for each individual `shinyCatch` call `shinyCatch({...}, trace_back = TRUE)`.
#' @param prefix character, what prefix to display on console for the log, e.g.
#' for error, the default will be displayed as "SPS-ERROR". You can make your own
#' prefix, like `prefix = "MY"`, then, it will be "MY-ERROR". Use `""` if you do not
#' want any prefix, like `prefix = ""`, then, it will just be "ERROR".
#' multiple levels
#' @return see description and details
#' @importFrom shinytoastr toastr_info toastr_warning toastr_error
#' @export
#'
#' @examples
#' if(interactive()){
#'   ui <- fluidPage(
#'     spsDepend("shinyCatch"), # optional
#'     h4("Run this example on your own computer to better understand exception
#'            catch and dual-end logging", class = "text-center"),
#'     column(
#'       6,
#'       actionButton("btn1","error and blocking"),
#'       actionButton("btn2","error no blocking"),
#'       actionButton("btn3","warning but still returns value"),
#'       actionButton("btn4","warning but blocking returns"),
#'       actionButton("btn5","message"),
#'     ),
#'     column(
#'       6,
#'       verbatimTextOutput("text")
#'     )
#'   )
#'   server <- function(input, output, session) {
#'     fn_warning <- function() {
#'       warning("this is a warning!")
#'       return("warning returns")
#'     }
#'     observeEvent(input$btn1, {
#'       shinyCatch(stop("error with blocking"), blocking_level = "error")
#'       output$text <- renderPrint("You shouldn't see me")
#'     })
#'     observeEvent(input$btn2, {
#'       shinyCatch(stop("error without blocking"))
#'       output$text <- renderPrint("I am not blocked by error")
#'     })
#'     observeEvent(input$btn3, {
#'       return_value <- shinyCatch(fn_warning())
#'       output$text <- renderPrint("warning and blocked")
#'     })
#'     observeEvent(input$btn4, {
#'       return_value <- shinyCatch(fn_warning(), blocking_level = "warning")
#'       print(return_value)
#'       output$text <- renderPrint("other things")
#'     })
#'     observeEvent(input$btn5, {
#'       shinyCatch(message("some message"))
#'       output$text <- renderPrint("some message")
#'     })
#'   }
#'   shinyApp(ui, server)
#' }
#' # outside shiny examples
#' shinyCatch(message("this message"))
#' try({shinyCatch(stop("this error")); "no block"}, silent = TRUE)
#' try({shinyCatch(stop("this error"), blocking_level = "error"); "blocked"}, silent = TRUE)
#' # get variable from outside
#' shinyCatch({my_val <- 123})
#' my_val
shinyCatch <- function(
  expr,
  position = "bottom-right",
  blocking_level = "none",
  shiny = TRUE,
  prefix = "SPS",
  trace_back = spsOption("traceback")
) {

  assert_that(is.logical(shiny))
  assert_that(all(is.character(prefix), length(prefix) == 1))
  prefix <- paste0(prefix, if (prefix == "") " " else "-")
  shiny <- all(!is.null(getDefaultReactiveDomain()), shiny)
  if(shiny) dependServer("toastr")
  toastr_actions <- list(
    message = function(m) {
      msg(m$message, paste0(prefix, "INFO"), "blue")
      if(shiny) shinytoastr::toastr_info(message = remove_ANSI(m$message),
                                         position = position, closeButton = TRUE,
                                         timeOut = 3000, preventDuplicates = TRUE)
    },
    warning = function(m) {
      msg(m$message, paste0(prefix, "WARNING"), "orange")
      if(shiny) shinytoastr::toastr_warning(
        message = remove_ANSI(m$message),
        position = position, closeButton = TRUE,
        timeOut = 5000, preventDuplicates = TRUE)
    },
    error = function(m) {
      msg(m$message, paste0(prefix, "ERROR"), "red")
      if(shiny) shinytoastr::toastr_error(
        message = remove_ANSI(m$message), position = position,
        closeButton = TRUE, timeOut = 0, preventDuplicates = TRUE,
        title = "There is an error", hideDuration = 300)
    }
  )

  switch(tolower(blocking_level),
         "error" = tryCatch(
           suppressMessages(suppressWarnings(withCallingHandlers(
             expr,
             message = function(m) toastr_actions$message(m),
             warning = function(m) toastr_actions$warning(m),
             error = function(m) if(trace_back) printTraceback(sys.calls())
           ))),
           error = function(m) {
             toastr_actions$error(m)
             reactiveStop(class = "validation")
           }),
         "warning" = tryCatch(
           suppressMessages(withCallingHandlers(
             expr,
             message = function(m) toastr_actions$message(m),
             error = function(m) if(trace_back) printTraceback(sys.calls())
           )),
           warning = function(m) {
             toastr_actions$warning(m)
             reactiveStop(class = "validation")
           },
           error = function(m) {
             if(!is.empty(m$message)) toastr_actions$error(m)
             reactiveStop(class = "validation")
           }),
         "message" = tryCatch(
           withCallingHandlers(
             expr,
             error = function(m) if(trace_back) printTraceback(sys.calls())
           ),
           message = function(m) {
             toastr_actions$message(m)
             reactiveStop(class = "validation")
           },
           warning = function(m) {
             toastr_actions$warning(m)
             reactiveStop(class = "validation")
           },
           error = function(m) {
             if(!is.empty(m$message)) toastr_actions$error(m)
             reactiveStop(class = "validation")
           }),
         tryCatch(
           suppressMessages(suppressWarnings(withCallingHandlers(
             expr,
             message = function(m) toastr_actions$message(m),
             warning = function(m) toastr_actions$warning(m),
             error = function(m) if(trace_back) printTraceback(sys.calls())
           ))),
           error = function(m) {
             toastr_actions$error(m)
             return(NULL)
           }
         )
  )
}

# print error trace back
printTraceback <- function(calls){
  calls <- calls[-length(calls): (-length(calls) + 2)]
  trace_files <- findTraceFile(calls)
  paste0(
    crayon::green$bold(seq_along(calls)), ". ",
    as.character(calls), " ",
    crayon::blue$bold(trace_files)
  ) %>% cat(sep = "\n")
}

# find errors trace back file and line
findTraceFile <- function(calls) {
  lapply(calls, function(ca) {
    if (!is.null(srcref <- attr(ca, "srcref"))) {
      srcfile <- attr(srcref, "srcfile")
      glue('{srcfile$filename}#{srcref[1]}')
    } else ""
  })
}



#' Validate expressions
#' @description this function is used on server side to usually validate input
#' dataframe or some expression. The usage is similar to [shiny::validate] but is
#' not limited to shiny render functions and
#' provides better user notification and server-end logging (dual-end logging).
#'
#' @param expr the expression to validate data or other things. Use
#' `stop("your message")` or generate some errors inside to fail the validation.
#' If there is no error, it will return `TRUE` and display `pass_msg` on both
#' console and shiny app if `verbose = TRUE` or global SPS option verbose is `TRUE`.
#'
#' If the expression fails, it will block the code following this function within
#' the same reactive domain to continue, similar to [shinyCatch()].
#'
#' @param vd_name validate title
#' @param pass_msg string, if pass, what message do you want to show
#' @param shiny bool, show message on console but hide from users?
#' see [shinyCatch()] for more details
#' @param verbose bool, show pass message? Default follows global verbose
#' setting, use [spsUtil::spsOption] to set up the value `spsOption("verbose, TRUE")`
#' to turn on and `spsOption("verbose, FALSE")` to turn off and `spsOption("verbose")`
#' to check current setting, see examples.
#' @param prefix see `prefix` in [shinyCatch()]
#' @return If expression fails, block the code following this validation function
#' and no final return, else `TRUE`.
#' @export
#' @details
#' - Since spsComps 0.3.1 to have the message displayed on shiny UI, you don't need
#' to attach the dependencies manually by adding `spsDepend("spsValidate")` or
#' `spsDepend("toastr")` (old name) on UI. This becomes optional, only in the case
#' that automatic attachment is not working.
#' @examples
#' if(interactive()){
#'     ui <- fluidPage(
#'         spsDepend("spsValidate"), # optional
#'         column(
#'             4,
#'             h3("click below to make the plot"),
#'             p("this button will succeed, verbose on"),
#'             actionButton("vd1", "make plot 1"),
#'             plotOutput("p1")
#'         ),
#'         column(
#'             4,
#'             h3("click below to make the plot"),
#'             p("this button will succeed, verbose off"),
#'             actionButton("vd2", "make plot 2"),
#'             plotOutput("p2")
#'         ),
#'         column(
#'             4,
#'             h3("click below to make the plot"),
#'             p("this button will fail, no plot will be made"),
#'             actionButton("vd3", "make plot 3"),
#'             plotOutput("p3")
#'         ),
#'         column(
#'             4,
#'             h3("click below to make the plot"),
#'             p("this button will fail, but the message is hidden from users"),
#'             actionButton("vd4", "make plot 4"),
#'             plotOutput("p4")
#'         )
#'     )
#'     server <- function(input, output, session) {
#'         mydata <- datasets::iris
#'         observeEvent(input$vd1, {
#'             spsOption("verbose", TRUE) # use global sps verbose setting
#'             spsValidate({
#'                 is.data.frame(mydata)
#'             }, vd_name = "Is dataframe")
#'             output$p1 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
#'         })
#'         observeEvent(input$vd2, {
#'             spsValidate({
#'                 is.data.frame(mydata)
#'             },
#'             vd_name = "Is dataframe",
#'             verbose = FALSE) # use in-function verbose setting
#'             output$p2 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
#'         })
#'         observeEvent(input$vd3, {
#'             spsValidate({
#'                 is.data.frame(mydata)
#'                 if(nrow(mydata) <= 200) stop("Input needs more than 200 rows")
#'             })
#'             print("other things blocked")
#'             output$p3 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
#'         })
#'         observeEvent(input$vd4, {
#'             spsValidate({
#'                 is.data.frame(mydata)
#'                 if(nrow(mydata) <= 200) stop("Input needs more than 200 rows")
#'             }, shiny = FALSE)
#'             print("other things blocked")
#'             output$p4 <- renderPlot(plot(iris$Sepal.Length, iris$Sepal.Width))
#'         })
#'     }
#'     shinyApp(ui, server)
#' }
#' # outside shiny example
#' mydata2 <- list(a = 1, b = 2)
#' spsValidate({(mydata2)}, "Not empty")
#' try(spsValidate(stopifnot(is.data.frame(mydata2)), "is dataframe?"), silent = TRUE)
spsValidate <- function(
    expr,
    vd_name="my validation",
    pass_msg = glue("validation: '{vd_name}' passed"),
    shiny = TRUE,
    verbose = spsOption('verbose'),
    prefix = ""
){
    shiny <- all(!is.null(getDefaultReactiveDomain()), shiny)
    shinyCatch(
        expr,
        blocking_level = "error",
        shiny = shiny,
        prefix = prefix
    )

    if(emptyIsFalse(verbose)){
      msg(pass_msg, paste0(prefix, "INFO"), "blue")
      if(shiny){
        shinytoastr::toastr_success(
          pass_msg, position = "bottom-right", timeOut = 3000)
      }
    }
    return(TRUE)
}


#' Shiny package checker
#' @description  A server end function to check package namespace for some required
#' packages of users' environment. If all packages are installed, a successful message
#' will be displayed on the bottom-right. If not, pop up
#' a message box in shiny to tell users how to install the missing packages.
#'
#' This is useful when some of packages are required by a shiny app. Before
#' running into that part of code, using this function to check the required
#' pakcage and pop up warnings will prevent app to crash.
#' @param session shiny session
#' @param cran_pkg a vector of package names
#' @param bioc_pkg a vector of package names
#' @param github a vector of github packages, github package must use the format of
#'  "github user name/ repository name", eg. c("user1/pkg1", "user2/pkg2")
#' @param quietly bool, should warning messages be suppressed?
#' @importFrom shinyAce is.empty
#' @importFrom shinytoastr toastr_success
#' @return TRUE if pass, sweet alert massage and FALSE if fail
#' @export
#'
#' @examples
#' if(interactive()){
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     tags$label('Check if package "pkg1", "pkg2", "bioxxx",
#'                     github package "user1/pkg1" are installed'), br(),
#'     actionButton("check_random_pkg", "check random_pkg"),
#'     br(), spsHr(),
#'     tags$label('We can combine `spsValidate` to block server code to prevent
#'                      crash if some packages are not installed.'), br(),
#'     tags$label('If "shiny" is installed, make a plot.'), br(),
#'     actionButton("check_shiny", "check shiny"), br(),
#'     tags$label('If "ggplot99" is installed, make a plot.'), br(),
#'     actionButton("check_gg99", "check ggplot99"), br(),
#'     plotOutput("plot_pkg")
#'   )
#'
#'   server <- function(input, output, session) {
#'     observeEvent(input$check_random_pkg, {
#'       shinyCheckPkg(session, cran_pkg = c("pkg1", "pkg2"),
#'                     bioc_pkg = "bioxxx", github = "user1/pkg1")
#'     })
#'     observeEvent(input$check_shiny, {
#'       spsValidate(verbose = FALSE, {
#'         if(!shinyCheckPkg(session, cran_pkg = c("shiny"))) stop("Install packages")
#'       })
#'       output$plot_pkg <- renderPlot(plot(1))
#'     })
#'     observeEvent(input$check_gg99, {
#'       spsValidate({
#'         if(!shinyCheckPkg(session, cran_pkg = c("ggplot99"))) stop("Install packages")
#'       })
#'       output$plot_pkg <- renderPlot(plot(99))
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#' }
shinyCheckPkg <-function(
    session,
    cran_pkg = NULL,
    bioc_pkg = NULL,
    github = NULL,
    quietly = FALSE
    ) {

    missing_cran <- checkNameSpace(cran_pkg, quietly, from = "CRAN")
    missing_bioc <- checkNameSpace(bioc_pkg, quietly, from = "BioC")
    github_pkg <- github %>% str_remove("^.*/")
    missing_github_pkg <- checkNameSpace(github_pkg, quietly, from = "GitHub")
    missing_github <- github[github_pkg %in% missing_github_pkg]
    cran_cmd <- if (shinyAce::is.empty(missing_cran)) "" else
        paste0("install.packages(c('", paste0(missing_cran, collapse = "', '"), "'))")
    bioc_cmd <- if (shinyAce::is.empty(missing_bioc)) "" else
        paste0(
            'if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")\n',
            "BiocManager::install(c('", paste0(missing_bioc, collapse = "', '"), "'))"
        )
    github_cmd <- if (shinyAce::is.empty(missing_github)) "" else
        paste0(
            'if (!requireNamespace("remotes", quietly=TRUE))
                install.packages("remotes")\n',
            "remotes::install(c('", paste0(missing_github, collapse = "', '"), "'))"
        )

    if (length(missing_cran) + length(missing_bioc) + length(missing_github) > 0) {
      dependServer("sweetalert2")
      alert <- list(
        type = "error",
        title = "Please install packages",
        body = htmltools::doRenderTags(tags$div(
          style =
          "
          background-color: #FA5858;
          text-align: left;
          overflow: auto;
          white-space: pre;
          color: black;
          margin: 0 -30px;
          ",
        p(cran_cmd),
        p(bioc_cmd),
        p(github_cmd)
        ))
      )
      session$sendCustomMessage("sps-checkpkg", message = alert)
      return(FALSE)
    } else {
      dependServer("toastr")
      shinytoastr::toastr_success(
        message = "You have all required packages for this tab",
        position = "bottom-right")
      return(TRUE)
    }
}

checkNameSpace <- function(packages, quietly = FALSE, from = "CRAN") {
  if (!emptyIsFalse(packages)) return(NULL)
  pkg_ls <- installed.packages()[, 1]
  missing_pkgs <- packages[!packages %in% pkg_ls]
  if (!quietly & assertthat::not_empty(missing_pkgs)) {
    msg(glue("These packages are missing from ",
             "{from}: {glue_collapse(missing_pkgs, sep = ',')}"), "warning")
  }
  return(missing_pkgs)
}



#' In-line numeric operation for reactiveVal
#' @description In-place operations like `i += 1`, `i -= 1` is not support in
#' R. These functions implement these operations in R. This set of functions will
#' apply this kind of operations on `[shiny::reactiveVal]` objects.
#' @param react reactiveVal object, when it is called, should return an numeric object
#' @param value the numeric value to do the operation on `react`
#' @seealso If you want [shiny::reactiveValues]  version of these operators or just
#' normal numeric objects, use [spsUtil::inc], [spsUtil::mult], and [spsUtil::divi].
#' @return No return, will directly change the reactiveVal object provided to the
#' `react` argument
#' @details
#' `incRv(i)` is the same as `i <- i + 1`.
#' `incRv(i, -1)` is the same as `i <- i - 1`.
#' `multRv(i)` is the same as `i <- i * 2`.
#' `diviRv(i)` is the same as `i <- i / 2`.
#' @export
#'
#' @examples
#' reactiveConsole(TRUE)
#' rv <- reactiveVal(0)
#' incRv(rv) # add 1
#' rv()
#' incRv(rv) # add 1
#' rv()
#' incRv(rv, -1) # minus 1
#' rv()
#' incRv(rv, -1) # minus 1
#' rv()
#' rv2 <- reactiveVal(1)
#' multRv(rv2) # times 2
#' rv2()
#' multRv(rv2) # times 2
#' rv2()
#' diviRv(rv2) # divide 2
#' rv2()
#' diviRv(rv2) # divide 2
#' rv2()
#' reactiveConsole(FALSE)
#' # Real shiny example
#' if(interactive()){
#'   ui <- fluidPage(
#'     textOutput("text"),
#'     actionButton("b", "increase by 1")
#'   )
#'   server <- function(input, output, session) {
#'     rv <- reactiveVal(0)
#'     observeEvent(input$b, {
#'       incRv(rv)
#'     })
#'     output$text <- renderText({
#'       rv()
#'     })
#'   }
#'   shinyApp(ui, server)
#' }
incRv <- function(react, value = 1) {
  if(!inherits(react, "reactiveVal")) stop("react must be a 'reactiveVal' object")
  if(!is.numeric(value)) stop("value must be numeric")
  react(isolate(react()) + value)
}

#' @export
#' @rdname incRv
multRv <-  function(react, value = 2) {
  if(!inherits(react, "reactiveVal")) stop("react must be a 'reactiveVal' object")
  if(!is.numeric(value)) stop("value must be numeric")
  react(isolate(react()) * value)
}


#' @export
#' @rdname incRv
diviRv <-  function(react, value = 2) {
  if(!inherits(react, "reactiveVal")) stop("react must be a 'reactiveVal' object")
  if(!is.numeric(value)) stop("value must be numeric")
  react(isolate(react()) / value)
}


onNextInput <- function(expr, session = getDefaultReactiveDomain()) {
  observeEvent(once = TRUE, reactiveValuesToList(session$input), {
    force(expr)
  }, ignoreInit = TRUE)
}


