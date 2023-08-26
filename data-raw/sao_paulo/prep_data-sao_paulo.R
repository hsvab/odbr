# year 1977 ---------------------------------------------------------------

# lendo arquivo bruto
od_sp_1977_not_harmonized <- read_sav("data-raw/sao_paulo/1977/not_harmonized/od_sao-paulo_1977_not-harmonized.sav")

# salvando arquivo em formato compactado (.gz)
readr::write_csv2(od_sp_1977_not_harmonized, "data-raw/sao_paulo/1977/not_harmonized/od_sao-paulo_1977_not-harmonized.csv.gz")

# Criar uma release nova no repositório
piggyback::pb_new_release(repo = "hsvab/odbr",
                          tag = "v0.0.1")

# Subindo o arquivo para um release do repo odbr, release especificado no parâmetro
piggyback::pb_upload(file = "data-raw/sao_paulo/1977/not_harmonized/od_sao-paulo_1977_not-harmonized.csv.gz",
                     repo = "hsvab/odbr",
                     tag = "v0.0.1")

# Disponibilizar o dicionário de dados
od_sp_1977_not_harmonized_dictionary <- readr::read_csv2("data-raw/sao_paulo/1977/not_harmonized/od_sao-paulo_1977_not-harmonized-dicionary.csv")

#
usethis::use_data(od_sp_1977_not_harmonized_dictionary)
