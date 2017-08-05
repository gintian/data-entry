package org.whale.pu.excel;

import org.apache.poi.ss.usermodel.Row;

/**
 * excel 行读取处理器
 * @date 2015年9月10日 上午11:08:11
 */
public interface IRowReadHandler {

	/**
	 * excel行读取处理器
	 * @param rowIdx 行索引，第一行索引为0 
	 * @param excelRow 行对象
	 * @param lastRowIdx 最后一行索引，(行数-1)
	 */
	void handle(int rowIdx, Row excelRow,int lastRowIdx);

	
}
