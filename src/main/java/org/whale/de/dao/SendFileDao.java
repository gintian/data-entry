package org.whale.de.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.whale.base.TimeUtil;
import org.whale.base.UserContextUtil;
import org.whale.de.domain.SendFile;
import org.whale.system.common.util.Strings;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;

@Repository
public class SendFileDao extends BaseDao<SendFile, Long> {

	public void querySendFilePage(Page page,Map<String, String> paramMap) {
		StringBuilder sql = new StringBuilder("SELECT s.userName, t.PK_SEND_FILE, t.DICT_FILE_CATEGORY, t.FILE_TITLE,t.SEND_COMPANYS_OTHER, t.SEND_DATE, t.SEND_NO, t.FILE_CODE, t.DICT_DENSE, t.DENSE_CODE, t.CONFIDENTIAL_CODE, t.MEMO"
				+ ", CONCAT(CASE WHEN t.send_companys IS NOT NULL THEN (SELECT GROUP_CONCAT(ORG_COMPANY SEPARATOR ',') FROM de_organization WHERE FIND_IN_SET(PK_ORGANIZATION,t.send_companys)) END, \",\", t.send_companys_other) AS send_companys  FROM DE_SEND_FILE t inner join sys_user s on s.userId = t.update_by_id where 1=1 ");
		
		if(paramMap != null && paramMap.size() > 0 ){
			String DICT_FILE_CATEGORY = paramMap.get("DICT_FILE_CATEGORY");
			if(Strings.isNotBlank(DICT_FILE_CATEGORY)){
				sql.append("and t.DICT_FILE_CATEGORY = ? ");
				page.addArg(DICT_FILE_CATEGORY.trim());
			}
			String FILE_TITLE = paramMap.get("FILE_TITLE");
			if(Strings.isNotBlank(FILE_TITLE)){
				sql.append("and t.FILE_TITLE like ? ");
				page.addArg("%" + FILE_TITLE.trim() + "%");
			}
			String FILE_CODE = paramMap.get("FILE_CODE");
			if(Strings.isNotBlank(FILE_CODE)){
				sql.append("and t.FILE_CODE like ? ");
				page.addArg("%" + FILE_CODE.trim() + "%");
			}
			String SEND_NO = paramMap.get("SEND_NO");
			if(Strings.isNotBlank(SEND_NO)){
				sql.append("and t.SEND_NO like ? ");
				page.addArg("%" + SEND_NO.trim() + "%");
			}
			/*String SEND_DATE = paramMap.get("SEND_DATE");
			if(Strings.isNotBlank(SEND_DATE)){
				sql.append("and t.SEND_DATE like ? ");
				page.addArg("%"+SEND_DATE.trim()+"%");
			}*/
			String MIN_SEND_DATE = paramMap.get("MIN_SEND_DATE");
			if (Strings.isNotBlank(MIN_SEND_DATE)) {
				MIN_SEND_DATE = TimeUtil.fillUpDateStrToDayMin(MIN_SEND_DATE);
				sql.append(" AND t.SEND_DATE >= ? ");
				page.addArg(MIN_SEND_DATE);
			}
			String MAX_SEND_DATE = paramMap.get("MAX_SEND_DATE");
			if (Strings.isNotBlank(MAX_SEND_DATE)) {
				MAX_SEND_DATE = TimeUtil.fillUpDateStrToDayMax(MAX_SEND_DATE);
				sql.append(" AND t.SEND_DATE <= ? ");
				page.addArg(MAX_SEND_DATE);
			}
			String DICT_DENSE = paramMap.get("DICT_DENSE");
			if(Strings.isNotBlank(DICT_DENSE)){
				sql.append("and t.DICT_DENSE = ? ");
				page.addArg(DICT_DENSE.trim());
			}
			String CONFIDENTIAL_CODE = paramMap.get("CONFIDENTIAL_CODE");
			if(Strings.isNotBlank(CONFIDENTIAL_CODE)){
				sql.append("and t.CONFIDENTIAL_CODE like ? ");
				page.addArg("%" + CONFIDENTIAL_CODE.trim() + "%");
			}
		}
		
		sql.append(" order by t.SEND_DATE desc, t.SEND_NO desc");
		page.setSql(sql.toString());
		this.queryPage(page);
	}
	
	public SendFile getById(Long id){
		StringBuilder sql = new StringBuilder("SELECT t.PK_SEND_FILE, t.SEND_COMPANYS_OTHER, t.DICT_FILE_CATEGORY, t.FILE_TITLE, t.SEND_DATE, t.SEND_NO, t.FILE_CODE, t.DICT_DENSE, t.DENSE_CODE, t.CONFIDENTIAL_CODE, t.MEMO, t.CREATE_BY_ID, t.CREATE_BY_TIME, t.UPDATE_BY_ID, t.UPDATE_BY_TIME, t.IS_VALID"
				+ ", CONCAT(CASE WHEN t.send_companys IS NOT NULL THEN (SELECT GROUP_CONCAT(ORG_COMPANY SEPARATOR ',') FROM de_organization WHERE FIND_IN_SET(PK_ORGANIZATION,t.send_companys)) END, \",\", t.send_companys_other) AS send_companys FROM DE_SEND_FILE t "
				+ " where 1=1 "
				+ " and t.PK_SEND_FILE = ?");
		
		List<SendFile> list = this.query(sql.toString(), id);
		return list.get(0);
	}
	
	@Override
	public void save(SendFile t) {
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
	public void update(SendFile t) {
		Long operUserId = UserContextUtil.getUserContext().getUserId();
		t.setUpdateById(operUserId);
		t.setUpdateByTime(new Date());
		
		SendFile old = this.get(t.getPkSendFile());
		t.setCreateById(old.getCreateById());
		t.setCreateByTime(old.getCreateByTime());
		t.setIsValid(1);
		super.update(t);
	}
	
}