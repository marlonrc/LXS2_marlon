#!/bin/bash

DATA=/home/lxs2/Downloads/Proyecto-de-Programacion/problema1/hojasDatos
mkdir $DATA/archivos_csv

OUT_DATA=$DATA/archivos_csv

m=1

for i in `find $DATA -name '*.xls'`
do
	echo "Procesando archivo $i"

	xls2csv $i > $OUT_DATA/datos-$m.csv
	let m=m+1
done 2> error1.log
