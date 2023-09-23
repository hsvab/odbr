# The "read_od" function requires as parameter city, year and whether you want
# the harmonized database (over the years, for the same city) or not - the default is the raw base

read_od <- function(city = "São Paulo", year = 1977, harmonize = FALSE) {
  # Argument check - if it is passed a non-existent city in odbr, it gives an error message
  if (!city %in% metadata$city) {
    usethis::ui_stop("The specified city ({city}) is not available.
                   Check the metadata object for available cities and cohorts.")
  }

  # Argument check - if it is passed a valid city but with a non-existent year in
  # odbr, it gives an error message
  if (!city %in% metadata$city) {
    usethis::ui_stop("The specified year ({year}) is not available.
                   Check the metadata object for available years and cohorts.")
  }

  # Argument check - if it is passed a valid city with a valid year, but with a
  # non-existent harmonized parameter, it gives an error message
  if (!city %in% metadata$city) {
    usethis::ui_stop("The specified harmonized parameter ({harmonize}) is not available.
                 Check the metadata object for available harmonizeed parameters and cohorts.")
  }

  # Creating the filename to download
  filename_to_download <- paste0(compose_name(city, year, harmonize), ".csv.gz")

  # Calling the "download_piggyback" function with "filename_to_download" as
  # parameter and saving the function return in "temporary_filename"
  temporary_filename <- download_piggyback(filename_to_download)

  # Uploading the file to a release in odbr repository
  od_file <- readr::read_csv2(temporary_filename, show_col_types = FALSE)

  # Deleting the "temporary_filename" variable
  fs::file_delete(temporary_filename)

  # Delivering the requested file as a function return
  return(od_file)
}
