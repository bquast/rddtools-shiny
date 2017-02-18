library(tibble)
library(rddtools)
library(haven)
library(readr)
library(readxl)


data(house)

##
write_csv(house, "TestFiles/house.csv")
write_dta(house, "TestFiles/house.dta")
write_sav(house, "TestFiles/house.sav")
write_sas(house, "TestFiles/house.sas")

## read?
read_excel("TestFiles/house.xls")
