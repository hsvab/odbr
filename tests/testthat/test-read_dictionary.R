test_that("read_dictionary works", {
  testing_object <-
    read_dictionary(
      city = "São Paulo",
      year = 1997,
      harmonize = FALSE
    )

  expect_equal(is.data.frame(testing_object), TRUE)
})
