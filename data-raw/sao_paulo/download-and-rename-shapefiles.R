# Saving gkpg --------------

# Composing the name of the new directory ------------------
city <- "sao_paulo"
year <- 2023
directory <- paste0("data-raw/", city, "/", year, "/not_harmonized/")


# Create directory ----------------
dir.create(directory)

# Download zip file ---------------------------
# Be careful not to upload this to GitHub.
# It is a large file!

destfile_path <- paste0(directory, "pesquisa_od.zip")


zip_file <- paste0(
  "https://transparencia.metrosp.com.br/sites/",
  "default/files/Site_190225_PesquisaOD2023.zip"
)


download.file(url = zip_file, destfile = destfile_path)

# Unzip the file -----------

zip::unzip(zipfile = destfile_path, exdir = directory)


# List files in the directory

ls_dir <- list.files(directory, recursive = TRUE, full.names = TRUE)

# Finding shapefiles in the directory ----

shapefiles <- stringr::str_subset(ls_dir, ".shp$|.shx$|.dbf$|.prj$|.cpg") |>
  stringr::str_subset("Municipios|Distritos|Zonas")

# Copy shapefiles to the new directory ----
fs::file_copy(shapefiles, directory)


# Finding new shapefiles in the directory ----

ls_dir_2 <- list.files(directory, recursive = FALSE, full.names = TRUE)

shapefiles_2 <- stringr::str_subset(ls_dir_2, ".shp$|.shx$|.dbf$|.prj$|.cpg") |>
  stringr::str_subset("Municipios|Distritos|Zonas")


# Check if names are following the pattern -------

rename_files <- function(name) {
  file_name <- basename(name)
  level <- stringr::str_extract(file_name, "Municipios|Distritos|Zonas")
  year <- stringr::str_extract(file_name, "[0-9]{4}")
  file_extension <- tools::file_ext(file_name)
  new_name <- paste0(level, year, "_region.", file_extension)
  new_path <- stringr::str_replace(name, file_name, new_name)
  fs::file_move(name, new_path)
}

possibly_rename_files <- purrr::possibly(rename_files, otherwise = NULL)

# Rename files ----
purrr::map(shapefiles_2, possibly_rename_files)
