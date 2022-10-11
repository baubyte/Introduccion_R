library(flipbookr)
library(tidyverse)
library(xaringanthemer)
library(xaringan)
library(gt)
#library(icons)
library(here)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Cargo la base de trabajo  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
baseSnic <- read_csv("https://estadisticascriminales.minseg.gob.ar/datos/snic-departamentos-mes-sexo.csv")

# Armo tabla
tablaVictimas <- baseSnic %>% 
  filter(!is.na(cantidad_victimas) & codigo_delito_snic_id == 1) %>% 
  mutate(periodo = paste0(anio, "_", mes)) %>% 
  group_by(periodo) %>% 
  summarise(cant_victimas_h_doloso = sum(cantidad_victimas, na.rm = TRUE))

tablaVictimas <- baseSnic %>% 
  filter(!is.na(cantidad_victimas) & codigo_delito_snic_id == 1) %>% 
  mutate(periodo = paste0(anio, "_", mes),
         anio_mes = lubridate::ym(periodo)) %>% 
  group_by(anio_mes) %>% 
  summarise(cant_victimas_h_doloso = sum(cantidad_victimas, na.rm = TRUE))

# geom_line()
graficoVictimas <- tablaVictimas %>% 
  ggplot(
    aes(x = anio_mes,
        y = cant_victimas_h_doloso,
        group = "")) +
  geom_line() +
  labs(title = "Cantidad de víctimas por homicidio doloso por mes",
       subtitle = "Años 2017 a 2020. Total país.",
       x = "Período",
       y = "Cantidad de víctimas")

graficoVictimas

graficoVictimas +
  scale_x_date(date_breaks = "2 month",
               date_labels = '%b %Y') +
  ylim(0, 300) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 8, 
                               face = "italic"))

tablaVictimasXmes <- baseSnic %>% 
  filter(!is.na(cantidad_victimas) & codigo_delito_snic_id == 1) %>% 
  mutate(periodo = paste0(anio, "_", mes),
         anio_mes = lubridate::ym(periodo)) %>% 
  pivot_longer(cols = starts_with("victimas_"),
               names_to = "genero_victima",
               values_to = "cantidad") %>% 
  group_by(anio_mes, genero_victima) %>% 
  summarise(cantidad = sum(cantidad))

tablaVictimasXmes %>% 
  head()


ggplot(data = tablaVictimasXmes,
       aes(x = anio_mes,
           y = cantidad,
           color = genero_victima,
           group = genero_victima)) +
  geom_line(stat='summary') +
  scale_x_date(date_breaks = "2 month",
               date_labels = '%b %Y') +
  labs(title = "Cantidad de víctimas por homicidio doloso según género",
       subtitle = "Anos 2017 a 2020. Total país",
       x = "Período",
       y = "Cantidad de víctimas",
       fill = "Género de la víctima") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 8, face = "italic"),
    panel.grid = element_blank(),
    panel.background = element_rect(fill = "lemonchiffon", colour = "black", size = 1),
    legend.position = "bottom")


themeBaubyte <- function() {
  
  theme(
    # plotting components
    
    ## Cambiamos las líneas de la grilla
    panel.grid.minor = element_blank(),
    panel.grid.major =  element_line(color = "#d0d0d0"),
    # Fondo del panel y de la imágen + bordes
    panel.background = element_rect(fill = "#f0f0f0", color = NA),
    plot.background = element_rect(fill = "#f0f0f0", color = NA),
    panel.border = element_blank(),
    # Márgenes del gráfico and remove axis ticks
    plot.margin = margin(0.5, 1, 0.5, 1, unit = "cm"),
    axis.ticks = element_blank(),
    # Cambio de fuentes, tamaño y posición en títulos
    text = element_text(size = 12),
    axis.text = element_text(face = "bold", color = "grey", size = 12),
    axis.title = element_text(face = "bold", size = rel(1.33)),
    axis.title.x = element_text(margin = margin(0.5, 0, 0, 0, unit = "cm")),
    axis.title.y = element_text(margin = margin(0, 0.5, 0, 0, unit = "cm"), angle =90),
    plot.title = element_text(face = "bold", size = rel(1.67), hjust = 0),
    plot.title.position = "plot",
    plot.subtitle = element_text(size = 16, margin = margin(0.2, 0, 1, 0, unit = "cm"), hjust = 0),
    plot.caption = element_text(size = 10, margin = margin(1, 0, 0, 0, unit = "cm"), hjust = 1),
    strip.text = element_text(size = rel(1.33), face = "bold")
  )
}

tablaVictimasXmes %>% 
  ggplot(aes(x = anio_mes,
             y = cantidad,
             color = genero_victima,
             linetype = genero_victima)) +
  geom_line(aes(group = genero_victima),
            size = 2) +
  labs(title = "Cantidad de casos confirmados por fecha de diagnóstico",
       x = "Fecha de diagnóstico",
       y = "Cantidad de casos") +
  themeBaubyte()