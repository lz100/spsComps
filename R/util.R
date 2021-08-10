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

# from spsUtil
notFalsy <- function (x) {
  if (is.function(x)) return(TRUE)
  if (is.environment(x)) return(TRUE)
  if (length(x) < 1 || all(is.na(x)) || is.null(x)) return(FALSE)
  if (nchar(x[1]) == 0) return(FALSE)
  if (isFALSE(x)) return(FALSE)
  else TRUE
}
emptyIsFalse <- notFalsy
isFalsy <- function(x) {
  !notFalsy(x)
}

# from spsUtil
remove_ANSI <- function(strings) {
  assertthat::assert_that(is.character(strings))
  ANSI <- paste0("(?:(?:\\x{001b}\\[)|\\x{009b})(?:(?:[0-9]{1,3})?(?:",
                 "(?:;[0-9]{0,3})*)?[A-M|f-m])|\\x{001b}[A-M]")
  gsub(ANSI, "", strings, perl = TRUE)
}

# from spsUtil
spsOption <- function(opt, value = NULL, .list = NULL, empty_is_false = TRUE){
  if (!is.null(.list)) {
    lapply(seq_along(.list), function(x) {
      if(is.null(.list[[x]])) stop(c("In `spsOption`: option ", names(.list)[x], " is NULL, not allowed"))
    })
    old_opts <- getOption('sps')
    old_opts[names(.list)] <- .list
    return(options(sps = old_opts))
  }
  assertthat::assert_that(is.character(opt) && length(opt) == 1)
  if(assertthat::not_empty(value))
    options(sps = getOption('sps') %>% {.[[opt]] <- value; .})
  else {
    get_value <- getOption('sps')[[opt]]
    if(!emptyIsFalse(get_value)){
      if(empty_is_false) FALSE
      else get_value
    }
    else get_value
  }
}

msg <- function(msg,
                level = "INFO",
                .other_color=NULL,
                info_text = "INFO",
                warning_text = "WARNING",
                error_text = "ERROR",
                use_color = TRUE){
  msg <- paste0(msg, collapse = "")
  info <- warn <- err <- other <- function(msg){return(msg)}
  if(use_color || (!is.null(getOption('sps')[['use_crayon']]) && getOption('sps')[['use_crayon']])){
    info <- crayon::blue$bold
    warn <- crayon::make_style("orange")$bold
    err <- crayon::red$bold
    other <- if(is.null(.other_color)) crayon::chr else crayon::make_style(.other_color)$bold
  }
  level_text <- switch(toupper(level),
                       "WARNING" = warning_text,
                       "ERROR" = error_text,
                       "INFO" = info_text,
                       level
  )
  msg <- if(str_detect(msg, "\\[.*\\] [0-9]{4}-[0-9]{2}")) msg
  else glue("[{level_text}] {Sys.time()} {msg}")

  switch(toupper(level),
         "WARNING" = warning("\r", warn(msg), call. = FALSE, immediate. = TRUE),
         "ERROR" = stop("\r", err(msg), call. = FALSE),
         "INFO" = message(info(msg)),
         cat(other(msg), sep = "\n")
  )
}
