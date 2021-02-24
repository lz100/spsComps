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
