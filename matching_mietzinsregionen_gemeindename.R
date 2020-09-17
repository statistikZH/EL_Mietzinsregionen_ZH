library(readr)
library(dplyr)

data_drz7D <- read_csv("data-drz7D.csv")

gemeinden <- readxl::read_excel("BFS_Gemeindestand_2020.xlsx")


el_mietzinsregionen <- data_drz7D %>%
  left_join(., gemeinden, by=c("Gemeinde" = "Gemeindename")) %>%
  filter(Kanton == "ZH") %>%
  select(Kanton, "Gemeindenummer" = `BFS Gde-nummer`, Gemeinde, "Bezirksnummer" = `Bezirks-nummer`, Bezirksname, "EL_Region" = Region) %>%
  mutate(EL_Region_Label = case_when(EL_Region == 1 ~ "Grosszentren",
                                     EL_Region == 2 ~ "Stadt",
                                     EL_Region == 3 ~ "Land"))

write_csv(el_gem_regio, "el_gemeinden_mietzinsregionen.csv")
