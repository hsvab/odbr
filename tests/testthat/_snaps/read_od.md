# read_od() works

    Code
      read_od(city = "Manaus", year = 1977, harmonize = FALSE)
    Condition
      Error in `read_od()`:
      ! There is no data for:
        - city: Manaus
        - year: 1977
        - harmonized: FALSE
      i Check the metadata object for available data.

---

    Code
      read_od(city = "São Paulo", year = 1978, harmonize = FALSE)
    Condition
      Error in `read_od()`:
      ! There is no data for:
        - city: São Paulo
        - year: 1978
        - harmonized: FALSE
      i Check the metadata object for available data.

---

    Code
      read_od(city = "São Paulo", year = 1977, harmonize = TRUE)
    Condition
      Error in `read_od()`:
      ! There is no data for:
        - city: São Paulo
        - year: 1977
        - harmonized: TRUE
      i Check the metadata object for available data.

