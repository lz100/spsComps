####### Some internal shiny utils

#' @importFrom utils packageVersion
NULL

# can't import shiny internal function, gives warnings, so rewrite here
reactiveStop <- function(message = "\r              ", class = NULL){
    cond <- structure(list(message = message),
                      class = c(c("shiny.silent.error", class),
                                "error",
                                "condition")
    )
    stop(cond)
}


utils::globalVariables(c("."))


getBsColor <- function(status) {
  status <- match.arg(status, c("primary", "info", "success", "warning", "danger"))
  switch(status,
         "primary" = "#0275d8",
         "info" = "#5bc0de",
         "success" = "#5cb85c",
         "warning" = "#f0ad4e",
         "danger" = "#d9534f"
  )
}
