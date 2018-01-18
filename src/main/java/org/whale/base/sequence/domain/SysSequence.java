package org.whale.base.sequence.domain;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.whale.system.cache.service.DictCacheService;
import org.whale.system.common.util.SpringContextHolder;
import org.whale.system.domain.BaseEntry;
import org.whale.system.jdbc.annotation.Column;
import org.whale.system.jdbc.annotation.Id;
import org.whale.system.jdbc.annotation.Table;

/**
 * 系统序列
 * @author cxc
 * @date 2015年9月15日 上午10:36:32
 */
@Table(value="SYS_SEQUENCE",cnName="")
public class SysSequence extends BaseEntry {
	
	private static final long serialVersionUID = -1410714248140l;
	
	/**
	 * 序列类型
	 */
	public enum SeqType{
		/** 9楼配置 begin*/
		/**收文序列*/
		//REC_NO(1L, "SW", "MS"), 
		/**发文序列*/
		//SEND_NO(2L, "FW", "MF");
		/** 9楼配置 end*/
		
		/** 10楼配置 begin*/
		/**收文序列*/
		//REC_NO(1L, "SW", "BMS"), 
		/**发文序列*/
		//SEND_NO(2L, "FW", "BMF");
		/** 10楼配置 end*/
		
		/**收文序列*/
		REC_NO(1L, "SW", "MS"), 
		/**发文序列*/
		SEND_NO(2L, "FW", "MF"); 
		
		private Long value;
		private String prefix;
		private String mjPrefix;
		
		SeqType(Long value, String prefix, String mjPrefix){
			this.value = value;
			this.prefix = prefix;
			this.mjPrefix = mjPrefix;
		}

		public Long getValue() {
			return value;
		}
		public String getPrefix(){
			if(this.value == 1L){
				return SpringContextHolder.getBean(DictCacheService.class).getItemValue("DICT_REC_SEND_PREFIX", "PREFIX_REC", "SW");
			}else if(this.value == 2L){
				return SpringContextHolder.getBean(DictCacheService.class).getItemValue("DICT_REC_SEND_PREFIX", "PREFIX_SEND", "FW");
			}
			return prefix;
		}

		public String getMjPrefix() {
			if(this.value == 1L){
				return SpringContextHolder.getBean(DictCacheService.class).getItemValue("DICT_REC_SEND_PREFIX", "PREFIX_REC_DENSE", "MS");
			}else if(this.value == 2L){
				return SpringContextHolder.getBean(DictCacheService.class).getItemValue("DICT_REC_SEND_PREFIX", "PREFIX_SEND_DENSE", "MF");
			}
			return mjPrefix;
		}
	}
	
	/**
	 * 序列锁
	 * key 序列类型
	 * value 类型对应序列锁
	 */
	public static final Map<Long, Object> SEQ_LOCK = new HashMap<Long, Object>(2);
	static{
		SEQ_LOCK.put(SeqType.REC_NO.getValue(), new Object());
		SEQ_LOCK.put(SeqType.SEND_NO.getValue(), new Object());
	}
	
	@Id
	@Column(name="PK_SYS_SEQUENCE", cnName="主键")
	private Long pkSysSequence; 
	
	@Column(name="CUR_DATE", cnName="当前日期")
	private Date curDate; 
	
	@Column(name="CURRENT_VALUE", cnName="当前值")
	private Long currentValue; 
	
	@Column(name="SEQ_TYPE", cnName="序列号类型 1:收文号序列,2:发文号序列")
	private Long seqType; 
	
	@Column(name="CACHED_SIZE", cnName="缓存大小")
	private Long cachedSize; 
	
	@Column(name="REMARKS", cnName="备注")
	private String remarks; 

	public Long getPkSysSequence() {
		return pkSysSequence;
	}

	public void setPkSysSequence(Long pkSysSequence) {
		this.pkSysSequence = pkSysSequence;
	}

	/**当前值*/
	public Long getCurrentValue() {
		return currentValue;
	}
	
	/**当前值*/
	public void setCurrentValue(Long currentValue) {
		this.currentValue = currentValue;
	}
	public Long getSeqType() {
		return seqType;
	}
	
	public void setSeqType(Long seqType) {
		this.seqType = seqType;
	}
	/**缓存大小*/
	public Long getCachedSize() {
		return cachedSize;
	}
	
	/**缓存大小*/
	public void setCachedSize(Long cachedSize) {
		this.cachedSize = cachedSize;
	}
	/**备注*/
	public String getRemarks() {
		return remarks;
	}
	
	/**备注*/
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getCurDate() {
		return curDate;
	}

	public void setCurDate(Date curDate) {
		this.curDate = curDate;
	}
	
}

