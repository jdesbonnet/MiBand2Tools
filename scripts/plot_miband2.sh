#!/bin/bash

DB=$1
NREC=1000

./read_gadgetbridge_db.sh $DB 2 > miband2.dat
tail -n ${NREC} miband2.dat > t.dat

gnuplot <<EOF

set title "Activity and sleeping heart rate data from Mi Band 2"

set terminal pngcairo size 1400,600
set output "sleep.png"

set grid
set xdata time
set timefmt "%s"
set format x "%H:%M\n%a"
set yrange [0:120]
set ylabel "Beats per minute (bpm)"

plot 't.dat' using 1:7 title "Sleeping heart rate (bpm)" , '' using 1:4 with impulses lt 3 title 'Activity'
EOF
