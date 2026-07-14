1. ¿Cuántas filas devuelve cada consulta y por qué son distintas?

La consulta con UNION devuelve 11 filas, mientras que la consulta con UNION ALL devuelve 14 filas.

La consulta con UNION devuelve 11 filas porque se seleccionan únicamente id_producto y nombre_producto. Existen tres productos presentes en ambas sucursales (Monitor 4K 27", Teclado Mecánico y SSD Externo 1TB), por lo que UNION conserva una sola aparición de cada uno. Si también se hubiera seleccionado la columna stock, esas filas dejarían de ser idénticas, ya que el stock es diferente en cada sucursal, y UNION devolvería las 14 filas.

En este conjunto de datos existían 3 registros idénticos entre ambas sucursales (mismo id_producto, mismo nombre_producto y mismo stock). Esos registros fueron eliminados por UNION, por eso el resultado contiene menos filas.

2. ¿Por qué UNION ALL es más eficiente?

UNION ALL es más eficiente porque simplemente concatena los resultados de ambas consultas.

En cambio, UNION debe realizar una operación adicional para identificar y eliminar registros duplicados. Internamente compara todas las filas obtenidas por ambos SELECT antes de devolver el resultado final.

Esa comparación consume CPU y memoria, especialmente cuando se trabaja con millones de registros.

3. ¿En qué casos usarías cada uno?
UNION
Crear un catálogo único de productos provenientes de distintas sucursales.
Unificar una lista de clientes registrados en diferentes sistemas evitando clientes repetidos.
UNION ALL
Consolidar ventas mensuales para obtener el total de operaciones realizadas.
Unir registros históricos y actuales para realizar análisis estadísticos sin perder ninguna observación.
4. ¿Qué ocurre si las columnas no coinciden?

Para utilizar UNION o UNION ALL, ambas consultas deben devolver el mismo número de columnas y en el mismo orden. Además, los tipos de datos deben ser compatibles.

Si esto no se cumple, SQL Server genera errores como:

Distinto número de columnas

All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.

Tipos incompatibles

SQL Server intentará convertir los tipos de datos automáticamente cuando sea posible. Si no puede hacerlo, devolverá un error de conversión, por ejemplo:

Conversion failed when converting the varchar value to data type int.
