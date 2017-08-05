package org.whale.de.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.whale.base.UserContextUtil;
import org.whale.system.common.util.LangUtil;
import org.whale.system.common.util.Strings;
import org.whale.de.domain.RecFile;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;

@Repository
public class RecFileDao extends BaseDao<RecFile, Long> {

	public void queryRecFilePage(Page page,Map<String, String> paramMap) {
		StringBuilder sql = new StringBuilder("SELECT *, t.FILE_CNT as DE_SIGN_UP, CASE WHEN t.HANDLE_PRES IS NOT NULL AND (t.IS_HANDLE IS NULL OR t.IS_HANDLE = 0) AND t.HANDLE_PRES < CURRENT_DATE() THEN 1 ELSE 0 END AS IS_OVERTIME FROM DE_REC_FILE t where 1=1 ");
		
		if(paramMap != null && paramMap.size() > 0 ){
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
				sql.append("and t.DICT_REC_COMPANY = ? ");
				page.addArg(DICT_REC_COMPANY.trim());
			}
			String REC_DATE = paramMap.get("REC_DATE");
			if(Strings.isNotBlank(REC_DATE)){
				sql.append("and t.REC_DATE like ? ");
				page.addArg("%"+REC_DATE.trim()+"%");
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
		}
		
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
		t.setIsValid(1);
		super.update(t);
	}
	
}