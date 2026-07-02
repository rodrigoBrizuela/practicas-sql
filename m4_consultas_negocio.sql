/* Consulta 1 — Resumen ejecutivo mensual 
Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con EXTRACT(MONTH FROM fecha_venta).*/

SELECT
	MONTH(fecha_venta) AS mes,
	SUM(cantidad * precio_unitario) AS total_Vendido,
	COUNT(*) AS cant_pedidos,
	AVG(cantidad * precio_unitario) AS ticket_promedio
FROM dbo.ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

/*Consulta 2 — Ranking de productos 
Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) y el total generado. 
Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.*/

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM dbo.ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

/*Consulta 3 — Clientes recurrentes 
id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado. 
Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.*/

SELECT
	id_cliente,
	COUNT(*) AS cant_pedidos,
	SUM(cantidad * precio_unitario) AS total_gastado
FROM dbo.ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

/*Consulta 4 — Meses por encima/por debajo del promedio 
Total facturado por mes, con una columna adicional que etiquete con CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.*/

WITH ventas_mensuales AS (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)

SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado >
             (SELECT AVG(total_facturado)
              FROM ventas_mensuales)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas_mensuales
ORDER BY mes;


-- ==========================================
-- Hallazgos encontrados
-- (Actualizar según los resultados obtenidos)
-- ==========================================

-- 1. El producto con id_producto = 1 concentra la mayor parte de la facturación.
-- 2. El mes 3 presentó el ticket promedio más alto del período analizado.
-- 3. El cliente con id_cliente = 1 es el que más dinero gastó.