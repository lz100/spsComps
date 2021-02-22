
#' @importFrom glue glue glue_collapse
#' @importFrom stringr str_split str_remove_all str_replace_all str_which
#' @importFrom stringr str_remove str_which str_extract str_replace str_sort
#' @importFrom stringr str_detect str_pad
#' @importFrom magrittr %>%
#' @importFrom assertthat not_empty assert_that
#' @import shiny spsUtil
NULL

#' Add online content
#' @noRd
#'
.onLoad <- function(...) {
    shiny::addResourcePath('spsComps', system.file("assets", package = "spsComps"))
}
