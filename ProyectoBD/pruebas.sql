INSERT INTO CATEGORIAS (categoria_id, nombre_categoria) VALUES (1, 'Laptops'), (2, 'Periféricos');
INSERT INTO PRODUCTOS (producto_id, nombre, precio_venta, categoria_id) 
VALUES (101, 'Laptop Gaming Z-15', 1200.00, 1), (102, 'Mouse Óptico', 25.00, 2);
INSERT INTO INVENTARIO (inventario_id, producto_id, cantidad_stock) VALUES (1, 101, 15), (2, 102, 50);
INSERT INTO CLIENTES (cliente_id, nombre, apellido) VALUES (1, 'Jeff', 'Smith');
INSERT INTO VENTAS (venta_id, cliente_id, fecha_venta, total_monto) VALUES (1001, 1, '2025-12-01', 1225.00);
INSERT INTO DETALLE_VENTA (venta_id, producto_id, cantidad_vendida, precio_unitario) 
VALUES (1001, 101, 1, 1200.00), (1001, 102, 1, 25.00);


-- B. PRUEBA DE INTEGRIDAD DE LA VENTA (La clave foránea debe funcionar)
-- Intentar insertar un DETALLE_VENTA con una venta_id (9999) que no existe.
-- Esta sentencia DEBE FALLAR.
INSERT INTO DETALLE_VENTA (venta_id, producto_id, cantidad_vendida, precio_unitario) 
VALUES (9999, 101, 1, 1200.00);


-- C. PRUEBA DE COHERENCIA DE DATOS (Consulta de Lógica de Negocio)
-- Consulta para obtener el total de ingresos por categoría.
SELECT 
    C.nombre_categoria,
    SUM(DV.cantidad_vendida * DV.precio_unitario) AS ingresos_totales
FROM 
    CATEGORIAS C
JOIN 
    PRODUCTOS P ON C.categoria_id = P.categoria_id
JOIN 
    DETALLE_VENTA DV ON P.producto_id = DV.producto_id
GROUP BY 
    C.nombre_categoria;

SELECT 
    R.nombre AS Proveedor,
    P.nombre AS Producto,
    I.cantidad_stock AS Stock_Actual
FROM 
    PROVEEDORES R
JOIN 
    PRODUCTO_PROVEEDOR PP ON R.proveedor_id = PP.proveedor_id
JOIN 
    PRODUCTOS P ON PP.producto_id = P.producto_id
JOIN 
    INVENTARIO I ON P.producto_id = I.producto_id
ORDER BY 
    R.nombre, P.nombre;