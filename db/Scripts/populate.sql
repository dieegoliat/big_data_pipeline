-- POPULAR TABLA CLIENTES

CREATE TEMPORARY TABLE IF NOT EXISTS tempClientes AS (
	SELECT DISTINCT 
		cuit, 
		cliente_apellido, 
		cliente_nombre, 
		region 
	FROM facturas_maestra);

INSERT INTO clientes ( 
      cuit, 
      apellido, 
      nombre, 
      region) 
SELECT cuit, 
       cliente_apellido, 
       cliente_nombre, 
       region
FROM tempClientes;

-- POPULAR TABLA PRODUCTOS

CREATE TEMPORARY TABLE IF NOT EXISTS tempProductos AS (
	SELECT DISTINCT 
		producto, 
		precio
	FROM facturas_maestra);
    
INSERT INTO productos ( 
      nombre, 
      precioUnitario) 
SELECT producto, 
       precio
FROM tempProductos;

-- POPULAR TABLA FACTURAS

CREATE TEMPORARY TABLE IF NOT EXISTS tempFacturas AS (
	SELECT DISTINCT 
		oid, 
		nro_factura, 
		cuit, 
		fecha_emision,
    	fecha_vencimiento,
    	condpago,
    	0 AS total
	FROM facturas_maestra);
    
INSERT INTO facturas ( 
      oid, 
      nroFactura, 
      clienteCUIT, 
      fechaEmision,
	  fechaVencimiento,
	  condPago,
	  total) 
SELECT oid, 
       nro_factura, 
       cuit, 
       fecha_emision,
       fecha_vencimiento,
       condpago,
       total
FROM tempFacturas;

-- CARGAR TOTALES DE FACTURAS
-- ESTO PODRIA NECESITARSE SER IMPORTADO O EJECUTADO EN BACKGROUND
-- CREADO UN ARCHIVO cargar_total_facturas.sql PARA EJECUTAR POR SEPARADO

CREATE TEMPORARY TABLE IF NOT EXISTS tempFacturasTotal AS (
    SELECT f.nroFactura, SUM(fm.cantidad * fm.precio) AS total FROM facturas f
        INNER JOIN facturas_maestra fm
            ON fm.nro_factura = f.nroFactura
        GROUP BY nroFactura);


UPDATE facturas f SET total = (SELECT total FROM tempFacturasTotal tf WHERE tf.nroFactura = f.nroFactura)

-- POPULAR TABLA PRODUCTOS_FACTURAS

CREATE TEMPORARY TABLE IF NOT EXISTS tempFacturasPorProducto AS (
    SELECT fm.cantidad, f.id AS facturaId, p.id AS productoId
        FROM facturas_maestra fm
        LEFT JOIN facturas f
            ON f.nroFactura = fm.nro_factura
        LEFT JOIN productos p
            ON p.nombre = fm.producto);
            
INSERT INTO productos_facturas (
    facturaId,
    productoId,
    cantidad)
SELECT facturaId,
  productoId,
    cantidad
FROM tempFacturasPorProducto;
            
