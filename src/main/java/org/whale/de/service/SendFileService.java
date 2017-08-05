package org.whale.de.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.whale.system.common.util.LangUtil;
import org.whale.system.common.util.Strings;

import org.whale.de.dao.SendFileDao;
import org.whale.de.domain.SendFile;
import org.whale.system.dao.BaseDao;
import org.whale.system.dao.Page;
import org.whale.system.service.BaseService;

/**
 *  管理
 *
 * @Date 2017-08-01
 */
@Service
public class SendFileService extends BaseService<SendFile, Long> {
	private static Logger logger = LoggerFactory.getLogger(SendFileService.class);

	@Autowired
	private SendFileDao sendFileDao;
	
	@Override
	public BaseDao<SendFile, Long> getDao() {
		return sendFileDao;
	}
	
	/**
	 * 分页查询
	 * @param page
	 * @param paramMap
	 */
	public void querySendFilePage(Page page,Map<String,String> paramMap) {
		sendFileDao.querySendFilePage(page,paramMap);
	}
	
	/**
	 * 指定id查询记录
	 * @return
	 */
	public SendFile getById(Long id){
		return sendFileDao.getById(id);
	}
	
}