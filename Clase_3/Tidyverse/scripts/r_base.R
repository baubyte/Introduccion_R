HOGAR  <- c(1,1,1,1,2,3,3)

MIEMBRO  <- c(1,2,3,4,1,1,2)

SEXO  <-  c("Varon","Mujer","Mujer","Varon","Mujer","Varon","Mujer")

EDAD  <-  c(60,54,18,27,32,71,66)

NIVEL_ED  <-  c("Secundario","Terciario","Secundario","Secundario","Universitario",NA,"Primario")

ESTADO  <-  c("Ocupado","Ocupado","Inactivo","Desocupado","Ocupado","Inactivo","Inactivo")

datos <- data.frame(HOGAR,MIEMBRO, SEXO, EDAD, NIVEL_ED, ESTADO)
# Para tener una vista preliminar y conocer la estructura básica de nuestros 
# datos, podemos usar la función str. La misma nos indica la cantidad de 
# observaciones y de variables de nuestra base, y para cada variable nos indica 
# el tipo de variable y nos muestra las primeras observaciones:
str(datos)
# Nos sirve para conocer los estadísticos principales de las variables:
summary(datos)
# Si quisiéramos conocer los nombres de las variables de nuestro dataframe, podríamos usar la función names:
names(datos)
# Otra función muy útil es table, que nos da la frecuencia de una variable.
table(datos$NIVEL_ED)
# Para conocer si hay missing values y cuáles son las variables que los 
# contienen, podemos hacerlo ejecutando el siguiente comando:
is.na(datos)
# También podemos hacerlo para una variable específica de nuestro dataframe:
is.na(datos$HOGAR)
# Para que la tabla nos muestre también la frecuencia de los valores 
# perdidos es necesario especificarlo.
table(datos$NIVEL_ED, exclude = NULL)
# Supongamos ahora que la variable EDAD tiene un missing value:
datos$EDAD[2] <- NA
datos$EDAD
# Que sucedería si queremos calcular el promedio de edad?
mean(datos$EDAD)
# El resultado que obtenemos es nulo. Entonces, para poder calcular el 
# promedio de una variable que tiene datos perdidos, considerando únicamente 
# todos los valores válidos, tenemos que agregar na.rm = TRUE
mean(datos$EDAD, na.rm = TRUE)
# Lo mismo nos sucedería con otras funciones que hacen operaciones sobre 
# variables numéricas con valores perdidos, por ejemplo:
sum(datos$EDAD)
sum
# Pero no si simplemente queremos contar la cantidad de elementos de un vector:
length(datos$EDAD)
# Volvemos a corregir el dato y lo dejamos como estaba originalmente:
datos$EDAD[2] <- 54
datos$EDAD
