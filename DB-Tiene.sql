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
    numVenta INTEGER ,
    totalVenta VARCHAR (20),
    fechaVenta VARCHAR (20)
);
CREATE TABLE OrdenDetalle (
    numVentas VARCHAR(20),
    idProductoD INTEGER,
    precioProducto DECIMAL,
    cantidaProducto INTEGER
    PRIMARY KEY (ipProducto),
    --- Aqui se le tiene que agregar la otra PK de numVentas y la FK igualmente de numVentas
    FOREIGN KEY (idProductoD) REFERENCES idProducto(Producto)
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
