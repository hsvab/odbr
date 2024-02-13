# Build the wordlist of valid words not in the "English" dictionary
build_wordlist <- function() {
  words <- c(
    "CMD",
    "CRS",
    "Codecov",
    "Isoda",
    "Metrô",
    "Microdata",
    "Oliveira",
    "Paulo",
    "Rabatone",
    "SIRGAS",
    "Sao",
    "São",
    "Tani",
    "br",
    "de",
    "microdata",
    "od",
    "rOpenSci"
  )
  saveRDS(words, file = ".aspell/odbr.rds", version = 2)
}

# TODO: List down here all the commands we need to run while releasing a new
# version of the package, including all tests, documentation building, etc.
build_wordlist()
devtools::build_manual()
devtools::build_readme()
devtools::build_vignettes()
# devtools::build_site() # deployed via gh pages
devtools::lint()
lintr::lint_package()
devtools::build()
devtools::check()
