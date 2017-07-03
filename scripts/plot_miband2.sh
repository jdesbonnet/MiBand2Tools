#!/bin/bash

DB=$1
./read_gadgetbridge_db.sh $DB > t.dat
gnuplot <<EOF

set title "Sleeping heart rate data from Mi Band 2"

set terminal pngcairo size 1280,600
set output "sleep.png"

set xdata time
set timefmt "%s"
set yrange [40:120]
set ylabel "Beats per minute (bpm)"

plot 't.dat' using 1:7 title "Sleeping heart rate (bpm)"
EOF
