#!/bin/bash

FMT_BEGIN=20110206 0004
FMT_END=20110206 0204
FMT_X_SHOW=%H:%M

graficar()
{
	gnuplot << EOF 2> error.log
	set xdata time
	set timefmt "%Y%m%d %H%M"
	set xrange ["$FMT_BEGIN":"$FMT_END"]
	set format x "$FMT_X_SHOW"
	set terminal png
	set output 'fig1.png'
	plot "graf-1.dat" using 1:3 with lines title "Sensor 1", "graf-1.dat" using 1:4 with linespoints title "Sensor 2"
EOF
}

graficar

