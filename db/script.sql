CREATE TABLE Clientes(
   id INT NOT NULL,
   CUIT INT NOT NULL UNIQUE,
   apellido VARCHAR(32),
   nombre VARCHAR(32),
   region VARCHAR(32),
   PRIMARY KEY (id)
);

CREATE TABLE Productos(
  nombre VARCHAR(64) NOT NULL,
  precioUnitario DECIMAL(8,2),
  PRIMARY KEY (nombre)
);

CREATE TABLE Facturas(
  id INT NOT NULL,
  nroFactura INT NOT NULL UNIQUE,
  clienteId INT,
  fechaEmision DATE,
  fechaVencimiento DATE,
  condPago VARCHAR(32),
  total DECIMAL (12,2),
  PRIMARY KEY (id),
  FOREIGN KEY (clienteId)
  	REFERENCES Clientes(id)
  	ON DELETE SET NULL
 );

CREATE TABLE Productos_Facturas(
  facturaId INT NOT NULL,
  productoNombre VARCHAR(64) NOT NULL,
  cantidad INT,
  PRIMARY KEY (facturaId, productoNombre),
  FOREIGN KEY (facturaId)
  	REFERENCES Facturas(id)
  	ON DELETE CASCADE,
  FOREIGN KEY (productoNombre)
  	REFERENCES Productos(nombre)
  	ON DELETE CASCADE
);