package org.whale.pu.excel;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.whale.system.common.util.Strings;
import org.whale.system.common.util.TimeUtil;



/**
 * execl导出工具类
 * 
 * @author zhanghj
 *
 * @param <T>
 */
@SuppressWarnings("deprecation")
public class ExcelExportUtils<T> {
	private static Logger logger=LoggerFactory.getLogger(ExcelExportUtils.class);
	
	/**
	 * 功能说明: 入参判断
	 * @param sheetName
	 * @param dataset
	 * @param classes
	 * @return
	 * @throws Exception
	 */
	public HSSFWorkbook exportExcel(String sheetName, List<T> dataset,
			Class<?> classes,Object[] argsArr) {
		Field filed[] = null;
		if (Strings.isBlank(sheetName)){
			sheetName = "report";
		}
		if(null != classes){
			filed = classes.getDeclaredFields();	
		}else{
			Iterator<T> its = dataset.iterator();
			T ts = its.next();
		    filed = ts.getClass().getDeclaredFields();
		}
		
		return this.exportExcel(sheetName, dataset, filed, argsArr);
	}
	
	/**
	 * 标题、内容导出
	 * @param sheetName
	 * @param titleList
	 * @param dataList
	 * @return
	 */
	public HSSFWorkbook exportExcel(String sheetName, List<String> titleList, List<List<T>> dataList){
		HSSFWorkbook workbook = new HSSFWorkbook();
		try {
			HSSFSheet sheet = null;
			
			HSSFCellStyle headStyle = workbook.createCellStyle();
			headStyle = ExcelStyle.setHeadStyle(workbook, headStyle);

			HSSFCellStyle bodyStyle = workbook.createCellStyle();
			bodyStyle = ExcelStyle.setBodyStyle(workbook, bodyStyle);
			
			// 添加工作表
			int sheetContentCount = 0;
			int sheetNum = 1;
			SimpleDateFormat sdf=new SimpleDateFormat(TimeUtil.DAY_FORMAT);
            if ((dataList.size() > ExportSettingContants.SHEET_DATA_NUM)) {
                if (dataList.size() % ExportSettingContants.SHEET_DATA_NUM == 0) {
                    sheetNum = dataList.size() / ExportSettingContants.SHEET_DATA_NUM;
                }
                else {
                    sheetNum = dataList.size() / ExportSettingContants.SHEET_DATA_NUM + 1;
                }
            }
            // 遍历产生sheet
			for (int s = 0; s < sheetNum; s++) {
				sheet = workbook.createSheet(sheetName + "_" + s);
				sheet.setDefaultColumnWidth(18); //设置默认列宽
                // 添加工作表标题
    			HSSFRow row = sheet.createRow(0);
    			for (int i = 0; i < titleList.size(); i++) {
    				HSSFCell cell = row.createCell(i);
    				cell.setCellStyle(headStyle);
    				HSSFRichTextString text = new HSSFRichTextString(titleList.get(i));
    				cell.setCellValue(text);
    			}
    			// 添加工作表内容
    			for (int j = 0; j < ExportSettingContants.SHEET_DATA_NUM; j++) {
    				if (sheetContentCount == dataList.size()) {
                        break;
                    }
    				row = sheet.createRow(j + 1); //第一行为标题行, 从第二行开始写内容
    				List<T> rowList = dataList.get(j + ExportSettingContants.SHEET_DATA_NUM*s);
    				for (int k = 0; k < rowList.size(); k++) {
    					HSSFCell cell = row.createCell(k);
    					cell.setCellStyle(bodyStyle);
    					Object val=rowList.get(k);
    					if(val==null){
							cell.setCellValue(new HSSFRichTextString(""));
						}else{
							if(val instanceof Number){
	    						cell.setCellValue(Double.parseDouble(val.toString()));
	    						
	    					}else if(val instanceof Date){
	    						Date date=(Date)val;
	    						cell.setCellValue(new HSSFRichTextString(sdf.format(date)));
	    					}else{
	    						cell.setCellValue(new HSSFRichTextString(val.toString()));
	    					}
							
						}
    				}
    				sheetContentCount++;
    			}
			}
			
		} catch (Exception e) {
			logger.error("创建WorkBook失败",e);
		}

		return workbook;
	}
	
	/**
	 * 标题、内容导出
	 * @param sheetName
	 * @param titleMap
	 * @param dataList
	 * @return
	 */
	public HSSFWorkbook exportExcel(String sheetName, String sheetTopHeader, LinkedHashMap<String, ColumnHandlerComponent> titleMap, List<Map<String, Object>> dataList){
		HSSFWorkbook workbook = new HSSFWorkbook();
		try {
			HSSFSheet sheet = null;
			
			HSSFCellStyle topHeadStyle = workbook.createCellStyle();
			topHeadStyle = ExcelStyle.setTopHeadStyle(workbook, topHeadStyle);
			
			HSSFCellStyle headStyle = workbook.createCellStyle();
			headStyle = ExcelStyle.setHeadStyle(workbook, headStyle);

			HSSFCellStyle bodyStyle = workbook.createCellStyle();
			bodyStyle = ExcelStyle.setBodyStyle(workbook, bodyStyle);
			
			// 添加工作表
			int sheetContentCount = 0;
			int sheetNum = 1;
            if ((dataList.size() > ExportSettingContants.SHEET_DATA_NUM)) {
                if (dataList.size() % ExportSettingContants.SHEET_DATA_NUM == 0) {
                    sheetNum = dataList.size() / ExportSettingContants.SHEET_DATA_NUM;
                }
                else {
                    sheetNum = dataList.size() / ExportSettingContants.SHEET_DATA_NUM + 1;
                }
            }
            int sheetHearderFlag = 0;
            if(StringUtils.isNotBlank(sheetTopHeader)){
            	sheetHearderFlag = 1;
            }
            // 遍历产生sheet
			for (int s = 0; s < sheetNum; s++) {
				sheet = workbook.createSheet(sheetName + "_" + s);
				sheet.setDefaultColumnWidth(18); //设置默认列宽
				// 判断是否加顶部表头
				if(sheetHearderFlag == 1){
					HSSFRow row = sheet.createRow(0);
//					row.setHeightInPoints(50);
					HSSFCell headerCell = row.createCell(0);
					headerCell.setCellStyle(topHeadStyle);
					headerCell.setCellValue(new HSSFRichTextString(sheetTopHeader));
					sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, titleMap.size()-1));
				}
                // 添加工作表标题
    			HSSFRow row = sheet.createRow(0+sheetHearderFlag);
    			int i=0;
    			for (Iterator<String> it =  titleMap.keySet().iterator();it.hasNext();i++)
    			   {
    			    String key = it.next();
    			    HSSFCell cell = row.createCell(i);
    				cell.setCellStyle(headStyle);
    				HSSFRichTextString text = new HSSFRichTextString(titleMap.get(key).getColumnName());
    				cell.setCellValue(text);
    			   }

    			
    			// 添加工作表内容
    			for (int j = 0; j < ExportSettingContants.SHEET_DATA_NUM; j++) {
    				if (sheetContentCount == dataList.size()) {
                        break;
                    }
    				row = sheet.createRow(j + sheetHearderFlag + 1); //第一行为标题行, 从第二行开始写内容
    				Map<String, Object> rowList = dataList.get(j + ExportSettingContants.SHEET_DATA_NUM*s);
    				i=0;
    				for (Iterator<String> it =  titleMap.keySet().iterator();it.hasNext();i++) {
    					String key = it.next();
    					Object value=rowList.get(key);
    					ColumnHandlerComponent component=titleMap.get(key);
    					IColumnHandler handler=component.getHandler();
    					if(handler!=null){
    						value=handler.handle(value,rowList);
    						
    					}
    					HSSFCell cell = row.createCell(i);
    					bodyStyle.setWrapText(true);  
    					cell.setCellStyle(bodyStyle);
    					
    					String textValue=(null==value)?"":value.toString();
    					
    					// 签收人临时处理
    					if("DE_SIGN_UP".equals(key) && StringUtils.isNotBlank(textValue)){
    						row.setHeightInPoints(20 * Float.parseFloat(textValue));
    					}else{
                            if (component.getDataType()==ExcelConstant.DATA_TYPE_DOUBLE) {
                            	try {
                                cell.setCellValue(Double.parseDouble(textValue));
                            	} catch (NumberFormatException e) {
                            		HSSFRichTextString richString = new HSSFRichTextString(
                            				textValue);
                                    cell.setCellValue(richString);
    							}
                            } else {
                                HSSFRichTextString richString = new HSSFRichTextString(
                                        textValue);
                                cell.setCellValue(richString);
                            }
    					}
    				}
    				sheetContentCount++;
    			}
			}
			
		} catch (Exception e) {
			logger.error("创建WorkBook(工作薄)失败",e);
		}
		return workbook;
	}
	
	/**
	 * 功能说明: 导出Excel
	 * @param sheetName
	 * @param dataset
	 * @param filed
	 * @return
	 */
	@SuppressWarnings("all")
	private HSSFWorkbook exportExcel(String sheetName, List<T> dataset,
			Field filed[], Object[] argsArr) {
		HSSFWorkbook workbook = new HSSFWorkbook();
		try {
			HSSFSheet sheet = null;
			
			HSSFCellStyle headStyle = workbook.createCellStyle();
			headStyle = ExcelStyle.setHeadStyle(workbook, headStyle);

			HSSFCellStyle bodyStyle = workbook.createCellStyle();
			bodyStyle = ExcelStyle.setBodyStyle(workbook, bodyStyle);
			
			TextRender textRender = new VelocityTextRender();
			Map<String, Object> context = new HashMap<String, Object>();
			context.put(ExportSettingContants.ARGS_STRING, argsArr);
			
			List<Object[]> exportMetas = new ArrayList<Object[]>();
			for (int i = 0; i < filed.length; i++) {
				Field f = filed[i];
				ExcelAnnotation exa = f.getAnnotation(ExcelAnnotation.class);
				if (exa != null) {
					String _exportName = exa.exportName();
					String _pattern = exa.pattern();
					Integer _order = Integer.valueOf(exa.order());
					boolean _isSensitive = exa.isSensitive();
					boolean _isMerged = exa.isMerged();
					// 判断标题是否有变量
					if(null != argsArr && argsArr.length > 0 && _exportName.indexOf(ExportSettingContants.ARGS_STRING) != -1 ){
						_exportName = textRender.render(_exportName, context);
					}
					// 添加到标题List
					exportMetas.add(new Object[] { f.getName(), _exportName,
							_pattern, _order, _isSensitive, _isMerged });
				}
			}
			Collections.sort(exportMetas, new Comparator<Object[]>() {
				/** 根据元注释order 排列顺序 */
				@Override
				public int compare(Object[] o1, Object[] o2) {
					Integer order1 = (Integer) o1[3];
					Integer order2 = (Integer) o2[3];
					return order1.compareTo(order2);
				}
			});
			 // 需合并的展示列
            List mergeCellIndexList = new ArrayList<Integer>();
            for (int i = 0; i < exportMetas.size(); i++) {
				if((boolean)exportMetas.get(i)[5]){
					mergeCellIndexList.add(i);
				}
            }
			// 添加工作表
			int sheetContentCount = 0;
			int sheetNum = 1;
            if ((dataset.size() > ExportSettingContants.SHEET_DATA_NUM)) {
                if (dataset.size() % ExportSettingContants.SHEET_DATA_NUM == 0) {
                    sheetNum = dataset.size() / ExportSettingContants.SHEET_DATA_NUM;
                }
                else {
                    sheetNum = dataset.size() / ExportSettingContants.SHEET_DATA_NUM + 1;
                }
            }
            // 遍历产生sheet
			for (int s = 0; s < sheetNum; s++) {
				sheet = workbook.createSheet(sheetName + "_" + s);
				sheet.setDefaultColumnWidth(18); //设置默认列宽
                // 添加工作表标题
    			HSSFRow row = sheet.createRow(0);
    			for (int i = 0; i < exportMetas.size(); i++) {
    				HSSFCell cell = row.createCell(i);
    				cell.setCellStyle(headStyle);
    				HSSFRichTextString text = new HSSFRichTextString((String) exportMetas.get(i)[1]);
    				cell.setCellValue(text);
    			}
    			// 添加工作表内容
    			for (int j = 0; j < ExportSettingContants.SHEET_DATA_NUM; j++) {
    				if (sheetContentCount == dataset.size()) {
                        break;
                    }
    				row = sheet.createRow(j + 1); //第一行为标题行, 从第二行开始写内容
    				T t = dataset.get(j + ExportSettingContants.SHEET_DATA_NUM*s);
    				for (int k = 0; k < exportMetas.size(); k++) {
    					HSSFCell cell = row.createCell(k);
    					Object value = this.getObject(t,(String) exportMetas.get(k)[0]);
    					String textValue = this.getValue(value, exportMetas.get(k));
    					HSSFRichTextString richString = new HSSFRichTextString(textValue);
    					cell.setCellStyle(bodyStyle);
    					cell.setCellValue(richString);
    				}
    				sheetContentCount++;
    			}
    			//合并单元格操作
    			if(mergeCellIndexList.size() > 0){
    				mergedRegion(mergeCellIndexList,sheet);
    			}
			}
			
		} catch (Exception e) {
			logger.error("",e);
		}

		return workbook;
	}
	
	/**
	 * 功能说明:反射获取bean属性值
	 * 
	 * @param value
	 * @param meta
	 * @return
	 * @throws SecurityException 
	 * @throws NoSuchMethodException 
	 * @throws InvocationTargetException 
	 * @throws IllegalArgumentException 
	 * @throws IllegalAccessException 
	 */
	private Object getObject(T t,String filedName) throws Exception{
		String getMethodName = "get"+ filedName.substring(0, 1).toUpperCase() + filedName.substring(1);
		Class<?> tCls = t.getClass();
		Method getMethod = tCls.getMethod(getMethodName,new Class[] {});
		Object value = getMethod.invoke(t, new Object[] {});
		return value;
	}
	
	/**
	 * 功能说明: 类型对应值转化
	 * 
	 * @param value
	 * @param meta
	 * @return
	 */
	private String getValue(Object value, Object[] meta) {
		String textValue = "";
		if (value == null)
			return textValue;
		if (value instanceof Boolean) {
			textValue = (Boolean)value ? "是" : "否"; 
		} else if (value instanceof Date) {
			String pattern = (String) meta[2];
			if (StringUtils.isBlank(pattern))
				pattern = TimeUtil.DAY_FORMAT;
			textValue = new SimpleDateFormat(pattern).format((Date) value);
		} else {
			textValue = (Boolean)meta[4] ? value.toString().replaceAll("\\S", "*") : value.toString();
		}

		return textValue;
	}
	
	/**
	 * 功能说明: 合并单元格
	 * @param mergeCellIndexList
	 * @param sheet
	 */
	@SuppressWarnings("all")
	private void mergedRegion(List mergeCellIndexList,HSSFSheet sheet){
		int startRowIndex = sheet.getFirstRowNum()+1, 
			  endRowIndex = sheet.getFirstRowNum()+1;
		for (int m = sheet.getFirstRowNum()+1; m <= sheet.getLastRowNum(); m++) {
			String preCellVal = sheet.getRow(m).getCell((int)mergeCellIndexList.get(0)).getStringCellValue();//目前以待合并的某个列值相同作为合并条件,其余需合并列一并处理
			int n = (m < sheet.getLastRowNum()) ? m+1 : m;
			String nextCellVal = sheet.getRow(n).getCell((int)mergeCellIndexList.get(0)).getStringCellValue();
			if(m!=n && preCellVal.equals(nextCellVal)){     
				endRowIndex = sheet.getRow(n).getRowNum();
			}else{
				for (int l = 0; l < mergeCellIndexList.size(); l++) {
					sheet.addMergedRegion(new CellRangeAddress(startRowIndex, endRowIndex, (int)mergeCellIndexList.get(l), (int)mergeCellIndexList.get(l)));
				}
				startRowIndex = endRowIndex + 1;
				endRowIndex = endRowIndex + 1;
			}
		}
	}
}