package org.whale.pu.attach.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.whale.pu.attach.dao.AttachFileDao;
import org.whale.pu.attach.domain.AttachFile;
import org.whale.system.common.util.SpringContextHolder;
import org.whale.system.common.util.Strings;
import org.whale.system.dao.BaseDao;
import org.whale.system.service.BaseService;

@Service
public class AttachFileService extends BaseService<AttachFile, Long> {

	@Autowired
	private AttachFileDao attachFileDao;
	
    /**
	 * 按 原文件名 获取 文件
	 * @param realFileName 原文件名
	 * @return
	 */
    public AttachFile getByRealFileName(String realFileName) {
    	if(Strings.isBlank(realFileName)){
    		return null;
    	}
    	
    	return this.attachFileDao.getByRealFileName(realFileName.trim());
    }
    
    /**
     * 根据url地址获取文件对象
     * @param urlPath
     * @return
     */
    public AttachFile getByUrlPath(String urlPath) {
    	if(Strings.isBlank(urlPath)){
    		return null;
    	}
    	
    	return this.attachFileDao.getByUrlPath(urlPath.trim());
    }
    
    /**
     * 根据流程信息查看文件列表
     * @param processInstanceId
     * @param taskId
     * @return
     */
    public List<AttachFile> getByFlowMsg(String businessKey,String processInstanceId, String taskId,String businessTableName){
    	
		return this.attachFileDao.getByFlowMsg(businessKey,processInstanceId,taskId,businessTableName);
	
    }
    
    /**
     * 查找指定的附件列表
     * @param attachIds
     * @return
     */
    public List<AttachFile> getByAttachIds(String attachIds){
    	
    	return this.attachFileDao.getByAttachIds(attachIds);
    	
    }
	
    /**
     * 业务回调更新流程流程参数
     * @param attachIdsList
     * @param businessKey  业务表实例ID
     * @param processInstanceId  流程实例ID
     * @param taskDefinitionKey  流程任务节点key
     * @param businessTableName  业务表表名
     */
     public int updateEngineInfo(List<Long> attachIdsList,String businessKey,String processInstanceId, String taskDefinitionKey,String businessTableName){
    	if(attachIdsList != null && attachIdsList.size() > 0){
     		return this.attachFileDao.updateEngineInfo(attachIdsList, businessKey, processInstanceId, taskDefinitionKey, businessTableName);
     	}
     	return 0;
     }
     
    @Override
	public BaseDao<AttachFile, Long> getDao() {
		return attachFileDao;
	}

	public static AttachFileService getThis(){
		return SpringContextHolder.getBean(AttachFileService.class);
	}
	
}