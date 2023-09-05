#' Validates that a data frame contains columns that match expected
#' columns.
#'
#' This function takes a data frame and a vector of expected column names as
#' arguments and tests whether all the columns in the df match those listed in
#' the vector - both in name and number. The function returns TRUE or FALSE
#' invisibly (for use in downstream control statements) and if in interactive
#' session will print messages to the console.
#'
#' @usage validate_data_cols(data, expected_col_names)
#' @param data data frame object: the data set to be validated
#' @param expected_col_names vector: character vector of expected column names to be validated against.
#' @return `TRUE`/`FALSE` after completing all validations. Messages are displayed to screen if called in an interactive session.
#' @export
#'
#' @examples
#' df <- data.frame(a = 1:3, b = 1:3, totals = c(2,4,6))
#' expected_col_names <- c("a", "b", "totals")
#' validate_data_cols(df, expected_col_names)
#' if(validate_data_cols(df, expected_col_names)) {
#'   "Dataset cols have been validated."
#'   }

validate_data_cols <- function(data, expected_col_names) {
  if (!length(names(data)) == length(expected_col_names)) {
    stop("Dataset has fewer or more columns than expected.")
    invisible(F)
  } else if (!all(names(data) %in% expected_col_names)) {
    stop("Column names do not match expected names.")
    invisible(F)
  } else if (any(duplicated(names(data)))) {
    stop("Duplicate column names present.")
    invisible(F)
  } else {
    message("Dataset columns match expectations. Please proceed.")
    invisible(T)
  }
}
