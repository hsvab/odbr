#' Scripts to prepare Sao Paulo OD data for package realase
#'
# Setup ------------------------------------------------------------------------
repository <- "hsvab/odbr"
tag <- "v0.0.6"
city <- "S\u00E3o Paulo"
years <- c("1977", "1987", "1997", "2007", "2017")
harmonize <- c(FALSE) # in the future include TRUE here
city_levels <- c("Zonas", "Municipios", "Distritos")
languages <- c("en", "es", "pt")

devtools::load_all()

# Building a new release in the repo
piggyback::pb_new_release(
  repo = repository,
  tag = tag
)

# Database ---------------------------------------------------------------------
for (year in years) {
  for (harmonization in harmonize) {
    upload_sav_db_to_repo(city, year, harmonization)
  }
}

# Maps -------------------------------------------------------------------------
for (year in years) {
  for (harmonization in harmonize) {
    for (level in city_levels) {
      filename_map <- paste0(
        compose_file_path(
          city,
          year,
          harmonization
        ),
        "/",
        level,
        year,
        "_region.shp"
      )
      file_to_upload <- paste0(
        compose_file_path(
          city,
          year,
          harmonization
        ),
        "/",
        compose_name(
          city,
          year,
          harmonization,
          level
        ),
        ".gpkg"
      )

      # File name translating
      file_to_upload <- gsub("Zonas",
        "zone",
        file_to_upload,
        ignore.case = TRUE
      )
      file_to_upload <- gsub("Municipios",
        "municipality",
        file_to_upload,
        ignore.case = TRUE
      )
      file_to_upload <- gsub("Distritos",
        "district",
        file_to_upload,
        ignore.case = TRUE
      )

      if (file.exists(filename_map) == TRUE) {
        # Reading shape files, if it exists
        od_map <- sf::read_sf(filename_map)

        # Writing a gpkg unique file
        sf::write_sf(od_map, file_to_upload)

        # Uploading a file to a specific release from odbr repo (see parameter)
        piggyback::pb_upload(
          file = file_to_upload,
          repo = repository,
          tag = tag
        )
        rm("od_map")
      }
    }
  }
}

# TODO-update
rm(list = c("level", "city_levels", "filename_map", "file_to_upload"))

# Dictionaries -----------------------------------------------------------------

# Making the data dictionary available in the package
for (year in years) {
  for (harmonization in harmonize) {
    for (language in languages) {
      # Name of the dictionary variable that will be available in the package
      dic_name <- paste0(
        compose_name(city, year, harmonize),
        "_dictionary_",
        language
      )

      # path of the csv file with dictionary content to be read
      filename_dic <- paste0("data-raw/sao_paulo/dic/", dic_name, ".csv")

      data <- data.table::fread(filename_dic, sep = ";")

      # Clean the name of the city before comparing to the metadata
      data <- dplyr::mutate(data, across(
        c(1:4),
        clean_string
      ))

      # Create a local df variable named as the content of "dic_name" with the
      # data content
      assign(dic_name, data)

      # Call use_data with the first argument having the variable which has the
      # same name as the content of the variable "dic_name"
      do.call(usethis::use_data, list(as.name(dic_name), overwrite = TRUE))

      # Cleanup
      rm(list = c(dic_name, "dic_name", "filename_dic", "data"))
    }
  }
}

# Cleanup
rm(list = c("years", "languages", "year", "language"))
