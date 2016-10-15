#!/bin/bash

# Ejemplo de case, determina si la distro está soportada

shopt -s nocasematch

DISTRO=$i


case "$DISTRO" in
	Ubuntu)
		echo "Distribución $DISTRO soportada"
	;;
	Centos)
		echo "Distribución $DISTRO soportada"
	;;
	Fedora)
		echo "Distribución $DISTRO soportada"
	;;
	*)
		echo "Distro no soportada"
esac
