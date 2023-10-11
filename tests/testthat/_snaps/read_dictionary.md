# read_dictionary works

    Code
      read_dictionary(city = "Manaus", year = 1977, harmonize = FALSE)
    Error <usethis_error>
      There is no dictionary for:
         - city: Manaus
         - year: 1977
         - harmonized: FALSE
         - language: pt
      Check the metadata object for available data.

---

    Code
      read_dictionary(city = "São Paulo", year = 1978, harmonize = FALSE)
    Error <usethis_error>
      There is no dictionary for:
         - city: São Paulo
         - year: 1978
         - harmonized: FALSE
         - language: pt
      Check the metadata object for available data.

---

    Code
      read_dictionary(city = "São Paulo", year = 1977, harmonize = TRUE)
    Error <usethis_error>
      There is no dictionary for:
         - city: São Paulo
         - year: 1977
         - harmonized: TRUE
         - language: pt
      Check the metadata object for available data.

