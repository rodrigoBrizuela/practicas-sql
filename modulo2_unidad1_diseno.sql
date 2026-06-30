-- Crear la base de datos
CREATE DATABASE modulo2_unidad1_diseno

-- Seleccionar la base de datos
USE modulo2_unidad1_diseno;

-- Tabla de clientes
CREATE TABLE clientes (
	-- Identificador único del cliente
	id_cliente INT,
	-- Nombre del cliente (máximo 100 caracteres)
	nombre VARCHAR(100),
	-- Texto largo para notas o biografía
	perfil_bio VARCHAR(200),
	-- Solo almacena la fecha de registro
	fecha_registro DATE
);


-- Tabla de productos
CREATE TABLE productos (
	--Identificador único del producto
	id_producto INT,
	-- Descripción del producto
	descripcion VARCHAR (255),
	 -- Tipo adecuado para valores monetarios
	precio DECIMAL (10,2),
	 -- 1 = activo, 0 = inactivo
	esta_Activo INT
);