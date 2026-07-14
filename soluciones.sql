-- ══════════════════════════════════════════
-- RetailChain — UNION y UNION ALL
-- Autor: [Rodrigo Brizuela]
-- Fecha: [14/07/26]
-- ══════════════════════════════════════════

-- ── CONSULTA 1: UNION ────────────────────
-- Reporte de Catálogo Unificado
-- Pregunta de negocio: ¿Qué productos únicos comercializa
-- la empresa en toda su red de sucursales?
-- Operador: UNION (elimina filas completamente duplicadas)

SELECT 
	sn.id_producto,
	sn.nombre_producto AS nombre_producto
FROM dbo.inventario_sucursal_norte sn

UNION

SELECT
    ss.id_producto,
    ss.nombre_producto AS nombre_producto
FROM dbo.inventario_sucursal_sur ss


-- ── CONSULTA 2: UNION ALL ────────────────
-- Auditoría de Stock Total
-- Pregunta de negocio: ¿Cuántos registros físicos de stock
-- existen en total entre ambas sucursales?
-- Operador: UNION ALL (mantiene todos los registros incluyendo duplicados)

SELECT
	sn.id_producto,
	sn.nombre_producto AS nombre_producto,
	sn.stock AS stock
FROM dbo.inventario_sucursal_norte sn

UNION ALL

SELECT
	ss.id_producto,
	ss.nombre_producto AS nombre_producto,
	ss.stock AS stock
FROM dbo.inventario_sucursal_sur ss


-- ── CONSULTA 3: COMPARACIÓN DE RESULTADOS ─
-- Ejecutá estas dos consultas para comparar cuántas filas
-- devuelve cada operador y explicá la diferencia en tu README

SELECT COUNT(*) AS filas_union     FROM (/* tu UNION aquí */)     AS resultado_union; --11
SELECT COUNT(*) AS filas_union_all FROM (/* tu UNION ALL aquí */) AS resultado_union_all; --14

