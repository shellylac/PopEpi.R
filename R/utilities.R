#' Inverse of %in% function
#'
#' Searches whether each of element of its first argument is NOT present
#' in its second.
#' @usage x \%nin\% table
#' @param x vector or NULL: the values to be matched
#' @param table vector or NULL: the values to be matched against
#' @return A `TRUE`/`FALSE` vector of the same length as `x`.
#' @export
#'
#' @examples
#' x <- c("a", "b", "c")
#' x %in% letters
`%nin%` <- function(x, table) {
  match(x, table, nomatch = 0) == 0
}
