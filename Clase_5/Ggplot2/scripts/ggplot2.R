library(tidyverse)
# rm(list = ls())
atencionCiudadano <- read.csv("./datos/gcba_suaci_comunas.csv")

contactosPorComuna <- atencionCiudadano %>% 
  group_by(COMUNA) %>% 
  summarise(miles_contactos = sum(total) / 1000 )

contactosPorComuna

habitantes <- read.csv("./datos/gcba_pob_comunas_17.csv")

habitantes

contactosPorComuna <- contactosPorComuna %>% left_join(habitantes)

# scatterplot
ggplot(contactosPorComuna)
# geom_point
ggplot(contactosPorComuna) + geom_point(aes(x = POBLACION, y = miles_contactos))
# factor por color
ggplot(contactosPorComuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos, color = factor(COMUNA)))

# factor por label
ggplot(contactosPorComuna) +
  geom_label(aes(x = POBLACION, y = miles_contactos, label = factor(COMUNA)))

# factor por size
ggplot(contactosPorComuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos, size = miles_contactos))

#faactor por forma shape
ggplot(contactosPorComuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos, shape = factor(COMUNA)))

# color
ggplot(contactosPorComuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), color = "blue")

# colores reconocido por R  http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf ;
ggplot(contactosPorComuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), color = "darkolivegreen4")

# tamaño
ggplot(contactosPorComuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), size = 5)

# 
ggplot(contactosPorComuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), 
             size = 9, color = "chocolate3", shape = 0)

# Facetado

summary(atencionCiudadano)

contactosPorComunatTipo <- atencionCiudadano %>% 
  group_by(COMUNA, TIPO_PRESTACION) %>% 
  summarise(miles_contactos = sum(total) / 1000 ) %>% 
  left_join(habitantes)

head(contactosPorComunatTipo)

# facet_wrap
ggplot(contactosPorComunatTipo) + 
  geom_point(aes(x = POBLACION, y = miles_contactos)) +
  facet_wrap(~TIPO_PRESTACION)

# Grafico de barras

ggplot(atencionCiudadano) +
  geom_bar(aes(x = BARRIO, weight = total))

# Desactivar Notacion cientifica
options(scipen = 999)

# eje vertical
ggplot(atencionCiudadano) +
  geom_bar(aes(x = BARRIO, weight = total)) +
  coord_flip()
# fill
ggplot(atencionCiudadano) +
  geom_bar(aes(x = BARRIO, weight = total, fill = TIPO_PRESTACION)) +
  coord_flip()

# color
ggplot(atencionCiudadano) +
  geom_bar(aes(x = BARRIO, weight = total, color = TIPO_PRESTACION)) +
  coord_flip()
# weight
ggplot(atencionCiudadano) +
  geom_bar(aes(x = TIPO_PRESTACION, weight = total)) 
# fill
ggplot(atencionCiudadano) +
  geom_bar(aes(x = TIPO_PRESTACION, weight = total, fill = BARRIO)) 

# facet_wrap
ggplot(atencionCiudadano) +
geom_bar(aes(x = TIPO_PRESTACION, weight = total)) +
  facet_wrap(~BARRIO)

# Histogramas

contactosPorMes <- atencionCiudadano %>% 
  group_by(PERIODO) %>% 
  summarise(gran_total = sum(total))

head(contactosPorMes)

ggplot(contactosPorMes) + 
  geom_histogram(aes(x = gran_total))

contactosPorMesTipo <- atencionCiudadano %>% 
  group_by(PERIODO, TIPO_PRESTACION) %>% 
  summarise(gran_total = sum(total))

head(contactosPorMesTipo)

ggplot(contactosPorMesTipo) + 
  geom_histogram(aes(x = gran_total)) +
  facet_wrap(~TIPO_PRESTACION)

ggplot(atencionCiudadano) +
  geom_bar(aes(x = BARRIO, weight = total, fill = TIPO_PRESTACION)) +
  coord_flip()

# LABS

ggplot(atencionCiudadano) +
  geom_bar(aes(x = BARRIO, weight = total, fill = TIPO_PRESTACION)) +
  coord_flip() +
  labs(title = "Contactos realizados al Sistema Único de Atención Ciudadana",
       subtitle = "Ciudad Autónoma de Buenos Aires, 2013 - 2015",
       caption = "Fuente: portal de datos abiertos de la Ciudad - http://data.buenosaires.gob.ar",
       x = "barrio",
       y = "cantidad",
       fill = "Motivo del contacto")

# THEME theme_minimal(), theme_dark(), theme_classic()
ggplot(atencionCiudadano) +
  geom_bar(aes(x = BARRIO, weight = total, fill = TIPO_PRESTACION)) +
  coord_flip() +
  labs(title = "Contactos realizados al Sistema Único de Atención Ciudadana",
       subtitle = "Ciudad Autónoma de Buenos Aires, 2013 - 2015",
       caption = "Fuente: portal de datos abiertos de la Ciudad - http://data.buenosaires.gob.ar",
       x = "barrio",
       y = "cantidad",
       fill = "Motivo del contacto") +
  theme_minimal()