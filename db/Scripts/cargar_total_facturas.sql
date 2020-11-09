CREATE TEMPORARY TABLE IF NOT EXISTS tempFacturasTotal AS (
    SELECT f.nroFactura, SUM(fm.cantidad * fm.precio) AS total FROM facturas f
        INNER JOIN facturas_maestra fm
            ON fm.nro_factura = f.nroFactura
        GROUP BY nroFactura);


UPDATE facturas f SET total = (SELECT total FROM tempFacturasTotal tf WHERE tf.nroFactura = f.nroFactura)