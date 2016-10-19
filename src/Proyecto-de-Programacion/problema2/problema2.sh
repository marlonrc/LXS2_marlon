#!/bin/bash

# Definimos las variables a utilizar en el script problema2.sh

FACTURAS=/home/lxs2/LXS2_marlon/src/Proyecto-de-Programacion/problema2
FACTURAS_CSV=$FACTURAS/factura_csv
FACTURAS_GRAF=$FACTURAS/factura_graf

# Creamos las carpetas donde se guardaran los archivos

mkdir $FACTURAS_CSV
mkdir $FACTURAS_GRAF

# Creamos el ciclo para convertir los archivos .xls a .csv

f=1

for x in `find $FACTURAS -name '*.xls'`
do
	echo "Procesando archivo $x"
	xls2csv $x > $FACTURAS_CSV/factura-$f.csv
	let f=f+1
done 2> errorFactura.log

# Creamos el ciclo para dar formato de datos al archivo .csv y guardamos solamente la informacion necesaria

f=1

for d in `find $FACTURAS_CSV -name "*.csv"`
do
	echo "Dando formato de datos al archivo $d"
	cat $d |awk -F "\",\"" '{print $1 " " $2}' | sed '1,$ s/"//g' | sed '1d' | sed '1 s/Servicios/#Servicios/g' | head > $FACTURAS_GRAF/factura_graf-$f.dat
	let f=f+1
done 2> errorDatosGraf.log

