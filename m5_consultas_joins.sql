-- ══════════════════════════════════════════
-- RetailPro / Ventas_Tech_DB — Consultas con JOINs
-- Módulo M5 — Cruzando tablas para enriquecer el análisis
-- Autor: Rodrigo Brizuela
-- ══════════════════════════════════════════

-- ── CONSULTA 1: Vista base del proyecto (INNER JOIN) ──────────
-- Combina ventas, clientes, productos y categorías en una sola fila.
-- Será la fuente principal para el dashboard de Power BI (M7).
-- Nota: el esquema no tiene tabla "territorios" ni columna "región"/"segmento",
-- por eso se usa "ciudad" (de clientes) como dato geográfico disponible.
SELECT
    v.fecha_venta,
    c.nombre            AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM dbo.ventas v
INNER JOIN dbo.clientes   c   ON v.id_cliente   = c.id_cliente
INNER JOIN dbo.productos  p   ON v.id_producto  = p.id_producto
INNER JOIN dbo.categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;


-- ── CONSULTA 2: Clientes sin ventas (LEFT JOIN) ────────────────
-- Clientes registrados que nunca compraron (pedido del área de CRM).
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM dbo.clientes c
LEFT JOIN dbo.ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;


-- ── CONSULTA 3: Productos sin ventas (LEFT JOIN) ───────────────
-- Productos del catálogo sin ningún movimiento (pedido del área de producto).
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM dbo.productos p
INNER JOIN dbo.categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN dbo.ventas v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;


-- ── CONSULTA 4: Consolidado por canal (UNION ALL) ──────────────
-- SUPUESTO: la tabla ventas no tiene columna "canal" en este esquema.
-- Para poder practicar UNION ALL se simula el canal con un criterio arbitrario
-- (id_venta par = Online, impar = Presencial). Esto es solo para fines
-- didácticos de esta entrega; no representa un canal real de venta.
SELECT
    id_venta,
    fecha_venta,
    cantidad,
    precio_unitario,
    (cantidad * precio_unitario) AS total_venta,
    'Online' AS canal
FROM dbo.ventas
WHERE id_venta % 2 = 0

UNION ALL

SELECT
    id_venta,
    fecha_venta,
    cantidad,
    precio_unitario,
    (cantidad * precio_unitario) AS total_venta,
    'Presencial' AS canal
FROM dbo.ventas
WHERE id_venta % 2 <> 0;

-- Total facturado por canal (sobre el mismo consolidado de arriba)
SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT
        (cantidad * precio_unitario) AS total_venta,
        'Online' AS canal
    FROM dbo.ventas
    WHERE id_venta % 2 = 0

    UNION ALL

    SELECT
        (cantidad * precio_unitario) AS total_venta,
        'Presencial' AS canal
    FROM dbo.ventas
    WHERE id_venta % 2 <> 0
) AS consolidado
GROUP BY canal;

-- ==========================================
-- Notas / supuestos
-- ==========================================
-- 1. "ciudad" reemplaza a "región" y no existe "segmento" en el esquema real.
-- 2. El canal (Online/Presencial) es simulado con id_venta par/impar,
--    ya que la tabla ventas no distingue canal de venta.
