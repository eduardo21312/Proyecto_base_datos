-- Tabla proveedor
CREATE TABLE PROVEDOR(
	razon_social varchar(60) NOT NULL,
	calle varchar(30) NOT NULL,
	estado varchar(30) NOT NULL,
	codigo_postal int NOT NULL,
	colonia varchar(30) NOT NULL,
	numero int NOT NULL check(numero>0),
	nombre_pila VARCHAR(30) NOT NULL,
	apellido_paterno VARCHAR(30) NOT NULL,
	apellido_materno VARCHAR(30)  NULL,
	CONSTRAINT razon_social_PK PRIMARY KEY (razon_social)
);

-- Tabla teléfonos
CREATE TABLE TELEFONO_PROVEDOR(
	telefono int NOT NULL ,
	razon_social varchar(60) NOT NULL,
	CONSTRAINT TELEFONO_PK PRIMARY KEY(razon_social,telefono),
	CONSTRAINT PROVEEDOR_FK FOREIGN KEY (razon_social) REFERENCES PROVEDOR(razon_social)
);

-- Tabla inventario
CREATE TABLE INVENTARIO(
	codigo_barras_inventario int NOT NULL,
	precio_compra DECIMAL(6,2)  NOT NULL CHECK (precio_compra>0),
	fecha_compra date NOT NULL default now(),
	cantidad_bodega int NOT NULL CHECK(cantidad_bodega>=0),
	CONSTRAINT codigo_barras_PK PRIMARY KEY (codigo_barras_inventario)
);

-- Tabla producto
CREATE TABLE PRODUCTO (
	id_producto int  GENERATED ALWAYS AS IDENTITY NOT NULL,
	descripcion varchar(100)  NULL,
	--nombre VARCHAR(40) NOT NULL,
	marca VARCHAR(60) NOT NULL,
	precio DECIMAL(6,2) NOT NULL CHECK(precio>0),
	codigo_barras int NOT NULL,
	--utilidad DECIMAL(6,2) NOT NULL ,
	razon_social varchar(60) NOT NULL,
	CONSTRAINT id_producto_PK PRIMARY KEY (id_producto),
	CONSTRAINT PROVEEDOR_PRODUCTO_FK FOREIGN KEY (razon_social) REFERENCES PROVEDOR (razon_social),
	CONSTRAINT INVENTARIO_FK FOREIGN KEY (codigo_barras) REFERENCES INVENTARIO(codigo_barras_inventario) ON DELETE CASCADE
);

-- Tabla Cliente
CREATE TABLE CLIENTE(
	 rfc varchar(20) NOT NULL,
	 apellido_paterno VARCHAR(30) NOT NULL,
	 apellido_materno VARCHAR(30)  NULL,
	 nombre VARCHAR(60) NOT NULL,
	 calle varchar(30) NOT NULL,
	 numero int CHECK (numero>0),
	 colonia varchar(30) NOT NULL,
	 codigo_postal varchar(5) NOT NULL,
	 estado int NOT NULL,
	 CONSTRAINT razon_cliente_PK PRIMARY KEY (rfc)
);

-- Tabla email del cliente
CREATE TABLE EMAIL(
	email varchar(80) NOT NULL,
	rfc_cliente varchar(20) NOT NULL,
	CONSTRAINT EMAIL_PK PRIMARY KEY(rfc_cliente,email),
	CONSTRAINT CLIENTE_FK FOREIGN KEY (rfc_cliente) REFERENCES CLIENTE (rfc)
);

-- Tabla venta
CREATE TABLE VENTA(
	 num_venta int GENERATED ALWAYS AS IDENTITY  NOT NULL,
	 fecha_venta date NOT NULL,
	 nota VARCHAR(15) null default 'VENT-',
	 rfc_cliente varchar(20) NOT NULL,
	 CONSTRAINT VENTA_PK PRIMARY KEY (num_venta),
	 CONSTRAINT VENTA_CLIENTE_FK FOREIGN KEY (rfc_cliente) REFERENCES CLIENTE(rfc)
);

-- Tabla detalle venta
CREATE TABLE DETALLE_VENTA(
	num_venta int  NOT NULL,
	id_producto int  NOT NULL,
	precio_producto DECIMAL(6,2) not null,
	cantidad_producto int NOT NULL,
	vental_total DECIMAL(7,2) NOT NULL,
	num_detalle_venta int GENERATED ALWAYS AS IDENTITY not null,
	CONSTRAINT DETALLE_VENTA_PK PRIMARY KEY (num_venta,id_producto),
	CONSTRAINT ORDEN_PRODUCTO_FK FOREIGN KEY (id_producto) REFERENCES  PRODUCTO(id_producto) on delete CASCADE,
	CONSTRAINT VENTA_FK FOREIGN KEY (num_venta) REFERENCES  VENTA(num_venta)on delete CASCADE
);




