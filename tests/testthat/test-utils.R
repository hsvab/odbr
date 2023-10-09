test_that("compose_file_path", {
  expect_equal(
    compose_file_path("São Paulo", 1977, FALSE),
    "data-raw/sao_paulo/1977/not_harmonized"
  )
})

test_that("compose_name", {
  expect_equal(
    compose_name("São Paulo", 1977, FALSE),
    "od_sao_paulo_1977_not_harmonized"
  )
})

# Testing data file loading with read_od
test_that("read_od", {
  testing_object <- read_od(city = "São Paulo", year = 1997, harmonize = FALSE)
  expect_equal(is.data.frame(testing_object), TRUE)
})

# Testing read_od error message
test_that("read_od", {
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


# TODO: Test upload_sav_db_to_repo function


