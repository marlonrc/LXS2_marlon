#! /bin/bash

ERRORLOG="$0.err"

# La salida estándar de error estará rediraccionada al archivo if-the.sh.err

if cp archivo1.txt archivo1.txt.bck 2> $ERRORLOG
then
	echo "El archivo1.txt fue correctamente respaldado"
else
	echo "El archivo1.txt no pudo ser respaldado, verifique el log :$ERRORLOG"
fi
