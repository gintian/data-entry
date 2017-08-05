package org.whale.base;

import org.whale.system.common.util.Strings;
import org.whale.system.dao.Page;


public class Utils {
	/**
	 * 获取随机数字
	 * @param bit 几位随机数字
	 * @return
	 */
	public static String getRandom(int bit) {
		String randomStr = "";
		while(randomStr.length() < bit) {
			randomStr += (int)(Math.random()*10);
		}
		return randomStr;
	}
	
	/**
	 * 支持in的参数查询
	 * @param inParam 参数用,分割，例如：test1,test2,test3
	 * @param column 需要查询的字段，例如 a.DICT_AMOUNT_TYPE
	 * @param stringBufferSql
	 * @param page
	 * @return
	 */
	public static StringBuilder convertAddInParam(String inParam, String column, StringBuilder stringBuilderSql, Page page) {
		if (Strings.isNotBlank(inParam)) {
			String[] inParamArr = inParam.split(",");
			stringBuilderSql.append(" AND ").append(column).append(" in ( ");
			// stringBuffer.append("AND a.DICT_AMOUNT_TYPE in (");
			for (int i = 0; i < inParamArr.length; i++) {
				// 最后1个
				if (i == inParamArr.length - 1) {
					stringBuilderSql.append("?) ");
				} else {
					stringBuilderSql.append("?, ");
				}
				page.addArg(inParamArr[i]);
			}
		}
		return stringBuilderSql;
	}
	
	/**
	 * 支持in的参数查询
	 * @param inParam 参数用,分割，例如：test1,test2,test3
	 * @param column 需要查询的字段，例如 a.DICT_AMOUNT_TYPE
	 * @param stringBufferSql 注意：拼接后的SQL，也要用这个stringBufferSql
	 * @param args 原本的参数对象数组
	 * @return copyArgs 原本的参数对象数组 + test1和2和3
	 */
	public static Object[] convertAddInParam(String inParam, String column, StringBuilder stringBuilderSql, Object[] args) {
		if (Strings.isNotBlank(inParam)) {
			String[] inParamArr = inParam.split(",");
			int argsLength = args == null || args.length == 0 ? 0 : args.length;
			Object[] copyArgs = new Object[argsLength + inParamArr.length];
			if(args != null) {
			   System.arraycopy(args, 0, copyArgs, 0, args.length);  
			}
			
			stringBuilderSql.append(" AND ").append(column).append(" in ( ");
			for (int i = 0; i < inParamArr.length; i++) {
				// 最后1个
				if (i == inParamArr.length - 1) {
					stringBuilderSql.append("?) ");
				} else {
					stringBuilderSql.append("?, ");
				}
				copyArgs[argsLength + i] = inParamArr[i];
			}
			return copyArgs;
		}
		return args;
	}
	
	/**
	 * 支持in的参数查询
	 * @param inParam 参数用,分割，例如：test1,test2,test3
	 * @param stringBuilderSql 注意：拼接后的SQL，也要用这个stringBufferSql
	 * @param args 原本的参数对象数组
	 * @return copyArgs 原本的参数对象数组 + test1和2和3
	 */
	public static Object[] convertFillUpInParam(String inParam, StringBuilder stringBuilderSql, Object[] args) {
		if (Strings.isNotBlank(inParam)) {
			String[] inParamArr = inParam.split(",");
			int argsLength = args == null || args.length == 0 ? 0 : args.length;
			Object[] copyArgs = new Object[argsLength + inParamArr.length];
			if(args != null) {
			   System.arraycopy(args, 0, copyArgs, 0, args.length);  
			}
			
			stringBuilderSql.append(" ( ");
			for (int i = 0; i < inParamArr.length; i++) {
				// 最后1个
				if (i == inParamArr.length - 1) {
					stringBuilderSql.append("?) ");
				} else {
					stringBuilderSql.append("?, ");
				}
				copyArgs[argsLength + i] = inParamArr[i];
			}
			return copyArgs;
		}
		return args;
	}
	
	public static void main(String[] args) {
		Object[] s1 = { "中国", "山西", "太原", "TYUT", "zyy" };
		StringBuilder stringBuilder = new StringBuilder("12");
		Object[] s2 = Utils.convertFillUpInParam("test1,test2,test3", stringBuilder, s1);
		/*for (Object str : s1) {
			System.out.println(str);
		}*/
		System.out.println(stringBuilder);
	}

}
