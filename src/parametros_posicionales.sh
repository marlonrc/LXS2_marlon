#! /bin/bash

# La salida estándar de error estará rediraccionada al archivo if-the.sh.err

if cp archivo1.txt archivo1.txt.bck 2> $0.err
then
	echo "El archivo1.txt fue correctamente respaldado"
fi
