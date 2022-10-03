library("tidyverse")
baseSnic <- read.csv2("https://estadisticascriminales.minseg.gob.ar/datos/snic-departamentos-mes-sexo.csv")


tablaDelitos <- baseSnic %>%
  filter(anio == 2020 & !is.na(codigo_delito_snic_nombre) & cantidad_hechos > 0) %>% 
  group_by(codigo_delito_snic_nombre) %>%
  summarise(cant_hechos = sum(cantidad_hechos)) %>%
  arrange(desc(cant_hechos)) %>%
  head(n = 15)

# a
ggplot(head(tablaDelitos), aes(x=codigo_delito_snic_nombre, y=desc(cant_hechos))) + 
  geom_bar(stat = "identity") +
  coord_flip()

# b
victimasProvincia <- baseSnic %>% 
  filter(anio == 2018 & cantidad_victimas > 0 & provincia_nombre != "" & !is.na(codigo_delito_snic_nombre)) %>% 
  group_by(provincia_nombre) %>%
  summarise(cant_victimas = sum(cantidad_victimas))

ggplot(victimasProvincia) +
  geom_bar(aes(x = provincia_nombre, weight = cant_victimas), color = "green")+
  coord_flip() +
  labs(title = "Victimas por Provincias",
       subtitle = "Año 2018",
       caption = "Gráfico solo de Practica",
       x = "PROVINCIA",
       y = "CANTIDAD VICTIMAS")   
# c

victimasCabaComuna1 <- baseSnic %>% 
  filter(anio == 2017 & dpto_nombre == "Comuna 1"& cantidad_victimas > 0 & provincia_nombre != "" & !is.na(codigo_delito_snic_nombre) & codigo_delito_snic_nombre == "Lesiones dolosas") %>% 
  group_by(mes) %>%
  summarise(victimas_masculino = sum(victimas_masculino))


victimasCabaComuna1  %>%
  ggplot(aes(x=mes,y=victimas_masculino,))+
  geom_col(fill = "black",colour ="green",alpha = 0.4,)+
  labs(title = "VICTIMAS MASCULINAS",
       subtitle = "AÑO 2017",
       x = "DELITOS DOLOSOS",
       y = "CANTIDAD DE VICTIMAS",
       source = "Fuente : Elaboracion propia en base a SNIC")
