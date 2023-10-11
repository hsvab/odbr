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
#'   city = "Sao Paulo",
#'   year = 1977,
#'   harmonize = FALSE,
#'   language = "pt"
#' )
#'
read_dictionary <- function(city = "S\u00E3o Paulo",
                            year = 2017,
                            harmonize = FALSE,
                            language = "pt") {
  # Clean the name of the city before comparing to the metadata
  city_clean <- clean_string(city)

  # Validate if there is any metadata entry for the given arguments
  if (nrow(odbr::metadata[clean_string(odbr::metadata$city) == city_clean &
                            odbr::metadata$year == year &
                            odbr::metadata$harmonized == harmonize &
                            odbr::metadata$language == language, ]) == 0) {
    usethis::ui_stop("There is no dictionary for:
                          - city: {city}
                          - year: {year}
                          - harmonized: {harmonize}
                          - language: {language}
                                           Check the metadata object for available data.")
  }

  # Creating the dictionary filename
  language_text <- clean_string(language)
  od_dic_name <- paste0(compose_name(city, year, harmonize), "_dictionary_", language_text)

  # Get the correct dictionary
  od_dic <- get0(od_dic_name, envir = asNamespace("odbr"))

  # Verify is loaded as a data.frame object
  if (is.data.frame(od_dic) == FALSE) {
    usethis::ui_stop("The specified dictionary is not available.
                 Check the metadata object for available dictionaries and cohorts.")
  }

  # Delivering the requested file as a function return
  return(od_dic)
}
