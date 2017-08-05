package org.whale.pu.attach;

import java.util.HashMap;
import java.util.Map;
import org.whale.system.common.util.Strings;

public class AttachConstant {
	/** 1.保存到硬盘 */
	public static final Integer SAVE_DISK = 1;
	/** 2.保存到FTP */
	public static final Integer SAVE_FTP = 2;
	/** 3.保存到硬盘 和 FTP */
	public static final Integer SAVE_BOTH = 3;
	
	/** 文件类型 1.普通文件 */
	public static final Integer TYPE_FILE = 1;
	/** 文件类型 2.图片 */
	public static final Integer TYPE_IMG = 2;
	/** 文件类型 3.文本 */
	public static final Integer TYPE_TXT = 3;
	/** 文件类型 4.压缩包 */
	public static final Integer TYPE_RAR = 4;
	/** 文件类型 5.安装包 */
	public static final Integer TYPE_EXE = 5;
	/** 文件类型 6.媒体文件 */
	public static final Integer TYPE_MEDIA = 6;
	
	public static HashMap<Integer, String> extMap = new HashMap<Integer, String>();

	static{
		extMap.put(AttachConstant.TYPE_IMG, "gif,jpg,jpeg,png,bmp");
		extMap.put(AttachConstant.TYPE_MEDIA, "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb,swf,flv");
		extMap.put(AttachConstant.TYPE_TXT, "doc,docx,xls,xlsx,ppt,htm,html,txt,java,c");
		extMap.put(AttachConstant.TYPE_EXE, "exe,sh,bat,com,dll");
		extMap.put(AttachConstant.TYPE_RAR, "tar,zip,rar,gz,7z");
	}
	
	/**
	 * 根据文件名判断文件类型
	 * @param type
	 * @return
	 */
	public static Integer parseType(String fileName){
		if(Strings.isBlank(fileName))
			return AttachConstant.TYPE_FILE;
		fileName = fileName.toLowerCase();
		int index = fileName.lastIndexOf(".");
		if(index != -1){
			fileName = fileName.substring(index + 1);
		}
		fileName = fileName.trim();
		for(Map.Entry<Integer, String> entry : extMap.entrySet()){
			if(entry.getValue().indexOf(fileName) != -1){
				return entry.getKey();
			}
		}
		return AttachConstant.TYPE_FILE;
	}
}
