package org.whale.pu.excel;

public class ColumnHandlerComponent {
	private String columnName;
	private IColumnHandler handler;
	private int dataType=0;
	public ColumnHandlerComponent(String columnName, IColumnHandler handler,int dataType) {
		super();
		this.columnName = columnName;
		this.handler = handler;
		this.dataType=dataType;
	}
	public ColumnHandlerComponent(String columnName, IColumnHandler handler) {
		super();
		this.columnName = columnName;
		this.handler = handler;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public IColumnHandler getHandler() {
		return handler;
	}
	public void setHandler(IColumnHandler handler) {
		this.handler = handler;
	}
	public int getDataType() {
		return dataType;
	}
	public void setDataType(int dataType) {
		this.dataType = dataType;
	}
	

}
