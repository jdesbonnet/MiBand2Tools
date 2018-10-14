#!/bin/bash

# Input: .dat file location with MiBand2 data, Number of records to plot

FILENAME=$1
NREC=$2

# Following command is valid if the data hasn't been extracted yet. To follow my standard,
# load the data already from ../../data/<file_name>.dat
# ./read_gadgetbridge_db.sh $DB $USER > miband2.dat
tail -n ${NREC} ${FILENAME} > t.dat # +${REC} used to output all lines.

gnuplot <<EOF

set title "Activity and Heart Rate data from Mi Band 2"

set terminal pngcairo size 1400,600
set output "sleep.png"

set grid
set xdata time
set timefmt "%s"
set format x "%H:%M\n%a"
set yrange [0:200]
set ylabel "Beats Per Minute (bpm)"
set datafile missing '255' 

# Note: lines don't work with the NaNs
#plot 't.dat' using 1:((\$7<40||\$7>150)?NaN:\$7) with linespoints title "bpm" , \
#'' using 1:4 with impulses lt 3 title 'Activity' , \
#'' using 1:5 with impulses lt 2 title 'Steps', \
#'' using 1:6 
#plot 't.dat' using 1:7 with linespoints title "bpm" , '' using 1:4 with impulses lt 3 title 'Activity'


plot 't.dat' using 1:((\$7<40||\$7>150)?NaN:\$7) with linespoints title "bpm" , '' using 1:4 with impulses lt 3 title 'Activity'
EOF
java Analyze ${FILENAME} > sleep.dat
#gnuplot sleep_summary.gnuplot. Uncommented because I don't use the sleep summary.

