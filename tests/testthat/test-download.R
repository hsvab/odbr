# TODO: Test download_piggyback() function

test_that("mocked test to fail gracefully", {

  # using a mocked binding to check if the function fails
  # gracefully when there is an internet connection problem

  local_mocked_bindings(
    download_piggyback = function(...) NULL
  )

  result <- read_od(city = "Sao Paulo", year = 2017, harmonize = FALSE)
  testthat::expect_null(result)

})
