test_that("read_map() works", {
  testing_object <- read_map(
    city = "São Paulo",
    year = 1997,
    harmonize = FALSE,
    geometry = "zone"
  )

  expect_equal(is.data.frame(testing_object), TRUE)

  expect_s3_class(testing_object, "sf")
})
