package org.whale.base;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogTimeUtil {
	private static final Logger logger = LoggerFactory.getLogger(LogTimeUtil.class);

	public static long logStartTime(String msg) {
		long logStartTime = new Date().getTime();
		logger.warn(msg + " logStartTime:" + logStartTime);
		return logStartTime;
	}
	
	public static void logEndTime(long logStartTime, String msg) {
		Date logEndDate = new Date();
		long logEndTime = logEndDate.getTime();
		long durationTime = logEndTime - logStartTime;
		logger.warn(msg + " logStartTime:" + logStartTime + ", logEndTime:" + logEndTime + ", durationTime:" + durationTime);
		if(durationTime > 10000) {
			logger.warn(msg + " 10000 end logStartTime:" + logStartTime + ", logEndTime:" + logEndTime + ", durationTime:" + durationTime);
		}
		if(durationTime > 30000) {
			logger.warn(msg + " 30000 end logStartTime:" + logStartTime + ", logEndTime:" + logEndTime + ", durationTime:" + durationTime);
		}
	}

}
