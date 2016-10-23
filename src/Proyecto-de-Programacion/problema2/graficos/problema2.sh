#!/bin/bash

# Definimos las variables a utilizar en el script problema2.sh

FACTURAS=/home/lxs2/LXS2_marlon/src/Proyecto-de-Programacion/problema2
FACTURAS_CSV=$FACTURAS/factura_csv
FACTURAS_GRAF=$FACTURAS/factura_graf
FACTURAS_COMP=$FACTURAS/graficos

# Creamos las carpetas donde se guardaran los archivos

mkdir $FACTURAS_CSV
mkdir $FACTURAS_GRAF
mkdir $FACTURAS_COMP

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

# Se crean los condicionales para evitar datos duplicados en los graficos finales

if [ -a $FACTURAS_COMP/graf_luz.dat ]
then
	rm $FACTURAS_COMP/graf_luz.dat
	echo "Archivo graf_luz.dat eliminado"
fi 2> errorIfLuz.log

if [ -a $FACTURAS_COMP/graf_agua.dat ]
then
	rm $FACTURAS_COMP/graf_agua.dat
	echo "Archivo graf_agua.dat eliminado"
fi 2> errorIfAgua.log

# Creamos el ciclo con los datos a graficar en el consumo de luz
# En este ciclo ingresamos las variables manualmente para que se grafiquen especificamente los 3 primeros meses

for l in $FACTURAS_GRAF/factura_graf-5.dat $FACTURAS_GRAF/factura_graf-4.dat $FACTURAS_GRAF/factura_graf-3.dat
do
	sed '1d' $l >> $FACTURAS_COMP/graf_luz.dat
	echo "Procesando archivo $l"
done 2> errorGrafLuz.log

# Creamos el ciclo con los datos a graficar en el consumo de agua

for a in `find $FACTURAS_GRAF -name "*.dat"`
do
	sed '1d' $a >> $FACTURAS_COMP/graf_agua.dat
	echo "Procesando archivo $a"
done 2> errorGrafAgua.log

graficar()
{
	gnuplot << EOF 2> errorGrafLuz.log
	set xtic labels ('Luz')
	set terminal png
	set output 'figLuz.png
	plot "$FACTURAS_COMP/graf_luz.dat" using 1:2 with lines
EOF

}

graficar

