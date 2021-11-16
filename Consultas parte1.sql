/*CONSULTA1*/
/*
Un listado de los inmigrantes por nacionalidades, 
presentando de mayor a menor el que país presenta 
un mayor número de inmigrantes
*/

SELECT
NA.NACIONALIDAD_DESCRIPCION AS NACIONALIDAD,
COUNT(CLIENTE.NACIONALIDAD_ID) AS TOTAL_DE_INMIGRANTES
FROM CLIENTE
INNER JOIN NACIONALIDAD NA ON CLIENTE.NACIONALIDAD_ID=NA.NACIONALIDAD_ID
GROUP BY NA.NACIONALIDAD_DESCRIPCION
ORDER BY COUNT(CLIENTE.NACIONALIDAD_ID) DESC;

/*CONSULTA2*/
/*
Las fechas de mayor movilidad humana
*/

SELECT 
REGISTRO_FECHA_INGRESO AS FECHA_DE_MOVILIDAD
FROM REGISTRO
ORDER BY REGISTRO_FECHA_INGRESO ASC;


/*CONSULTA3*/
/*
Mostrar histórico entre el tiempo de arribo al país 
y el tiempo en acercarse al departamento de migración. 
En una columna debe aparecer los nombres y apellidos, 
en otra columna la fecha de arribo y en otra columna 
la fecha de acercamiento a migración.
*/

SELECT
REGISTRO_FECHA_REGISTRO::DATE - REGISTRO_FECHA_INGRESO::DATE AS DIAS_DE_DIFERENCIA_DE_ARRIBO,
CONCAT(CL.CLIENTE_NOMBRE,' ',CL.CLIENTE_APELLIDO) AS NOMBRE_Y_APELLIDO,
REGISTRO_FECHA_INGRESO AS FECHA_DE_ARRIBO,
REGISTRO_FECHA_REGISTRO AS FECHA_DE_ACERCAMIENTO_MIGRACION
FROM REGISTRO
INNER JOIN CLIENTE CL ON REGISTRO.CLIENTE_ID=CL.CLIENTE_ID

/*CONSULTA4*/
/*
Un listado de los objetivos de arribo al país más comunes, 
en una columna debe aparecer los nombre y apellidos, 
en otra columna debe aparecer el objetivo de arribo 
y en otra la nacionalidad
*/

SELECT 
CONCAT(CL.CLIENTE_NOMBRE,' ',CL.CLIENTE_APELLIDO) AS NOMBRE_Y_APELLIDO,
REGISTRO_MOTIVO_INGRESO AS OBJETIVO_DE_ARRIBO,
CL.NACIONALIDAD_ID AS NACIONALIDAD
FROM REGISTRO
INNER JOIN CLIENTE CL ON REGISTRO.CLIENTE_ID=CL.CLIENTE_ID
ORDER BY REGISTRO_MOTIVO_INGRESO ASC;