package org.whale.de.dao;

import java.util.Date;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.whale.base.UserContextUtil;
import org.whale.de.domain.Organization;
import org.whale.system.common.util.Strings;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;

@Repository
public class OrganizationDao extends BaseDao<Organization, Long> {

	public void queryOrganizationPage(Page page,Map<String, String> paramMap) {
		StringBuilder sql = new StringBuilder("SELECT * FROM DE_ORGANIZATION t where 1=1 ");
		
		if(paramMap != null && paramMap.size() > 0 ){
			String dictOrgCategory = paramMap.get("DICT_ORG_CATEGORY");
			if(Strings.isNotBlank(dictOrgCategory)){
				sql.append("and t.DICT_ORG_CATEGORY = ? ");
				page.addArg(dictOrgCategory.trim());
			}
			String orgCompany = paramMap.get("ORG_COMPANY");
			if(Strings.isNotBlank(orgCompany)){
				sql.append("and t.ORG_COMPANY like ? ");
				page.addArg("%" + orgCompany.trim() + "%");
			}
			
		}
		sql.append(" ORDER BY t.DICT_ORG_CATEGORY");
		page.setSql(sql.toString());
		this.queryPage(page);
	}
	
	@Override
	public void save(Organization t) {
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
	public void update(Organization t) {
		Long operUserId = UserContextUtil.getUserContext().getUserId();
		t.setUpdateById(operUserId);
		t.setUpdateByTime(new Date());
		
		Organization old = this.get(t.getPkOrganization());
		t.setCreateById(old.getCreateById());
		t.setCreateByTime(old.getCreateByTime());
		t.setIsValid(1);
		super.update(t);
	}
	
}