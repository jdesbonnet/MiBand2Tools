#!/bin/bash

DB=$1
NREC=20000

./read_gadgetbridge_db.sh $DB > t.dat
tail -n ${NREC} t.dat > a.dat
mv a.dat t.dat
gnuplot <<EOF

set title "Sleeping heart rate data from Mi Band 2"

set terminal pngcairo size 1400,600
set output "sleep.png"

set grid
set xdata time
set timefmt "%s"
set format x "%H:%M"
set yrange [0:120]
set ylabel "Beats per minute (bpm)"

plot 't.dat' using 1:7 title "Sleeping heart rate (bpm)" , '' using 1:4 with impulses lt 3
EOF
