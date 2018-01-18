package org.whale.de.dao;

import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;
import org.whale.base.BaseController;
import org.whale.base.TimeUtil;
import org.whale.base.UserContextUtil;
import org.whale.de.domain.RecFile;
import org.whale.system.common.util.Strings;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;

@Repository
public class RecFileDao extends BaseDao<RecFile, Long> {

	public void queryRecFilePage(Page page,Map<String, String> paramMap,Integer oprType) {
		StringBuilder sql = new StringBuilder("SELECT t.*, s.userName, CASE WHEN t.HANDLE_PRES IS NOT NULL AND ( t.IS_HANDLE IS NULL OR t.IS_HANDLE = 0 ) AND t.HANDLE_PRES < CURRENT_DATE() THEN 1 ELSE 0 END AS IS_OVERTIME, ft.signUpComps AS DE_SIGN_UP_COMPANYS, ft.signUps AS DE_SIGN_UP, ft.signTimes AS DE_SIGN_TIME FROM DE_REC_FILE t INNER JOIN sys_user s ON s.userId = t.update_by_id LEFT JOIN (SELECT d.`FK_REC_FILE`, GROUP_CONCAT( CASE WHEN o.`DICT_ORG_CATEGORY` = 'ORG_CATEGORY_QT' THEN d.`SIGN_UP_OTHER` ELSE o.`ORG_COMPANY` END SEPARATOR '\\n' ) AS signUpComps, GROUP_CONCAT(d.`SIGN_UP` SEPARATOR '\\n') AS signUps, GROUP_CONCAT(IF(d.`SIGN_TIME`, DATE_FORMAT(SIGN_TIME, '%Y-%m-%d'), '') SEPARATOR '\\n') AS signTimes FROM de_rec_file_sign d INNER JOIN de_organization o ON d.`FK_ORGANIZATION` = o.`PK_ORGANIZATION` WHERE d.`IS_VALID` = 1 GROUP BY d.`FK_REC_FILE`) ft ON ft.FK_REC_FILE = t.PK_REC_FILE WHERE 1 = 1 AND t.IS_VALID = 1  ");
//		StringBuilder sql = new StringBuilder("SELECT t.*, s.userName, t.FILE_CNT AS DE_FILE_CNT, CASE WHEN t.HANDLE_PRES IS NOT NULL AND ( t.IS_HANDLE IS NULL OR t.IS_HANDLE = 0 ) AND t.HANDLE_PRES < CURRENT_DATE() THEN 1 ELSE 0 END AS IS_OVERTIME, ft.signUpComps AS DE_SIGN_UP_COMPANYS FROM DE_REC_FILE t INNER JOIN sys_user s ON s.userId = t.update_by_id LEFT JOIN (SELECT d.`FK_REC_FILE`, GROUP_CONCAT(CASE WHEN o.`DICT_ORG_CATEGORY`= 'ORG_CATEGORY_QT' THEN d.`SIGN_UP_OTHER` ELSE o.`ORG_COMPANY` END) AS signUpComps FROM de_rec_file_sign d INNER JOIN de_organization o ON d.`FK_ORGANIZATION` = o.`PK_ORGANIZATION` WHERE d.`IS_VALID` = 1 GROUP BY d.`FK_REC_FILE`) ft ON ft.FK_REC_FILE = t.PK_REC_FILE WHERE 1 = 1 AND t.IS_VALID = 1 ");
		if(paramMap != null && paramMap.size() > 0 ){
			String EXPORT_IDS = paramMap.get(BaseController.EXPORT_IDS_KEY);
			// 导出
			if(oprType == 2 && StringUtils.isNotBlank(EXPORT_IDS)){
				sql.append("and t.PK_REC_FILE in ("+ EXPORT_IDS.trim() +") ");
			}else{
				String DICT_FILE_SOURCE = paramMap.get("DICT_FILE_SOURCE");
				if(Strings.isNotBlank(DICT_FILE_SOURCE)){
					sql.append("and t.DICT_FILE_SOURCE = ? ");
					page.addArg(DICT_FILE_SOURCE.trim());
				}
				String DICT_FILE_CATEGORY = paramMap.get("DICT_FILE_CATEGORY");
				if(Strings.isNotBlank(DICT_FILE_CATEGORY)){
					sql.append("and t.DICT_FILE_CATEGORY = ? ");
					page.addArg(DICT_FILE_CATEGORY.trim());
				}
				String DICT_REC_COMPANY = paramMap.get("DICT_REC_COMPANY");
				if(Strings.isNotBlank(DICT_REC_COMPANY)){
					sql.append("and t.DICT_REC_COMPANY like ? ");
					page.addArg("%"+DICT_REC_COMPANY.trim()+"%");
				}
				/*String REC_DATE = paramMap.get("REC_DATE");
				if(Strings.isNotBlank(REC_DATE)){
					sql.append("and t.REC_DATE like ? ");
					page.addArg("%"+REC_DATE.trim()+"%");
				}*/
				String MIN_REC_DATE = paramMap.get("MIN_REC_DATE");
				if (Strings.isNotBlank(MIN_REC_DATE)) {
					MIN_REC_DATE = TimeUtil.fillUpDateStrToDayMin(MIN_REC_DATE);
					sql.append(" AND t.REC_DATE >= ? ");
					page.addArg(MIN_REC_DATE);
				}
				String MAX_REC_DATE = paramMap.get("MAX_REC_DATE");
				if (Strings.isNotBlank(MAX_REC_DATE)) {
					MAX_REC_DATE = TimeUtil.fillUpDateStrToDayMax(MAX_REC_DATE);
					sql.append(" AND t.REC_DATE <= ? ");
					page.addArg(MAX_REC_DATE);
				}
				String REC_NO = paramMap.get("REC_NO");
				if(Strings.isNotBlank(REC_NO)){
					sql.append("and t.REC_NO like ? ");
					page.addArg("%" + REC_NO.trim() + "%");
				}
				String FILE_CODE = paramMap.get("FILE_CODE");
				if(Strings.isNotBlank(FILE_CODE)){
					sql.append("and t.FILE_CODE like ? ");
					page.addArg("%" + FILE_CODE.trim() + "%");
				}
				String FILE_TITLE = paramMap.get("FILE_TITLE");
				if(Strings.isNotBlank(FILE_TITLE)){
					sql.append("and t.FILE_TITLE like ? ");
					page.addArg("%" + FILE_TITLE.trim() + "%");
				}
				String DICT_DENSE = paramMap.get("DICT_DENSE");
				if(Strings.isNotBlank(DICT_DENSE)){
					sql.append("and t.DICT_DENSE = ? ");
					page.addArg(DICT_DENSE.trim());
				}
				String DENSE_CODE = paramMap.get("DENSE_CODE");
				if(Strings.isNotBlank(DENSE_CODE)){
					sql.append("and t.DENSE_CODE like ? ");
					page.addArg("%" + DENSE_CODE.trim() + "%");
				}
				String DICT_GRADE = paramMap.get("DICT_GRADE");
				if(Strings.isNotBlank(DICT_GRADE)){
					sql.append("and t.DICT_GRADE = ? ");
					page.addArg(DICT_GRADE.trim());
				}
				String IS_PROPOSED = paramMap.get("IS_PROPOSED");
				if(Strings.isNotBlank(IS_PROPOSED)){
					sql.append("and t.IS_PROPOSED = ? ");
					page.addArg(IS_PROPOSED.trim());
				}
				String SIGN_UP_STATUS = paramMap.get("SIGN_UP_STATUS");
				if(Strings.isNotBlank(SIGN_UP_STATUS)){
					sql.append("and t.SIGN_UP_STATUS = ? ");
					page.addArg(SIGN_UP_STATUS.trim());
				}
				String DIRECTOR_OPER = paramMap.get("DIRECTOR_OPER");
				if(Strings.isNotBlank(DIRECTOR_OPER)){
					sql.append("and t.DIRECTOR_OPER = ? ");
					page.addArg(DIRECTOR_OPER.trim());
				}
				String IS_NEED_FEEDBACK = paramMap.get("IS_NEED_FEEDBACK");
				if(Strings.isNotBlank(IS_NEED_FEEDBACK)){
					sql.append("and t.IS_NEED_FEEDBACK = ? ");
					page.addArg(IS_NEED_FEEDBACK.trim());
				}
			}
		}
		
		sql.append(" order by t.REC_DATE desc, t.REC_NO desc");
		page.setSql(sql.toString());
		this.queryPage(page);
	}
	
	public void doHandle(Long id) {
		String sql = "update DE_REC_FILE set IS_HANDLE = 1 where PK_REC_FILE = ?";
		this.jdbcTemplate.update(sql, id);
	}
	
	@Override
	public void save(RecFile t) {
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
	public void update(RecFile t) {
		Long operUserId = UserContextUtil.getUserContext().getUserId();
		t.setUpdateById(operUserId);
		t.setUpdateByTime(new Date());
		
		RecFile old = this.get(t.getPkRecFile());
		t.setCreateById(old.getCreateById());
		t.setCreateByTime(old.getCreateByTime());
		//t.setIsValid(1);
		super.update(t);
	}

	public void queryRecFileSignPage(Page page, Map<String, String> paramMap,Integer oprType) {
		//StringBuilder sql = new StringBuilder("SELECT t.*, CASE WHEN o.`DICT_ORG_CATEGORY`= 'ORG_CATEGORY_QT' THEN f.`SIGN_UP_OTHER` ELSE o.`ORG_COMPANY` END AS ORG_COMPANY, s.userName, 1 AS DE_SIGN_UP, CASE WHEN t.HANDLE_PRES IS NOT NULL AND ( t.IS_HANDLE IS NULL OR t.IS_HANDLE = 0 ) AND t.HANDLE_PRES < CURRENT_DATE() THEN 1 ELSE 0 END AS IS_OVERTIME FROM DE_REC_FILE t INNER JOIN sys_user s ON s.userId = t.update_by_id LEFT JOIN de_rec_file_sign f ON f.FK_REC_FILE = t.PK_REC_FILE LEFT JOIN de_organization o ON o.PK_ORGANIZATION = f.FK_ORGANIZATION WHERE 1 = 1 AND t.is_valid = 1 ");
		StringBuilder sql = new StringBuilder("SELECT t.*, s.userName, 1 AS DE_SIGN_UP, CASE WHEN t.HANDLE_PRES IS NOT NULL AND ( t.IS_HANDLE IS NULL OR t.IS_HANDLE = 0 ) AND t.HANDLE_PRES < CURRENT_DATE() THEN 1 ELSE 0 END AS IS_OVERTIME, ft.signUpComps AS ORG_COMPANY FROM DE_REC_FILE t INNER JOIN sys_user s ON s.userId = t.update_by_id LEFT JOIN (SELECT d.`FK_REC_FILE`, GROUP_CONCAT( CASE WHEN o.`DICT_ORG_CATEGORY` = 'ORG_CATEGORY_QT' THEN d.`SIGN_UP_OTHER` ELSE o.`ORG_COMPANY` END ) AS signUpComps FROM de_rec_file_sign d INNER JOIN de_organization o ON d.`FK_ORGANIZATION` = o.`PK_ORGANIZATION` WHERE d.`IS_VALID` = 1 GROUP BY d.`FK_REC_FILE`) ft ON ft.FK_REC_FILE = t.PK_REC_FILE WHERE 1 = 1 AND t.is_valid = 1 ");
		
		if(paramMap != null && paramMap.size() > 0 ){
			String EXPORT_IDS = paramMap.get(BaseController.EXPORT_IDS_KEY);
			// 导出
			if(oprType == 2 && StringUtils.isNotBlank(EXPORT_IDS)){
				sql.append("and t.PK_REC_FILE in ("+ EXPORT_IDS.trim() +") ");
			}else{
				String DICT_FILE_SOURCE = paramMap.get("DICT_FILE_SOURCE");
				if(Strings.isNotBlank(DICT_FILE_SOURCE)){
					sql.append("and t.DICT_FILE_SOURCE = ? ");
					page.addArg(DICT_FILE_SOURCE.trim());
				}
				String REC_DATE = paramMap.get("REC_DATE");
				if(Strings.isNotBlank(REC_DATE)){
					sql.append("and t.REC_DATE like ? ");
					page.addArg("%"+REC_DATE.trim()+"%");
				}
				String FILE_CODE = paramMap.get("FILE_CODE");
				if(Strings.isNotBlank(FILE_CODE)){
					sql.append("and t.FILE_CODE like ? ");
					page.addArg("%" + FILE_CODE.trim() + "%");
				}
				String FILE_TITLE = paramMap.get("FILE_TITLE");
				if(Strings.isNotBlank(FILE_TITLE)){
					sql.append("and t.FILE_TITLE like ? ");
					page.addArg("%" + FILE_TITLE.trim() + "%");
				}
				String SIGN_UP_STATUS = paramMap.get("SIGN_UP_STATUS");
				if(Strings.isNotBlank(SIGN_UP_STATUS)){
					sql.append("and t.SIGN_UP_STATUS = ? ");
					page.addArg(SIGN_UP_STATUS.trim());
				}
				String ORG_COMPANY = paramMap.get("ORG_COMPANY");
				if(Strings.isNotBlank(ORG_COMPANY)){
					sql.append("and o.ORG_COMPANY like ? ");
					page.addArg("%" + ORG_COMPANY.trim() + "%");
				}
				String REC_NO = paramMap.get("REC_NO");
				if(Strings.isNotBlank(REC_NO)){
					sql.append("and t.REC_NO like ? ");
					page.addArg("%" + REC_NO.trim() + "%");
				}
				String DICT_REC_COMPANY = paramMap.get("DICT_REC_COMPANY");
				if(Strings.isNotBlank(DICT_REC_COMPANY)){
					sql.append("and t.DICT_REC_COMPANY like ? ");
					page.addArg("%" + DICT_REC_COMPANY.trim() + "%");
				}
			}
		}
		
		sql.append(" order by t.REC_DATE desc, t.REC_NO desc");
		page.setSql(sql.toString());
		this.queryPage(page);
	}
	
}