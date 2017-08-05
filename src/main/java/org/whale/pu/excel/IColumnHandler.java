package org.whale.pu.excel;

import java.util.Map;

public interface IColumnHandler {
	public String handle(Object object,Map<String, Object> rowData);
}
