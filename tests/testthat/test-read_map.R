test_that("read_map() works", {
  testing_object <- read_map(
    city = "São Paulo",
    year = 1997,
    harmonize = FALSE,
    geometry = "zone"
  )

  expect_equal(is.data.frame(testing_object), TRUE)

  expect_s3_class(testing_object, "sf")

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
