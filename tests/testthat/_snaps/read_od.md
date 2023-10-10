# read_od() works

    Code
      read_od(city = "Manaus", year = 1977, harmonize = FALSE)
    Error <usethis_error>
      There is no data for:
         - city: Manaus
         - year: 1977
         - harmonized: FALSE
      Check the metadata object for available data.

---

    Code
      read_od(city = "São Paulo", year = 1978, harmonize = FALSE)
    Error <usethis_error>
      There is no data for:
         - city: São Paulo
         - year: 1978
         - harmonized: FALSE
      Check the metadata object for available data.

---

    Code
      read_od(city = "São Paulo", year = 1977, harmonize = TRUE)
    Error <usethis_error>
      There is no data for:
         - city: São Paulo
         - year: 1977
         - harmonized: TRUE
      Check the metadata object for available data.

