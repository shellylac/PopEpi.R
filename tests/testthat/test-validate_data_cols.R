test_that("dataset cols works", {
  # Loads function quietly - captures output
  qval <- purrr::quietly(validate_data_cols)
  qval_call <- qval(
    data.frame(a = 1, b = 1, total = 2),
    c("a", "b", "total")
  )

  # qval_call has output as named list:
  expect_equal(qval_call$result, TRUE)
  expect_equal(
    qval_call$messages,
    "Dataset columns match expectations. Please proceed.\n"
  )

  expect_error(
    validate_data_cols(
      data = data.frame(a = 1, b = 1, tot = 2),
      expected_col_names = c("a", "b", "c")
    ),
    "Column names do not match expected names."
  )
  expect_error(
    validate_data_cols(
      data = data.frame(
        a = 1, b = 1, tot = 2,
        test = c("a", "b", "c")
      ),
      expected_col_names = c("a", "b", "c")
    ),
    "Dataset has fewer or more columns than expected."
  )
  expect_error(
    validate_data_cols(
      data = data.frame(a = 1, b = 1, tot = 2),
      expected_col_names = c("a", "b", "tot", "c")
    ),
    "Dataset has fewer or more columns than expected."
  )
})
