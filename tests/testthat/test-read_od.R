test_that("read_od() works", {
  # Testing data file loading with read_od
  testing_object <- read_od(city = "São Paulo", year = 1997, harmonize = FALSE)

  if (!is.null(testing_object)) {
    expect_true(is.data.frame(testing_object))
  } else {
    expect_null(testing_object)
  }

  # Testing read_od error message
  expect_snapshot(read_od(city = "Manaus", year = 1977, harmonize = FALSE),
    error = TRUE
  )
  expect_snapshot(read_od(city = "São Paulo", year = 1978, harmonize = FALSE),
    error = TRUE
  )
  expect_snapshot(read_od(city = "São Paulo", year = 1977, harmonize = TRUE),
    error = TRUE
  )
})
