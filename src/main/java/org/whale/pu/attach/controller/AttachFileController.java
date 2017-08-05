package org.whale.pu.attach.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.whale.pu.attach.AttachConstant;
import org.whale.pu.attach.domain.AttachFile;
import org.whale.pu.attach.service.AttachFileService;
import org.whale.pu.attach.utils.FtpUtil;
import org.whale.pu.attach.utils.ZipUtil;
import org.whale.system.auth.annotation.AuthEnum;
import org.whale.system.auth.annotation.AuthUri;
import org.whale.system.cache.service.DictCacheService;
import org.whale.system.common.exception.BusinessException;
import org.whale.system.common.util.Strings;
import org.whale.system.common.util.ThreadContext;
import org.whale.system.common.util.TimeUtil;
import org.whale.system.common.util.WebUtil;
import org.whale.system.controller.BaseController;
import org.whale.system.controller.login.UserContext;

@AuthUri(AuthEnum.PUBLIC)
@Controller
@RequestMapping("/attach")
public class AttachFileController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(AttachFileController.class);
	
	private static final String DISK_BASE_PATH = DictCacheService.getThis().getItemValue("DICT_ATTACH_DISK", "DICT_DISK_BASE_PATH");   //附件根目录(attach/)
	
	private static final String ATTACH_ZIP_PATH = DictCacheService.getThis().getItemValue("DICT_ATTACH_DISK", "DICT_DISK_ZIP_PATH");;     //附件压缩目录(zip_files/)
	
	@Autowired
	private AttachFileService attachFileService;
	@Autowired
	private DictCacheService dictCacheService;
	
	@RequestMapping("/goFileUpload")
	public ModelAndView goFileUpload(HttpServletRequest request, HttpServletResponse response,String businessKey, String processInstanceId, String taskDefinitionKey,String businessTableName, String saveWay, boolean readOnly) {
		//根据流程信息获取对应的文件列表
		List<AttachFile> attachFileList = new ArrayList<AttachFile>();
		if(!StringUtils.isBlank(businessKey)){
			attachFileList = this.attachFileService.getByFlowMsg(businessKey,processInstanceId,taskDefinitionKey,businessTableName);
		}
		return new ModelAndView("pu/attach/attach_file")
				.addObject("businessKey",businessKey)
				.addObject("processInstanceId",processInstanceId)
				.addObject("taskDefinitionKey",taskDefinitionKey)
				.addObject("businessTableName",businessTableName)
				.addObject("saveWay",Strings.isBlank(saveWay) ? AttachConstant.SAVE_DISK : saveWay)
				.addObject("readOnly",readOnly)
				.addObject("list",attachFileList);
	}
	
	/**
	 * 上传文件
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/doFileUpload")
	public void doFileUpload(HttpServletRequest request, HttpServletResponse response) {
		if (!ServletFileUpload.isMultipartContent(request)) {
			WebUtil.printFail(request, response, "请选择文件。");
			return;
		}
		AttachFile attachFile = new AttachFile();
		//流程相关信息
		attachFile.setBusinessKey(request.getParameter("businessKey"));
		attachFile.setProcessInstanceId(request.getParameter("processInstanceId"));
		attachFile.setTaskDefinitionKey(request.getParameter("taskDefinitionKey"));
		attachFile.setBusinessTableName(request.getParameter("businessTableName"));

		Map<String, MultipartFile> fileMap = ((MultipartHttpServletRequest) request).getFileMap();
		if (fileMap == null || fileMap.keySet().size() != 1) {
			WebUtil.printFail(request, response, "只能上传一个文件，请开启自动上传模式");
			return;
		}

		MultipartFile multipartFile = null;
		for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
			try {
				multipartFile = entry.getValue();
				if(multipartFile.getSize() > 100*1024*1024)
					throw new RuntimeException("文件大小超过100M，请重新选择上传！");
				decorateAttachFile(request, multipartFile,attachFile);
				String info = doSaveStream(attachFile, multipartFile, request);
				if (info != null) {
					WebUtil.printFail(request, response, info);
					return;
				}
				this.attachFileService.save(attachFile);
			} catch (Exception e) {
				WebUtil.printFail(request, response, e.getMessage());
				logger.error("保存文件出错" + e.getMessage(), e);
			}
		}

		WebUtil.printSuccess(request, response, attachFile);
		return;
	}
	

	/**
	 * 删除文件和文件记录
	 * 
	 * @param request
	 * @param response
	 * @param attachId
	 */
	@RequestMapping(value = "/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response, Long attachId){
		if (attachId == null) {
			WebUtil.printFail(request, response, "请选择要删除的文件");
			return;
		}
		FtpUtil ftpUtil = null;
		AttachFile attachFile = this.attachFileService.get(attachId);
		try {
			if (attachFile != null) {
				if(attachFile.getSaveWay() == null || AttachConstant.SAVE_DISK.equals(attachFile.getSaveWay())){
					File file = new File(attachFile.getAbsolutePath());
					if(file.exists()){
						file.delete();
					}
				}else if(AttachConstant.SAVE_FTP.equals(attachFile.getSaveWay())){
					if(ftpUtil == null)
						ftpUtil= new FtpUtil(FtpUtil.FtpDictConstant.DICT_FTP_CFG);
					ftpUtil.deleteFile(attachFile.getFilePath());
				}else if(AttachConstant.SAVE_BOTH.equals(attachFile.getSaveWay())){
					//磁盘删除
					File file = new File(attachFile.getAbsolutePath());
					if(file.exists()){
						file.delete();
					}
					//ftp删除
					if(ftpUtil == null)
						ftpUtil= new FtpUtil(FtpUtil.FtpDictConstant.DICT_FTP_CFG);
					ftpUtil.deleteFile(attachFile.getFilePath());
				}
				
				this.attachFileService.delete(attachId);
			}
			WebUtil.printSuccess(request, response);
			
		} catch (Exception e) {
			logger.error("删除文件出错" + e.getMessage(), e);
			WebUtil.printFail(request, response, "删除文件出错" + e.getMessage());
		}finally{
			if (ftpUtil != null)
				ftpUtil.closeConnect();
		}
		
	}

	/**
	 * 下载单个文件
	 * 
	 * @param fileId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/doDownload")
	public void doDownload(Long attachId, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		FtpUtil	ftpUtil = null;
		try {
			AttachFile attachFile = attachFileService.get(attachId);
			if (attachFile.getSaveWay() == null || AttachConstant.SAVE_DISK.equals(attachFile.getSaveWay()) || AttachConstant.SAVE_BOTH.equals(attachFile.getSaveWay())) {
				String fileName = (request.getSession().getServletContext()
						.getRealPath("/") + DISK_BASE_PATH + attachFile.getFilePath())
						.replaceAll("\\\\", "/").replaceAll("//", "/");
				File file = new File(fileName);
				if (file.exists()) {
					WebUtil.downLoad(request, response, attachFile.getRealFileName(), new FileInputStream(file)); 
				}
			}else if(AttachConstant.SAVE_FTP.equals(attachFile.getSaveWay())){
				ftpUtil= new FtpUtil(FtpUtil.FtpDictConstant.DICT_FTP_CFG);
				InputStream is = ftpUtil.download(ftpUtil.getFullPath(attachFile.getFilePath()));
				if(null != is){
					downLoadFtpFile(request, response, attachFile.getRealFileName(), is);
				}
			}
		} catch (Exception e) {
			logger.error("下载文件出错" + e.getMessage(), e);
		}finally{
			if (ftpUtil != null)
				ftpUtil.closeConnect();
		}
		
	}
	
	/**
	 * 下载批量文件
	 * 
	 * @param fileId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/doBatchDownload")
	public void doBatchDownload(String attachIds,Integer saveWay, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if(Strings.isBlank(attachIds)){
			throw new BusinessException("未选择文件进行批量下载");
		}
		FtpUtil	ftpUtil = null;
		try {
			String zipName = TimeUtil.formatTime(new Date(), "yyyyMMddHHmmssS") + ".zip";
			String attachDestName =  (request.getSession().getServletContext()
					.getRealPath("/") + DISK_BASE_PATH + ATTACH_ZIP_PATH + zipName)
					.replaceAll("\\\\", "/").replaceAll("//", "/");
			List<AttachFile> attachFileList = attachFileService.getByAttachIds(attachIds);
			if (saveWay == null || AttachConstant.SAVE_DISK.equals(saveWay) || AttachConstant.SAVE_BOTH.equals(saveWay)) {
				
				ZipUtil.doZip(attachFileList, attachDestName);
				
			}else if(AttachConstant.SAVE_FTP.equals(saveWay)){
				ftpUtil= new FtpUtil(FtpUtil.FtpDictConstant.DICT_FTP_CFG);
				ftpUtil.downloadZip(attachFileList, attachDestName);
			}
			
			File file = new File(attachDestName);
			if (file.exists()) {
				WebUtil.downLoad(request, response, zipName, new FileInputStream(file));
				//删除磁盘存放的压缩文件
				file.delete();
			}
		} catch (Exception e) {
			logger.error("下载文件出错" + e.getMessage(), e);
		}finally{
			if (ftpUtil != null)
				ftpUtil.closeConnect();
		}
	}
	
	// --------------------------------------------------------------------------------------------------

	/**
	 * 从请求中获取上传对象
	 * 
	 * @param request
	 * @param file
	 * @param savePath
	 * @param rootPath
	 * @return
	 */
	public static void decorateAttachFile(HttpServletRequest request, MultipartFile multipartFile, AttachFile attachFile) {
		
		String fileName = getUUID(); 
		String fileRealName = multipartFile.getOriginalFilename();

		String suffix = null;
		int suffixIndex = fileRealName.lastIndexOf(".");
		if (suffixIndex != -1) {
			suffix = fileRealName.substring(suffixIndex + 1);
			fileName += "." + suffix;
		}
		
		/** 文件存放目录 **/
		attachFile.setDirName(TimeUtil.formatTime(new Date(), "yyyy") + File.separatorChar + TimeUtil.formatTime(new Date(), "yyyyMM"));
		/** 上传文件名称* */
		attachFile.setRealFileName(fileRealName);
		/** 上传文件大小* */
		attachFile.setFileSize(multipartFile.getSize());
		/** 上传文件后缀* */
		attachFile.setFileSuffix(suffix);
		/** 文件存储名称* */
		attachFile.setFileName(fileName);
		/** 文件存储时间* */
		attachFile.setCreateTime(new Date());
		/** 文件存储用户ID* */
		attachFile.setCreator(((UserContext)ThreadContext.getContext().get(ThreadContext.KEY_USER_CONTEXT)).getUserId());
		/** 保存方式 * */
		String saveWay = request.getParameter("saveWay");
		attachFile.setSaveWay(Strings.isBlank(saveWay) ? AttachConstant.SAVE_DISK : Integer.parseInt(saveWay));
		/** 文件类型 **/
		attachFile.setFileType(AttachConstant.parseType(fileRealName));
	}

	/**
	 * 保存数据流
	 * 
	 * @param AttachFile
	 * @param request
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	public static String doSaveStream(AttachFile attachFile, MultipartFile multipartFile, HttpServletRequest request) {
		if (AttachConstant.SAVE_DISK.equals(attachFile.getSaveWay())) {
			return save2Disk(attachFile, multipartFile, request);
		} else if (AttachConstant.SAVE_FTP.equals(attachFile.getSaveWay())) {
			return save2Ftp(attachFile, multipartFile, request);
		} else if(AttachConstant.SAVE_BOTH.equals(attachFile.getSaveWay())){
			FtpUtil	ftpUtil = null;
			String saveResult = save2Disk(attachFile, multipartFile, request);
			try {
			    if(null == saveResult){
					ftpUtil= new FtpUtil(FtpUtil.FtpDictConstant.DICT_FTP_CFG);
					return ftpUtil.uploadFile(new File(attachFile.getAbsolutePath()), attachFile.getProcessInstanceId(), attachFile.getFileName()) ? null : "保存文件出错";
				}
			} catch (Exception e) {
				logger.error("保存文件出错" + e.getMessage(), e);
				return e.getMessage();
			}finally{
				if (ftpUtil != null)
					ftpUtil.closeConnect();
			}
		}
		return null;
	}

	/**
	 * 保存硬盘
	 * 
	 * @param AttachFile
	 * @param request
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	public static String save2Disk(AttachFile attachFile, MultipartFile multipartFile, HttpServletRequest request) {
		// 相对路径   
		String relativePath = (attachFile.getDirName() + "/").replaceAll("\\\\", "/").replaceAll("//", "/");
		// 文件保存目录路径
		String affixPath = (request.getSession().getServletContext()
				.getRealPath("/") + DISK_BASE_PATH + relativePath);
		// 保存文件相对路径
		attachFile.setFilePath(relativePath + attachFile.getFileName());
		attachFile.setUrlPath("http://" + request.getLocalAddr() + ":"
				+ request.getLocalPort() + request.getContextPath() + "/"
				+ DISK_BASE_PATH + relativePath + attachFile.getFileName());
		
		attachFile.setAbsolutePath(affixPath + attachFile.getFileName());
		// 创建文件夹
		File dirFile = new File(affixPath);
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}

		File file = new File(affixPath + attachFile.getFileName());
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			logger.error("保存文件出错" + e.getMessage(), e);
			return e.getMessage();
		}
		return null;
	}
	
	/**
	 * 保存到Ftp
	 * 
	 * @param attachFile
	 * @param multipartFile
	 * @param request
	 * @return
	 */
	public static String save2Ftp(AttachFile attachFile, MultipartFile multipartFile, HttpServletRequest request) {
		// ftp对外展示文件相对路径
		String relativePath = (attachFile.getDirName().trim() + "/").replaceAll("\\\\", "/").replaceAll("//", "/");
		String netAddress = DictCacheService.getThis().getItemValue(FtpUtil.FtpDictConstant.DICT_FTP_CFG, FtpUtil.FtpDictConstant.DICT_NET_ADDRESS);
		String ftpUrlPath = DictCacheService.getThis().getItemValue(FtpUtil.FtpDictConstant.DICT_FTP_CFG, FtpUtil.FtpDictConstant.DICT_FTP_URL_PATH);
		if (StringUtils.isBlank(netAddress))
			throw new RuntimeException("字典元素【文件服务器】["
					+ FtpUtil.FtpDictConstant.DICT_NET_ADDRESS + "] 为设置地址");
		netAddress = netAddress.trim();
		if (!netAddress.endsWith("/"))
			netAddress = netAddress + "/";
		if (StringUtils.isNotBlank(ftpUrlPath) && !ftpUrlPath.endsWith("/"))
			ftpUrlPath = ftpUrlPath + "/";
		FtpUtil ftpUtil = null;
		try {
			
			ftpUtil = new FtpUtil(FtpUtil.FtpDictConstant.DICT_FTP_CFG);
			
			attachFile.setFilePath(relativePath + attachFile.getFileName());
			attachFile.setUrlPath(ftpUrlPath + relativePath + attachFile.getFileName());
			attachFile.setAbsolutePath(netAddress+ ftpUtil.getFullPath(relativePath)+ attachFile.getFileName());

			ftpUtil.uploadFile(multipartFile.getInputStream(), relativePath,attachFile.getFileName());

		} catch (Exception e) {
			logger.error("保存文件出错" + e.getMessage(), e);
			return  e.getMessage();
		} finally {
			if (ftpUtil != null)
				ftpUtil.closeConnect();
		}
		return null;
	}
	
	/**
	 * 下载Ftp文件流，输出到客户端
	 * @param request
	 * @param response
	 * @param fileName
	 * @param is
	 */
	public void downLoadFtpFile(HttpServletRequest request, HttpServletResponse response, String fileName, InputStream is){
		OutputStream os = null;
		byte buffer[] = new byte[8192];
		int length = 0;
		try {
			os = new BufferedOutputStream(response.getOutputStream());
			response.reset();
			response.setContentType("application/octet-stream");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename="
					+ URLEncoder.encode(fileName,"utf-8"));
//			response.addHeader("Content-Length", "" + 198265);
            while ((length = is.read(buffer)) != -1) {
				os.write(buffer, 0, length);
			}
			os.flush();
		} catch (Exception e) {
		}finally{
			if(is!=null){
				try {
					is.close();
				} catch (IOException e) {
				}
			}
			if(os!=null){
				try {
					os.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	 /** 
     * 获取UUID作为文件名
     * @return String UUID 
     */ 
    public static String getUUID(){ 
        String uuidStr = UUID.randomUUID().toString(); 
        //去掉“-”符号 
        return uuidStr.substring(0,8)+uuidStr.substring(9,13)+uuidStr.substring(14,18)+uuidStr.substring(19,23)+uuidStr.substring(24); 
    } 
	
}