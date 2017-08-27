package org.whale.de.dao;

import java.util.Date;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.whale.base.UserContextUtil;
import org.whale.de.domain.RecFileSign;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;

@Repository
public class RecFileSignDao extends BaseDao<RecFileSign, Long> {

	public void queryRecFileSignPage(Page page,Map<String, String> paramMap) {
		StringBuilder sql = new StringBuilder("SELECT * FROM DE_REC_FILE_SIGN where 1=1 ");
		
		if(paramMap != null && paramMap.size() > 0 ){
			/*if(Strings.isNotBlank(CUSTOMER_NAME)){
				sql.append("and d.CUSTOMER_NAME like ? ");
				page.addArg("%"+CUSTOMER_NAME.trim()+"%");
			}*/
		}
		
		page.setSql(sql.toString());
		this.queryPage(page);
	}
	
	@Override
	public void save(RecFileSign t) {
		Long operUserId = UserContextUtil.getUserContext().getUserId();
		t.setCreateById(operUserId);
		t.setUpdateById(operUserId);
		Date operDate = new Date();
		t.setCreateByTime(operDate);
		t.setUpdateByTime(operDate);
		t.setIsValid(1);
		super.save(t);
	}

	@Override
	public void update(RecFileSign t) {
		Long operUserId = UserContextUtil.getUserContext().getUserId();
		t.setUpdateById(operUserId);
		t.setUpdateByTime(new Date());
		
		RecFileSign old = this.get(t.getPkRecFileSign());
		t.setCreateById(old.getCreateById());
		t.setCreateByTime(old.getCreateByTime());
		t.setIsValid(1);
		super.update(t);
	}
	
}