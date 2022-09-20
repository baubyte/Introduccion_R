library("tidyverse")
baseSnic <- read.csv2("https://estadisticascriminales.minseg.gob.ar/datos/snic-departamentos-mes-sexo.csv")

baseSnic %>%
  filter(anio %in% c(2017, 2018, 2019)) %>%
  group_by(anio) %>%
  summarise(cantidadHechos = sum(cantidad_hechos))

baseSnic %>%
  filter(anio %in% c(2017, 2018, 2019))%>%
  group_by(anio) %>%
  summarise(promedioHechos = mean(cantidad_hechos))

baseSnic %>%
  filter(anio %in% c(2017, 2018, 2019))%>%
  filter(provincia_nombre == "Tucumán")%>%
  filter(!is.na(cantidad_victimas))%>%
  group_by(anio)%>%
  summarise(cant_hechos = sum(cantidad_victimas))


baseSnic %>%
  filter(provincia_nombre %in% c("San Luis", "Santiago del Estero"))%>%
  filter(!is.na(cantidad_victimas))%>%
  mutate(semestre = case_when(mes <= 6 ~ "Primer Semestre",
                              mes >6  ~  "Segundo semestre"
                              )
         )%>%
  group_by(semestre)%>%
  summarise(cant_hechos = sum(cantidad_victimas))

baseSnic %>%
  filter(!is.na(cantidad_victimas))%>%
  group_by(provincia_nombre)%>%
  summarise(cant_hechos = sum(cantidad_victimas))