# a. Crear un OBJETO llamado cosa definido como el resultado de la multiplicación: 5*6
cosa <- 5*6

# b. Crear un vector llamado nro_victimas que contenga los números 7, 12, 2 y 54
nro_victimas <- c(7, 12, 2, 54)

# c. Modificar en el mismo vector nro_victimas el segundo elemento y asignarle el valor 5
nro_victimas[2] <- 5

# d. Crear 2 vectores con la misma cantidad de valores que nro_victimas, pero de tipo texto (character).
tipos <- c("nombre", "apellido", "usuario", "email")
descripcion <- c("bau", "byte", "buabyte", "baubyte@gmail.com")

# e. Crear y nombrar un objeto de tipo dataframe que sea la combinación de todos los vectores creados previamente
dataFrameCombinacion <- data.frame(nro_victimas, tipos, descripcion)

# f. Crear un objeto llamado otra_cosa que guarde el valor contenido en la segunda fila y tercera columna del dataframe creado anteriormente
otra_cosa <- dataFrameCombinacion[2,3]

# g. Crear un vector con el siguiente contenido:
vector <- c("1", "dos", 3, "CUATRO", 5, NA)

# h_1. Calcular el promedio de nro_victimas para el dataframe creado
mean(dataFrameCombinacion$nro_victimas)

# h_2. Verificar de qué tipo es el vector recientemente creado
class(vector)

# i. Sobre el dataframe creado, ejecutar las siguientes funciones y describir brevemente qué hace cada una:
dim(dataFrameCombinacion) # Retorna la dimensión del data.frame

names(dataFrameCombinacion) # Retorna las columnas del data.frame

summary(dataFrameCombinacion) # Retorna un resumen del data.frame "Columnas su longitud,clase, valor min masx"

length(dataFrameCombinacion) # Retorna la cantidad de columnas data.frame

str(dataFrameCombinacion) # Retorna la estructura interna del data.frame