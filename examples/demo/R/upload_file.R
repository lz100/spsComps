
# UI
uiUploadFile <- function(id) {
  ns <- NS(id)
  spsOption("mode", "local")
  local_ui <- dynamicFile(ns("local_file"), "local")
  spsOption("mode", "server")
  server_ui <- dynamicFile(ns("server_file"), "server")
  fluidRow(
      tabTitle("Upload components"),
      column(
        6,
        box(
          title = "dynamicFile & dynamicFileServer", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
              '
              ### about the component
              Depending on the SPS option of "mode" you choose, it will render different UI.
              This is especially convenient if you have different deploy environment, like
              local computer and <https://shinyapps.io>. To change file upload
              strategy, you **do NOT need to rewrite the code**, you only need to
              change the global SPS "mode" setting from `local` to `server`.

              ### modes
              1. `local` mode will not copy file, directly use a path pointer, good
              for large files. So you can directly choose file from the server-end file system.
              It is recommended to use if run the app on your own computer (user-end,
              server-end are both your current computer). Use this mode on deploy environment
              like <https://shinyapps.io> will allow users to reach part of file system on the
              server (not recommended).
              2. `server` mode upload file over web interface and store in temp. User
              do not have access to your server file system, but if you run the app
              on your own computer, server and user are on the same computer. This
              will cause a redundant copy of the target file. Secure, but slow and
              not friendly for large files.

              ### other tips
              - `dynamicFile` is used on UI.
              - `dynamicFileServer` is used on server to get the uploaded file path.

              A demo file called "dynamicFile_demoxxxxx.txt" has created for you to choose
              under `local` components.
              ')
          ),
          fluidRow(
            column(
              6,
              local_ui,
              tags$span("file path pointer on server:"),
              verbatimTextOutput(ns("local_out"))
            ),
            column(
              6,
              server_ui,
              tags$span("file path pointer on server:"),
              verbatimTextOutput(ns("server_out"))
            )
          ),
          spsCodeBtn(
            ns("code_dynamicfile"),
            show_span = TRUE,
            '
            # To demostrate different modes in the same app, we set options before the function.
            # This is NOT recommended, you should stick with only one mode for the entire app.
            spsOption("mode", "local")
            local_ui <- dynamicFile("local_file", "local")
            spsOption("mode", "server")
            server_ui <- dynamicFile("server_file", "server")

            ui <- fluidPage(
                column(
                    6,
                    local_ui,
                    verbatimTextOutput("local_out")
                ),
                column(
                    6,
                    server_ui,
                    verbatimTextOutput("server_out")
                )
            )

            server <- function(input,output,session){
                spsOption("mode", "local")
                file_local <- dynamicFileServer(input,session, id = "local_file")
                output$local_out <- renderPrint({
                    file_local() # remember to use `()` for reactive value
                })
                spsOption("mode", "server")
                file_server <- dynamicFileServer(input,session, id = "server_file")
                output$server_out <- renderPrint({
                    file_server()
                })
            }
            shinyApp(ui = ui, server = server)
            '
          )
        )
      ),
      column(
        6,
        box(
          title = "loadDF", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            For a Shiny app, we often want to display some example data and then allow
            users to upload their own data. This component can help developers
            display the example dataset and switch to the uploaded data which a
            toggle button or other events.

            - This is a server end function which helps you to load the **tabular file** content
            from example or user uploads into R.

            - This function is often combine with the `dynamicFile` component
            so we put it here instead of the *Server Components* tab.

            - It is "crash-free". Unlike normal `read.xxx` R functions which
            return errors if the file cannot be parse and often this will crash
            the Shiny app, this function will report the error to user and log it
            on server, then block the rest of the code in the same reactive context
            continues. Similar to the `shinyCatch` components (see Server Components tab),
            but a special variant to handle files.

            - When there is no example or upload file provided, it returns a 8x8 empty
            tibble, so the table can still be display by function like `renderDataTable`.
            ')
          ),
          spsDepend("toastr"),
          shinyWidgets::radioGroupButtons(
            inputId = ns("data_source"), label = "Choose your data file source:",
            selected = "eg",
            choiceNames = c("Upload", "Example"),
            choiceValues = c("upload", "eg")
          ),
          dynamicFile(
            ns("data_path"), label = "input file",
            title = "Change the source to upload and choose a csv file and then a random file that
            cannot be read to tibbles, like a jpg or png."),
          dataTableOutput(ns("df")),
          spsCodeBtn(
            ns("code_"),
            show_span = TRUE,
            '

            '
          )
        )
      )
  )
}

# Server
serverUploadFile <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ## dynamicFileServer ----
      spsOption("mode", "local")
      demo_file <- tempfile(pattern = "dynamicFile_demo", fileext = ".txt")
      cat("some random txt", file = demo_file)
      file_local <- dynamicFileServer(input, session, id = "local_file", roots = c(temp=tempdir()))
      output$local_out <- renderPrint({
        file_local() # remember to use `()` for reactive value
      })
      spsOption("mode", "server")
      file_server <- dynamicFileServer(input, session, id = "server_file")
      output$server_out <- renderPrint({
        file_server()
      })

      ## loadDF ----
      tmp_file <- tempfile(fileext = ".csv")
      write.csv(iris[1:5,], file = tmp_file)
      upload_path <- dynamicFileServer(input, session, "data_path")
      data_df <- reactive({
        loadDF(choice = input$data_source,
               upload_path = upload_path()$datapath,
               delim = ",", eg_path = tmp_file)
      })
      output$df <- renderDataTable(data_df(), )



      session$onSessionEnded(function() {
        if(file.exists(demo_file)) file.remove(demo_file)
      })
    }
  )
}
