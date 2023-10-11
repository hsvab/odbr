# read_map() works

    Code
      read_map(city = "Manaus", year = 1977, harmonize = FALSE, geometry = "zone")
    Condition
      Error:
      ! There is no geometry data for:
         - city: Manaus
         - year: 1977
         - harmonized: FALSE
         - geometry: zone
      Check the metadata object for available data.

---

    Code
      read_map(city = "São Paulo", year = 1978, harmonize = FALSE, geometry = "zone")
    Condition
      Error:
      ! There is no geometry data for:
         - city: São Paulo
         - year: 1978
         - harmonized: FALSE
         - geometry: zone
      Check the metadata object for available data.

---

    Code
      read_map(city = "São Paulo", year = 1977, harmonize = TRUE, geometry = "zone")
    Condition
      Error:
      ! There is no geometry data for:
         - city: São Paulo
         - year: 1977
         - harmonized: TRUE
         - geometry: zone
      Check the metadata object for available data.

