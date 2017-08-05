package org.whale.base;

/*
 * 基础常量类
 */
public class BaseConstant {
	/**
	 * 和易宝同步的字段常量
	 */
	public enum SyncStatus {
		/**和易宝同步的字段-同步失败，易宝返回同步失败等错误信息*/
		SYNC_STATUS_FAILURE(-1),
		/**和易宝同步的字段-未同步，保存本地数据库成功，未发起同步请求*/
		SYNC_STATUS_UNSYNC(1),
		/**和易宝同步的字段-同步中，已发起同步请求，等待易宝返回结果*/
		SYNC_STATUS_SYNCING(2),
		/**和易宝同步的字段-同步成功，易宝返回成功*/
		SYNC_STATUS_SUCCEED(3);
		
		SyncStatus(int value){
			this.value = value;
		}
		private Integer value;
		
		public Integer getValue(){
			return value;
		}
		
	}
	
	
	/**字典常量sys_dict*/
	public enum SysDict {
		/**字典常量sys_dict-系统配置*/
		DICT_SYS_CONF(1),
		/**字典常量sys_dict-豁免地址*/
		DICT_FREE_URL(2),
		/**字典常量sys_dict-文件上传*/
		DICT_FILE(4),
		/**字典常量sys_dict-短信*/
		SMS(5),
		/**字典常量sys_dict-短信返回状态*/
		SMS_STATUS_CODE(6),
		
		/**字典常量sys_dict-资金种类*/
		DICT_AMOUNT_KIND(18),
		/**字典常量sys_dict-计算费用的方式DICT*/
		DICT_CHARGING_TYPE(19),
		/**字典常量sys_dict-结算费用的周期*/
		DICT_CHARGING_CYCLE(20),
		/**字典常量sys_dict-费用计算方式*/
		DICT_CHARGING_CALC_METHOD(21),
		/**字典常量sys_dict-计费规则类型*/
		DICT_RULES_TYPE(22),
		/**字典常量sys_dict-应收应付类型*/
		DICT_RECE_PAY_TYPE(23),
		/**字典常量sys_dict-应收应付款状态*/
		DICT_RECE_PAY_STATUS(24),
		/**字典常量sys_dict-应收应付轨迹状态*/
		DICT_RP_TRACK_STATUS(25),
		/**字典常量sys_dict-收付款方式*/
		DICT_EXCHANGE_MODE(26),
		/**字典常量sys_dict-资金类型*/
		DICT_AMOUNT_TYPE(27),
		/**字典常量sys_dict-业务类型*/
		DICT_BUSINESS_TYPE(28),
		/**字典常量sys_dict-风险等级*/
		DICT_RISK_LEVEL(29),
		/**字典常量sys_dict-客户类型*/
		DICT_CUSTOMER_TYPE(30),
		/**字典常量sys_dict-账户分类*/
		DICT_ACCOUNT_CATEGORY(31),
		/**字典常量sys_dict-证券公司*/
		DICT_SECURITIES_COMPANY(32),
		/**字典常量sys_dict-账号类型*/
		DICT_ACCOUNT_TYPE(33),
		/**字典常量sys_dict-银行名称*/
		DICT_BANK_ID(34),
		/**字典常量sys_dict-资金使用部门*/
		DICT_INVESTMENT_USED(35),
		/**字典常量sys_dict-客户等级*/
		DICT_CUSTOMER_LEVEL(36);
		
		SysDict(int value){
			this.value = (long)value;
		}
		private Long value;
		
		public Long getValue(){
			return (long)value;
		}
    }
	
	/**
	 * 操作来源枚举类型，区分门户或者管理平台
	 */
	public enum OperChannel {
		/**门户*/
		OPER_CHANNEL_PROTAL(1),
		/**管理平台*/
		OPER_CHANNEL_OA(2);
		
		OperChannel(int value){
			this.value = value;
		}
		private int value;
		
		public int getValue(){
			return value;
		}
		
	}
	/**
	 * 默认的操作者枚举，一般是是后台线程
	 * 可以根据需要补充定义
	 */
	public enum OperUser{
		/**门户默认的操作者*/
		OPER_USER_PROTAL_DEFAULT(-1l),
		/**管理平台默认的操作者*/
		OPER_USER_OA_DEFAULT(-2l);
		
		OperUser(Long value){
			this.value = value;
		}
		private Long value;
		
		public Long getValue(){
			return value;
		}
	}
	
	/**
	 * 短信类型
	 * OperUser.OPER_USER_PROTAL_DEFAULT.getValue()
	 */
	public enum SmsType{
		/**业务短信*/
		SMS_TYPE_BIZ(1),
		/**告警短信*/
		SMS_TYPE_ALARM(2);
		
		SmsType(Integer value){
			this.value = value;
		}
		private Integer value;
		
		public Integer getValue(){
			return value;
		}
	}

}
