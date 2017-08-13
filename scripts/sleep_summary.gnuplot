#
# Plot sleep summary. Plotting stacked bar chart with timeo on x axis
# is a little tricky. See:
# https://stackoverflow.com/questions/23749093/stacked-histogram-over-time-via-gnuplot
#

set terminal pngcairo size 1400,850
set output "sleep_summary.png"

set key opaque right bottom 

#set title "Sleep summary (data from Mi Band 2)"
set multiplot layout 5, 1  title "Sleep etc" font ",18"

set tmargin 0.35
set bmargin 0.35
set lmargin 10


set grid ytics noxtics
set xdata time
set format x "%d/%m\n%a"

# 
# Weight plot
#
set timefmt "%Y%m%d"
set ylabel "kg"
set format x ""
set xrange["20170622":"20170813"]
plot 'weight.dat' using 1:2:xtic("") with linespoints linewidth 2 title "weight"


# 
# Heart rate plot
#
set timefmt "%s"
set ylabel "beats per minute"
set format x ""
set xrange [*:*]
plot 'sleep.dat' using (timecolumn(1)+100000):5:6:xtic("") with errorbars linewidth 2 title "sleeping heart rate / standard deviation"

#unset xdata
#set style data histogram
#plot 'sleep.dat' using 5:xtic("") title 'sleeping heart rate' fillcolor rgb "#6020ff"

# 
# Sleep hours
# 
unset xdata
set key opaque right top
set ylabel "hours"
set yrange [0:14]
set style data histograms
set style histogram rowstacked
set boxwidth 1 relative
set style fill solid 1.0 border -1

plot 'sleep.dat' using 3:xtic("") title 'main sleep' fillcolor rgb "#6020ff",\
     '' using 4 title 'nap' fillcolor rgb '#ffb020'



#
# Seeping activity
#
set key opaque right top
#unset xdata
set ylabel "arbitrary units"
set style data histograms
set boxwidth 1 relative
set style fill solid 1.0 border -1
set yrange [0:8]
plot 'sleep.dat' using 9:xtic("") title 'mean sleep activity' fillcolor rgb "#60c000"




# Room for tic labels on bottom chart
set bmargin 3
set xtics font ", 8"

#
# Daily steps
#
set key opaque right top
unset xdata
set ylabel "ksteps"
set style data histograms
set boxwidth 1 relative
set style fill solid 1.0 border -1
set yrange [0:*]
plot 'sleep.dat' using ($10/1000):xtic(strftime("%d\n%b\n%a", strptime("%Y%m%d", strcol(2)))) title 'daily steps' fillcolor rgb "#60c0ff"



