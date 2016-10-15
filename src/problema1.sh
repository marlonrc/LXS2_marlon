#!/bin/bash

DATA=/home/lxs2/Downloads/Proyecto-de-Programacion/problema1/hojasDatos
OUT_DATA=$DATA/archivos_csv
GRAF_DATA=$DATA/datos_graf

mkdir $OUT_DATA
mkdir $GRAF_DATA

m=1

for i in `find $DATA -name '*.xls'`
do
	echo "Procesando archivo $i"

	xls2csv $i > $OUT_DATA/datos-$m.csv
	let m=m+1
done 2> error1.log

m=1

for e in `find $OUT_DATA -name "*.csv"`
do
	echo "Dando formato de datos para graficar el archivo $e"
	cat $e | awk -F "\",\"" '{print $1 " " $2 " " $3 " " $4 " " $5}' | sed '1,$ s/"//g' | sed '1 s/date/#date/g' > $GRAF_DATA/graf-$m.dat
	let m=m+1
done 2> error2.log


