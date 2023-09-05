#' Calculates variance
#'
#' @usage my_var(x)
#' @param x vector of numeric values
#' @return A numeric value of the variance.
#' @export
#'
#' @examples
#' x <- c(1,2,2,4,5)
#' my_var(x)
my_var <- function(x){
  n <- length(x)
  xbar <- mean(x)
  SSE <- sum( (x - xbar)^2 )
  v <- SSE / ( n - 1 )
  return(v)
}
