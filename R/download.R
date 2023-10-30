# Requiring as parameter the filename_to_download it returns the R object "temporary_filename"
download_piggyback <- function(filename_to_download, force_download = FALSE) {
  # Defining our temporary directory
  temp_dest_dir <- tempdir(check = TRUE)

  # Creating the temporary folder effectively
  fs::dir_create(path = temp_dest_dir, recurse = TRUE)

  # Creating path + filename and saving to "temporary_filename"
  temp_full_file_path <- paste0(temp_dest_dir, "/", filename_to_download)

  connected_to_the_internet <- curl::has_internet()

  # If its not connected to the internet,
  # return message.
  if(isFALSE(connected_to_the_internet) & !file.exists(temp_full_file_path)){
    temp_full_file_path <- ""
    return(message("There is no internet connection."))
  } else if(isFALSE(connected_to_the_internet) & force_download){
    temp_full_file_path <- ""
    return(message("There is no internet connection."))
  } else if(isFALSE(force_download) & file.exists(temp_full_file_path)){
    return(temp_full_file_path)
  } else if (isTRUE(connected_to_the_internet) & !file.exists(temp_full_file_path) || force_download) {
    # Downloading the file to a release of the odbr repo - release specified in the parameter
    piggyback::pb_download(
      file = filename_to_download,
      repo = "hsvab/odbr",
      dest = temp_dest_dir
    )
  }

  # return path of the downloaded file
  return(temp_full_file_path)
}
