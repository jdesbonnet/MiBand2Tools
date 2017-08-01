
sleep = dlmread('sleep.dat');
main_sleep = sleep ( : ,3);
nap_sleep = sleep ( : ,4);

mean(main_sleep(~isna(main_sleep)))
mean(nap_sleep(~isna(nap_sleep)))

