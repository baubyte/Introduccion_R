library("tidyverse")
baseSnic <- read.csv2("https://estadisticascriminales.minseg.gob.ar/datos/snic-departamentos-mes-sexo.csv")

byColumnName <- baseSnic %>%
  select(provincia_id, provincia_nombre, dpto_id, dpto_nombre)

byColumnIndex <- baseSnic %>%
  select(8,1,6,7)

byColumnPattern <- baseSnic %>%
  select(starts_with("victimas"), ends_with("victimas"), contains("_id"))

byidProvinceAndCodCrime <- baseSnic %>%
  filter(provincia_id %in% c(2,4,3)) %>%
  filter(codigo_delito_snic_nombre  == "Violaciones")

rangeCant <- baseSnic %>%
  mutate(
    rango_hecho = case_when(
      cantidad_hechos < 5 ~ "Bajo",
      cantidad_hechos >= 5 & cantidad_hechos  < 10  ~ "Medio",
      cantidad_hechos >= 10 & cantidad_hechos < 15  ~ "Moderado",
      cantidad_hechos >= 15 & cantidad_hechos < 20  ~ "Alto",
      cantidad_hechos >= 20  ~ "Alerta"
      )
    )