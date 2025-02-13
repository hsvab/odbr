test_that("compose_file_path", {
  expect_equal(
    compose_file_path("São Paulo", 1977, FALSE),
    "data-raw/sao_paulo/1977/not_harmonized"
  )

  expect_equal(
    compose_file_path("São Paulo", 1977, TRUE),
    "data-raw/sao_paulo/1977/harmonized"
  )
})

test_that("compose_name", {
  expect_equal(
    compose_name("São Paulo", 1977, FALSE),
    "od_sao_paulo_1977_not_harmonized"
  )

  expect_equal(
    compose_name("São Paulo", 1977, TRUE),
    "od_sao_paulo_1977_harmonized"
  )
})

# TODO: Test upload_sav_db_to_repo function

test_that("clean_string", {
  expect_equal(
    clean_string("São Paulo"),
    "sao_paulo"
  )

  expect_equal(
    clean_string("SÃO PAULO"),
    "sao_paulo"
  )

  expect_equal(
    clean_string("Sao Paulo"),
    "sao_paulo"
  )
})
