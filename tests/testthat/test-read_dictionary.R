test_that("read_dictionary works", {
  testing_object <-
    read_dictionary(
      city = "São Paulo",
      year = 1997,
      harmonize = FALSE
    )

  expect_equal(is.data.frame(testing_object), TRUE)

  # Testing error message
  expect_snapshot(
    read_dictionary(
      city = "Manaus",
      year = 1977,
      harmonize = FALSE
    ),
    error = TRUE
  )
  expect_snapshot(
    read_dictionary(
      city = "São Paulo",
      year = 1978,
      harmonize = FALSE
    ),
    error = TRUE
  )
  expect_snapshot(
    read_dictionary(
      city = "São Paulo",
      year = 1977,
      harmonize = TRUE
    ),
    error = TRUE
  )
})
