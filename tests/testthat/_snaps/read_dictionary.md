# read_dictionary works

    Code
      read_dictionary(city = "Manaus", year = 1977, harmonize = FALSE)
    Condition
      Error in `read_dictionary()`:
      ! There is no dictionary for:
      - city: Manaus
      - year: 1977
      - harmonized: FALSE
      - language: pt
      i Check the metadata object for available data.

---

    Code
      read_dictionary(city = "São Paulo", year = 1978, harmonize = FALSE)
    Condition
      Error in `read_dictionary()`:
      ! There is no dictionary for:
      - city: São Paulo
      - year: 1978
      - harmonized: FALSE
      - language: pt
      i Check the metadata object for available data.

---

    Code
      read_dictionary(city = "São Paulo", year = 1977, harmonize = TRUE)
    Condition
      Error in `read_dictionary()`:
      ! There is no dictionary for:
      - city: São Paulo
      - year: 1977
      - harmonized: TRUE
      - language: pt
      i Check the metadata object for available data.

