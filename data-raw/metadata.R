## Prepare `metadata` dataset

metadata <- data.table::fread("data-raw/metadata.csv", sep = ",")

# Making the metadata.csv file available
usethis::use_data(metadata, overwrite = TRUE)
