# The "download_piggyback" function requires as parameter the filename_to_download
download_piggyback <- function(filename_to_download, force_download = FALSE) {
  # Defining our temporary directory
  temp_dest_dir <- tempdir(check = TRUE)

  # Creating the temporary folder effectively
  fs::dir_create(path = temp_dest_dir, recurse = TRUE)

  # Creating path + filename and saving to "temporary_filename"
  temp_full_file_path <- paste0(temp_dest_dir, "/", filename_to_download)

  if (!file.exists(temp_full_file_path) || force_download) {
    # Uploading the file to a release of the odbr repo - release specified in the parameter
    piggyback::pb_download(
      file = filename_to_download,
      repo = "hsvab/odbr",
      dest = temp_dest_dir
    )
  }

  # The function returns the R object "temporary_filename"
  return(temp_full_file_path)
}
