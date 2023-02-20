// Todos los productos del rubro "librería", creados hoy.

SELECT producto.nombre 
FROM producto 
JOIN rubro  ON producto.id_rubro = rubro.id
WHERE rubro.nombre = 'librería' AND DATE(p.fecha_creacion) = DATE(NOW())

// Monto total vendido por cliente (mostrar nombre del cliente y monto).

SELECT cliente.nombre, SUM(cantidad*precio_unitario) as monto_total
FROM venta JOIN cliente ON venta.id_cliente=cliente.id_cliente
GROUP BY cliente.nombre;

// Cantidad de ventas por producto

SELECT p.nombre, SUM(v.cantidad) as cantidad_vendida_producto
FROM venta v
INNER JOIN producto p ON v.codigo_producto = p.codigo
GROUP BY p.codigo


// Cantidad de productos comprados por cliente en el mes actual

SELECT cliente.nombre, SUM(v.cantidad) as cantidad_comprada
FROM venta v
INNER JOIN cliente ON v.id_cliente = cliente.id
WHERE MONTH(v.fecha) = MONTH(CURDATE()) AND YEAR(v.fecha) = YEAR(CURDATE())
GROUP BY cliente.id

// Ventas que tienen al menos un producto del rubro "bazar".

SELECT DISTINCT v.*
FROM venta v
INNER JOIN producto p ON v.codigo_producto = p.codigo
INNER JOIN rubro r ON p.id_rubro = r.id_rubro
WHERE r.nombre = 'bazar'


// Rubros que no tienen ventas en los últimos 2 meses.

SELECT r.*
FROM rubro r
LEFT JOIN producto p ON r.id_rubro = p.id_rubro
LEFT JOIN venta v ON p.codigo = v.codigo_producto AND v.fecha BETWEEN DATE_SUB(NOW(), INTERVAL 2 MONTH) AND NOW()
WHERE v.id IS NULL

