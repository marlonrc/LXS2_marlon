#!/bin/bash

# Definimos las variables a utilizar en el script problema2.sh

FACTURAS=/home/lxs2/LXS2_marlon/src/Proyecto-de-Programacion/problema2
FACTURAS_CSV=$FACTURAS/factura_csv

# Creamos las carpetas donde se guardaran los archivos

mkdir $FACTURAS_CSV

# Creamos el ciclo para convertir los archivos .xls a .csv

f=1

for x in `find $FACTURAS -name '*.xls'`
do
	echo "Procesando archivo $x"
	xls2csv $x > $FACTURAS_CSV/factura-$f.csv
	let f=f+1
done 2> errorFactura.log

