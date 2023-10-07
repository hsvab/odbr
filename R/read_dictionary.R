#' Download data dictionary from OD surveys databases
#'
#' @description
#' The "read_dictionary" function requires as parameter city, year and whether
#' you want the harmonized database (over the years, for the same city) or not -
#' the default is the raw base.
#'
#' @template city
#' @template year
#' @template harmonize
#' @param language Character. The language of data dictionary to be opened.
#' Options include `c("pt", "en", "es")`.
#'
#' @return A `"data.frame"` object.
#' @export
#' @family Documentation
#'
#' @examples
#' library(odbr)
#'
#' # return data dictionary from OD Surveys, as data.frame, at a given city and year
#' df <- read_dictionary(
#'   city = "S\u00E3o Paulo",
#'   year = 1977,
#'   harmonize = FALSE,
#'   language = "pt"
#' )
#'
read_dictionary <- function(city = "S\u00E3o Paulo",
                            year = 1977,
                            harmonize = FALSE,
                            language = "pt") {

  # Clean the name of the city before comparing to the metadata
  city_clean <- clean_string(city)

  # Argument check - error message if it is passed a non-existent city parameter
  if (!city_clean %in% clean_string(metadata$city)) {
    usethis::ui_stop("The specified city ({city}) is not available.
                   Check the metadata object for available cities and cohorts.")
  }

  # Argument check - error message if it is passed a non-existent year parameter
  if (!year %in% metadata$year) {
    usethis::ui_stop("The specified year ({year}) is not available.
                 Check the metadata object for available years and cohorts.")
  }

  # Argument check - error message if it is passed a non-existent harmonized parameter
  if (!harmonize %in% metadata$harmonized) {
    usethis::ui_stop("The specified harmonized parameter ({harmonize}) is not available.
               Check the metadata object for available harmonizeed parameters and cohorts.")
  }

  # Argument check - error message if it is passed a non-existent language parameter
  if (!language %in% metadata$language) {
    usethis::ui_stop("The specified language parameter ({language}) is not available.
               Check the metadata object for available language parameters and cohorts.")
  }
  # Creating the filename to download
  language_text <- clean_string(language)

  object_to_use <- paste0(compose_name(city_clean, year, harmonize), "_dictionary_", language_text)

  # get object
  get(object_to_use)

}
