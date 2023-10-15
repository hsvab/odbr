#' Download microdata from OD Surveys databases
#'
#' @description
#' The "read_od" function requires as parameter city, year and whether you want
#' the harmonized database (over the years, for the same city) or not - the
#' default is the raw base.
#'
#' @template city
#' @template year
#' @template harmonize
#'
#' @return A `"data.frame"` object.
#' @export
#' @family Microdata
#'
#' @examplesIf identical(tolower(Sys.getenv("NOT_CRAN")), "true")
#' library(odbr)
#'
#' # return data from OD Surveys database as data.frame
#' df <- read_od(
#'   city = "Sao Paulo",
#'   year = 1977,
#'   harmonize = FALSE
#' )
#'
read_od <- function(city = "S\u00E3o Paulo",
                    year = 2017,
                    harmonize = FALSE) {
  # Clean the name of the city before comparing to the metadata
  city_clean <- clean_string(city)

  # Validate if there is any metadata entry for the given arguments
  if (nrow(odbr::metadata[clean_string(odbr::metadata$city) == city_clean &
                            odbr::metadata$year == year &
                            odbr::metadata$harmonized == harmonize, ]) == 0) {
    usethis::ui_stop("There is no data for:
                        - city: {city}
                        - year: {year}
                        - harmonized: {harmonize}
                     Check the metadata object for available data.")
  }

  # Creating the filename to download
  filename_to_download <- paste0(compose_name(city, year, harmonize), ".csv.gz")

  # Calling the "download_piggyback" function with "filename_to_download" as
  # parameter and saving the function return in "temporary_filename"
  temporary_filename <- download_piggyback(filename_to_download)

  # Reading the file to a release in odbr repository
  od_file <- data.table::fread(temporary_filename,
    sep = ";"
  )

  # Delivering the requested file as a function return
  return(od_file)
}
