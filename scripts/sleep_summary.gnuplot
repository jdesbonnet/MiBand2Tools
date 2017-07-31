#
# Plot sleep summary. Plotting stacked bar chart with timeo on x axis
# is a little tricky. See:
# https://stackoverflow.com/questions/23749093/stacked-histogram-over-time-via-gnuplot
#

set terminal pngcairo size 1400,600
set output "sleep_summary.png"

#set title "Sleep summary (data from Mi Band 2)"
set multiplot layout 2, 1  title "Sleep summary (data from Mi Band 2)" font ",24"

set tmargin 0.5
set bmargin 3
set lmargin 10


set grid
set xdata time
#set timefmt "%Y%m%d"
set timefmt "%s"
set format x "%d/%m\n%a"


# 
# Heart rate plot
#
#set xrange ["20170623":"20170730"]

set ylabel "beats per minute"
plot 'sleep.dat' using (timecolumn(1)+100000):5:6:xtic(strftime("%d\n%m", strptime("%Y%m%d", strcol(2)))) with errorbars linewidth 2 title "heart rate / standard deviation"

#set xrange ["1498194000":"1501390800"]
#plot 'sleep.dat' using (timecolumn(1)+100000):5:6 with errorbars linewidth 2 title "heart rate / standard deviation"


# 
# Sleep hours
# 
unset xdata
#set xrange restore
#set xrange ["1498194000":"1501390800"]

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



