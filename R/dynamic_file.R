#' Dynamically generate Shiny file selection component based on option
#' @description  Depending on the "mode" in SPS options, this function renders
#' a similar UI components but behaves differently on server.
#'
#' 1. `local` mode will not copy file, directly
#' use a path pointer.
#' 2. `server` mode upload file and store in temp. Expect
#' similar behavior as [shiny::fileInput].
#' @details To setup the option:
#'
#' The `local` mode uses functions from [shinyFiles] so it will reach file system
#' on the **server end**. Although the latest [shinyFiles] limits users to only
#' specified server end location (folder), there is still some **risk**. That's why
#' it is named "local", you are encouraged to run the app on your local computer.
#' The advantage of "local" is: for some very large files, it does not upload and
#' store in the temp. Rather, it directly parses the path on the local file system
#' and return the path immediately. It means the file has to exist on the file
#' system that serves the Shiny app. If you deploy the app on places like shinyapps.io,
#' users can only choose files from server.
#'
#' On the other hand, `server` mode uses original shiny default upload component.
#' Users can upload files from local to server. So users do not have access to
#' server end file system if you deploy it online. However, the limitations are:
#'
#' 1. not ideal for large files, default limit is 30MB, and there is no break point
#' upload.
#' 2. If you are running the app on your own computer, local end and server end is
#' the same, which is your computer. Using `server` mode will make a copy of your
#' existing file to temp location which is a waste of time and storage.
#'
#' To set up options:
#'
#' 1. Under SPS framework, edit options in `global.R`.
#' 2. Outside SPS framework with your own Shiny app, use [spsUtil::spsOption()] function,
#' like `spsUtil::spsOption("mode", "server")` or `spsUtil::spsOption("mode", "local")` to
#' set up mode.
#'
#' If you are not sure what mode you are on, use `spsUtil::spsOption('mode')` to check.
#'
#' @param id element ID, Use `ns()` to wrap the id if you are using within a shiny
#' module, but DO NOT use `ns()` to wrap the id on server side
#' @param title element title
#' @param label upload button label
#' @param icon button icon, only works for `local` mode
#' @param style additional button style, only works for `local` mode
#' @param multiple bool, are multiple files allowed?
#' @importFrom shinyAce is.empty
#' @importFrom shinyFiles shinyFilesButton
#' @return a Shiny upload component on UI
#'
#' For the server end it returns a
#' **reactive** object which is a dataframe, need to extract the value inside reactive
#' expression, observe, or inside `isolate`. See examples
#' @export
#'
#' @examples
#' # Simple example
#' if(interactive()){
#'     options(sps = list(mode='server')) # Change the mode to 'local' to see difference
#'     ui <- fluidPage(
#'         dynamicFile("server_file", "server"),
#'         verbatimTextOutput("server_out")
#'     )
#'
#'     server <- function(input,output,session){
#'         file_server <- dynamicFileServer(input,session, id = "server_file")
#'         output$server_out <- renderPrint({
#'             file_server()  # remember to use `()` for reactive value
#'         })
#'     }
#'     shinyApp(ui = ui, server = server)
#' }
#' # To demostrate different modes in the same app, we can set options before the function.
#' # This is NOT recommended, you should stick with only one mode for the entire app.
#' if(interactive()){
#'     spsOption("mode", "local")
#'     local_ui <- dynamicFile("local_file", "local")
#'     spsOption("mode", "server")
#'     server_ui <- dynamicFile("server_file", "server")
#'     ui <- fluidPage(
#'         column(
#'             6,
#'             local_ui,
#'             verbatimTextOutput("local_out")
#'         ),
#'         column(
#'             6,
#'             server_ui,
#'             verbatimTextOutput("server_out")
#'         )
#'     )
#'
#'     server <- function(input,output,session){
#'         spsOption("mode", "local")
#'         file_local <- dynamicFileServer(input,session, id = "local_file")
#'         output$local_out <- renderPrint({
#'             file_local() # remember to use `()` for reactive value
#'         })
#'         spsOption("mode", "server")
#'         file_server <- dynamicFileServer(input,session, id = "server_file")
#'         output$server_out <- renderPrint({
#'             file_server()
#'         })
#'     }
#'     shinyApp(ui = ui, server = server)
#' }
dynamicFile <- function(id, title = "Select your file:",
                        label = "Browse", icon = NULL, style = "",
                        multiple = FALSE){
    icon <- if(shinyAce::is.empty(icon)) icon("upload")
    if (spsOption('mode') == "local") {
        div(class = "form-group shiny-input-container sps-file",
            tags$label(class="control-label", `for`=id, title),
            div(class="input-group",
                tags$label(class="input-group-btn input-group-prepend",
                           shinyFiles::shinyFilesButton(id, label,
                                                        title = title, multiple = multiple,
                                                        buttonType = "btn btn-primary",
                                                        icon = icon,
                                                        style = style)
                ),
                textInput(inputId = glue("{id}-text"), label = NULL,
                          placeholder="No file selected", width = "100%") %>% {
                              .[['children']][[2]][['attribs']][['readonly']] <- 'true'
                              .
                          }
            )

        )

    } else {
        fileInput(inputId = id, label = title,
                  multiple = multiple, buttonLabel = label)
    }
}


#' @rdname dynamicFile
#' @param input shiny server input
#' @param session shiny server session
#' @param roots a named character vector, paths where users can reach
#' on the server, so only required for "server" mode, default is
#' current directory + all system volumes. You can lock users to a specific path,
#' so they are not allowed to browse parent folders.
#' like only current directory: `c(current=getwd())`; a temp folder:
#' `c(current=tempdir())`; unlimited: `c(shinyFiles::getVolumes()())`
#' @export
#' @importFrom shinyFiles getVolumes shinyFileChoose parseFilePaths
dynamicFileServer <- function(input, session, id, roots = c(root = "default")){
    file_return <- reactiveVal(NULL)
    if(names(roots)[1] == "root" & roots[1] == "default")
        roots = c(current=getwd(), shinyFiles::getVolumes()())
    if (spsOption('mode') == "local") {
        shinyFiles::shinyFileChoose(input, id, roots = roots, session = session)
        observeEvent(input[[id]],
                     file_return({
                         req(is.list(input[[id]]))
                         file_selected <- shinyFiles::parseFilePaths(roots, input[[id]])
                         updateTextInput(inputId = glue("{id}-text"),
                                         session = session,
                                         placeholder = unname(file_selected$datapath))
                         as.data.frame(file_selected)
                     })
        )
        file_return
    } else {
        observe(file_return(input[[id]]))
        file_return
    }
}
