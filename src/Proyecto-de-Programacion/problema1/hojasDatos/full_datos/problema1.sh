#!/bin/bash

DATA=/home/lxs2/LXS2_marlon/src/Proyecto-de-Programacion/problema1/hojasDatos
OUT_DATA=$DATA/archivos_csv
GRAF_DATA=$DATA/datos_graf
FULL_DATA=$DATA/full_datos

## Creamos las carpetas donde manejaremos los archivos por separado y definimos las variables

mkdir $OUT_DATA
mkdir $GRAF_DATA
mkdir $FULL_DATA

## En este ciclo for se convierten los archivos .xls a .csv

m=1

for i in `find $DATA -name '*.xls'`
do
	echo "Procesando archivo $i"

	xls2csv $i > $OUT_DATA/datos-$m.csv
	let m=m+1
done 2> error1.log

## En este ciclo for se le da el formato a los datos de una manera limpia en la cual
## se puedan enviar a un archivo .dat y asi poder graficar

m=1

for e in `find $OUT_DATA -name "*.csv"`
do
	echo "Dando formato de datos para graficar el archivo $e"
	cat $e | awk -F "\",\"" '{print $1 " " $2 " " $3 " " $4 " " $5}' | sed '1,$ s/"//g' | sed '1 s/date/#date/g' > $GRAF_DATA/graf-$m.dat
	let m=m+1
done 2> error2.log

## En este condicional if se elimina el archivo full.dat para no crear duplicados 

if [ -a $FULL_DATA/full.dat ]
then
	rm $FULL_DATA/full.dat
	echo "Archivo full.dat borrado"
fi 2> errorIf.log

## En este ciclo for creamos un archivo con todos los datos a graficar

for k in `find $GRAF_DATA -name "*.dat"`
do
	sed '1d' $k >> $FULL_DATA/full.dat
	echo "Procesando archivo $k"
done 2> error3.log

FMT_BEGIN='20110206 0000'
FMT_END='20110206 0200'
FMT_X_SHOW=%H:%M
DATA_DONE=$FULL_DATA/full.dat

## Esta ultima parte de nuestro script problema1.sh es para graficar el archivo full.dat

graficar()
{
	gnuplot << EOF 2> error.log
	set xdata time
	set timefmt "%Y%m%d %H%M"
#	set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set format x "$FMT_X_SHOW"
	set terminal png
	set output 'fig1.png'
	plot "$DATA_DONE" using 1:3 with lines title "sensor1","$DATA_DONE" using 1:4 with linespoints title "sensor2"
EOF

}

graficar

