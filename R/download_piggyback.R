#' Download file from odbr using piggyback
#'
#' @param filename_to_download String. The name of the file to be downloaded.
#'
#' @return A string with the path to the file saved in a tempdir
#'
#' @keywords internal
download_piggyback <- function(filename_to_download) {
  # Validate input parameter
  if (missing(filename_to_download) || !nzchar(filename_to_download)) {
    stop("Parameter 'filename_to_download' must be a non-empty string.")
  }

  # Defining our temporary directory
  temp_dest_dir <- tempdir(check = TRUE)

  # Creating the temporary folder effectively
  fs::dir_create(path = temp_dest_dir, recurse = TRUE)

  # Use file.path for proper path concatenation
  temp_full_file_path <- file.path(temp_dest_dir, filename_to_download)

  # Print the temp_full_file_path to the console
  message("Downloading file to: ", temp_full_file_path)


  # Attempt to download using tryCatch for improved error handling
  tryCatch({
    piggyback::pb_download(
      file = filename_to_download,
      repo = "hsvab/odbr",
      dest = temp_dest_dir
    )
  }, error = function(e) {
    message("Error during download: ", e$message)
    return(invisible(NULL))
  })

  # Check if the file was downloaded successfully
  if (!file.exists(temp_full_file_path)) {
    #use the gh_rate_limits() function to check the rate limits for the type "core"
    gh::gh_rate_limits("core")

    message("Download failed: Check internet connection, file name or if you are logged in into github to avoid rate limiting.") # nolint: line_length_linter.
    invisible(NULL)
  } else {
    # return string with the path to the file saved in a tempdir
    return(temp_full_file_path)
  }
}
