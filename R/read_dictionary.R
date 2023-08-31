# The "read_dictionary" function requires as parameter city, year and whether you want
# the harmonized database (over the years, for the same city) or not - the default is the raw base

# Functions that will be used
source("R/utils.R")

read_dictionary <- function(city = "São Paulo",
                            year = 1977,
                            harmonize = FALSE,
                            language = "pt") {

# Argument check - if it is passed a non-existent city in odbr, it gives an error message
if(!city %in% metadata$city){
usethis::ui_stop("The specified city ({city}) is not available.
                   Check the metadata object for available cities and cohorts.")
  }


# Creating the filename to download
lanaguage_text <- gsub(" ", "_", tolower(iconv(city, to = "ASCII//TRANSLIT")))
filename_to_download <- paste0(compose_name(city, year, harmonize), "_dictionary_", language_text, ".csv")



}
