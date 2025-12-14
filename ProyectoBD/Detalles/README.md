# Inventario y Ventas de 'Electro-Tech Store'

## 1. Situación de la Entidad: Electro-Tech Store

Electro-Tech Store es una mediana empresa minorista especializada en la venta de productos electrónicos, incluyendo computadoras, componentes, periféricos y accesorios, actualmente, la tienda opera a través de una pequeña ubicación física y un sitio web de comercio electrónico en crecimiento

### Problema Actual
La gestión del inventario y las ventas se realiza mediante una combinación de hojas de cálculo de Excel y registros en papel. Esta metodología ha generado varios problemas de eficiencia e integridad:

1.  **Errores de Stock:** El conteo manual y la actualización retrasada de las hojas de cálculo a menudo llevan a discrepancias entre el stock físico y el stock reportado, resultando en ventas de productos agotados o exceso de existencias en artículos de baja rotación.
2.  **Lentitud en Consultas:** Es difícil obtener reportes rápidos sobre el rendimiento de las ventas, los productos más populares, o los niveles de stock bajo para realizar pedidos a proveedores de manera oportuna.
3.  **Integridad de Datos:** La falta de restricciones de datos robustas permite la introducción de información inconsistente (ej. nombres de productos mal escritos, precios nulos) y dificulta el seguimiento fiable de los clientes y sus historiales de compra.

## 2. Necesidad de la Base de Datos (DB)

Para sostener su crecimiento y mejorar la eficiencia operativa, Electro-Tech Store requiere urgentemente migrar su información a un **Sistema de Gestión de Bases de Datos (SGBD)** robusto.

### Propósito y Justificación

La creación de una base de datos centralizada tiene el propósito de:

* **Garantizar la Integridad:** Implementar claves primarias y foráneas para asegurar que cada producto, cliente y transacción sea único y esté correctamente relacionado, eliminando la inconsistencia de datos.
* **Optimizar el Inventario:** Permitir un seguimiento en tiempo real del stock. Cada venta o recepción de mercancía activará una actualización inmediata en la tabla de Inventario, minimizando los errores de stock y optimizando los pedidos a proveedores.
* **Mejorar la Toma de Decisiones:** Facilitar la ejecución de consultas complejas para generar informes de ventas, identificar tendencias y analizar el rendimiento de productos y empleados de manera rápida.
* **Soporte a la Expansión:** Sentar las bases para la integración con sistemas futuros, como el sitio web de comercio electrónico y herramientas de gestión de la relación con el cliente (CRM).

El SGBD permitirá a Electro-Tech Store pasar de una gestión reactiva y manual a una gestión proactiva y automatizada de sus recursos críticos.

---

## 3. Pruebas de Validación de la Base de Datos (Tarea II)

Para garantizar que la base de datos cumpla con los requisitos operativos y de integridad, se han diseñado y ejecutado un conjunto de pruebas definidas en el archivo `pruebas.sql`. Estas pruebas cubren tres aspectos fundamentales:

### A. Carga de Datos Inicial (Pruebas de Inserción)
Se realizan inserciones de datos de prueba en todas las tablas principales para verificar que la estructura acepta la información correctamente.
- **Categorías y Productos:** Se insertan categorías ('Laptops', 'Periféricos') y productos asociados.
- **Inventario:** Se registra el stock inicial de los productos.
- **Clientes y Ventas:** Se simula el registro de un cliente y una transacción de venta completa, incluyendo sus detalles.

### B. Prueba de Integridad Referencial (Validación de Claves Foráneas)
Esta prueba es crítica para validar la robustez de la base de datos.
- **Objetivo:** Verificar que el sistema **rechace** intentos de crear registros huérfanos.
- **Procedimiento:** Se intenta insertar un detalle de venta asociado a un `venta_id` (9999) que no existe en la tabla `VENTAS`.
- **Resultado Esperado:** La base de datos debe lanzar un error de restricción de clave foránea (`FOREIGN KEY constraint failed`), impidiendo la inserción.

### C. Prueba de Coherencia y Lógica de Negocio (Consultas)
Se ejecutan consultas `SELECT` con `JOIN` para verificar que los datos están correctamente relacionados y que se puede extraer información útil para el negocio.
1.  **Ingresos por Categoría:** Calcula el total monetario vendido agrupado por categoría.
    *   *Verifica:* JOINs entre `CATEGORIAS`, `PRODUCTOS` y `DETALLE_VENTA`.
2.  **Reporte de Proveedores y Stock:** Lista los productos suministrados por cada proveedor y su stock actual.
    *   *Verifica:* Relaciones complejas (Proveedor -> Producto_Proveedor -> Producto -> Inventario).

---

## 4. Ejecución y Análisis de Calidad (Proyecto I)

A continuación, se presenta la evidencia de la ejecución del script de pruebas (main.py) y el análisis de los resultados obtenidos.

### Evidencia de Ejecución

El script arrojó el siguiente resultado

--- INICIO DE PRUEBAS Y OBTENCIÓN DE EVIDENCIA ---

▶️ Ejecutando: INSERT INTO CATEGORIAS (categoria_id, nombre_categoria) VALUES (1, 'Laptops'), (2, 'Periféricos')...
✅ Comando ejecutado exitosamente. Cambios guardados.

▶️ Ejecutando: INSERT INTO PRODUCTOS (producto_id, nombre, precio_venta, categoria_id)...
✅ Comando ejecutado exitosamente. Cambios guardados.

▶️ Ejecutando: INSERT INTO INVENTARIO (inventario_id, producto_id, cantidad_stock) VALUES (1, 101, 15), (2, 102, 50)...
✅ Comando ejecutado exitosamente. Cambios guardados.

▶️ Ejecutando: INSERT INTO CLIENTES (cliente_id, nombre, apellido) VALUES (1, 'Jeff', 'Smith')...
✅ Comando ejecutado exitosamente. Cambios guardados.

▶️ Ejecutando: INSERT INTO VENTAS (venta_id, cliente_id, fecha_venta, total_monto) VALUES (1001, 1, '2025-12-01', 1225.00)...
✅ Comando ejecutado exitosamente. Cambios guardados.

▶️ Ejecutando: INSERT INTO DETALLE_VENTA (venta_id, producto_id, cantidad_vendida, precio_unitario)...
✅ Comando ejecutado exitosamente. Cambios guardados.

▶️ Ejecutando: INSERT INTO DETALLE_VENTA (venta_id, producto_id, cantidad_vendida, precio_unitario) VALUES (9999, 101, 1, 1200.00)...
❌ ERROR (EVIDENCIA DE INTEGRIDAD): FOREIGN KEY constraint failed

▶️ Ejecutando: SELECT C.nombre_categoria, SUM(DV.cantidad_vendida * DV.precio_unitario) AS ingresos_totales...

[RESULTADO OBTENIDO - EVIDENCIA]
---
nombre_categoria | ingresos_totales
-----------------------------------
Laptops | 1200.0
Periféricos | 25.0
---

### Análisis de Resultados

1.  **Validación de Estructura e Inserción:**
    *   Todas las operaciones de inserción de datos válidos (Test A) se completaron exitosamente ("Comando ejecutado exitosamente"). Esto confirma que los tipos de datos y las restricciones básicas (como NOT NULL) están configurados correctamente.

2.  **Validación de Integridad (Crucial):**
    *   El intento de insertar una venta con un ID inexistente falló como se esperaba, generando el error: `FOREIGN KEY constraint failed`.
    *   **Conclusión:** El sistema de integridad referencial está **activo y funcionando**. La base de datos protege contra datos inconsistentes.

3.  **Validación de Lógica de Negocio:**
    *   La consulta de ingresos muestra correctamente que se vendió 1 Laptop ($1200) y 1 Mouse ($25), coincidiendo con los datos insertados.
    *   **Conclusión:** Las relaciones entre tablas (`JOIN`) están correctamente definidas en el modelo, permitiendo extraer información analítica precisa.
