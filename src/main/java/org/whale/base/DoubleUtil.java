package org.whale.base;

import java.io.Serializable;
import java.math.BigDecimal;

import org.whale.system.common.exception.BusinessException;

public class DoubleUtil implements Serializable {
	private static final long serialVersionUID = -3345205828566485102L;  
    // 默认除法运算精度  
    private static final Integer DEF_DIV_SCALE = 2;  
    private static final Integer DIV_SCALE_10 = 10;  
    // 小数点保留位数
    private static final Integer ROUND_2 = 2;  
  
    /**
     * 判断2个浮点型是否相等，允许0.00001
     * @param value1
     * @param value2
     * @return
     */
    public static boolean isEquals(Double value1, Double value2) {
    	if(value1 == null || value2 == null) {
			throw new BusinessException("调用DoubleUtil.isEquals()参数为null");
    	}
    	if(Math.abs(value1 - value2) < 0.00001) {
    		return true;
    	} else {
    		return false;
    	}
    }
    /**
     * 判断一个浮点型是否等于0（null也等于0，允许0.00001）
     * @param value1
     * @return
     */
    public static boolean isZero(Double value1) {
    	if(value1 == null) {
    		return true;
    	}
    	return isEquals(value1, 0.0);
    }
    
    /** 
     * 提供精确的加法运算。 
     * @param value1 被加数 
     * @param value2 加数 
     * @return 两个参数的和 
     */  
    public static Double add(Number value1, Number value2) {
    	if(value1 == null || value2 == null) {
			throw new BusinessException("调用DoubleUtil.add()参数为null");
    	}
        BigDecimal b1 = new BigDecimal(Double.toString(value1.doubleValue()));  
        BigDecimal b2 = new BigDecimal(Double.toString(value2.doubleValue()));  
        return b1.add(b2).doubleValue();  
    }
  
    /** 
     * 提供精确的减法运算。 
     *  
     * @param value1 
     *            被减数 
     * @param value2 
     *            减数 
     * @return 两个参数的差 
     */  
    public static double sub(Number value1, Number value2) {
    	if(value1 == null || value2 == null) {
			throw new BusinessException("调用DoubleUtil.sub()参数为null");
    	}
        BigDecimal b1 = new BigDecimal(Double.toString(value1.doubleValue()));  
        BigDecimal b2 = new BigDecimal(Double.toString(value2.doubleValue()));  
        return b1.subtract(b2).doubleValue();  
    }
    
    /** 
     * 提供精确的乘法运算。 
     *  
     * @param value1 
     *            被乘数 
     * @param value2 
     *            乘数 
     * @return 两个参数的积 
     */  
    public static Double mul(Number value1, Number value2) {
    	if(value1 == null || value2 == null) {
			throw new BusinessException("调用DoubleUtil.mul()参数为null");
    	}
        BigDecimal b1 = new BigDecimal(Double.toString(value1.doubleValue()));  
        BigDecimal b2 = new BigDecimal(Double.toString(value2.doubleValue()));  
        return b1.multiply(b2).doubleValue();  
    }
    
    
    /** 
     * 提供（相对）精确的除法运算，当发生除不尽的情况时， 精确到小数点以后2位，以后的数字四舍五入。 
     *  
     * @param dividend 
     *            被除数 
     * @param divisor 
     *            除数 
     * @return 两个参数的商 
     */  
    public static Double divCal2(Number dividend, Number divisor) {  
        return div(dividend, divisor, DEF_DIV_SCALE);  
    }
    
    /** 
     * 提供（相对）精确的除法运算，当发生除不尽的情况时， 精确到小数点以后10位，以后的数字四舍五入。 
     *  
     * @param dividend 
     *            被除数 
     * @param divisor 
     *            除数 
     * @return 两个参数的商 
     */  
    public static Double divCal10(Number dividend, Number divisor) {  
        return div(dividend, divisor, DIV_SCALE_10);  
    }
  
    /** 
     * 提供（相对）精确的除法运算。 当发生除不尽的情况时，由scale参数指定精度，以后的数字四舍五入。 
     *  
     * @param dividend 
     *            被除数 
     * @param divisor 
     *            除数 
     * @param scale 
     *            表示表示需要精确到小数点以后几位。 
     * @return 两个参数的商 
     */  
    public static Double div(Number dividend, Number divisor, Integer scale) {
    	if(dividend == null || divisor == null) {
			throw new BusinessException("调用DoubleUtil.div()参数为null");
    	}
        if (scale < 0) {
            throw new IllegalArgumentException(  
                    "The scale must be a positive integer or zero");  
        }
        
        BigDecimal b1 = new BigDecimal(Double.toString(dividend.doubleValue()));  
        BigDecimal b2 = new BigDecimal(Double.toString(divisor.doubleValue()));  
        return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();  
    }  
  
    /** 
     * 提供精确的小数位四舍五入处理。 
     *  
     * @param value 
     *            需要四舍五入的数字 默认保留2位小数点
     * @return 四舍五入后的结果 
     */  
    public static Double round(Double value) {
    	return round(value, DEF_DIV_SCALE);
    }
    
    /** 
     * 提供精确的小数位四舍五入处理。 
     *  
     * @param value 
     *            需要四舍五入的数字 
     * @param scale 
     *            小数点后保留几位 
     * @return 四舍五入后的结果 
     */  
    public static Double round(Double value, Integer scale) {
    	if(value == null) {
			throw new BusinessException("调用DoubleUtil.round()参数为null");
    	}
        if (scale < 0) {  
            throw new IllegalArgumentException(  
                    "The scale must be a positive integer or zero");  
        }  
        BigDecimal b = new BigDecimal(Double.toString(value));  
        BigDecimal one = new BigDecimal("1");  
        return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();  
    }
    
    /** 
     * 提供精确的小数位处理（舍弃后面的小数，没有四舍五入）
     *  
     * @param value 
     *            需要精确处理的数字 
     * @param scale 
     *            小数点后保留几位 
     * @return
     */  
    public static Double roundDown(Double value, Integer scale) {
    	if(value == null) {
			throw new BusinessException("调用DoubleUtil.roundDown()参数为null");
    	}
        if (scale < 0) {  
            throw new IllegalArgumentException(  
                    "The scale must be a positive integer or zero");  
        }  
        BigDecimal b = new BigDecimal(Double.toString(value));  
        BigDecimal one = new BigDecimal("1");  
        return b.divide(one, scale, BigDecimal.ROUND_DOWN).doubleValue();  
    }
    
    /** 
     * 提供精确的小数位处理（舍弃后面的小数，没有四舍五入，保留2位）
     *  
     * @param value 
     *            需要精确处理的数字 
     * @return
     */  
    public static Double roundDown2(Double value) {
    	return roundDown(value, ROUND_2);
    }
    
    public static String formatScale2(Double value) {
    	if(value == null) {
			throw new BusinessException("调用DoubleUtil.formatScale2()参数为null");
    	}
    	java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");  
    	return df.format(value);
    }
    
    public static String formatScale3(Double value) {
    	if(value == null) {
			throw new BusinessException("调用DoubleUtil.formatScale3()参数为null");
    	}
    	java.text.DecimalFormat df = new java.text.DecimalFormat("###,###.00");  
    	return df.format(value);
    }
    
    /**
     * 是否可以被整除
     * @param val1
     * @param val2
     * @return
     */
    public static boolean isRemainder2Zero(BigDecimal value1, BigDecimal value2){
    	if(value1 == null) {
			throw new BusinessException("调用isRemainder2Zero参数为null");
    	}
    	value2 = ((value2 == null)? new BigDecimal(100) : value2);
    	BigDecimal result = value1.remainder(value2);
    	if(result.equals(new BigDecimal(0))){
    		return true;
    	}
    	return false;
    }
    
	public static void main(String[] args) {
//		System.out.println(0.05 + 0.01);
//		System.out.println(1.0 - 0.42);
//		System.out.println(4.015 * 100);
//		System.out.println(123.3 / 100);

//		System.out.println(DoubleUtil.add(0.05, 0.01));
//		System.out.println(DoubleUtil.sub(1.0, 0.42));
//		System.out.println(DoubleUtil.mul(4.015, 100));
//		System.out.println(DoubleUtil.roundDown2(12.333));
//		System.out.println(DoubleUtil.roundDown2(12.334));
//		System.out.println(DoubleUtil.roundDown2(12.335));
//		System.out.println(DoubleUtil.roundDown2(12.338));
//		System.out.println(DoubleUtil.roundDown2(12.339));
//		System.out.println(DoubleUtil.round(123.3));
//		System.out.println(DoubleUtil.formatScale3((double)1213112414));
		System.out.println(DoubleUtil.isRemainder2Zero(new BigDecimal(20), null));

	}

}
