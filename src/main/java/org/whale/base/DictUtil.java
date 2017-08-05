package org.whale.base;

import java.util.List;

import org.whale.system.common.util.Strings;
import org.whale.system.domain.Dict;
import org.whale.system.domain.DictItem;

public class DictUtil {
	public static String getItemLabel(Dict dict,String itemCode){
		DictItem dictItem=null;
		if (Strings.isBlank(itemCode))
			return null;
		List<DictItem> list = dict.getItems();
		if ((list == null) || (list.size() < 1))
			return null;
		for (DictItem item : list) {
			if (itemCode.trim().equals(item.getItemCode())){
				dictItem=item;
				break;
			}
		}
		if (dictItem == null)
			{return null;}
		String label = dictItem.getItemName();
		return label;
	}
}
