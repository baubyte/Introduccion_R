HOGAR  <- c(1,1,1,1,2,3,3)

MIEMBRO  <- c(1,2,3,4,1,1,2)

SEXO  <-  c("Varon","Mujer","Mujer","Varon","Mujer","Varon","Mujer")

EDAD  <-  c(60,54,18,27,32,71,66)

NIVEL_ED  <-  c("Secundario","Terciario","Secundario","Secundario","Universitario",NA,"Primario")

ESTADO  <-  c("Ocupado","Ocupado","Inactivo","Desocupado","Ocupado","Inactivo","Inactivo")

datos <- data.frame(HOGAR,MIEMBRO, SEXO, EDAD, NIVEL_ED, ESTADO)

# Permite filtrar observaciones de una base de datos acorde al cumplimiento de 
# condiciones lógicas
filter(datos,EDAD>40 & ESTADO == "Ocupado")
# O, lo que es lo mismo:
datos %>%
  filter(EDAD>40 , ESTADO == "Ocupado")
# Permite renombrar una columna (variable) de la base de datos.
# Funciona de la siguiente manera: Data %>% rename( nuevo_nombre = viejo_nombre )
datos %>% 
  rename(NMIEMBRO = MIEMBRO)
# Sirve para crear una nueva variable en la base de datos. Se debe 
# especificar el nombre de la nueva variable seguido de el signo “=” y a 
# continuación la definición de cómo se conforma la nueva variable. La misma 
# puede ser el resultado de operaciones sobre otras variables de la misma tabla.
datos %>% 
  mutate(EDAD_ALCUADRADO=EDAD*EDAD)
# Permite definir condiciones excluyentes. Se puede utilizar en conjunto con 
# la función “mutate” para crear una variable que tome determinados valores 
# cuando cumple una condición. En caso de no cumplir ninguna de las condiciones 
# establecidas la variable tomara valor NA.
datos <- datos %>% 
  mutate(GRUPO_EDAD = 
           case_when(
             EDAD < 29 ~ "Joven",
             EDAD >=29 & EDAD<60  ~ "Adulto",
             EDAD >=60  ~ "Adulto mayor"
             )
         )
datos
# Permite especificar la serie de columnas que se desea conservar de un 
# DataFrame. También pueden especificarse las columnas que se desean 
# descartar (agregándoles un -). Muy útil para agilizar el trabajo en bases 
# de datos de gran tamaño.
datos %>% 
  select(HOGAR,MIEMBRO,SEXO)
datos %>% 
  select(-c(SEXO,GRUPO_EDAD))
# Permite ordenar una tabla por los valores de determinada/s variable/s. 
# Es útil cuando luego deben hacerse otras operaciones que requieran del 
# ordenamiento de la tabla
datos %>% 
  arrange(ESTADO, EDAD)
datos %>% 
  arrange(desc(ESTADO), EDAD)