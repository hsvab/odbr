# Setup ------------------------------------------------------------------------
year=1977
city="São Paulo"
harmonize = FALSE
repository = "hsvab/odbr"
tag = "v0.0.3"

devtools::load_all()

# Building a new release in the repo
piggyback::pb_new_release(repo = repository,
                          tag = tag)

# Database ---------------------------------------------------------------------

upload_sav_db_to_repo (city, year, harmonize)

# Maps -------------------------------------------------------------------------

city_levels <- c("Zonas", "Municipios", "Distritos")

for(level in city_levels){

  filename_map <- paste0(compose_file_path(city, year, harmonize),"/",level,year,"_region.shp")

  file_to_upload <- paste0(compose_file_path(city, year, harmonize),"/",
                           compose_name(city, year, harmonize, level),".gpkg")

  if(file.exists(filename_map) == TRUE){

    # Reading shape files, if it exists
    od_map <- sf::read_sf(filename_map)

    # Writing a gpkg unique file
    sf::write_sf(od_map, file_to_upload)

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

