#' Download microdata from OD Surveys databases
#'
#' @description
#' `read_od()` download the data for a specific Origin Destination survey and
#' return it as a dataframe. It uses the cached data file if it was previously
#' downloaded to avoid extra networking consumption. To understand the returned
#' dataframe format, please refeer to the `read_dictionary()` function for the
#' same survey cohort.
#'
#' @template city
#' @template year
#' @template harmonize
#' @template force_download
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
#'   year = 2017,
#'   harmonize = FALSE
#' )
#'
read_od <- function(city = "S\u00E3o Paulo",
                    year = 2017,
                    harmonize = FALSE,
                    force_download = FALSE) {
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
  # parameter and saving the return in "temporary_filename"
  temporary_filename <- download_piggyback(filename_to_download, force_download)

  # Reading the file to a release in odbr repository
  od_file <- data.table::fread(temporary_filename,
    sep = ";"
  )

  # Delivering the requested file as a function return
  return(od_file)
}
