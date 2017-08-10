#
# Plot sleep summary. Plotting stacked bar chart with timeo on x axis
# is a little tricky. See:
# https://stackoverflow.com/questions/23749093/stacked-histogram-over-time-via-gnuplot
#

set terminal pngcairo size 1400,600
set output "sleep_summary.png"

set key opaque right bottom 

#set title "Sleep summary (data from Mi Band 2)"
set multiplot layout 3, 1  title "Sleep summary (data from Mi Band 2)" font ",18"

set tmargin 0.25
set bmargin 0.25
set lmargin 10


set grid ytics noxtics
set xdata time
#set timefmt "%Y%m%d"
set timefmt "%s"
set format x "%d/%m\n%a"


# 
# Heart rate plot
#
#set size 1.0,0.3
#set origin 0,0.7

#set xrange ["20170623":"20170730"]

set ylabel "beats per minute"
set format x ""
plot 'sleep.dat' using (timecolumn(1)+100000):5:6:xtic("") with errorbars linewidth 2 title "sleeping heart rate / standard deviation"


# 
# Sleep hours
# 
#set size 1.0,0.7
unset xdata
set ylabel "hours"
set style data histograms
set style histogram rowstacked
set boxwidth 1 relative
set style fill solid 1.0 border -1

plot 'sleep.dat' using 3:xtic("") title 'main sleep' fillcolor rgb "#6020ff",\
     '' using 4 title 'nap' fillcolor rgb '#ffb020'


# Room for tic labels on bottom chart
set bmargin 3


#
# Seeping activity
#
set key opaque right top
unset xdata
set ylabel "arbitrary units"
set style data histograms
set boxwidth 1 relative
set style fill solid 1.0 border -1
plot 'sleep.dat' using 9:xtic(strftime("%d\n%m", strptime("%Y%m%d", strcol(2)))) title 'mean sleep activity' fillcolor rgb "#60c000"





