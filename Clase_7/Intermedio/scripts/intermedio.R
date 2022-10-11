### Cargo librería
library(tidyverse)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Cargo la base de Trabajo  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
baseSnic <- read_csv("https://estadisticascriminales.minseg.gob.ar/datos/snic-departamentos-mes-sexo.csv")


# IF
if( 2+2 == 4){
  print("Todo marcha bien")
}

if( 2+2 == 148.24){
  print("R, tenemos un problema")
}

# IF + ELSE
if(condicion){
  
  #codigo a ejecutar si se cumple la condición
  
} else {
  
  #codigo a ejecutar si NO se cumple la condición
}

#exists
baseCargada <- exists("baseSnic")
baseCargada

if (baseCargada == TRUE) {
  "La base ya se encuentra en el ambiete"
} else {
  print("La base no se encuentra en el ambiente, por lo que voy a importarla")
  base_snic <- read_csv2("../data/snic-departamentos-mes-sexo.csv")
}

# Funciones

suma <- function(valor1, valor2) {
  valor1+valor2
}
suma
suma(valor1 = 5,valor2 = 6)

# Creamos la función
pegaTexto <- function(parametro1,parametro2) {
  
  paste(parametro1, parametro2, sep = " <--> ")
  
}

# Usamos la función
pegaTexto(parametro1 = "A ver", parametro2 = "que pasa")


# Creamos la función
otraFuncionPrueba <- function(parametro1,parametro2 = "colgado") {
  paste(parametro1, parametro2, sep = ", ")
}

otraFuncionPrueba(parametro1 = "Hola")


calculaRatio <- function(vector) {
  vector.max  <-   max(vector)
  vector.min  <-   min(vector)
  return(vector.max/vector.min)
}

ratio <- calculaRatio(vector = c(1,2,3,4))
ratio

calculaRatio(vector = c(1,2,3,4,"H"))


calculaRatio <- function(vector) {
  
  assertthat::assert_that(is.numeric(vector),
                          msg = "Ingresá un vector numérico!")
  
  
  vector.max  <-   max(vector)
  vector.min  <-   min(vector)
  
  
  return(vector.max/vector.min)
}

calculaRatio(vector = c(1,2,3,4,"H"))

calculaRatio(vector = c(1,2,3,4,0))


calculaRatio <- function(vector) {
  
  assertthat::assert_that(is.numeric(vector),
                          msg = "Ingresa un vector numérico")
  
  if(any(vector==0)){
    
    warning("Mensaje: Hay un cero en tu vector, no lo tomo en cuenta para el calculo")
    vector <- vector[vector!=0]
    
  }
  vector.max  <-   max(vector)
  vector.min  <-   min(vector)
  
  
  return(vector.max/vector.min)
}
calculaRatio(vector = c(1,2,3,4))

#Loops

for(i in 1:10){
  print(i^2)
  
}

for(valor in 1:10){
  print(valor^2)
}

tabla <- baseSnic %>% 
  group_by(provincia_nombre) %>% 
  summarise(cantidad_victimas = sum(cantidad_victimas, na.rm = TRUE))

categoriasProvincias <- unique(tabla$provincia_nombre)
categoriasProvincias


tablaTucuman  <- tabla %>% 
  filter(provincia_nombre == "Tucumán")  

ggplot(data = tablaTucuman,
       aes(x = provincia_nombre, y = cantidad_victimas)) +
  geom_col()

for(provincia in categoriasProvincias){
  
  tablaGrafico <- tabla %>% 
    filter(provincia_nombre == provincia)  
  
  grafico <- ggplot(data = tablaGrafico,
                    aes(x = provincia_nombre, y = cantidad_victimas)) +
    geom_col() +
    geom_text(aes(label = cantidad_victimas),
              vjust = -0.5) +
    labs(title = paste0("Cantidad de hechos en la provinciaa de ", provincia)) +
    theme_minimal()
  
  print(grafico)
  
}