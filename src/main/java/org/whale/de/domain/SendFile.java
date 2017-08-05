package org.whale.de.domain;

import java.math.BigDecimal;
import java.util.Date;

import org.whale.system.domain.BaseEntry;
import org.whale.system.jdbc.annotation.Column;
import org.whale.system.jdbc.annotation.Id;
import org.whale.system.jdbc.annotation.Table;

/**
 * 
 *
 * @Date 2017-08-01
 */
@Table(value="DE_SEND_FILE",cnName="")
public class SendFile extends BaseEntry {

	private static final long serialVersionUID = -1410714248140l;
	
	@Id
	@Column(name="PK_SEND_FILE", cnName="主键")
	private Long pkSendFile; 
	
	@Column(name="DICT_FILE_CATEGORY", cnName="文件类别，字典表：公文件、机要件、挂号信件、普通信件")
	private String dictFileCategory; 
	
	@Column(name="FILE_TITLE", cnName="文件标题")
	private String fileTitle; 
	
	@Column(name="SEND_COMPANYS", cnName="发送单位：存放机构单位主键，多个以，分隔")
	private String sendCompanys; 
	
	@Column(name="SEND_DATE", cnName="发文日期，格式yyyyMMdd")
	private Date sendDate; 
	
	@Column(name="SEND_NO", cnName="发文号：流水号，自动生成")
	private String sendNo; 
	
	@Column(name="FILE_CODE", cnName="文号，比如闽公宗（2017）051号")
	private String fileCode; 
	
	@Column(name="DICT_DENSE", cnName="密级，字典表：非密、秘密、机密、绝密、内部文件")
	private String dictDense; 
	
	@Column(name="DENSE_CODE", cnName="密级编号，只有当选项是秘密或机密或绝密时，才出现密级编号，密级编号不是必填项，也可以填无")
	private String denseCode; 
	
	@Column(name="MEMO", cnName="备注")
	private String memo; 
	
	@Column(name="CREATE_BY_ID", cnName="本条记录系统用户创建者ID")
	private Long createById; 
	
	@Column(name="CREATE_BY_TIME", cnName="本条记录系统用户创建时间")
	private Date createByTime; 
	
	@Column(name="UPDATE_BY_ID", cnName="本条记录系统用户修改者ID")
	private Long updateById; 
	
	@Column(name="UPDATE_BY_TIME", cnName="本条记录系统用户修改时间")
	private Date updateByTime; 
	
	@Column(name="IS_VALID", cnName="删除状态位(1有效，0无效，作废的时候表示无效)")
	private Integer isValid; 


	/**主键*/
	public Long getPkSendFile() {
		return pkSendFile;
	}
	
	/**主键*/
	public void setPkSendFile(Long pkSendFile) {
		this.pkSendFile = pkSendFile;
	}
	/**文件类别，字典表：公文件、机要件、挂号信件、普通信件*/
	public String getDictFileCategory() {
		return dictFileCategory;
	}
	
	/**文件类别，字典表：公文件、机要件、挂号信件、普通信件*/
	public void setDictFileCategory(String dictFileCategory) {
		this.dictFileCategory = dictFileCategory;
	}
	/**文件标题*/
	public String getFileTitle() {
		return fileTitle;
	}
	
	/**文件标题*/
	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}
	/**发送单位：存放机构单位主键，多个以，分隔*/
	public String getSendCompanys() {
		return sendCompanys;
	}
	
	/**发送单位：存放机构单位主键，多个以，分隔*/
	public void setSendCompanys(String sendCompanys) {
		this.sendCompanys = sendCompanys;
	}
	/**发文日期，格式yyyyMMdd*/
	public Date getSendDate() {
		return sendDate;
	}
	
	/**发文日期，格式yyyyMMdd*/
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	/**发文号：流水号，自动生成*/
	public String getSendNo() {
		return sendNo;
	}
	
	/**发文号：流水号，自动生成*/
	public void setSendNo(String sendNo) {
		this.sendNo = sendNo;
	}
	/**文号，比如闽公宗（2017）051号*/
	public String getFileCode() {
		return fileCode;
	}
	
	/**文号，比如闽公宗（2017）051号*/
	public void setFileCode(String fileCode) {
		this.fileCode = fileCode;
	}
	/**密级，字典表：非密、秘密、机密、绝密、内部文件*/
	public String getDictDense() {
		return dictDense;
	}
	
	/**密级，字典表：非密、秘密、机密、绝密、内部文件*/
	public void setDictDense(String dictDense) {
		this.dictDense = dictDense;
	}
	/**密级编号，只有当选项是秘密或机密或绝密时，才出现密级编号，密级编号不是必填项，也可以填无*/
	public String getDenseCode() {
		return denseCode;
	}
	
	/**密级编号，只有当选项是秘密或机密或绝密时，才出现密级编号，密级编号不是必填项，也可以填无*/
	public void setDenseCode(String denseCode) {
		this.denseCode = denseCode;
	}
	/**备注*/
	public String getMemo() {
		return memo;
	}
	
	/**备注*/
	public void setMemo(String memo) {
		this.memo = memo;
	}
	/**本条记录系统用户创建者ID*/
	public Long getCreateById() {
		return createById;
	}
	
	/**本条记录系统用户创建者ID*/
	public void setCreateById(Long createById) {
		this.createById = createById;
	}
	/**本条记录系统用户创建时间*/
	public Date getCreateByTime() {
		return createByTime;
	}
	
	/**本条记录系统用户创建时间*/
	public void setCreateByTime(Date createByTime) {
		this.createByTime = createByTime;
	}
	/**本条记录系统用户修改者ID*/
	public Long getUpdateById() {
		return updateById;
	}
	
	/**本条记录系统用户修改者ID*/
	public void setUpdateById(Long updateById) {
		this.updateById = updateById;
	}
	/**本条记录系统用户修改时间*/
	public Date getUpdateByTime() {
		return updateByTime;
	}
	
	/**本条记录系统用户修改时间*/
	public void setUpdateByTime(Date updateByTime) {
		this.updateByTime = updateByTime;
	}
	/**删除状态位(1有效，0无效，作废的时候表示无效)*/
	public Integer getIsValid() {
		return isValid;
	}
	
	/**删除状态位(1有效，0无效，作废的时候表示无效)*/
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

}

