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

---------------------------------------------------------------------------------------------------------------------

Pre-entrega n°6: Contenido CARPETA: TechStore
    Proyecto de ingesta y pipeline ETL utilizando Power BI Desktop, Power Query y lenguaje M sobre el dataset 'TechStore'.
        Archivo de respaldo: Pipeline_ETL_Pablo_Camerotto.pbix
        Documento de entrega: Pipeline_ETL_Pablo_Camerotto.pdf
        Perfilado y calidad de datos: Detección y saneamiento de anomalías intencionales (eliminación de duplicados por clave primaria y resolución técnica justificada de valores nulos en dimensiones de clientes y productos).
        Modelado dimensional: Estandarización de tablas (Dim_Clientes, Dim_Productos, Dim_Categorias, Fact_Ventas) con tipado de datos estricto.
        Transformación: Merge (Left Outer Join) en la tabla Fact_Ventas para desnormalizar y añadir el nombre del producto y su categoría.
        Documentación técnica: Comentarios justificados con doble barra (//) en el Editor Avanzado de Lenguaje M explicando el impacto analítico de los pasos aplicados.
        Verificación final.

----------------------------------------------------------------------------------------------------------------------

Pre-entrega n°7: Archivo .svg - Boceto del Dashboard Retail Pro
** Archivo disponible en carpeta RetailPro
Dispone de: 
- Se detalla título de la compañía (con su logo)
- Mantiene paleta de colores uniforme y acorde a la compañía
- Incluye título del Dashboard
- Dispone de 4 KPIs indicados
- Incluye gráfico de líneas para identificar temporalidades y establece comparativa entre los dos canlaes de ventas
- Establece comparativa de resultado de ventas para las distintas categorías de productos
- Incluye tabla de ventas
----------------------------------------------------------------------------------------------------------------------

Pre-entrega n°8: Contenido en CARPETA: RetailPro
** Archivo disponible en carpeta RetailPro "Camerotto_Pablo_Checkpoint2.pbix" con la resolución completa del Módulo 8
Dispone de: 
- Modelo de datos: Esquema estrella con relaciones 1:N
- Dim_Fechas marcada como tabla fechas con las medidas de tiempo solicitadas
- Contenedor _Medidas estructurado
- Métricas DAX avanzadas:
   * Modificación de contexto de filtro con Calculate
   * Acumulados temporales (Total YTD)
   * Optimización con variables VAR / Return y división con Divide
- Validación en formato Matriz con variaciones interanuales y acumulados YTD.


