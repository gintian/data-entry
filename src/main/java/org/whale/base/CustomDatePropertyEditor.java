package org.whale.base;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CustomDatePropertyEditor extends PropertyEditorSupport{

	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		if(text == null || "".equals(text)){
			setValue(null);
			return;
		}
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.setLenient(true);
		Date date = null;
		try {
			sdf.applyPattern("yyyy-MM-dd hh:mm:ss");
			date = sdf.parse(text);
		} catch (ParseException e) {
			sdf.applyPattern("yyyy-MM-dd");
			try {
				date = sdf.parse(text);
			} catch (ParseException e1) {
				sdf.applyPattern("yyyy/MM/dd hh:mm:ss");
				try {
					date = sdf.parse(text);
				} catch (ParseException e2) {
					sdf.applyPattern("yyyy/MM/dd");
					try {
						date = sdf.parse(text);
					} catch (ParseException e3) {
						e.printStackTrace();
					}
				}
			}
		}
		setValue(date);
	}
	
	
}
