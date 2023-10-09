# Function to compose the base name of map files -------------------------------
compose_file_path <- function(city, year, harmonize) {
  city_text <- clean_string(city)

  harmonized_text <- "not_harmonized"
  if (harmonize == TRUE) {
    harmonized_text <- "harmonized"
  }
  filepath <- paste0("data-raw/", city_text, "/", year, "/", harmonized_text)

  return(filepath)
}

# Function to compose the base name of data / dictionary / map files -----------
compose_name <- function(city, year, harmonize, level = "od") {
  city_text <- clean_string(city)

  harmonized_text <- "not_harmonized"
  if (harmonize == TRUE) {
    harmonized_text <- "harmonized"
  }

  level_text <- clean_string(level)

  name <- paste0(level_text, "_", city_text, "_", year, "_", harmonized_text)
  return(name)
}

# Function to convert sav to csv.gz file, and upload to repository -------------
upload_sav_db_to_repo <- function(city, year, harmonize, repository, tag) {
  base_filename <- paste0(
    compose_file_path(city, year, harmonize), "/",
    compose_name(city, year, harmonize)
  )

  # Creating the filename to download
  filename_to_download <- paste0(base_filename, ".sav")

  # Reading raw data
  od <- haven::read_sav(filename_to_download)

  # Creating compacted filename
  compacted_filename <- paste0(base_filename, ".csv.gz")

  # Compacting the file (.gz)
  data.table::fwrite(od,
    file = compacted_filename,
    sep = ";"
  )

  # Uploading a file to a specific release from odbr repo (see parameter)
  piggyback::pb_upload(
    file = compacted_filename,
    repo = repository,
    tag = tag
  )
}

# Function to remove non-ASCII characters -------------------------------------
clean_string <- function(text) {
  gsub("~", "", gsub(" ", "_", tolower(iconv(text, to = "ASCII//TRANSLIT"))))
}
