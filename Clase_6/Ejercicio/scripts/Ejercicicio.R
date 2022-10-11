library("tidyverse")
baseSnic <- read.csv2("https://estadisticascriminales.minseg.gob.ar/datos/snic-departamentos-mes-sexo.csv")

### Armo tabla
tablaEjercicio <- baseSnic %>% 
  filter(!is.na(cantidad_hechos)) %>% 
  group_by(anio, mes) %>% 
  summarise(cantidad_hechos = sum(cantidad_hechos)) %>% ungroup() %>% 
  mutate(anio = factor(anio),
         mes = factor(mes))

### Completar donde haya ____
tablaEjercicio %>% 
  ggplot(aes(x = mes, y = cantidad_hechos, color = anio, group = anio)) +
  geom_line()
