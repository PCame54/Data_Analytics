-- Motor utilizado: PostgreSQL 18.6.3

/*SECCIÓN 1 - DROP: Se eliminan las tablas en orden inverso a sus dependencias siendo la primera la que contendrían
claves foráneas para evitar violaciones de integridad referencial*/

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

--SECCIÓN 2 - CREATE: Se crean tres tablas maestras en orden (primeras tres) y una cuarta de hechos:
--1) Tabla categorías:
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);

--2) Tabla clientes:
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);

--3) Tabla productos:
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT REFERENCES categorias(id_categoria),
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE
);

--4) Tabla ventas: 
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_producto INT REFERENCES productos(id_producto),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL
);

--SECCIÓN 3 - INSERT: Insert Data
--a)Categoría REGISTROS: 4 registros
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
    (1, 'Computación',    'Laptops, Pcs y monitores'),
    (2, 'Accesorios',     'Periféricos y complementos'),
    (3, 'Audio',          'Auriculares y parlantes'),
    (4, 'Almacenamiento', 'Discos y memorias');

--b)Categoría CLIENTES: 5 registros
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES
    (1, 'María López',    'maria@mail.com',     'Buenos Aires',   '2024-01-05'),
    (2, 'Carlos Ruiz',    'carlos@mail.com',    'Córdoba',        '2024-01-10'),
    (3, 'Ana Gómez',      'ana@mail.com',       'Rosario',        '2024-02-01'),
    (4, 'Pedro Sanz',     'pedro@mail.com',     'Mendoza',        '2024-02-15'),
    (5, 'Laura Torres',   'laura@mail.com',     'Tucumán',        '2024-03-01');

--c) Categpría PRODUCTOS: 6 registros
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES
    (1, 'Laptop Pro 15',      1, 1200.00, 15, TRUE),
    (2, 'Mouse Inalámbrico',  2,   28.00, 80, TRUE),
    (3, 'Monitor 4K 27',      1,  450.00, 12, TRUE),
    (4, 'Auriculares BT Pro', 3,  120.00, 35, TRUE),
    (5, 'SSD Externo 1TB',    4,  130.00, 18, TRUE),
    (6, 'Teclado Mecánico',   2,   95.00, 40, TRUE);

--d) Categpría VENTAS: 10 registros
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
    ( 1, 1, 1, 2, 1200.00, '2024-03-05'),
    ( 2, 2, 2, 5,   28.00, '2024-03-06'),
    ( 3, 3, 3, 1,  450.00, '2024-03-07'),
    ( 4, 1, 4, 2,  120.00, '2024-03-08'),
    ( 5, 4, 5, 3,  130.00, '2024-03-10'),
    ( 6, 2, 6, 4,   95.00, '2024-03-11'),
    ( 7, 5, 1, 1, 1200.00, '2024-03-12'),
    ( 8, 3, 2, 8,   28.00, '2024-03-13'),
    ( 9, 4, 4, 1,  120.00, '2024-03-14'),
    (10, 5, 3, 2,  450.00, '2024-03-15');




--SECCION 4: VALIDACIÓN - Chequeamos que cada tabla tenga los registros la cantidad de registros que se solicitan.
--4 registros en categorías
SELECT
	*
FROM categorias;

--5 registros en clientes
SELECT
	*
FROM clientes;

--6 registros en productos
SELECT
	*
FROM productos;

--10 registros en ventas
SELECT
	*
FROM ventas;