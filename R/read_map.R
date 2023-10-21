#' Download spatial data from OD Surveys databases
#'
#' `read_map()` download the geodetic data for a specific Origin Destination survey
#' and return it as an sf dataframe. It uses the cached data file if it was
#' previously downloaded to avoid extra networking consumption. To understand
#' the returned dataframe format, please reefer to the `read_dictionary()`
#' function for the same survey cohort.
#' It is also necessary to specify the geometry granularity wanted, be it
#' "municipality", "district" or "zone" level of details. Of course, not all
#' geometries are available for all surveys.
#'
#' @template city
#' @template year
#' @template harmonize
#' @param geometry Character. The type of spatial data to be opened. Options
#' include `c("zone","district", "municipality")`.
#' @template force_download
#'
#' @return An `"sf" "data.frame"` object
#' @export
#' @family Geometry
#'
#' @examplesIf identical(tolower(Sys.getenv("NOT_CRAN")), "true")
#' library(odbr)
#'
#' # return zone data from OD Surveys database as sf object at a given city and year
#' df <- read_map(
#'   city = "Sao Paulo",
#'   year = 2017,
#'   harmonize = FALSE,
#'   geometry = "zone"
#' )
#'
#' #' # return district data from OD Surveys database as sf object at a given city and year
#' df <- read_map(
#'   city = "Sao Paulo",
#'   year = 2017,
#'   harmonize = FALSE,
#'   geometry = "district"
#' )
#'
#' # return municipality data from OD Surveys database as sf object at a given city and year
#' df <- read_map(
#'   city = "Sao Paulo",
#'   year = 2017,
#'   harmonize = FALSE,
#'   geometry = "municipality"
#' )
#'
read_map <- function(city = "S\u00E3o Paulo",
                     year = 2017,
                     harmonize = FALSE,
                     geometry = "zone",
                     force_download = FALSE) {
  # Clean the name of the city before comparing to the metadata
  city_clean <- clean_string(city)

  # Validate if there is any metadata entry for the given arguments
  if (nrow(odbr::metadata[clean_string(odbr::metadata$city) == city_clean &
                            odbr::metadata$year == year &
                            odbr::metadata$harmonized == harmonize, ]) == 0) {
    usethis::ui_stop("There is no geometry data for:
                        - city: {city}
                        - year: {year}
                        - harmonized: {harmonize}
                        - geometry: {geometry}
                     Check the metadata object for available data.")
  }

  # Creating the filename to download
  filename_to_download <- paste0(
    compose_name(
      city,
      year,
      harmonize,
      geometry
    ),
    ".gpkg"
  )

  # Calling the "download_piggyback" function with "filename_to_download" as
  # parameter and saving the function return in "temporary_filename"
  temporary_filename <- download_piggyback(filename_to_download, force_download)

  # Reading shape files
  od_map <- sf::read_sf(temporary_filename)

  # Delivering the requested file as a function return
  return(od_map)
}
