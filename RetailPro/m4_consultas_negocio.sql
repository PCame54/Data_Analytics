/*Pre-entrega 4: Consultas SQL de negocio
--TITULO: Extrayendo métricas clave con SQL*/

SELECT
   *
FROM ventas


/* CONSULTA 1 - Resumen ejecutivo mensual: Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
calcular el total como cantidad *precio_unitario. Usá alias descritpivos en español y agrupar por mes con 
EXTRACT (MOTH FROM fecha_venta).*/

SELECT 
   EXTRACT (MONTH FROM fecha_venta) AS Mes,
   SUM (cantidad * precio_unitario) AS Total,
   COUNT (id_venta) AS Cantidad_pedidos,
   AVG (cantidad * precio_unitario) AS Ticket_promedio
FROM ventas
GROUP BY EXTRACT (MONTH FROM fecha_venta)
ORDER BY mes;

/* CONSULTA 2 - Ranking de productos TOP 5 de id_producto por total facturado, mostando las unidades vendidas (SUM(cantidad) 
y el total generado. 
Usar GROUP BY id_prodcuto , ORDER BY y lmitá el resutlado a 5.*/

SELECT 
    id_producto,
	SUM (cantidad) AS unidades_vendidas,
	SUM (cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC
LIMIT 5;

/* CONSULTA 3 - Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad 
de pedidos y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) >1. 
NOTA: Además lo ordené de manera descendente por total gastado*/

SELECT
    id_cliente,
	COUNT (*) AS cantidad_pedidos,
	SUM (cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) >1
ORDER BY total_gastado DESC;


/* CONSULTA 4 - Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional
que etiquete con CASE WHEN si ese mes quedó 'por encima' o 'por debajo' del promedio mensual general. */

SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) >= (
            -- Subconsulta: promedio de los totales mensuales
            SELECT AVG(total_mes)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mes
                FROM ventas
                GROUP BY EXTRACT(MONTH FROM fecha_venta)
            ) AS ventas_mensuales
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS estado_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;


/* HALLAZGOS: 
1) Si bien el producto 2 es el más económico, también concentra la mayor cantidad de ventas ya que tiene 
tantas unidades vendidas como la sumatoria de los productos 1,3,5,6. Se podría armar alguna promoción para incrementar
las ventas del producto 1 o 3.

2) El que más $ generó es el id_1 con un 166% más que el id_3 que es el que le sigue en la segunda posición. 

3) Los clientes más recurrentes hicieron dos pedidos, pero los clientes (id_1) y (id_5) son los que más están gastando
en equipamiento tech concentrando un 74% de las ventas del mes.



