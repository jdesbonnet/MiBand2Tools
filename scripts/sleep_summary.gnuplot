#
# Plot sleep summary. Plotting stacked bar chart with timeo on x axis
# is a little tricky. See:
# https://stackoverflow.com/questions/23749093/stacked-histogram-over-time-via-gnuplot
#

set terminal pngcairo size 1400,600
set output "sleep_summary.png"

#set title "Sleep summary (data from Mi Band 2)"
set multiplot layout 3, 1  title "Sleep summary (data from Mi Band 2)" font ",18"

set tmargin 0.5
set bmargin 1
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
# Seeping activity
#

unset xdata
set ylabel "mean activity"
set style data histograms
set boxwidth 1 relative
set style fill solid 1.0 border -1
plot 'sleep.dat' using 9:xtic("") title 'mean sleep activity' fillcolor rgb "#6020ff"


set bmargin 3

# 
# Sleep hours
# 
#set size 1.0,0.7
unset xdata
#set xrange restore
#set xrange ["1498194000":"1501390800"]

#set xlabel "Date"
set ylabel "hours"
set style data histograms
set style histogram rowstacked
set boxwidth 1 relative
set style fill solid 1.0 border -1

#plot 'sleep.dat' using 2:xtic(1) title 'main sleep','' using 3 title 'nap' lt 3

#plot 'sleep.dat' using 3:xtic(strftime("%d\n%m", strptime("%Y%m%d", strcol(2)))) title 'main sleep' fillcolor rgb "#6020ff",\
#     '' using 4 title 'nap' fillcolor rgb '#ffb020'
plot 'sleep.dat' using 3:xtic(strftime("%d\n%m", strptime("%Y%m%d", strcol(2)))) title 'main sleep' fillcolor rgb "#6020ff",\
     '' using 4 title 'nap' fillcolor rgb '#ffb020'



