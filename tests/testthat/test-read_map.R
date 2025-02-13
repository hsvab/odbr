test_that("read_map() works", {
  testing_object <- read_map(
    city = "São Paulo",
    year = 1997,
    harmonize = FALSE,
    geometry = "zone"
  )

  # Let's take into consideration the case in which we have reached
  # the github API rate limit and then we will have a null result.
  if (is.null(testing_object)) {
    expect_null(testing_object)
  } else {
    expect_equal(is.data.frame(testing_object), TRUE)
    expect_s3_class(testing_object, "sf")
  }

  # Testing error message
  expect_snapshot(
    read_map(
      city = "Manaus",
      year = 1977,
      harmonize = FALSE,
      geometry = "zone"
    ),
    error = TRUE
  )
  expect_snapshot(
    read_map(
      city = "São Paulo",
      year = 1978,
      harmonize = FALSE,
      geometry = "zone"
    ),
    error = TRUE
  )
  expect_snapshot(
    read_map(
      city = "São Paulo",
      year = 1977,
      harmonize = TRUE,
      geometry = "zone"
    ),
    error = TRUE
  )
})
