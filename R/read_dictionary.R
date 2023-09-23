# The "read_dictionary" function requires as parameter city, year and whether you want
# the harmonized database (over the years, for the same city) or not - the default is the raw base

read_dictionary <- function(city = "São Paulo",
                            year = 1977,
                            harmonize = FALSE,
                            language = "pt") {

# Argument check - if it is passed a non-existent city in odbr, it gives an error message
if(!city %in% metadata$city){
  usethis::ui_stop("The specified city ({city}) is not available.")
                 #Check the metadata object for available cities and cohorts.")
}

# Argument check - if it is passed a valid city but with a non-existent year in
# odbr, it gives an error message
if(!city %in% metadata$city){
  usethis::ui_stop("The specified year ({year}) is not available.
                 Check the metadata object for available years and cohorts.")
}

# Argument check - if it is passed a valid city with a valid year, but with a
# non-existent harmonized parameter, it gives an error message
if(!city %in% metadata$city){
  usethis::ui_stop("The specified harmonized parameter ({harmonize}) is not available.
               Check the metadata object for available harmonizeed parameters and cohorts.")
}

# Creating the filename to download
lanaguage_text <- gsub(" ", "_", tolower(iconv(city, to = "ASCII//TRANSLIT")))
filename_to_download <- paste0(compose_name(city, year, harmonize), "_dictionary_", language_text, ".csv")

}
