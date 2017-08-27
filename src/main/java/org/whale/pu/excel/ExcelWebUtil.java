package org.whale.pu.excel;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.whale.base.UserContextUtil;
import org.whale.system.common.util.Strings;
import org.whale.system.common.util.WebUtil;

/**
 * Execl 输出（整合到WebUtil）
 * @author zhanghj
 *
 */
public class ExcelWebUtil extends WebUtil {
	
	
	/**
	 * 导出Excel（文件名、sheet名默认情况）
	 * @param request
	 * @param response
	 * @param dataList
	 * @throws Exception
	 */
	public static void flushExcelOutputStream(HttpServletRequest request, HttpServletResponse response, List<?> dataList) throws Exception{
		String fileName = UUID.randomUUID().toString() + ".xls"; //默认文件名
		flushExcelOutputStream(request,response,dataList,null,null,fileName,"");
	}
	
	/**
	 * 导出Execl（标题有变量替换情况）
	 * @param request
	 * @param response
	 * @param argsArr
	 * @param dataList
	 * @throws Exception
	 */
	public static void flushExcelOutputStream(HttpServletRequest request, HttpServletResponse response, List<?> dataList, Object[] argsArr) throws Exception{
		String fileName = UUID.randomUUID().toString() + ".xls"; //默认文件名
		flushExcelOutputStream(request,response,dataList,null,argsArr,fileName,"");
	}
	
	
	/**
	 * 导出Excel
	 * @param request
	 * @param response
	 * @param dataList
	 * @param fileName
	 * @param sheetName
	 * @throws Exception
	 */
	public static void flushExcelOutputStream(HttpServletRequest request, HttpServletResponse response, List<?> dataList, String fileName, String sheetName) throws Exception{
		fileName = Strings.isBlank(fileName) ? UUID.randomUUID().toString() + ".xls" : fileName;
		flushExcelOutputStream(request,response,dataList,null,null,fileName,sheetName);
	}
	
	/**
	 * 导出Execl（标题有变量替换情况）
	 * @param request
	 * @param response
	 * @param dataList
	 * @param argsArr
	 * @param fileName
	 * @param sheetName
	 * @throws Exception
	 */
	public static void flushExcelOutputStream(HttpServletRequest request, HttpServletResponse response, List<?> dataList, Object[] argsArr, String fileName, String sheetName) throws Exception{
		fileName = Strings.isBlank(fileName) ? UUID.randomUUID().toString() + ".xls" : fileName;
		flushExcelOutputStream(request,response,dataList,null,argsArr,fileName,sheetName);
	}
	
	/**
	 * 导出Excel
	 * @param request
	 * @param response
	 * @param dataList
	 * @param classes
	 * @param fileName
	 * @param sheetName
	 * @throws Exception
	 */
	@SuppressWarnings("all")
	public static void flushExcelOutputStream(HttpServletRequest request, HttpServletResponse response, List<?> dataList,  Class<?> classes, Object[] argsArr,String fileName, String sheetName) throws Exception{
		if(UserContextUtil.getUserContext()!=null && request!=null )
		logger.info("开始 导出数据到文件["+fileName+"],数据量["+dataList.size()+"],操作用户["+UserContextUtil.getUserContext().getUserName()+"],请求源["+request.getHeader("referer")+"]。");
		response.setContentType(EXCEL_TYPE+";charset=GB2312");
        response.setHeader("Content-Disposition", (new StringBuilder("attachment; filename=\"")).append(new String(fileName.getBytes("GB2312"), "ISO8859-1")).append("\"").toString());
		setDisableCacheHeader(response);
		ServletOutputStream out = null;
		try {
			HSSFWorkbook workbook = new ExcelExportUtils().exportExcel(sheetName, dataList, classes, argsArr);
			out = response.getOutputStream();
			workbook.write(out);
			out.flush();
			
		} catch (Exception e) {
			throw new Exception("文件导出异常:"+e.getMessage(),e);
		}finally{
			if(out != null){
				try {
					out.close();
					logger.info("结束 导出数据到文件["+fileName+"]");
				} catch (IOException e) {
					logger.error(e.getMessage(), e);
					logger.error("",e);
				}
			}
		}
	}
	
	/**
	 * 内容List导出
	 * @param request
	 * @param response
	 * @param titleList
	 * @param dataList
	 * @param fileName
	 * @param sheetName
	 * @throws Exception
	 */
	@SuppressWarnings("all")
	public static void flushExcelOutputStream(HttpServletRequest request, HttpServletResponse response,List<String> titleList, List<?> dataList, String fileName, String sheetName) throws Exception{
		fileName = Strings.isBlank(fileName) ? UUID.randomUUID().toString() + ".xls" : fileName;
		if(UserContextUtil.getUserContext()!=null && request!=null )
		logger.info("开始 导出数据到文件["+fileName+"],数据量["+dataList.size()+"],操作用户["+UserContextUtil.getUserContext().getUserName()+"],请求源["+request.getHeader("referer")+"]。");
		response.setContentType(EXCEL_TYPE+";charset=GB2312");
        response.setHeader("Content-Disposition", (new StringBuilder("attachment; filename=\"")).append(new String(fileName.getBytes("GB2312"), "ISO8859-1")).append("\"").toString());
		setDisableCacheHeader(response);
		ServletOutputStream out = null;
		try {
			HSSFWorkbook workbook = new ExcelExportUtils().exportExcel(sheetName, titleList, dataList);
			out = response.getOutputStream();
			workbook.write(out);
			out.flush();
			
		} catch (Exception e) {
			throw new Exception("文件导出异常:"+e.getMessage(),e);
		}finally{
			if(out != null){
				try {
					out.close();
					logger.info("结束 导出数据到文件["+fileName+"]");
				} catch (IOException e) {
					logger.error(e.getMessage(), e);
					logger.error("",e);
				}
			}
		}
	}
	
	/**
	 * 重载 flushExcelOutputStream
	 * @param request
	 * @param response
	 * @param titleMap
	 * @param dataList
	 * @param fileName
	 * @param sheetName
	 * @throws Exception
	 */
	@SuppressWarnings("all")
	public static void flushExcelOutputStream(HttpServletRequest request, HttpServletResponse response,String sheetTopHeader,LinkedHashMap<String,ColumnHandlerComponent> titleMap, List<Map<String,Object>> dataList, String fileName, String sheetName) throws Exception{
		fileName = Strings.isBlank(fileName) ? UUID.randomUUID().toString() + ".xls" : fileName;
		if(UserContextUtil.getUserContext()!=null && request!=null )
			logger.info("开始 导出数据到文件["+fileName+"],数据量["+dataList.size()+"],操作用户["+UserContextUtil.getUserContext().getUserName()+"],请求源["+request.getHeader("referer")+"]。");
		response.setContentType(EXCEL_TYPE+";charset=GB2312");
        response.setHeader("Content-Disposition", (new StringBuilder("attachment; filename=\"")).append(new String(fileName.getBytes("GB2312"), "ISO8859-1")).append("\"").toString());
		setDisableCacheHeader(response);
		ServletOutputStream out = null;
		try {
			HSSFWorkbook workbook = new ExcelExportUtils().exportExcel(sheetName, sheetTopHeader, titleMap, dataList);
			out = response.getOutputStream();
			workbook.write(out);
			out.flush();
			
		} catch (Exception e) {
			throw new Exception("文件导出异常:"+e.getMessage(),e);
		}finally{
			if(out != null){
				try {
					out.close();
					logger.info("结束 导出数据到文件["+fileName+"]");
				} catch (IOException e) {
					logger.error(e.getMessage(), e);
					logger.error("",e);
				}
			}
		}
	}
	
}
