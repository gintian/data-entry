package org.whale.de.service;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.whale.base.TimeUtil;
import org.whale.base.sequence.domain.SysSequence.SeqType;
import org.whale.de.dao.RecFileDao;
import org.whale.de.domain.RecFile;
import org.whale.de.domain.RecFileSign;
import org.whale.de.dto.RecFileSignDto;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;
import org.whale.system.service.BaseService;

/**
 *  管理
 *
 * @Date 2017-08-01
 */
@Service
public class RecFileService extends BaseService<RecFile, Long> {
	private static Logger logger = LoggerFactory.getLogger(RecFileService.class);

	@Autowired
	private RecFileDao recFileDao;
	@Autowired
	private RecFileSignService recFileSignService;
	
	@Override
	public BaseDao<RecFile, Long> getDao() {
		return recFileDao;
	}
	
	/**
	 * 分页查询
	 * @param page
	 * @param paramMap
	 * @param oprType 1查询、2导出
	 */
	public void queryRecFilePage(Page page,Map<String,String> paramMap, Integer oprType) {
		recFileDao.queryRecFilePage(page,paramMap,oprType);
	}
	
	public void queryRecFileSignPage(Page page, Map<String,String> paramMap, Integer oprType) {
		recFileDao.queryRecFileSignPage(page,paramMap,oprType);
	}
	
	/**
	 * 办结收文
	 * @param id
	 */
	public void doHandle(Long id) {
		recFileDao.doHandle(id);
	}
	
	/**
	 * 保存收文信息、签收信息
	 * @param recFile
	 */
	public void doSaveOrUpdate(RecFile recFile, RecFileSignDto dto) {
		// 判断是否完成签收
		/*Integer signUpStatus = 1;
		List<RecFileSign> recFileSignList = dto.getRecFileSigns();
		Iterator<RecFileSign> iter = recFileSignList.iterator();
		while(iter.hasNext()){
			RecFileSign recFileSign = iter.next();
			if(null == recFileSign.getFkOrganization()){
				iter.remove();
				continue;
			}
			if(StringUtils.isBlank(recFileSign.getSignUp()) || null == recFileSign.getSignTime()){
				signUpStatus = 0;
			}
		}
		if(null == recFileSignList || recFileSignList.size() < 1){
			signUpStatus = 0;
		}	
		recFile.setSignUpStatus(signUpStatus);*/
		if(null == recFile.getPkRecFile()){
			save(recFile);
		}else{
			update(recFile);
		}
		
		// recFileSignService.doReset(recFile.getPkRecFile(), recFileSignList);
		
	}
	
	/**
	 * 查询收文单位
	 * @param dictRecCompany
	 */
	public List<Map<String, Object>> queryRecCompanys(String dictRecCompany) {
		String str = "SELECT t1.`itemName` as DICT_REC_COMPANY FROM sys_dict_item t1 INNER JOIN sys_dict t2 ON t1.`dictId`= t2.`dictId` WHERE t2.`dictCode` = 'DICT_REC_COMPANY' AND t1.`itemName` LIKE ?";
		return this.getDao().getJdbcTemplate().queryForList(str, "%"+dictRecCompany.trim()+"%");
	}
	
	/**
	 * 伪删除
	 * @param idS
	 */
	public void deleteFake(List<Long> idS){
		if(idS != null && idS.size() > 0) {
			for(Long id : idS) {
				RecFile t = this.get(id);
				t.setIsValid(0);
				this.update(t);
			}
		}
	}
	
	/**
	 * 获取被删除的收文号
	 * @param recDate
	 * @return
	 */
	public String getRecNoFromDeleted(Date recDate){
		String sql = "SELECT t.* FROM de_rec_file t "
				+ "WHERE t.`REC_DATE` = ? "
				+ "AND t.`IS_VALID` = 0 "
				+ "AND NOT EXISTS (SELECT 1 FROM de_rec_file s WHERE s.`REC_DATE` = ? AND s.`IS_VALID` = 1 AND s.`REC_NO` = t.`REC_NO`) "
				+ "ORDER BY t.`REC_NO` ASC "
				+ "LIMIT 1";
		List<RecFile> recFileList = this.getDao().query(sql, recDate, recDate);
		return CollectionUtils.isEmpty(recFileList) ? null : recFileList.get(0).getRecNo();
	}
	
	/**
	 * 新增之前的收文，获取收文号
	 * @param recDate
	 * @return
	 */
	public String getRecNoByHistory(Date recDate, boolean isDense){
		String sql = "SELECT t.* FROM de_rec_file t WHERE t.`REC_DATE` = ? AND t.`IS_VALID` = 1 ORDER BY t.`REC_NO` DESC LIMIT 1";
		List<RecFile> recFileList = this.getDao().query(sql, recDate);
		if(CollectionUtils.isEmpty(recFileList)){
			if(isDense){
				return SeqType.REC_NO.getMjPrefix() + TimeUtil.getCurrDate(recDate, "yyyyMMdd") + "001";
			}else{
				return SeqType.REC_NO.getPrefix() + TimeUtil.getCurrDate(recDate, "yyyyMMdd") + "001";
			}
		}
		String recNo = recFileList.get(0).getRecNo();
		return recNo.substring(0, 10) + String.format("%03d", Integer.parseInt(recNo.substring(10)) + 1);
	}
	
	
}