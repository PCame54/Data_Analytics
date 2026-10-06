/* CONSULTA 1 — Vista base del proyecto (INNER JOIN)
Combiná con INNER JOIN tu tabla de ventas con las tablas descriptivas que hayas modelado 
(clientes, productos y cualquier otra dimensión de tu caso de negocio) para obtener en una sola fila, como mínimo: 
fecha, identificación del cliente, descripción del producto, cantidad, precio unitario y total de venta.
Sumá además las columnas descriptivas que existan en tu propio esquema (por ejemplo segmento de cliente, 
categoría de producto o región, si las modelaste). No es necesario que estén todas: la consulta se evalúa 
sobre las tablas que vos diseñaste, no sobre una lista fija.
*/

SELECT 
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c 
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p 
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat 
    ON p.id_categoria = cat.id_categoria
ORDER BY v.id_venta;

/* CONSULTA 2 — Clientes sin ventas (LEFT JOIN) Identificá clientes registrados que aún no han 
realizado ninguna compra. Mostrá su nombre, email y fecha de registro. Usá WHERE ... IS NULL para aislar los casos.*/

SELECT
* 
FROM clientes;

--NOTA: tenía 5 clientes cargados y todos con compras hechas. Por tanto agrego uno para traer un NULL de ejemplo--
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro)
     VALUES (6, 'Enzo Fernandez', 'enzo@mail.com', 'San Martin', '2024-05-10');

--Ahora si corro la consulta testeando que hay un NULL--
SELECT
     c.id_cliente,
	 c.nombre,
	 c.email,
	 c.ciudad,
	 c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
	WHERE v.id_venta IS NULL;

/* CONSULTA 3: Identificá productos del catálogo que no tienen ninguna venta registrada. Mostrá nombre del producto, 
categoría y precio. Usá WHERE ... IS NULL. 

Los productos registran al menos una venta por tanto voy a agregar un producto sin ventas dentro del catálogo 
para validar el LEFT JOIN*/

INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo)
     VALUES (7, 'Cámara web 4K Pro', 2, 85.00, 25, TRUE);

--Ahora si, ejecuto la consulta/validación
SELECT 
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat 
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v 
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

/* CONSULTA 4: Generar la columna CANAL dentro de cada select como valor literal. Escribir dos SELECT sobre las ventas,
separados por criterio que corresponda a tu caso (dos períodos de ventas)- Agregar en cada uno una columna de texto fija
que identifique el origen. Unilos con UNION ALL y cerrá con GROUP BY para obtener el total por cada origen. */

SELECT 
    canal,
    COUNT(*) AS cantidad_ventas,
    SUM(total) AS total_facturado
FROM (
-- (Ventas primer período -> Canal Online)
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Online' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

-- (ventas segundo período -> Canal Presencial)
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS subconsulta_canales
GROUP BY canal
ORDER BY total_facturado DESC;

