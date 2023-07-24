test_that("%nin% returns correct results", {
  expect_equal(c("a", "c", "abc") %nin% letters, c(F, F, T))
  expect_equal(c("a", "c", "abc", NULL, 0, NA) %nin% letters, c(F, F, T, T, T))
})
