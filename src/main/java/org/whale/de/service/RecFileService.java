package org.whale.de.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
	 */
	public void queryRecFilePage(Page page,Map<String,String> paramMap) {
		recFileDao.queryRecFilePage(page,paramMap);
	}
	
	public void queryRecFileSignPage(Page page, Map<String,String> paramMap){
		recFileDao.queryRecFileSignPage(page,paramMap);
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
		Integer signUpStatus = 1;
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
		recFile.setSignUpStatus(signUpStatus);
		if(null == recFile.getPkRecFile()){
			save(recFile);
		}else{
			update(recFile);
		}
		
		recFileSignService.doReset(recFile.getPkRecFile(), recFileSignList);
		
	}

}