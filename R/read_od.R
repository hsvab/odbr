
# read_od (city = , year = , harmonize = TRUE/FALSE)
# harmonize vai filtrar se vamos pegar as bases compatibilizadas ou não

read_od <- function(city = "São Paulo", year = 1977, harmonize = FALSE) {

# checar argumentos: se passar cidade inexistente, dá mensagem de erro
if(!city %in% metadata$city){
  usethis::ui_stop("The specified city ({city}) is not available.
                   Check the metadata object for available cities and cohorts.")
}

# checar argumentos: se passar cidade + ano inexistente, dá mensagem de erro


# checar argumentos: se passar cidade + ano + parâmetro de hamonized inexistente
# dá mensagem de erro


# Crio um caminho de um arquivo temporário e salvo no objeto temp do R
temp <- fs::file_temp()

# Crio o nome do arquivo que quero fazer download
filename_to_download <- "od_sao-paulo_1977_not-harmonized.csv.gz"

# TODO: compor o nome do arquivo que vamos baixar

# Crio efetivamnete a pasta temporária
fs::dir_create(temp)

# Crio o caminho + nome de arquivo
temporary_filename <- paste0(temp, "/", filename_to_download)

# Subindo o arquivo para um release do repo odbr, release especificado no parâmetro
piggyback::pb_download(file = filename_to_download,
                         repo = "hsvab/odbr",
                         tag = "v0.0.1",
                         dest = temp)

# Subindo o arquivo para um release do repo odbr, release especificado no parâmetro
od_file <- readr::read_csv2(temporary_filename)

fs::dir_delete(temp)

od_file

}
