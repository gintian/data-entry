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
@Table(value="DE_REC_FILE",cnName="")
public class RecFile extends BaseEntry {

	private static final long serialVersionUID = -1410714248140l;
	
	@Id
	@Column(name="PK_REC_FILE", cnName="主键")
	private Long pkRecFile; 
	
	@Column(name="DICT_FILE_SOURCE", cnName="文件来源，字典表：公安系统、外部系统、办公室内部收文、局直单位呈报")
	private String dictFileSource; 
	
	@Column(name="DICT_FILE_CATEGORY", cnName="文件类别，字典表：公文件、机要件、挂号信件、普通信件")
	private String dictFileCategory; 
	
	@Column(name="DICT_REC_COMPANY", cnName="来文单位，字典表：公安部、省公安厅、市委、市政府、市委政法委、市委办公厅、市政府办公厅、市委政法委办公厅、市综治办、市委组织部、市纪委")
	private String dictRecCompany; 
	
	@Column(name="REC_DATE", cnName="收文日期，格式yyyyMMdd")
	private Date recDate; 
	
	@Column(name="REC_NO", cnName="收文号：流水号，自动生成")
	private String recNo; 
	
	@Column(name="FILE_CODE", cnName="文号，比如闽公宗（2017）051号")
	private String fileCode; 
	
	@Column(name="FILE_TITLE", cnName="文件标题")
	private String fileTitle; 
	
	@Column(name="DICT_DENSE", cnName="密级，字典表：非密、秘密、机密、绝密、内部文件")
	private String dictDense; 
	
	@Column(name="DENSE_CODE", cnName="密级编号，只有当选项是秘密或机密或绝密时，才出现密级编号，密级编号不是必填项，也可以填无")
	private String denseCode; 
	
	@Column(name="DICT_GRADE", cnName="等级，字典表：普通，加急，平急，特提")
	private String dictGrade; 
	
	@Column(name="FILE_CNT", cnName="文件数量")
	private Long fileCnt; 
	
	@Column(name="HANDLE_PRES", cnName="办理时效，如果选择了日期，则在超时后自动显示红色，同时用户可以手动点击已办结，然后不显示红色")
	private Date handlePres; 
	
	@Column(name="IS_HANDLE", cnName="是否办结：1是0否，")
	private Integer isHandle; 
	
	@Column(name="IS_PROPOSED", cnName="是否拟办：1是0否")
	private Integer isProposed; 
	
	@Column(name="PROPOSED_COMMENTS", cnName="拟办意见")
	private String proposedComments; 
	
	@Column(name="LEADER_INS", cnName="领导批示")
	private String leaderIns; 
	
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
	public Long getPkRecFile() {
		return pkRecFile;
	}
	
	/**主键*/
	public void setPkRecFile(Long pkRecFile) {
		this.pkRecFile = pkRecFile;
	}
	/**文件来源，字典表：公安系统、外部系统、办公室内部收文、局直单位呈报*/
	public String getDictFileSource() {
		return dictFileSource;
	}
	
	/**文件来源，字典表：公安系统、外部系统、办公室内部收文、局直单位呈报*/
	public void setDictFileSource(String dictFileSource) {
		this.dictFileSource = dictFileSource;
	}
	/**文件类别，字典表：公文件、机要件、挂号信件、普通信件*/
	public String getDictFileCategory() {
		return dictFileCategory;
	}
	
	/**文件类别，字典表：公文件、机要件、挂号信件、普通信件*/
	public void setDictFileCategory(String dictFileCategory) {
		this.dictFileCategory = dictFileCategory;
	}
	/**来文单位，字典表：公安部、省公安厅、市委、市政府、市委政法委、市委办公厅、市政府办公厅、市委政法委办公厅、市综治办、市委组织部、市纪委*/
	public String getDictRecCompany() {
		return dictRecCompany;
	}
	
	/**来文单位，字典表：公安部、省公安厅、市委、市政府、市委政法委、市委办公厅、市政府办公厅、市委政法委办公厅、市综治办、市委组织部、市纪委*/
	public void setDictRecCompany(String dictRecCompany) {
		this.dictRecCompany = dictRecCompany;
	}
	/**收文日期，格式yyyyMMdd*/
	public Date getRecDate() {
		return recDate;
	}
	
	/**收文日期，格式yyyyMMdd*/
	public void setRecDate(Date recDate) {
		this.recDate = recDate;
	}
	/**收文号：流水号，自动生成*/
	public String getRecNo() {
		return recNo;
	}
	
	/**收文号：流水号，自动生成*/
	public void setRecNo(String recNo) {
		this.recNo = recNo;
	}
	/**文号，比如闽公宗（2017）051号*/
	public String getFileCode() {
		return fileCode;
	}
	
	/**文号，比如闽公宗（2017）051号*/
	public void setFileCode(String fileCode) {
		this.fileCode = fileCode;
	}
	/**文件标题*/
	public String getFileTitle() {
		return fileTitle;
	}
	
	/**文件标题*/
	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
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
	/**等级，字典表：普通，加急，平急，特提*/
	public String getDictGrade() {
		return dictGrade;
	}
	
	/**等级，字典表：普通，加急，平急，特提*/
	public void setDictGrade(String dictGrade) {
		this.dictGrade = dictGrade;
	}
	/**文件数量*/
	public Long getFileCnt() {
		return fileCnt;
	}
	
	/**文件数量*/
	public void setFileCnt(Long fileCnt) {
		this.fileCnt = fileCnt;
	}
	/**办理时效，如果选择了日期，则在超时后自动显示红色，同时用户可以手动点击已办结，然后不显示红色*/
	public Date getHandlePres() {
		return handlePres;
	}
	
	/**办理时效，如果选择了日期，则在超时后自动显示红色，同时用户可以手动点击已办结，然后不显示红色*/
	public void setHandlePres(Date handlePres) {
		this.handlePres = handlePres;
	}
	/**是否办结：1是0否，*/
	public Integer getIsHandle() {
		return isHandle;
	}
	
	/**是否办结：1是0否，*/
	public void setIsHandle(Integer isHandle) {
		this.isHandle = isHandle;
	}
	/**是否拟办：1是0否*/
	public Integer getIsProposed() {
		return isProposed;
	}
	
	/**是否拟办：1是0否*/
	public void setIsProposed(Integer isProposed) {
		this.isProposed = isProposed;
	}
	/**拟办意见*/
	public String getProposedComments() {
		return proposedComments;
	}
	
	/**拟办意见*/
	public void setProposedComments(String proposedComments) {
		this.proposedComments = proposedComments;
	}
	/**领导批示*/
	public String getLeaderIns() {
		return leaderIns;
	}
	
	/**领导批示*/
	public void setLeaderIns(String leaderIns) {
		this.leaderIns = leaderIns;
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

