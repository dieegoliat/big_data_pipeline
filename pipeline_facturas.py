#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 18 13:43:51 2020

@author: dieegoliat
"""
import json
#import pandas as pd


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
    cuit = cliente.get("cuit", None)
    region = cliente.get("region", None)
    
    print(apellido, nombre, cuit, region)
    
    # Forma de Pago
    condPago = item.get("condPago", None)
    fechaEmision = item.get("fechaEmision", None).get("$date", None)
    fechaVencimiento = item.get("fechaVencimiento", None).get("$date", None)
    
    print(condPago, fechaEmision, fechaVencimiento)
    
    #Factura    
    nro_factura = item.get("nroFactura", None)
    
    print("N° de Factura:", nro_factura)
    
    for item in item.get('item', []):
        cantidad = item.get("cantidad", None)
        precio = item.get("precio", None)
        producto = item.get("producto", None)
        print(cantidad, precio, producto)
        
    print("---------------------------------")
    
