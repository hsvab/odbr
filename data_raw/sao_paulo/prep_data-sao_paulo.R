# Setup ------------------------------------------------------------------------
year=1977
city="São Paulo"
harmonize = FALSE
repository = "hsvab/odbr"
tag = "v0.0.1"


# Database ---------------------------------------------------------------------

# Function to compose the base name of database files
compose_name_db <- function(city, year, harmonize){
  city_text <- gsub(" ", "_", tolower(iconv(city, to = "ASCII//TRANSLIT")))

  harmonized_text <- "not_harmonized"
  if(harmonize == TRUE){
    harmonized_text <- "harmonized"
  }
  filename <- paste0("data_raw/", city_text, "/", year, "/", harmonized_text, "/od_", city_text, "_", year, "_", harmonized_text)

  return(filename)
}

# Function to convert sav to csv.gz file, and upload to repository
upload_sav_db_to_repo <- function(city, year, harmonize){

  # Creating the filename to download
  filename_to_download <- paste0(compose_name_db(city, year, harmonize),".sav")

  # Reading raw data
  od <- haven::read_sav(filename_to_download)

  # Creating compacted filename
  compacted_filename <- paste0(compose_name_db(city, year, harmonize),".csv.gz")

  # Compacting the file (.gz)
  readr::write_csv2(od, compacted_filename)

  # Building a new release in the repo
  piggyback::pb_new_release(repo = repository,
                            tag = tag )

  # Uploading a file to a specific release from odbr repo (see parameter)
  piggyback::pb_upload(file = compacted_filename,
                       repo = repository,
                       tag = tag )
}

# Maps -------------------------------------------------------------------------

# Functions to compose the base name of map files

city_levels <- c("Zonas", "Municipios", "Distritos")

compose_file_path <- function(city, year, harmonize){
  city_text <- gsub(" ", "_", tolower(iconv(city, to = "ASCII//TRANSLIT")))

  harmonized_text <- "not_harmonized"
  if(harmonize == TRUE){
    harmonized_text <- "harmonized"
  }
  filepath <- paste0("data_raw/", city_text, "/", year, "/", harmonized_text)

  return(filepath)
}


for(level in city_levels){

  filename_map <- paste0(compose_file_path(city, year, harmonize),"/",level,year,"_region.shp")
  file_to_upload <- paste0(compose_file_path(city, year, harmonize),"/",level,year,".gpkg")

  if(file.exists(filename_map) == TRUE){

    # Reading shape files, if it exists
    od_map <- sf::read_sf(filename_map)

    # Writing a gpkg unique file
    od_map %>% sf::write_sf(file_to_upload)

    # Building a new release in the repo
    piggyback::pb_new_release(repo = repository,
                              tag = tag)

    # Uploading a file to a specific release from odbr repo (see parameter)
    piggyback::pb_upload(file = file_to_upload,
                         repo = repository,
                         tag = tag)
  }

}


# Dictionaries -----------------------------------------------------------------

# Making the data dictionary available in the package
od_sao_paulo_1977_not_harmonized_dictionary_pt <- readr::read_csv2("data_raw/sao_paulo/dic/od_sao_paulo_1977_not_harmonized_dictionary_pt.csv")
usethis::use_data(od_sao_paulo_1977_not_harmonized_dictionary_pt)

od_sao_paulo_1977_not_harmonized_dictionary_en <- readr::read_csv2("data_raw/sao_paulo/dic/od_sao_paulo_1977_not_harmonized_dictionary_en.csv")
usethis::use_data(od_sao_paulo_1977_not_harmonized_dictionary_en)

