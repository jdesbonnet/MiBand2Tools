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
		int activity,mainSleep=0,napSleep=0, hour;
		long time;

		LineNumberReader r = new LineNumberReader(new FileReader(arg[0]));

		while ( (line = r.readLine()) != null) {
		
			String[] p = line.split(" ");

			time = Long.parseLong(p[0]);
			date = df.format(time*1000);
			hour = Integer.parseInt(hf.format(time*1000));

			if (!date.equals(lastDate)) {
				double mainSleepHours = (double)mainSleep / 60.0;
				double napSleepHours = (double)napSleep / 60.0;
				System.out.println (lastDate 
					+ " " + String.format("%.1f",mainSleepHours)
					+ " " + String.format("%.1f",napSleepHours)
				);
				mainSleep = 0;
				napSleep = 0;
			}

			activity = Integer.parseInt(p[5]);

			if (activity == SLEEP) {
				if (hour < 12) {
					mainSleep++;
				} else {
					napSleep++;
				}
			}

			lastDate = date;

		}

	}
}

