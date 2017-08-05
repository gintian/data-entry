package org.whale.pu.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.whale.system.common.exception.BusinessException;
import org.whale.system.common.util.TimeUtil;

public class ExcelImportUtil {
    public final static String DATE_OUTPUT_PATTERNS = TimeUtil.COMMON_FORMAT;
	public static void importHandle(String excelFilePath,IRowReadHandler rowReadHandler) throws IOException{
		File excelFile = new File(excelFilePath);
		if( !excelFile.exists() ){
			throw new BusinessException("文件" + excelFilePath + "不存在");
		}
		
		InputStream is = new FileInputStream(excelFilePath);
		Workbook workbook = null;
		
		if(excelFilePath.endsWith("xls")){
			workbook = new HSSFWorkbook(is);
		}else if(excelFilePath.endsWith("xlsx")){
			workbook = new XSSFWorkbook(is);
		}else{
			if(is != null){
				is.close();
			}
			throw new BusinessException("非excel文件");
		}
		
        int numberOfSheets = workbook.getNumberOfSheets();
        for( int sheetNum = 0;sheetNum < numberOfSheets;sheetNum++ ){
        	Sheet  sheet = workbook.getSheetAt(sheetNum);
        	if (sheet == null) {
                continue;
            }
        	
        	//循环行
        	for( int rowIdx = 0;rowIdx <= sheet.getLastRowNum(); rowIdx ++ ){
        		Row row = sheet.getRow(rowIdx);
        		if (row == null) {
                    continue;
                }
        		rowReadHandler.handle(rowIdx,row,sheet.getLastRowNum());
        	}
        }
        
        if(workbook != null){
        	workbook.close();
        }
        
        if(is != null){
        	is.close();
        }
        
	}
	
	public static String getCellValue(Cell cell) {  
        String ret;  
        switch (cell.getCellType()) {  
        case Cell.CELL_TYPE_BLANK:  
            ret = "";  
            break;  
        case Cell.CELL_TYPE_BOOLEAN:  
            ret = String.valueOf(cell.getBooleanCellValue());  
            break;  
        case Cell.CELL_TYPE_ERROR:  
            ret = null;  
            break;  
        case Cell.CELL_TYPE_FORMULA:  
            Workbook wb = cell.getSheet().getWorkbook();  
            CreationHelper crateHelper = wb.getCreationHelper();  
            FormulaEvaluator evaluator = crateHelper.createFormulaEvaluator();  
            ret = getCellValue(evaluator.evaluateInCell(cell));  
            break;  
        case Cell.CELL_TYPE_NUMERIC:  
            if (DateUtil.isCellDateFormatted(cell)) {   
                Date theDate = cell.getDateCellValue();  
                ret = new SimpleDateFormat(DATE_OUTPUT_PATTERNS).format(theDate);  
            } else {   
                ret = NumberToTextConverter.toText(cell.getNumericCellValue());  
            }  
            break;  
        case Cell.CELL_TYPE_STRING:  
            ret = cell.getRichStringCellValue().getString();  
            break;  
        default:  
            ret = null;  
        }  
          
        return ret; //有必要自行trim  
    }  

	
}
