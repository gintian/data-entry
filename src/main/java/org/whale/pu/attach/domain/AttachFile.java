package org.whale.pu.attach.domain;

import java.text.DecimalFormat;
import java.util.Date;

import org.whale.system.domain.BaseEntry;
import org.whale.system.jdbc.annotation.Column;
import org.whale.system.jdbc.annotation.Id;
import org.whale.system.jdbc.annotation.Table;

@Table(value="PU_ATTACH_FILE",cnName="")
public class AttachFile extends BaseEntry{

	private static final long serialVersionUID = -1;
	@Id
	@Column(name="PK_ATTACH_FILE", cnName="PK_ATTACH_FILE")
	private Long pkAttachFile;
	
	@Column(name="STORE_FILE_NAME", cnName="文件名", nullable=false, unique=true)
	private String fileName;
	
  	@Column(name="FILE_TYPE", cnName="文件类型", nullable=false, width=2)
	private Integer fileType;
  	
  	@Column(name="REAL_FILE_NAME", cnName="原文件名", nullable=false, width=64)
	private String realFileName;
  	
  	@Column(name="FILE_SUFFIX", cnName="文件后缀名", nullable=true, width=16)
	private String fileSuffix;
  	
  	@Column(name="RELATIVE_PATH", cnName="文件路径", nullable=false, width=256)
	private String filePath;
  	
  	@Column(name="ABSOLUTE_PATH", cnName="绝对路径", width=256)
	private String absolutePath;
  	
  	@Column(name="URL_PATH", cnName="url访问地址", unique=true, nullable=false, width=256)
	private String urlPath;
  	
  	@Column(name="SAVE_TYPE", cnName="保存方式", nullable=false, width=2)
	private Integer saveWay;
  	
  	@Column(name="FILE_SIZE", cnName="文件大小", nullable=false, width=10)
	private Long fileSize;
  	
  	@Column(name="CREATE_BY_ID", cnName="创建人", width=10)
	private Long creator;
  	
  	@Column(name="CREATE_BY_TIME", cnName="创建时间")
	private Date createTime;
  	
  	@Column(name="BUSINESS_KEY", cnName="业务表实例ID")
  	private String businessKey;
  	
  	@Column(name="PROCESS_INSTANCE_ID", cnName="流程实例ID")
  	private String processInstanceId; 
  	
	@Column(name="TASK_DEFINITION_KEY", cnName="流程任务节点key")
  	private String taskDefinitionKey;
	
	@Column(name="BUSINESS_TABLE_NAME", cnName="业务表表名")
	private String businessTableName;
  	
  	private String dirName;
  	
  	public String getBusinessKey() {
		return businessKey;
	}

	public void setBusinessKey(String businessKey) {
		this.businessKey = businessKey;
	}

  	public String getTaskDefinitionKey() {
		return taskDefinitionKey;
	}

	public void setTaskDefinitionKey(String taskDefinitionKey) {
		this.taskDefinitionKey = taskDefinitionKey;
	}

	public String getProcessInstanceId() {
		return processInstanceId;
	}

	public void setProcessInstanceId(String processInstanceId) {
		this.processInstanceId = processInstanceId;
	}

  	public String getBusinessTableName() {
		return businessTableName;
	}

	public void setBusinessTableName(String businessTableName) {
		this.businessTableName = businessTableName;
	}

	public Long getSizeKB() {
  		if(this.fileSize != null)
  			return this.fileSize /1024;
  		return -1L;
  	}
  	
  	public String getSizeMB() {
  		DecimalFormat df = new DecimalFormat("#0.00");
  		if(this.fileSize != null)
  			return df.format(new Float(this.fileSize) /1024 / 1024);
  		return "0";
  	}
	
	/**文件名 */
	public String getFileName(){
		return fileName;
	}
	
	/**文件名 */
	public void setFileName(String fileName){
		this.fileName = fileName;
	}
	
	public Long getPkAttachFile() {
		return pkAttachFile;
	}

	public void setPkAttachFile(Long pkAttachFile) {
		this.pkAttachFile = pkAttachFile;
	}

	/**文件类型 */
	public Integer getFileType(){
		return fileType;
	}
	
	/**文件类型 */
	public void setFileType(Integer fileType){
		this.fileType = fileType;
	}
	
	/**原文件名 */
	public String getRealFileName(){
		return realFileName;
	}
	
	/**原文件名 */
	public void setRealFileName(String realFileName){
		this.realFileName = realFileName;
	}
	
	/**文件后缀名 */
	public String getFileSuffix(){
		return fileSuffix;
	}
	
	/**文件后缀名 */
	public void setFileSuffix(String fileSuffix){
		this.fileSuffix = fileSuffix;
	}
	
	/**文件路径 */
	public String getFilePath(){
		return filePath;
	}
	
	/**文件路径 */
	public void setFilePath(String filePath){
		this.filePath = filePath;
	}
	
	/**绝对路径 */
	public String getAbsolutePath(){
		return absolutePath;
	}
	
	/**绝对路径 */
	public void setAbsolutePath(String absolutePath){
		this.absolutePath = absolutePath;
	}
	
	/**url访问地址 */
	public String getUrlPath(){
		return urlPath;
	}
	
	/**url访问地址 */
	public void setUrlPath(String urlPath){
		this.urlPath = urlPath;
	}
	
	/**保存方式 */
	public Integer getSaveWay(){
		return saveWay;
	}
	
	/**保存方式 */
	public void setSaveWay(Integer saveWay){
		this.saveWay = saveWay;
	}
	
	/**文件大小 */
	public Long getFileSize(){
		return fileSize;
	}
	
	/**文件大小 */
	public void setFileSize(Long fileSize){
		this.fileSize = fileSize;
	}
	
	/**创建人 */
	public Long getCreator(){
		return creator;
	}
	
	/**创建人 */
	public void setCreator(Long creator){
		this.creator = creator;
	}
	
	/**创建时间 */
	public Date getCreateTime(){
		return createTime;
	}
	
	/**创建时间 */
	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}

	public String getDirName() {
		return dirName;
	}

	public void setDirName(String dirName) {
		this.dirName = dirName;
	}

}
