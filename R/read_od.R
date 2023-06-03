
read_od <- function(city, year, harmonize = FALSE) {

# checar argumentos: se passar cidade inexistente, dá mensagem de erro

# checar argumentos: se passar cidade + ano inexistente, dá mensagem de erro

# checar argumentos: se passar cidade + ano inexistente, dá mensagem de erro

temp <- fs::file_temp()

# Subindo o arquivo para um release do repo odbr, release especificado no parâmetro
piggyback::pb_download(file = "od_sao-paulo_1977_not-harmonized.csv.gz",
                         repo = "hsvab/odbr",
                         tag = "v0.0.1",
                         dest = temp)

}
