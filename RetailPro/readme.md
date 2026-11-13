# 🛒 RetailPro – Análisis de Datos Comercial

Proyecto de análisis de datos para **RetailPro**, una empresa dedicada a la venta de productos de computación e insumos. Cubre el ciclo completo: modelado relacional y consultas exploratorias en **PostgreSQL**, modelado dimensional en **esquema estrella** y construcción de métricas **DAX** en **Power BI**.

---

## 📑 Tabla de contenidos

1. [Descripción del proyecto](#-descripción-del-proyecto)
2. [Arquitectura y stack tecnológico](#-arquitectura-y-stack-tecnológico)
3. [Estructura del repositorio](#-estructura-del-repositorio)
4. [Guía de ejecución de los scripts SQL](#-guía-de-ejecución-de-los-scripts-sql)
5. [Entregables de Power BI y diseño](#-entregables-de-power-bi-y-diseño)
6. [Buenas prácticas y consideraciones](#-buenas-prácticas-y-consideraciones)
7. [Autor](#-autor)

---

## 📌 Descripción del proyecto

**Objetivo:** transformar los datos transaccionales de ventas de RetailPro en información útil para la toma de decisiones comerciales (desempeño mensual, ticket promedio, ranking de productos, comportamiento por cliente y categoría).

**Alcance:**
- Diseño del modelo relacional y carga de datos (`ventas_tech_db.sql`).
- Consultas exploratorias y métricas de negocio (`m4_consultas_negocio.sql`).
- Consultas relacionales con `INNER JOIN`, `LEFT JOIN` y `UNION ALL` (`m5_consultas_joins.sql`).
- Boceto visual del tablero (`Pre-Entrega-7-Pablo-Camerotto.svg`).
- Modelado dimensional en esquema copo de nieve y medidas DAX en Power BI (`Camerotto_Pablo_Checkpoint2.pbix`).

**Preguntas de negocio que responde el proyecto:**
- ¿Cuánto se factura por mes y cuál es el ticket promedio?
- ¿Qué productos y categorías generan más ingresos y cuáles más unidades?
- ¿Cómo se distribuyen las ventas por cliente, canal y período (`YTD` / `LY`)?

---

## 🏗️ Arquitectura y stack tecnológico

### Flujo general

```text
┌────────────────────┐      ┌──────────────────────┐      ┌─────────────────────────┐
│  PostgreSQL        │      │  Consultas SQL       │      │  Power BI               │
│  ventas_tech_db    │ ──►  │  M4 y M5 (JOINs)     │ ──►  │  Modelo copo de nieve   │
│  (ventas + dims)   │      │  Vista consolidada   │      │  + medidas DAX + visual │
└────────────────────┘      └──────────────────────┘      └─────────────────────────┘
```


Modelo dimensional (Esquema Estrella)
Tabla de hechos: Fact_Ventas (granularidad: una fila por venta).

Dimensiones: Dim_Clientes, Dim_Fechas (tabla calendario oficial), Dim_Productos y Dim_Categorias.

Normalización: Fact_Ventas → Dim_Productos → Dim_Categorias (relaciones 1:N con dirección de filtro único).

```text
Dim_Clientes ──────┐
                   ├──► Fact_Ventas ◄──── Dim_Productos ◄──── Dim_Categorias
Dim_Fechas   ──────┘     (Hechos)          (Dimensión)         (Sub-dimensión)
```


## 📂 Estructura del repositorio
```text
Data_Analytics/RetailPro/
├── README.md                              # Documentación general del proyecto
├── ventas_tech_db.sql                     # Creación de tablas (DDL), claves y carga inicial (DML)
├── m4_consultas_negocio.sql               # Consultas de resumen ejecutivo mensual y ranking TOP 5
├── m5_consultas_joins.sql                 # Vista base con INNER JOIN, validación con LEFT JOIN y UNION ALL
├── Pre-Entrega-7-Pablo-Camerotto.svg      # Boceto / wireframe del dashboard RetailPro
└── Camerotto_Pablo_Checkpoint2.pbix       # Modelo dimensional en Power BI, medidas DAX y validación
```

## ⚙️ Guía de ejecución de los scripts SQL
1. Requisitos previos
PostgreSQL instalado y en ejecución.
Cliente psql o pgAdmin 4.

Un usuario con permisos para crear bases de datos y objetos.

2. Clonar el repositorio
```text
git clone https://github.com/PCame54/Data_Analytics.git
cd Data_Analytics/RetailPro
```

3. Configurar las variables de conexión
No se incluyen credenciales en el repositorio. Definí tus propios valores como variables de entorno:
```text
export PGHOST=localhost
export PGPORT=5432
export PGUSER=<tu_usuario>
export PGPASSWORD=<tu_contraseña>
```

4. Crear la base de datos y ejecutar los scripts en orden
El orden respeta la creación previa del esquema y datos antes de correr las consultas:
```text
psql -d postgres -c "CREATE DATABASE retailpro;"
psql -d retailpro -f ventas_tech_db.sql
psql -d retailpro -f m4_consultas_negocio.sql
psql -d retailpro -f m5_consultas_joins.sql
```

5. Verificar la carga
```text
SELECT 'clientes'   AS tabla, COUNT(*) FROM clientes
UNION ALL SELECT 'productos',  COUNT(*) FROM productos
UNION ALL SELECT 'categorias', COUNT(*) FROM categorias
UNION ALL SELECT 'ventas',     COUNT(*) FROM ventas;
```

## 📊 Entregables de Power BI y diseño
### Archivos
Camerotto_Pablo_Checkpoint2.pbix (Modelo analítico en Power BI Desktop)

Pre-Entrega-7-Pablo-Camerotto.svg (Boceto estructural del reporte)

Conexión a los datos
1) Abrir Camerotto_Pablo_Checkpoint2.pbix en Power BI Desktop.

2) Ir a Inicio → Transformar datos → Configuración de origen de datos si se desea apuntar a una instancia local de PostgreSQL.

3) Presionar Actualizar para recargar el modelo.


## Medidas DAX principales (Tabla _Medidas)
```text
Total Ventas = SUM(Fact_Ventas[total_venta])
Ventas Online = CALCULATE([Total Ventas], Fact_Ventas[canal] = "Online")
Ventas YTD = TOTALYTD([Total Ventas], Dim_Fechas[Date])
Ventas LY = CALCULATE([Total Ventas], SAMEPERIODLASTYEAR(Dim_Fechas[Date]))

% Crecimiento Anual = 
VAR VentasActual = [Total Ventas]
VAR VentasAnterior = [Ventas LY]
RETURN
DIVIDE(VentasActual - VentasAnterior, VentasAnterior)
```

## ✅ Buenas prácticas y consideraciones
No se versionan credenciales ni cadenas de conexión reales.

En vistas base consolidando tablas no se incluye ORDER BY; el ordenamiento se aplica únicamente en la consulta de consumo final.
Los INNER JOIN garantizan que solo se incluyan transacciones válidas con cliente, producto y categoría existentes.

## 👤 Autor
Pablo Camerotto (PCame54) – github.com/PCame54/Data_Analytics

Proyecto desarrollado para el curso de Data Analytics (Comisión #91050).
