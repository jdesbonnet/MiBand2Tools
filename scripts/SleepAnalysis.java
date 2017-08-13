import java.io.*;
import java.text.*;

/**
 * Analyze MiBand2 data, make table of sleep (main sleep and naps)
 * grouped by day. Main sleep is sleep counted betweeen 00:00 and
 * 12:00, naps at any other time of day. 
 */
public class SleepAnalysis {

	// Date stamp, eg 20170703
	private static SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");

	// Just the hour
	private static SimpleDateFormat hf = new SimpleDateFormat("H");

	private static final int SLEEP = 112;

	public static void main (String[] arg) throws Exception {


		String line,date,lastDate="";
		int activityType,mainSleep=0,napSleep=0, hour;
		int intensity, steps, hr;
		int sigma_hr = 0;
		int sigma_hr2 = 0;
		int sigma_intensity = 0;
		int sigma_steps = 0;

		int hr_min = 999;
		int hr_max = 0;
		int hr_count = 0;
		long time;

		LineNumberReader r = new LineNumberReader(new FileReader(arg[0]));


		System.out.println ("# date main_sleep_hours nap_hours hr_mean hr_sd hr_min hr_max");

		while ( (line = r.readLine()) != null) {
		
			String[] p = line.split(" ");

			time = Long.parseLong(p[0]);
			date = df.format(time*1000);
			hour = Integer.parseInt(hf.format(time*1000));

			if (!date.equals(lastDate) && lastDate.length()>0) {
				// MiBand records are every 1 minute
				double mainSleepHours = (double)mainSleep / 60.0;
				double napSleepHours = (double)napSleep / 60.0;
				double n = (double)hr_count;
				double hr_mean = (double)sigma_hr / n;
				double hr_sd = Math.sqrt( (sigma_hr2 - (sigma_hr*sigma_hr)/n) / (n-1) );
				double meanSleepIntensity = mainSleep == 0 ? 0 : (double)sigma_intensity / (double)mainSleep;
				System.out.println (
					(df.parse(lastDate).getTime()/1000 + 6*3600)
					+ " " + lastDate 
					 
					+ " " + String.format("%.1f",mainSleepHours)
					+ " " + String.format("%.1f",napSleepHours)
					+ " " + String.format("%.1f",hr_mean)
					+ " " + String.format("%.2f",hr_sd)
					+ " " + hr_min
					+ " " + hr_max
					+ " " + String.format("%.2f", meanSleepIntensity)
					+ " " + sigma_steps
				);
				mainSleep = napSleep = 0;
				sigma_hr = sigma_hr2 = 0;
				hr_count = 0;
				hr_min = 999;
				hr_max = 0;
				sigma_intensity = 0;
				sigma_steps = 0;
			}

			intensity = Integer.parseInt(p[3]);
			steps = Integer.parseInt(p[4]);

			activityType = Integer.parseInt(p[5]);
			hr = Integer.parseInt(p[6]);

			sigma_steps += steps;

			if (activityType == SLEEP) {
				if (hour < 12) {
					mainSleep++;
					if (hr != 255) {
						// Measure mean and stddev heart rate during main sleep
						sigma_hr += hr;
						sigma_hr2 += hr*hr;
						if (hr > hr_max) {
							hr_max = hr;
						}
						if (hr < hr_min) {
							hr_min = hr;
						}
						hr_count++;
					}
					sigma_intensity += intensity;
				} else {
					napSleep++;
				}
			}

			lastDate = date;

		}

	}
}

