####### Some internal shiny utils


# can't import shiny internal function, gives warnings, so rewrite here
reactiveStop <- function(message = "\r              ", class = NULL){
    cond <- structure(list(message = message),
                      class = c(c("shiny.silent.error", class),
                                "error",
                                "condition")
    )
    stop(cond)
}
