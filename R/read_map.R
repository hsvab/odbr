#' Download spatial data from OD Surveys databases
#'
#' @description
#' The "read_map" function requires as parameter city, year, geometry (zones or
#' municipalities) - the default is zone, and whether you want the harmonized
#' database (variable names and reference/geodesic projection over the years,
#' for the same city) or not - the default is the raw base.
#'
#' @template city
#' @template year
#' @template harmonize
#' @param geometry Character. The type of spatial data to be opened. Options
#' include `c("zone","district", "municipality")`.
#'
#' @return An `"sf" "data.frame"` object
#' @export
#' @family Geometry
#'
#' @examples
#' library(odbr)
#'
#' # return zone data from OD Surveys database as data.frame at a given city and year
#' df <- read_map(
#'   city = "Sao Paulo",
#'   year = 2017,
#'   harmonize = FALSE,
#'   geometry = "zone"
#' )
#'
#' #' # return district data from OD Surveys database as data.frame at a given city and year
#' df <- read_map(
#'   city = "Sao Paulo",
#'   year = 2017,
#'   harmonize = FALSE,
#'   geometry = "district"
#' )
#'
#' # return municipality data from OD Surveys database as data.frame at a given city and year
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
                     geometry = "zone") {
  # Argument check - error message if it is passed a non-existent city parameter
  if (!city %in% metadata$city) {
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
                 Check the metadata object for available harmonized parameters and cohorts.")
  }

  # Argument check - error message if it is passed a non-existent geometry parameter
  if (!geometry %in% metadata$geometry) {
    usethis::ui_stop("The specified geometry parameter ({geometry}) is not available.
                 Check the metadata object for available geometry parameters and cohorts.")
  }

  # Creating the filename to download
  filename_to_download <- paste0(compose_name(city, year, harmonize, geometry), ".gpkg")

  #### STOPED HERE ######

  # Calling the "download_piggyback" function with "filename_to_download" as
  # parameter and saving the function return in "temporary_filename"
  temporary_filename <- download_piggyback(filename_to_download)

  # Uploading the file to a release in odbr repository
  od_file <- data.table::fread(temporary_filename,
    sep = ";"
  )

  # Delivering the requested file as a function return
  return(od_file)
}
