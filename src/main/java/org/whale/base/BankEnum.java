package org.whale.base;
 
public enum BankEnum {
	BOCO("BOCO","交通银行"),
	CEB("CEB","光大银行"),
	SPDB("SPDB","上海浦东发展银行"),
	ABC("ABC","农业银行"),
	ECITIC("ECITIC","中信银行"),
	CCB("CCB","建设银行"),
	CMBC("CMBC","民生银行"),
	SDB("SDB","平安银行"),
	PSBC("PSBC","中国邮政储蓄"),
	CMBCHINA("CMBCHINA","招商银行"),
	CIB("CIB","兴业银行"),
	ICBC("ICBC","中国工商银行"),
	BOC("BOC","中国银行"),
	BCCB("BCCB","北京银行"),
	GDB("GDB","广发银行"),
	HXB("HXB","华夏银行"),
	XAYHGFYHGS("XAYHGFYHGS","西安市商业银行"),
	SHYH("SHYH","上海银行"),
	TJYH("TJYH","天津市商业银行"),
	SZNCSYYHGFYHGS("SZNCSYYHGFYHGS","深圳农村商业银行"),
	BJNCSYYHGFYHGS("BJNCSYYHGFYHGS","北京农商银行"),
	HZYHGFYHGS("HZYHGFYHGS","杭州市商业银行"),
	KLYHGFYHGS("KLYHGFYHGS","昆仑银行"),
	ZZYH("ZZYH","郑州银行"),
	WZYH("WZYH","温州银行"),
	HKYH("HKYH","汉口银行"),
	NJYHGFYHGS("NJYHGFYHGS","南京银行"),
	XMYHGFYHGS("XMYHGFYHGS","厦门银行"),
	NCYH("NCYH","南昌银行"),
	JISYHGFYHGS("JISYHGFYHGS","江苏银行"),
	HKBEA("HKBEA","东亚银行(中国)"),
	CDYH("CDYH","成都银行"),
	NBYHGFYHGS("NBYHGFYHGS","宁波银行"),
	CSYHGFYHGS("CSYHGFYHGS","长沙银行"),
	HBYHGFYHGS("HBYHGFYHGS","河北银行"),
	GUAZYHGFYHGS("GUAZYHGFYHGS","广州银行");
	 
	private String value;
	private String desc;

	BankEnum(String value, String desc) {
		this.value = value;
		this.desc = desc;
	}

	public String getValue() {
		return value;
	}

	public String getDesc() {
		return desc;
	}

	public static boolean isValue(Integer value) {
		for (BankEnum u : BankEnum.values()) {
			if (value != null && u.getValue().equals(value.toString()))
				return true;
		}
		return false;
	}

	public static boolean isValue(String value) {
		for (BankEnum u : BankEnum.values()) {
			if (u.getValue().equals(value))
				return true;
		}
		return false;
	}
	
	public static BankEnum descOf(String desc) {
		for (BankEnum ft : BankEnum.values()) {
			if (desc != null && ft.getDesc().equals(desc.toString()))
				return ft;
		}
		return null;
	}
	public static BankEnum valueOf(Integer value) {
		for (BankEnum ft : BankEnum.values()) {
			if (value != null && ft.getValue().equals(value.toString()))
				return ft;
		}
		return null;
	}

	public static void main(String[] args) {
		BankEnum bankEnum=BankEnum.valueOf("CCB");
		System.out.println(bankEnum.getDesc());
	}
}