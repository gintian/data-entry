package org.whale.pu.attach.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.whale.pu.attach.domain.AttachFile;
import org.whale.system.dao.BaseDao;

@Repository
public class AttachFileDao extends BaseDao<AttachFile, Long> {

    /**
	 * 按 原文件名 获取 文件
	 * @param realFileName 原文件名
	 * @return
	 */
    public AttachFile getByRealFileName(String realFileName) {
    	StringBuilder strb = this.getSqlHead();
    	strb.append("and t.real_file_name=?");
    	
    	return this.getObject(strb.toString(), realFileName);
    }
    
    /**
     * 根据url地址获取文件对象
     * @param urlPath
     * @return
     */
    public AttachFile getByUrlPath(String urlPath) {
    	StringBuilder strb = this.getSqlHead();
    	strb.append("and t.url_path=?");
    	
    	return this.getObject(strb.toString(), urlPath);
    }
    
    /**
     * 根据流程信息查看文件列表
     * @param processInstanceId
     * @param taskId
     * @param businessTableName
     * @return
     */
    public List<AttachFile> getByFlowMsg(String businessKey,String processInstanceId, String taskId,String businessTableName){
		StringBuilder strb = new StringBuilder();
		strb.append("SELECT t.* ")
			.append("FROM ").append(this.getTableName()).append(" t ")
			.append("where t.business_key = ? ")
			.append(" and t.business_table_name = ? ");
		
		return this.query(strb.toString(), businessKey,businessTableName);
	}
    
    /**
     * 根据ids查看文件列表
     * @param attachIds
     * @return
     */
    public List<AttachFile>  getByAttachIds(String attachIds){
    	Object[] attachFiles = attachIds.split(",");
    	StringBuilder strb = new StringBuilder();
		strb.append("SELECT t.* ")
			.append("FROM ").append(this.getTableName()).append(" t ")
			.append("WHERE t.pk_attach_file in ( ");
		for (int i = 0; i < attachFiles.length; i++) {
			if (i == attachFiles.length - 1) {
				strb.append("?) ");
			} else {
				strb.append("?, ");
			}
		}
		
		return this.query(strb.toString(), attachFiles);
    }
    
    /**
     * 环节保存或提交，业务回调更新流程流程参数
     * @param ids
     * @param processInstanceId
     * @param taskId
     * @return
     */
    public int updateEngineInfo(List<Long> attachIdsList,String businessKey,String processInstanceId, String taskDefinitionKey,String businessTableName){
    	Object[] args = new Object[4 + attachIdsList.size()];
    	args[0] = businessKey;
    	args[1] = processInstanceId;
    	args[2] = taskDefinitionKey;
    	args[3] = businessTableName;
    	StringBuilder sb = new StringBuilder();
    	sb.append(" update ").append(this.getTableName())
    	  .append(" set business_key = ?")
    	  .append(" ,process_instance_id = ?")
    	  .append(" ,task_definition_key = ?")
    	  .append(" ,business_table_name = ?")
    	  .append(" WHERE pk_attach_file in ( ");
		for (int i = 0; i < attachIdsList.size(); i++) {
			if (i == attachIdsList.size() - 1) {
				sb.append("?) ");
			} else {
				sb.append("?, ");
			}
			args[4 + i] = attachIdsList.get(i);
		}
    	return this.getJdbcTemplate().update(sb.toString(), args);
    }
    
}