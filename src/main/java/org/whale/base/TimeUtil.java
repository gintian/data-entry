package org.whale.base;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.whale.system.common.exception.BusinessException;

public class TimeUtil {
	/**
	 * 取当前时间
	 * @param sDateFormat 格式化字符串
	 * @return
	 */
	public static String getCurrDate(String sDateFormat) {
		Calendar gc = new GregorianCalendar();
		java.util.Date date = gc.getTime();
		SimpleDateFormat sf = new SimpleDateFormat(sDateFormat);
		String result = sf.format(date);
		return result;
	}
	 public static String getCurrDate(Date date,String sDateFormat) {
		SimpleDateFormat sf = new SimpleDateFormat(sDateFormat);
		String result = sf.format(date);
		return result;
	}
	/**
     * 获取两个时间相差的天数
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return
     */
    public static long getSubDate(String startDate,String endDate){
    	if(startDate==null || endDate==null){
    		return 0L;
    	}
        Calendar calendar = new GregorianCalendar();
        String format = "yyyyMMdd";
        if( startDate != null && startDate.trim().length() == 6){
            format = "yyyyMM";
        }
        SimpleDateFormat bartDateFormat = new SimpleDateFormat(format);
        try {
            java.util.Date date = bartDateFormat.parse(startDate);
            calendar.setTime(date);
        }catch (Exception ex) {System.out.println(ex.getMessage());}

        Calendar calendar1 = new GregorianCalendar();
        String format1 = "yyyyMMdd";
        if( endDate != null && endDate.trim().length() == 6){
            format1 = "yyyyMM";
        }
        SimpleDateFormat bartDateFormat1 = new SimpleDateFormat(format1);
        try {
            java.util.Date date = bartDateFormat1.parse(endDate);
            calendar1.setTime(date);
        }catch (Exception ex) {System.out.println(ex.getMessage());}

        return (calendar1.getTime().getTime()-calendar.getTime().getTime())/(24*60*60*1000);
    }
	/**
	 * 将date的字符串类型补上YYYY-MM-DD 23:59:59
	 * 
	 * @param dateStr
	 * @return
	 */
	public static String fillUpDateStrToDayMax(String dateStr) {
		if (dateStr == null) {
			throw new BusinessException(
					"调用fillUpDateStrToDayMax()时，参数dateStr为空！");
		}
		return dateStr.trim() + " 23:59:59";
	}

	/**
	 * 将date的字符串类型补上YYYY-MM-DD 00:00:00
	 * 
	 * @param dateStr
	 * @return
	 */
	public static String fillUpDateStrToDayMin(String dateStr) {
		if (dateStr == null) {
			throw new BusinessException(
					"调用fillUpDateStrToDayMin()时，参数dateStr为空！");
		}
		return dateStr.trim() + " 00:00:00";
	}

	/**
	 * 将date置成YYYY-MM-DD 23:59:59
	 * 
	 * @param date
	 * @return
	 */
	public static Date parseDateToDayMax(Date date) {
		if (date == null) {
			throw new BusinessException("调用parseDateToDayMax()时，参数date为空！");
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 0); //值设置999，mysql会处理成次日 00:00:00
		return calendar.getTime();
	}

	/**
	 * 将date置成YYYY-MM-DD 00:00:00
	 * 
	 * @param date
	 * @return
	 */
	public static Date parseDateToDayMin(Date date) {
		if (date == null) {
			throw new BusinessException("调用parseDateToDayMin()时，参数date为空！");
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}

	/**
	 * compareDate是否在startDate和endDate之间（精确时分秒）
	 * 
	 * @param startDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @param compareDate
	 *            比较时间（可以为空，默认当前时间）
	 * @return
	 */
	public static boolean isBetweenStartAndEndDate(Date startDate,
			Date endDate, Date compareDate) {
		if (startDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDate()时，参数startDate为空！");
		}
		if (endDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDate()时，参数endDate为空！");
		}
		if (compareDate == null) {
			compareDate = new Date();
		}

		long startDateTime = startDate.getTime();
		long endDateTime = endDate.getTime();
		long compareDateTime = compareDate.getTime();

		if (startDateTime > endDateTime) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDate()时，startDate应比endDate小或等于！");
		}

		if (compareDateTime >= startDateTime && compareDateTime <= endDateTime) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * compareDate是否 大于等于startDate且小于endDate（精确时分秒）
	 * 
	 * @param startDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @param compareDate
	 *            比较时间（可以为空，默认当前时间）
	 * @return
	 */
	public static boolean isGeStartAndLtEndDate(Date startDate,
			Date endDate, Date compareDate) {
		if (startDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDate()时，参数startDate为空！");
		}
		if (endDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDate()时，参数endDate为空！");
		}
		if (compareDate == null) {
			compareDate = new Date();
		}

		long startDateTime = startDate.getTime();
		long endDateTime = endDate.getTime();
		long compareDateTime = compareDate.getTime();

		if (startDateTime > endDateTime) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDate()时，startDate应比endDate小或等于！");
		}

		if (compareDateTime >= startDateTime && compareDateTime < endDateTime) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * compareDate是否在startDate和endDate之间（忽略时分秒，只判断日期）
	 * 
	 * @param startDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @param compareDate
	 *            比较时间（可以为空，默认当前时间）
	 * @return
	 */
	public static boolean isBetweenStartAndEndDateAccuracyDay(Date startDate,
			Date endDate, Date compareDate) {
		if (startDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDateByDay()时，参数startDate为空！");
		}
		if (endDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDateByDay()时，参数endDate为空！");
		}
		if (compareDate == null) {
			compareDate = new Date();
		}

		return isBetweenStartAndEndDate(getDateForAccuracy(startDate, Calendar.DAY_OF_MONTH), 
								        getDateForAccuracy(endDate, Calendar.DAY_OF_MONTH), 
								        getDateForAccuracy(compareDate, Calendar.DAY_OF_MONTH));
	}
	
	/**
	 * compareDate是否 大于等于startDate且小于endDate（忽略时分秒，只判断日期）
	 * 
	 * @param startDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @param compareDate
	 *            比较时间（可以为空，默认当前时间）
	 * @return
	 */
	public static boolean isGeStartAndLtEndDateAccuracyDay(Date startDate,
			Date endDate, Date compareDate) {
		if (startDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDateByDay()时，参数startDate为空！");
		}
		if (endDate == null) {
			throw new BusinessException(
					"调用isBetweenStartAndEndDateByDay()时，参数endDate为空！");
		}
		if (compareDate == null) {
			compareDate = new Date();
		}

		return isGeStartAndLtEndDate(getDateForAccuracy(startDate, Calendar.DAY_OF_MONTH), 
								        getDateForAccuracy(endDate, Calendar.DAY_OF_MONTH), 
								        getDateForAccuracy(compareDate, Calendar.DAY_OF_MONTH));
	}

	/**
	 * 获取特定时间加上指定月份后的时间
	 * 
	 * @param originalTime
	 *            待处理时间
	 * @param month
	 *            需要调整的月份
	 * @return
	 */
	public static Date addMonth(Date originalTime, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(originalTime);
		calendar.add(Calendar.MONTH, month);
		return calendar.getTime();
	}

	/**
	 * 获取特定时间加上指定天数后的时间
	 * 
	 * @param originalTime
	 *            待处理时间
	 * @param day
	 *            需要调整的天数
	 * @return
	 */
	public static Date addDay(Date originalTime, int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(originalTime);
		calendar.add(Calendar.DAY_OF_MONTH, day);
		return calendar.getTime();
	}
	
	/**
	 * 获取特定时间加上指定分钟数
	 * 
	 * @param originalTime
	 *            待处理时间
	 * @param minute
	 *            需要调整的分钟数
	 * @return
	 */
	public static Date addMinute(Date originalTime, int minute) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(originalTime);
		calendar.add(Calendar.MINUTE, minute);
		return calendar.getTime();
	}
	/**
	 * 根据指定的精度，将后面的统一设置为0
	 * 
	 * @param date
	 *            如果为null，则表示系统当前时间
	 * @param accuracy
	 * @return
	 */
	public static Date getDateForAccuracy(Date date, int accuracy) {
		Calendar calendar = Calendar.getInstance();
		if (date != null) {
			calendar.setTime(date);
		}

		switch (accuracy) {
		// 精度到日，那么小时、分钟、秒、毫秒都设置为0
		case Calendar.DAY_OF_MONTH: {
			calendar.set(Calendar.HOUR_OF_DAY, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.set(Calendar.MILLISECOND, 0);
			return calendar.getTime();
		}
		// 精度到小时，那么分钟、秒、毫秒都设置为0
		case Calendar.HOUR_OF_DAY: {
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.set(Calendar.MILLISECOND, 0);
			return calendar.getTime();
		}
		// 精度到分，那么秒、毫秒都设置为0
		case Calendar.MINUTE: {
			calendar.set(Calendar.SECOND, 0);
			calendar.set(Calendar.MILLISECOND, 0);
			return calendar.getTime();
		}
		// 精度到秒，那么 毫秒设置为0
		case Calendar.SECOND: {
			calendar.set(Calendar.MILLISECOND, 0);
			return calendar.getTime();
		}
		}

		return null;
	}

	/**
	 * 根据指定的精度，将后面的统一设置为0
	 * @param date 如果为null，则表示系统当前时间
	 * @param accuracy Calendar
	 * @return
	 */
	public static Calendar getCalendarForAccuracy(Date date, int accuracy) {
		Calendar calendar = Calendar.getInstance();
		if(date != null) {
			calendar.setTime(date);
		}
		
		switch (accuracy) {
			//精度到日，那么小时、分钟、秒、毫秒都设置为0
			case Calendar.DAY_OF_MONTH : {
				calendar.set(Calendar.HOUR_OF_DAY, 0);
				calendar.set(Calendar.MINUTE, 0);
				calendar.set(Calendar.SECOND, 0);
				calendar.set(Calendar.MILLISECOND, 0);
				return calendar;
			}
			//精度到小时，那么分钟、秒、毫秒都设置为0
			case Calendar.HOUR_OF_DAY : {
				calendar.set(Calendar.MINUTE, 0);
				calendar.set(Calendar.SECOND, 0);
				calendar.set(Calendar.MILLISECOND, 0);
				return calendar;
			}
			//精度到分，那么秒、毫秒都设置为0
			case Calendar.MINUTE : {
				calendar.set(Calendar.SECOND, 0);
				calendar.set(Calendar.MILLISECOND, 0);
				return calendar;
			}
			//精度到秒，那么 毫秒设置为0
			case Calendar.SECOND : {
				calendar.set(Calendar.MILLISECOND, 0);
				return calendar;
			}
		}
		
		return null;
	}
	
	/**
	 * 把Date转成Calendar
	 * 
	 * @param date
	 * @return calendar
	 */
	public static Calendar convertToCalendar(Date date) {
		if (date == null) {
			date = new Date();
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar;
	}

	/**
	 * 毫秒差转为天数
	 * 
	 * @param startTimeMillisecond
	 * @param endTimeMillisecond
	 * @return
	 */
	public static int getDaysByMillisecondDif(long startTimeMillisecond,
			long endTimeMillisecond) {
		long totalDifDay = (endTimeMillisecond - startTimeMillisecond)
				/ (1000 * 60 * 60 * 24);
		return new Long(totalDifDay).intValue();
	}
	
	/**
	 * 计算两个日期之间相差的天数（两个日期的年月日计算相差的天数，忽略时分秒）开始时间当天计算在内，结束时间当天不计算在内。
	 * 比如startTime 2015-5-1 endTime 2015-6-1，那么返回31（5月31天）。
	 * 比如startTime 2015-1-1 endTime 2015-1-31，那么返回30。
	 * @param startTime
	 * @param endTime 可以为空，那么截止当前时间
	 * @return
	 */
	public static int getDaysByDateDif(Date startTime, Date endTime) {
		startTime = getDateForAccuracy(startTime, Calendar.DAY_OF_MONTH);
		endTime = getDateForAccuracy(endTime, Calendar.DAY_OF_MONTH);
		return getDaysByMillisecondDif(startTime.getTime(), endTime.getTime());
	}
	
	/**
	 * 计算两个日期是否相等（年相等，且月相等，且日相等，忽略时分秒）
	 * @param startTime 可以为空，那么默认当前日期
	 * @param endTime 可以为空，那么默认当前日期
	 * @return
	 */
	public static boolean isTheSameTimeByDate(Date startTime, Date endTime) {
		Calendar startCalendar = Calendar.getInstance();
		if(startTime != null) {
			startCalendar.setTime(startTime);
		}
		Calendar endCalendar = Calendar.getInstance();
		if(endTime != null) {
			endCalendar.setTime(endTime);
		}
		if(startCalendar.get(Calendar.YEAR) != endCalendar.get(Calendar.YEAR)) {
			return false;
		}
		if(startCalendar.get(Calendar.MONTH) != endCalendar.get(Calendar.MONTH)) {
			return false;
		}
		if(startCalendar.get(Calendar.DAY_OF_MONTH) != endCalendar.get(Calendar.DAY_OF_MONTH)) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * 计算两个日期之间相差的月份数（两个日期的年月日计算相差的月份数，忽略日时分秒）
	 * 比如开始时间为2015-03-05，结束时间为2016-09-23，那么返回18
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static int getMonthsByDateDif(Date startTime, Date endTime) {
		Calendar startCalendar = getCalendarForAccuracy(startTime, Calendar.DAY_OF_MONTH);
		Calendar endCalendar = getCalendarForAccuracy(endTime, Calendar.DAY_OF_MONTH);
		int yearDif = endCalendar.get(Calendar.YEAR) - startCalendar.get(Calendar.YEAR);
		int monthDif = endCalendar.get(Calendar.MONTH) - startCalendar.get(Calendar.MONTH);
		return yearDif * 12 + monthDif;
	}
	
	/**
	 * 比较两个日期的大小，忽略时分秒。如果一样，返回0；如果endTime比startTime迟，返回1；如果endTime比startTime早，返回-1。
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static int compareToDay(Date startTime, Date endTime) {
		long difDays = getDaysByDateDif(startTime, endTime);
		if(difDays == 0) {
			return 0;
		} else if(difDays > 0) {
			return 1;
		} else {
			return -1;
		}
	}

	public static String formatDate(Date date, String datePattern) {
		String result = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(datePattern);
			result = sdf.format(date);
		} catch (Exception e) {
			throw new BusinessException("日期格式化错误");
		}

		return result;
	}

	public static Date parseDateStr(String dateStr, String datePattern) {
		Date result = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(datePattern);
			result = sdf.parse(dateStr);
		} catch (Exception e) {
			throw new BusinessException("日期转换失败");
		}

		return result;
	}
	
	   
    /**
     * 获取两个时间相差的天数
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return
     */
    public static long getSubDate(Date startDate,Date endDate){
        Calendar calendar1 = new GregorianCalendar();
        calendar1.setTime(parseDateToDayMin(startDate));

        Calendar calendar2 = new GregorianCalendar();
        calendar2.setTime(parseDateToDayMin(endDate));

        return (calendar2.getTime().getTime()-calendar1.getTime().getTime())/(24*60*60*1000);
    }
    
}
