#' Download file from odbr using piggyback
#'
#' @param filename_to_download String. The name of the file to be downloaded.
#' @param force_download Logical. If `FALSE` (default) the function will read
#'        cached data downloaded previously in the same session. If `TRUE`, the
#'        function will download the data and overwrite cached data.
#'
#' @return A string with the path to the file saved in a tempdir
#'
#' @keywords internal
download_piggyback <- function(filename_to_download,
                               force_download = FALSE) {

  # Defining our temporary directory
  temp_dest_dir <- tempdir(check = TRUE)

  # Creating the temporary folder effectively
  fs::dir_create(path = temp_dest_dir, recurse = TRUE)

  # Creating path + filename and saving to "temporary_filename"
  temp_full_file_path <- paste0(temp_dest_dir, "/", filename_to_download)

  if (!file.exists(temp_full_file_path) || force_download) {
    # downloading the file from a release of the odbr repo - release specified in the parameter
    piggyback::pb_download(
      file = filename_to_download,
      repo = "hsvab/odbr",
      dest = temp_dest_dir
    )
  }

  # return string with the path to the file saved in a tempdir
  return(temp_full_file_path)
}
