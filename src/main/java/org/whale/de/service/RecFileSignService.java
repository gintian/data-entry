package org.whale.de.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.whale.de.dao.RecFileSignDao;
import org.whale.de.domain.RecFileSign;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;
import org.whale.system.service.BaseService;

/**
 *  管理
 *
 * @Date 2017-08-12
 */
@Service
public class RecFileSignService extends BaseService<RecFileSign, Long> {
	private static Logger logger = LoggerFactory.getLogger(RecFileSignService.class);

	@Autowired
	private RecFileSignDao recFileSignDao;
	
	@Override
	public BaseDao<RecFileSign, Long> getDao() {
		return recFileSignDao;
	}
	
	/**
	 * 分页查询
	 * @param page
	 * @param paramMap
	 */
	public void queryRecFileSignPage(Page page,Map<String,String> paramMap) {
		recFileSignDao.queryRecFileSignPage(page,paramMap);
	}
	
	/**
	 * 重置某个收文的签收单位信息
	 * @param pkRecFile
	 * @param recFileSigns
	 */
	public void doReset(Long pkRecFile, List<RecFileSign> recFileSigns) {
		RecFileSign operObj = new RecFileSign();
		operObj.setFkRecFile(pkRecFile);
		recFileSignDao.deleteBy(operObj);
		
		for(RecFileSign recFileSign: recFileSigns){
			recFileSign.setFkRecFile(pkRecFile);
		}
		recFileSignDao.save(recFileSigns);
	}

	public List<RecFileSign> query(Long id) {
		RecFileSign orient = new RecFileSign();
		orient.setFkRecFile(id);
		return recFileSignDao.query(orient);
	}

}