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
@Table(value="DE_ORGANIZATION",cnName="")
public class Organization extends BaseEntry {

	private static final long serialVersionUID = -1410714248140l;
	
	@Id
	@Column(name="PK_ORGANIZATION", cnName="主键")
	private Long pkOrganization; 
	
	@Column(name="DICT_ORG_CATEGORY", cnName="机构类别，字典表：局领导、局直各单位、各分局县（市）区公安局")
	private String dictOrgCategory; 
	
	@Column(name="ORG_COMPANY", cnName="机构单位：驻局纪检组、警务督察支队、办公室、指挥中心、政治部、边防支队、消防支队、警务队等等")
	private String orgCompany; 
	
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
	public Long getPkOrganization() {
		return pkOrganization;
	}
	
	/**主键*/
	public void setPkOrganization(Long pkOrganization) {
		this.pkOrganization = pkOrganization;
	}
	/**机构类别，字典表：局领导、局直各单位、各分局县（市）区公安局*/
	public String getDictOrgCategory() {
		return dictOrgCategory;
	}
	
	/**机构类别，字典表：局领导、局直各单位、各分局县（市）区公安局*/
	public void setDictOrgCategory(String dictOrgCategory) {
		this.dictOrgCategory = dictOrgCategory;
	}
	/**机构单位：驻局纪检组、警务督察支队、办公室、指挥中心、政治部、边防支队、消防支队、警务队等等*/
	public String getOrgCompany() {
		return orgCompany;
	}
	
	/**机构单位：驻局纪检组、警务督察支队、办公室、指挥中心、政治部、边防支队、消防支队、警务队等等*/
	public void setOrgCompany(String orgCompany) {
		this.orgCompany = orgCompany;
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

