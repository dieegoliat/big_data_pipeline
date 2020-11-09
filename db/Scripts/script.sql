DROP TABLE IF EXISTS Productos_Facturas;
DROP TABLE IF EXISTS Facturas;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes ;

CREATE TABLE Clientes(
   id INT NOT NULL AUTO_INCREMENT,
   cuit BIGINT UNIQUE,
   apellido VARCHAR(32),
   nombre VARCHAR(32),
   region VARCHAR(32),
   PRIMARY KEY (id)
);

CREATE TABLE Productos(
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(64) NOT NULL,
  precioUnitario DECIMAL(8,2),
  PRIMARY KEY (id)
);

CREATE TABLE Facturas(
  id INT NOT NULL AUTO_INCREMENT,
  oid VARCHAR(64) NOT NULL UNIQUE,
  nroFactura INT NOT NULL UNIQUE,
  clienteCUIT BIGINT,
  fechaEmision DATE,
  fechaVencimiento DATE,
  condPago VARCHAR(32),
  total DECIMAL (8,2),
  PRIMARY KEY (id),
  FOREIGN KEY (clienteCUIT)
    REFERENCES Clientes(cuit)
    ON DELETE SET NULL
 );

CREATE TABLE Productos_Facturas(
  facturaId INT NOT NULL,
  productoId INT NOT NULL,
  cantidad INT,
  PRIMARY KEY (facturaId, productoId),
  FOREIGN KEY (facturaId)
    REFERENCES Facturas(id)
    ON DELETE CASCADE,
  FOREIGN KEY (productoId)
    REFERENCES Productos(id)
    ON DELETE CASCADE
);