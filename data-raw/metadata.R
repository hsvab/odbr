## code to prepare `metadata` dataset goes here

metadata <- readr::read_csv("data-raw/metadata.csv")

# Making the metadata.csv available to users of the package as database
usethis::use_data(metadata, overwrite = TRUE)
