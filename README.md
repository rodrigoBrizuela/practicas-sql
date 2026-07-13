1. ¿Por qué usaste LEFT JOIN para la Consulta 1 y no INNER JOIN?

Utilicé LEFT JOIN porque necesitaba conservar todos los registros de la tabla productos, incluso aquellos que nunca tuvieron una venta.

Si hubiera utilizado un INNER JOIN, solamente aparecerían los productos que tienen coincidencias en la tabla ventas. En ese caso, los productos 108 (Hub USB-C 7p) y 109 (Parlante Bluetooth) desaparecerían del resultado porque nunca fueron vendidos.

El LEFT JOIN permite detectar precisamente esos productos sin ventas mediante los valores NULL en las columnas provenientes de la tabla ventas.

2. ¿Por qué usaste RIGHT JOIN para la Consulta 2?

Utilicé RIGHT JOIN porque la pregunta de negocio busca conservar todas las filas de la tabla ventas, incluso cuando no existe un producto correspondiente en el catálogo.

En mi consulta:

La tabla izquierda es productos.
La tabla derecha es ventas.

Al utilizar RIGHT JOIN, SQL devuelve todas las ventas. Cuando una venta hace referencia a un producto inexistente, las columnas de productos aparecen con valores NULL.

Esto permite detectar errores de carga de datos, como la venta con producto_id = 999.

3. ¿Qué representan los valores NULL?

Los valores NULL indican que no existe una coincidencia entre ambas tablas.

En la Consulta 1:

Cuando venta_id es NULL, significa que ese producto nunca fue vendido.

Ejemplo:

producto_id = 108
Hub USB-C 7p

No existe ninguna venta asociada a ese producto.

En la Consulta 2:

Cuando productos.producto_id es NULL, significa que existe una venta cuyo producto no está registrado en el catálogo.

Ejemplo:

venta_id = 10
producto_id = 999

La venta existe, pero el producto no.

4. ¿Cuándo usarías FULL OUTER JOIN?

Utilizaría FULL OUTER JOIN cuando necesito realizar una auditoría completa de los datos.

Por ejemplo:

detectar productos sin ventas;
detectar ventas con productos inexistentes;
verificar inconsistencias entre dos sistemas;
comparar información proveniente de distintas bases de datos.

Este tipo de unión permite visualizar todas las filas de ambas tablas sin perder información.
