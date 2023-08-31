# year 1977 ---------------------------------------------------------------

# Reading raw data
od_sp_1977_not_harmonized <- haven::read_sav("data_raw/sao_paulo/1977/not_harmonized/od_sao_paulo_1977_not_harmonized.sav")

# Compating the file (.gz)
readr::write_csv2(od_sp_1977_not_harmonized, "data_raw/sao_paulo/1977/not_harmonized/od_sao_paulo_1977_not_harmonized.csv.gz")

# Building a new release in the repo
piggyback::pb_new_release(repo = "hsvab/odbr",
                          tag = "v0.0.1")

# Uploading a file to a specific release from odbr repo (see parameter)
piggyback::pb_upload(file = "data_raw/sao_paulo/1977/not_harmonized/od_sao_paulo_1977_not_harmonized.csv.gz",
                     repo = "hsvab/odbr",
                     tag = "v0.0.1")

# Making the data dictionary available in the package
od_sao_paulo_1977_not_harmonized_dictionary_pt <- readr::read_csv2("data_raw/sao_paulo/dic/od_sao_paulo_1977_not_harmonized_dictionary_pt.csv")
usethis::use_data(od_sao_paulo_1977_not_harmonized_dictionary_pt)

od_sao_paulo_1977_not_harmonized_dictionary_en <- readr::read_csv2("data_raw/sao_paulo/dic/od_sao_paulo_1977_not_harmonized_dictionary_en.csv")
usethis::use_data(od_sao_paulo_1977_not_harmonized_dictionary_en)
