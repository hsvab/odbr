# Function to compose the base name of data / dictionary files
compose_name <- function(city, year, harmonize) {
  city_text <- gsub("~", "", gsub(" ", "-", tolower(iconv(city, to = "ASCII//TRANSLIT"))))

  harmonized_text <- "not-harmonized"
  if (harmonize == TRUE) {
    harmonized_text <- "harmonized"
  }
  name <- paste0("od_", city_text, "_", year, "_", harmonized_text)
  return(name)
}
