CREATE TABLE CATEGORIAS (
    categoria_id INTEGER PRIMARY KEY,
    nombre_categoria TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE PRODUCTOS (
    producto_id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    descripcion TEXT,
    precio_venta REAL NOT NULL CHECK (precio_venta >= 0),
    stock_minimo INTEGER NOT NULL CHECK (stock_minimo >= 0),
    categoria_id INTEGER,
    FOREIGN KEY (categoria_id) REFERENCES CATEGORIAS(categoria_id)
);

CREATE TABLE INVENTARIO (
    inventario_id INTEGER PRIMARY KEY,
    producto_id INTEGER UNIQUE NOT NULL,
    cantidad_stock INTEGER NOT NULL CHECK (cantidad_stock >= 0),
    ubicacion TEXT,
    FOREIGN KEY (producto_id) REFERENCES PRODUCTOS(producto_id)
);

CREATE TABLE CLIENTES (
    cliente_id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT UNIQUE,
    telefono TEXT,
    direccion TEXT
);

CREATE TABLE VENTAS (
    venta_id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    fecha_venta TEXT NOT NULL, --Text para fechas porque a diferencia de Postgre asi las maneja SQLite aparentemente
    total_monto REAL NOT NULL CHECK (total_monto >= 0),
    estado_pago TEXT NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (cliente_id) REFERENCES CLIENTES(cliente_id)
);

CREATE TABLE DETALLE_VENTA (
    detalle_id INTEGER PRIMARY KEY,
    venta_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad_vendida INTEGER NOT NULL CHECK (cantidad_vendida > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario >= 0),

    UNIQUE (venta_id, producto_id),

    FOREIGN KEY (venta_id) REFERENCES VENTAS(venta_id),
    FOREIGN KEY (producto_id) REFERENCES PRODUCTOS(producto_id)
);
