CREATE DATABASE Tienda;

CREATE TABLE Provedor ( 
    razonSocial VARCHAR(60),
    calle VARCHAR(30),
    codigoPostal INTEGER,
    colonia VARCHAR(30),
    nombre VARCHAR(30),
    apellidoPaterno VARCHAR(30),
    apellidoMAterno VARCHAR(30),
    PRIMARY KEY (razonSocial)
);

CREATE TABLE TelefonoProvedor (
    telefono INTEGER,
    razonSocialT VARCHAR,
    PRIMARY KEY (telefono),
    FOREIGN KEY (razonSocialT) REFERENCES rasonSocial(Provedor)
);

CREATE TABLE Producto (
    idProducto INTEGER,
    decripcion VARCHAR(200),
    marca VARCHAR(30),
    precio DECIMAL,
    codigoBarras INTEGER,
    PRIMARY KEY (idProvedor)
);

CREATE TABLE Inventario (
    codigoBarraInv INTEGER,
    fechaCompra DATE,
    cantidaBodega INTEGER,
    PRIMARY KEY (codigoBarraInv)
);
CREATE TABLE Ventas (
    numVenta VARCHAR ( 20),
    totalVenta VARCHAR (20),
    fechaVenta VARCHAR (20)
);
-- Orden detalle con dos llaves foraneas
CREATE TABLE OrdenDetalle (
    num_venta INTEGER,
    id_productoD INTEGER,
    precioProducto DECIMAL,
    cantidaProducto INTEGER
	constraint orden_venta_detalle_PK primary key (num_venta,id_producto),
    constraint orden_producto_FK foreign key (id_producto) references Producto(idProducto),
    constraint num_venta_FK foreign key (num_venta) references Venta(numVenta)
);

--ALTER TABLE OrdenDEtalle ADD CONSTRAINT numVentas FOREIGN KEY (numVentas) REFERENCES TABLE Ventas(numVentas);
CREATE TABLE Cliente (
    rfc VARCHAR(25),
    apellidoPaterno VARCHAR(20),
    apellidoMaterno VARCHAR(20),
    nombre  VARCHAR(20),
    calle VARCHAR(20),
    numero VARCHAR(20),
    colonia VARCHAR(20),
    codigoPostal INTEGER,
    estado VARCHAR (20)
    PRIMARY KEY (rfc)
);

CREATE TABLE EmailCliente (
    email VARCHAR(30),
    rfcClienteEC VARCHAR(25),
    PRIMARY KEY (email),
    FOREIGN KEY (rfcClienteEC) REFERENCES rfc(Cliente)
);
