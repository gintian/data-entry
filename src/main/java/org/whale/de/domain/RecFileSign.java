package org.whale.de.domain;

import java.util.Date;

import org.whale.system.domain.BaseEntry;
import org.whale.system.jdbc.annotation.Column;
import org.whale.system.jdbc.annotation.Id;
import org.whale.system.jdbc.annotation.Table;

/**
 * 
 *
 * @Date 2017-08-12
 */
@Table(value="DE_REC_FILE_SIGN",cnName="")
public class RecFileSign extends BaseEntry {

	private static final long serialVersionUID = -1410714248140l;
	
	@Id
	@Column(name="PK_REC_FILE_SIGN", cnName="主键")
	private Long pkRecFileSign; 
	
	@Column(name="FK_REC_FILE", cnName="FK收文表")
	private Long fkRecFile; 
	
	@Column(name="FK_ORGANIZATION", cnName="FK机构表，适用于收文管理（公安系统）和（外部系统）（局直单位呈报）")
	private Long fkOrganization; 
	
	@Column(name="SIGN_UP_OTHER", cnName="签收单位（其它）")
	private String signUpOther; 
	
	@Column(name="SIGN_UP", cnName="签收人")
	private String signUp; 
	
	@Column(name="SIGN_TIME", cnName="签收时间")
	private Date signTime; 
	
	@Column(name="SIGN_UP2", cnName="签收人2")
	private String signUp2; 
	
	@Column(name="SIGN_TIME2", cnName="签收时间2")
	private Date signTime2; 
	
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
	public Long getPkRecFileSign() {
		return pkRecFileSign;
	}
	
	/**主键*/
	public void setPkRecFileSign(Long pkRecFileSign) {
		this.pkRecFileSign = pkRecFileSign;
	}
	/**FK收文表*/
	public Long getFkRecFile() {
		return fkRecFile;
	}
	
	/**FK收文表*/
	public void setFkRecFile(Long fkRecFile) {
		this.fkRecFile = fkRecFile;
	}
	/**FK机构表，适用于收文管理（公安系统）和（外部系统）（局直单位呈报）*/
	public Long getFkOrganization() {
		return fkOrganization;
	}
	
	/**FK机构表，适用于收文管理（公安系统）和（外部系统）（局直单位呈报）*/
	public void setFkOrganization(Long fkOrganization) {
		this.fkOrganization = fkOrganization;
	}
	public String getSignUpOther() {
		return signUpOther;
	}

	public void setSignUpOther(String signUpOther) {
		this.signUpOther = signUpOther;
	}

	/**签收人*/
	public String getSignUp() {
		return signUp;
	}
	
	/**签收人*/
	public void setSignUp(String signUp) {
		this.signUp = signUp;
	}
	/**签收时间*/
	public Date getSignTime() {
		return signTime;
	}
	
	/**签收时间*/
	public void setSignTime(Date signTime) {
		this.signTime = signTime;
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

	public String getSignUp2() {
		return signUp2;
	}

	public void setSignUp2(String signUp2) {
		this.signUp2 = signUp2;
	}

	public Date getSignTime2() {
		return signTime2;
	}

	public void setSignTime2(Date signTime2) {
		this.signTime2 = signTime2;
	}

}

