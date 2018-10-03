#!/usr/bin/env octave -q
#
# Histogram of Mi Band 2 data
#
# Command line:
# octave histogram.m  data.dat > /dev/null
#
# Original script by Joe Desbonnet,
# jdesbonnet@gmail.com
# July 3rd, 2017

datain = argv(){1}
dataout = argv(){2}

miband2data = dlmread(datain, " ")

hr = miband2data( : , 7)
bins = [50 : 2 : 120]
hrhistogram = hist(hr,bins)

out = horzcat (bins', hrhistogram')
dlmwrite (dataout, out, " " )

