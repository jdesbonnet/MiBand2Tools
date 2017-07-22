#!/bin/bash

DB=$1
USER=$2
NREC=$3

./read_gadgetbridge_db.sh $DB $USER > miband2.dat
tail -n ${NREC} miband2.dat > t.dat

gnuplot <<EOF

set title "Activity and sleeping heart rate data from Mi Band 2"

set terminal pngcairo size 1400,600
set output "sleep.png"

set grid
set xdata time
set timefmt "%s"
set format x "%H:%M\n%a"
set yrange [0:130]
set ylabel "Beats per minute (bpm)"

set datafile missing '255' 

# Note: lines don't work with the NaNs
plot 't.dat' using 1:((\$7<40||\$7>150)?NaN:\$7) with linespoints title "Sleeping heart rate (bpm)" , \
'' using 1:4 with impulses lt 3 title 'Activity' , \
'' using 1:5 with impulses lt 2 title 'Steps', \
'' using 1:6 
#plot 't.dat' using 1:7 with linespoints title "Sleeping heart rate (bpm)" , '' using 1:4 with impulses lt 3 title 'Activity'

EOF
