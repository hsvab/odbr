## code to prepare `metadata` dataset goes here

metadata <- data.table::fread("data_raw/metadata.csv", sep = ",")

# Making the metadata.csv available to users of the package as database
usethis::use_data(metadata, overwrite = TRUE)
