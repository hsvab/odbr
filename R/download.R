#
download_piggyback <- function(filename_to_download) {

# Crio um caminho de um arquivo temporário e salvo no objeto temp do R
temp <- fs::file_temp()

# Crio efetivamnete a pasta temporária
fs::dir_create(temp)

# Crio o caminho + nome de arquivo
temporary_filename <- paste0(temp, "/", filename_to_download)

# Subindo o arquivo para um release do repo odbr, release especificado no parâmetro
piggyback::pb_download(file = filename_to_download,
                       repo = "hsvab/odbr",
                       tag = "v0.0.1",
                       dest = temp)

return(temporary_filename)

}
