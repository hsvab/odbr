# The "download_piggyback" function requires as parameter the filename_to_download
download_piggyback <- function(filename_to_download) {
  # Defining a temporary file path and saving it in "temp"
  temp <- fs::file_temp()

  # Creating the temporary folder effectively
  fs::dir_create(temp)

  # Creating path + filename and saving to "temporary_filename"
  temporary_filename <- paste0(temp, "/", filename_to_download)

  # Uploading the file to a release of the odbr repo - release specified in the parameter
  piggyback::pb_download(
    file = filename_to_download,
    repo = "hsvab/odbr",
    dest = temp
  )
  # The function returns the R object "temporary_filename"
  return(temporary_filename)
}
