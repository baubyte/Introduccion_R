#library(tidyverse)
HOGAR  <- c(1,1,1,1,2,3,3)

MIEMBRO  <- c(1,2,3,4,1,1,2)

SEXO  <-  c("Varon","Mujer","Mujer","Varon","Mujer","Varon","Mujer")

EDAD  <-  c(60,54,18,27,32,71,66)

NIVEL_ED  <-  c("Secundario","Terciario","Secundario","Secundario","Universitario",NA,"Primario")

ESTADO  <-  c("Ocupado","Ocupado","Inactivo","Desocupado","Ocupado","Inactivo","Inactivo")

datos <- data.frame(HOGAR,MIEMBRO, SEXO, EDAD, NIVEL_ED, ESTADO)

# Sirve para resumir/agrupar la información de una base de datos en una 
# nueva tabla. Para ello, es necesario definir las variables de resumen y la 
# función de agregación.
datos %>% 
  summarise(edadProm = mean(EDAD))

# Esta función permite realizar operaciones de forma agrupada. Lo que hace 
# la función es agrupar las observaciones (filas) según las categorías de 
# la/s variable/s indicada en la función group_by y dentro de cada uno de esos 
# “grupos de observaciones” de la tabla, hacer la operación especificada de 
# manera independiente. En nuestro ejemplo, sería útil para calcular el 
# promedio de edad por ESTADO
datos %>% 
  group_by(ESTADO) %>%
  summarise(edadProm = mean(EDAD))

datos %>% 
  group_by(SEXO,ESTADO) %>%
  summarise(edadProm = mean(EDAD))

datos %>% 
  filter(HOGAR == 1) %>% 
  rename(NMIEMBRO = MIEMBRO) %>% 
  mutate(GRUPO_EDAD = case_when(EDAD < 29 ~ "Joven",
                                EDAD >=29 & EDAD<60  ~ "Adulto",
                                EDAD >=60  ~ "Adulto mayor"
                                )
         ) %>%
  select(-NIVEL_ED)

# Otra implementación muy importante del paquete dplyr son las funciones 
# para unir diferentes tablas (joins)
# left_join
# un ejemplo de la función left_join (una de las más utilizadas en la práctica).
# Para ello crearemos previamente otro Dataframe que contenga un Ponderador 
# para cada hogar del Dataframe Datos.
ponderadores <- data.frame(HOGAR = c(1,2,3),
                           PONDERADOR = c(264,520,310)
                           )
ponderadores

datosJoin <- datos %>% 
  left_join(.,ponderadores, by = "HOGAR")
datosJoin
# Ahora, aprovecharemos el ejemplo para introducir la función weigthed.mean, 
# y así calcular un valor ponderado, en nuestro caso, la edad promedio ponderada.
edadPromPonderada <- datosJoin %>% 
  summarise(edadProm = weighted.mean(EDAD,w = PONDERADOR))
edadPromPonderada

# El paquete tidyr esta pensado para facilitar la visualización de los datos 
# ordenandolos de la manera más conveniente.
# pivot_longer() es una función que nos permite pasar los datos de forma 
# horizontal a una forma vertical.
# pivor_wider() es una función que nos permite pasar los datos de forma 
# vertical a una forma horizontal.
# Usaremos un recorte de la base para mostrar como operan estas funciones:
datosRecorte <- datos %>% 
  group_by(ESTADO,SEXO) %>%
  summarise(EDAD_PROM = mean(EDAD))
datosRecorte

datosLonger <- datosRecorte %>% 
  pivot_wider(.,                  # el . llama a lo que esta atras del %>% 
              names_from = SEXO,         #la llave es la variable cuyos valores van a dar los nombres de columnas
              values_from = EDAD_PROM
              )  #los valores con que se llenan las celdas
datosLonger

##La función opuesta (gather) nos permite obtener un dataframe como el original partiendo de un dataframe como el recién construido.

datosWider <- datosLonger %>%  
  pivot_longer(.,           # el . llama a lo que esta atras del %>% 
               names_to = "SEXO",      # como se llamará la variable que toma los nombres de las columnas 
               values_to = "EDAD_PROM", # como se llamará la variable que toma los valores de las columnas
               cols =  2:3
               ) #le indico que columnas juntar

datosWider