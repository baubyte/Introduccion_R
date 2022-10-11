library("tidyverse")
baseSnic <- read.csv2("./datos/snic-departamentos-mes-sexo.csv")

# Armo tabla condicional
isAnio = TRUE

if (isAnio) {
tablaEjercicio <- baseSnic %>% 
  filter(!is.na(cantidad_victimas)) %>% 
  group_by(anio) %>% 
  summarise(cantidad_victimas = sum(cantidad_victimas))
  
}else{
  tablaEjercicio <- baseSnic %>% 
    filter(!is.na(cantidad_victimas)) %>% 
    group_by(mes) %>% 
    summarise(cantidad_victimas = sum(cantidad_victimas))
}

saludo <- function(name){
  print(paste0("Hola ", name))
}
saludo("Martin")

incrementarCinco <- function(value){
  return(value+5)
}
incrementarCinco(8)

# Provincias
provincias <- unique(baseSnic$provincia_nombre)
provincias


hechosProvincias <- baseSnic %>% 
  group_by(provincia_nombre) %>% 
  filter(anio == 2019) %>%
  summarise(cantidad_hechos = sum(cantidad_hechos, na.rm = TRUE))


for (provincia in provincias) {
  
  tablaGrafico <- hechosProvincias %>% 
    filter(provincia_nombre == provincia)  
  
  grafico <- ggplot(data = tablaGrafico,
                    aes(x = provincia_nombre, y = cantidad_hechos)) +
    geom_col() +
    geom_text(aes(label = cantidad_hechos),
              vjust = -0.5) +
    labs(title = paste0("Cantidad de Hechos en la Provincia de ", provincia)) +
    theme_minimal()
  
  print(grafico)
  
}