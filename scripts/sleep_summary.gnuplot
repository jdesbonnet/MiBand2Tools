#
# Plot sleep summary. Plotting stacked bar chart with timeo on x axis
# is a little tricky. See:
# https://stackoverflow.com/questions/23749093/stacked-histogram-over-time-via-gnuplot
#

set title "Sleep summary (data from Mi Band 2)"

set terminal pngcairo size 1400,600
set output "sleep_summary.png"

set grid
#set xdata time
#set timefmt "%Y%m%d"
set format x "%H:%M\n%a"

#set xlabel "Date"
set ylabel "Hours"

set style data histograms
set style histogram rowstacked
set boxwidth 1 relative
set style fill solid 1.0 border -1

plot 'sleep.dat' using 2:xtic(1) title 'main sleep','' using 3 title 'nap' lt 3


