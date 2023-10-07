% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_od.R
\name{read_od}
\alias{read_od}
\title{Download microdata from OD Surveys databases}
\usage{
read_od(city = "São Paulo", year = 1977, harmonize = FALSE)
}
\arguments{
\item{city}{Character. City of reference. Defaults to "São Paulo".}

\item{year}{Numeric. Year of reference in the format \code{yyyy}. Defaults to
\code{1977}.}

\item{harmonize}{Logical. When \code{FALSE} (Default), the function returns the raw
data. If \code{TRUE}, the function returns harmonized data to the same
city, across all the years.}
}
\description{
The "read_od" function requires as parameter city, year and whether you want the harmonized database (over the years, for the same city) or not - the default is the raw base
}