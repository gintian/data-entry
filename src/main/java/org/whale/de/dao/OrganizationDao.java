package org.whale.de.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.whale.base.UserContextUtil;
import org.whale.de.domain.Organization;
import org.whale.system.common.exception.BusinessException;
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
	
	/**
	 * 查询机构数据
	 * @param fileType 1收文；2发文
	 * @param dictFileSource 文件来源，针对发文
	 * @return
	 */
	public List<Organization> queryOrganizations(Integer fileType, String dictFileSource){
		String sql = "";
		if(fileType == 1){
			if(dictFileSource.equals("FILE_SOURCE_BGSNBSW")){
				sql = "select * from DE_ORGANIZATION where dict_org_category in ('ORG_CATEGORY_NBGDW', 'ORG_CATEGORY_QT') order by PK_ORGANIZATION asc";
			}else{
				sql = "select * from DE_ORGANIZATION where dict_org_category in ('ORG_CATEGORY_JLD', 'ORG_CATEGORY_JZGDW', 'ORG_CATEGORY_GFJXSQGAJ', 'ORG_CATEGORY_QT') order by PK_ORGANIZATION asc";
			}
		}else if(fileType == 2){
			sql = "select * from DE_ORGANIZATION where dict_org_category in ('ORG_CATEGORY_JLD', 'ORG_CATEGORY_JZGDW', 'ORG_CATEGORY_GFJXSQGAJ') order by PK_ORGANIZATION asc";
		}else{
			throw new BusinessException("fileType参数传递有误，请检查");
		}
		return this.query(sql);
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