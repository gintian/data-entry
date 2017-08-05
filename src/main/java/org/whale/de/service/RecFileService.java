package org.whale.de.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.whale.system.common.util.LangUtil;
import org.whale.system.common.util.Strings;
import org.whale.de.dao.RecFileDao;
import org.whale.de.domain.RecFile;
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
	
	/**
	 * 办结收文
	 * @param id
	 */
	public void doHandle(Long id) {
		recFileDao.doHandle(id);
	}

}