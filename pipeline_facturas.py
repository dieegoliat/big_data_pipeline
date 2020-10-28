#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 18 13:43:51 2020

@author: dieegoliat
"""
import json
import  mysql.connector as mysql
import datetime

conn = mysql.connect(user='root', 
                     password='', 
                     database='facturas', 
                     host='localhost')

cursor = conn.cursor()
    

###############################################
########### Parser ###########################

data = []

for line in open('facturas.json', 'r'):
    data.append(json.loads(line))

# parse json data to SQL insert
for i, item in enumerate(data):
    _id = item.get("_id", None)
    oid = _id.get("$oid", None)
    
    print(oid)
    
    # Cliente
    cliente = item.get("cliente", None)
    apellido = cliente.get("apellido", None)
    nombre = cliente.get("nombre", None)
    cuit_int = int(cliente.get("cuit", None))
    cuit = cliente.get("cuit", None)
    region = cliente.get("region", None)
    
    print(apellido, nombre, cuit, cuit_int, region)
    
    # Forma de Pago
    condPago = item.get("condPago", None)
    fechaEmision = item.get("fechaEmision", None).get("$date", None)
    fechaVencimiento = item.get("fechaVencimiento", None).get("$date", None)
    
    d1 = datetime.datetime.strptime(fechaEmision,"%Y-%m-%dT%H:%M:%SZ")
    new_format = "%Y-%m-%d"
    fecha_emision = d1.strftime(new_format)
    d2 = datetime.datetime.strptime(fechaVencimiento,"%Y-%m-%dT%H:%M:%SZ")
    fecha_vencimiento = d2.strftime(new_format)
    
    print(condPago, fecha_emision, fecha_vencimiento)
    
    #Factura    
    nro_factura = item.get("nroFactura", None)
    
    print("N° de Factura:", nro_factura)
    
    for item in item.get('item', []):
        cantidad = item.get("cantidad", None)
        precio = item.get("precio", None)
        producto = item.get("producto", None)
        print(cantidad, precio, producto)
        sql = "INSERT INTO facturas (oid, cliente_nombre, cliente_apellido, cuit, region, condpago, fecha_emision, fecha_vencimiento, nro_factura, producto, cantidad, precio) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        val = (oid, nombre, apellido, cuit_int, region, condPago, fecha_emision, fecha_vencimiento, nro_factura, producto, cantidad, precio)
        cursor.execute(sql, val)
    print("---------------------------------")
    
    
    

conn.commit()

###############################################

conn.close()
