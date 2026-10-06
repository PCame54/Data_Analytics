# Data_Analytics
Curso Coderhouse - Data Analytics
Motor: PostgreSQL 18.6.3
Script DDL/DML y consultas analíticas de agregación sobre ventas y productos.


INDEX entregables: 

Pre-entrega n°3: Contenido FILE: ventas_tech_db.sql
    Se crean tablas, asignan atributos. 
    Inserción de datos a las tablas creadas.
    El script crea las tablas categorias | clientes | productos | ventas  y se les asigna atributos a cada columna. 
    Se incertan los datos dentro de cada tabla a fin de tener información para revisar
    Finalmente se valida que las tablas creadas y datos ingresados se detallen de manera correcta

---------------------------------------------------------------------------------------------------------------------

Pre-entrega n°4: Contenido FILE: m4_consultas_negocio.sql
    Utilizando la tabla generada en la entrega n°3 'ventas_tech_db.sql' se trabaja con los datos ingresados 
    Revisión de filtros y consultas sobre las tablas y datos ingresados.
    Se incluyen tres hallazgos en base a la información obtenida.

    
---------------------------------------------------------------------------------------------------------------------

Pre-entrega n°5: Contenido FILE: m5_consultas_joins.sql
    Se cruzan las tablas del modelo relacional utilizando cláusulas JOIN y operador UNION ALL.
    Consulta 1 (INNER JOIN): Se unen las 4 tablas (ventas, clientes, productos, categorias) en una sola vista, calculando el total de venta y sumando dimensiones de producto y geografía.
    Consulta 2 (Clientes sin ventas - LEFT JOIN): Se identifican clientes registrados que no registran compras mediante LEFT JOIN y WHERE IS NULL
    Consulta 3 (Productos sin ventas - LEFT JOIN): Se detectan artículos del catálogo sin movimiento comercial mediante LEFT JOIN y WHERE IS NULL
    Consulta 4 (Consolidado por canal - UNION ALL): Se dividen las ventas por período generando una columna literal de canal (Online / Presencial), apilando los registros sin pérdida de datos y totalizando con GROUP BY.
