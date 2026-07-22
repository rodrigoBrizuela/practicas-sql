# M5 — Cruzando tablas para enriquecer el análisis

Consultas SQL (SQL Server / T-SQL) sobre la base `Ventas_Tech_DB`, que combinan `ventas`, `clientes`, `productos` y `categorias` mediante JOINs y UNION ALL. Este archivo es la pre-entrega de M5 y su vista principal (Consulta 1) será la fuente de datos del dashboard de Power BI en M7.

Archivo: [`m5_consultas_joins.sql`](./m5_consultas_joins.sql)

## Supuestos sobre el esquema

La consigna original pedía columnas de `región`, `segmento` y `canal` que no existen en `Ventas_Tech_DB`. Adaptaciones hechas:

- **Región / segmento:** no hay tabla `territorios` ni columna `segmento` en `clientes`. Se usa `ciudad` (columna real de `clientes`) como dato geográfico.
- **Canal (Online/Presencial):** la tabla `ventas` no distingue canal de venta. Para poder practicar `UNION ALL` como pide la consigna, el canal se **simula** con un criterio arbitrario: `id_venta` par → Online, `id_venta` impar → Presencial. Esto es solo a fines didácticos de esta entrega y no representa un canal de venta real registrado en la base.

## Consulta 1 — Vista base del proyecto (INNER JOIN)

Cruza `ventas`, `clientes`, `productos` y `categorias` en una sola vista: cada fila es una venta con cliente, ciudad, producto, categoría, cantidad, precio unitario y total. Es la fuente principal para Power BI en M7.

## Consulta 2 — Clientes sin ventas (LEFT JOIN)

Clientes registrados que nunca compraron, aislados con `WHERE ... IS NULL` sobre el resultado del LEFT JOIN.

**Resultado:** vacío. En `Ventas_Tech_DB` todos los clientes registrados tienen al menos una compra, así que no hay filas que mostrar — es un resultado válido, no un error.

## Consulta 3 — Productos sin ventas (LEFT JOIN)

Productos del catálogo sin ninguna venta registrada, con la misma lógica de LEFT JOIN + `IS NULL`.

**Resultado:** vacío, por la misma razón: todos los productos del catálogo tienen al menos una venta registrada.

## Consulta 4 — Consolidado por canal (UNION ALL)

Combina las ventas "Online" y "Presencial" (canal simulado, ver supuestos arriba) en un solo resultado con `UNION ALL`, y calcula el total facturado por canal con `GROUP BY`.

**Resultado obtenido:**

| Canal | Total facturado |
|---|---|
| Online | $1884.00 |
| Presencial | $4560.00 |

## Notas

- Consultas ejecutadas y verificadas en SSMS contra `Ventas_Tech_DB`, sin errores de sintaxis.
- Los resultados vacíos de las Consultas 2 y 3 fueron confirmados manualmente: no son un error de JOIN, sino que reflejan que en este dataset no hay clientes ni productos sin movimiento.
