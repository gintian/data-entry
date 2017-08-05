package org.whale.pu.attach.utils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.whale.pu.attach.domain.AttachFile;
import org.whale.system.cache.service.DictCacheService;


public class FtpUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(FtpUtil.class);
	/**
	 * 字典元素
	 */
	public final class FtpDictConstant{
		
		public final static String DICT_FTP_CFG = "DICT_FTP_CFG";
		/** 统一域名 */
		public static final String DICT_NET_ADDRESS = "DICT_NET_ADDRESS";
		
		/** 远程 FTP IP */
		public final static String DICT_FTP_REMOTE_IP = "DICT_FTP_REMOTE_IP";
		/** 远程FTP 端口 */
		public final static String DICT_FTP_REMOTE_PORT = "DICT_FTP_REMOTE_PORT";
		/** 远程FTP 账号 */
		public final static String DICT_FTP_REMOTE_USER = "DICT_FTP_REMOTE_USER";
		/** 远程FTP 密码 */
		public final static String DICT_FTP_REMOTE_PASSWORD = "DICT_FTP_REMOTE_PASSWORD";
		/** FTP基础路径 */
		public final static String DICT_FTP_BASE_PATH = "DICT_FTP_BASE_PATH";
		/** 资源服务器图片应用地址 */
		public final static String DICT_FTP_URL_PATH = "DICT_FTP_URL_PATH";
	}
	
	private String server = null;
	private String port = null;
	private String user = null;
	private String pwd = null;

	private String basePath = null;	 //FTP根目录绝对路径  
	
	public FTPClient ftpClient = null;
	
	public FtpUtil(String server, String port, String user, String pwd, String basePath){
		this.server = server;
		this.port = port;
		this.user = user;
		this.pwd = pwd;
		this.basePath = basePath;
		
		formatBasePath();
		this.connectServer();
	}
	
	public FtpUtil(String abstractDictFtp){
		this.server = DictCacheService.getThis().getItemValue(abstractDictFtp, FtpUtil.FtpDictConstant.DICT_FTP_REMOTE_IP);
		this.port = DictCacheService.getThis().getItemValue(abstractDictFtp, FtpUtil.FtpDictConstant.DICT_FTP_REMOTE_PORT);
		this.user = DictCacheService.getThis().getItemValue(abstractDictFtp, FtpUtil.FtpDictConstant.DICT_FTP_REMOTE_USER);
		this.pwd = DictCacheService.getThis().getItemValue(abstractDictFtp, FtpUtil.FtpDictConstant.DICT_FTP_REMOTE_PASSWORD);
		this.basePath = DictCacheService.getThis().getItemValue(abstractDictFtp, FtpUtil.FtpDictConstant.DICT_FTP_BASE_PATH);
		
		formatBasePath();
		this.connectServer();
	}
	
	/**
	 *功能说明: 连接FTP服务器
	 */
	private void connectServer() {
		if (ftpClient == null) {
			try {
				ftpClient = new FTPClient();
				ftpClient.connect(server, Integer.parseInt(port));
				ftpClient.login(user, pwd);
				int reply = ftpClient.getReplyCode();
				ftpClient.setDataTimeout(120000);

				if (!FTPReply.isPositiveCompletion(reply)) {
					ftpClient.disconnect();
					logger.warn("FTP服务器拒绝连接");
					return ;
				}
				logger.info("登录ftp服务器{}成功", server);
			} catch (SocketException e) {
				logger.error("登录ftp服务器 " + server + " 失败,连接超时！"+e.getMessage(), e);
				throw new RuntimeException("登录ftp服务器 " + server + " 失败,连接超时！"+e.getMessage());
			} catch (IOException e) {
				logger.error("登录ftp服务器 " + server + " 失败，FTP服务器无法打开！"+e.getMessage(), e);
				throw new RuntimeException("登录ftp服务器 " + server + " 失败，FTP服务器无法打开！"+e.getMessage());
			}
		}
	}
	
	public void closeConnect() {
		try{
			if(ftpClient != null) {
				ftpClient.logout();
				ftpClient.disconnect();
			}
		}catch (Exception e) {
			logger.error("关闭ftp链接出错"+e.getMessage(), e);
			throw new RuntimeException("关闭ftp链接出错"+e.getMessage());
		}
	}

	
	/**
	 * 递归创建文件夹
	 * @param relativePath
	 * @throws IOException 
	 */
	public void makeDirectory(String relativePath){
		if(StringUtils.isBlank(relativePath))
			return ;
		relativePath =relativePath.trim().replaceAll("//", "/");
		String[] dirNames =  relativePath.split("/");
		
		String dir = this.basePath;
		
		for(String dirName : dirNames){
			if(StringUtils.isNotBlank(dirName)){
				try {
					ftpClient.changeWorkingDirectory(dir);
					dir += dirName.trim()+"/";
					ftpClient.makeDirectory(dir);
				} catch (IOException e) {
					logger.error("创建文件夹 "+dir+" 出错", e);
					throw new RuntimeException("创建文件夹 "+dir+" 出错");
				}
			}
		}
	}
	
	/**
	 * 删除文件夹
	 * @param relativePath
	 * @return
	 */
	public boolean removeDirectory(String relativePath){
		if(StringUtils.isBlank(relativePath)){
			logger.error("不能删除根文件路径");
			return false;
		}
		try {
			ftpClient.removeDirectory(this.getFullPath(relativePath));
		} catch (IOException e) {
			logger.error("删除文件夹 "+relativePath+" 出错", e);
			return false;
		}
		return true;
	}
	
	/**
	 * 删除文件夹
	 * @param relativePath
	 * @param isAll
	 * @return
	 */
	public boolean removeDirectory(String relativePath, boolean isAll){
		if(StringUtils.isBlank(relativePath)){
			logger.error("不能删除根文件路径");
			return false;
		}
		if(!isAll)
			return this.removeDirectory(relativePath);
		
		String fullPath = this.getFullPath(relativePath);
		try {
			FTPFile[] ftpFileArr = ftpClient.listFiles(fullPath);
			if (ftpFileArr == null || ftpFileArr.length == 0)
				return removeDirectory(relativePath);
	
			for (FTPFile ftpFile : ftpFileArr) {
				String name = ftpFile.getName();
				if (ftpFile.isDirectory()) {
					removeDirectory(fullPath + "/" + name, true);
				} else if (ftpFile.isFile()) {
					ftpClient.deleteFile(fullPath + "/" + name);
				} else if (ftpFile.isSymbolicLink()) {
				} else if (ftpFile.isUnknown()) {}
			}
		} catch (IOException e) {
			logger.error("删除文件夹 "+relativePath+" 出错", e);
			return false;
		}
		return this.removeDirectory(relativePath);
	}
	
	/**
	 * 
	 *功能说明: 删除文件
	 *@param relativePath
	 *@return boolean
	 *
	 */
	public boolean deleteFile(String relativePath){
		if(StringUtils.isBlank(relativePath))
			return false;
		try {
			return this.ftpClient.deleteFile(this.getFullPath(relativePath));
		} catch (IOException e) {
			logger.error("删除FTP文件 "+relativePath+" 错误", e);
			return false;
		}
	}
	
	/**
	 * 遍历文件
	 * @param path
	 * @return
	 * @throws IOException
	 */
	public List<String> getFileList(String path) {
		FTPFile[] ftpFiles = null;
		try {
			ftpFiles = ftpClient.listFiles(path);
		} catch (IOException e) {
			logger.error("遍历FTP文件 "+path+" 错误", e);
		}

		List<String> retList = new ArrayList<String>();
		if (ftpFiles == null || ftpFiles.length == 0)
			return retList;
		for (FTPFile ftpFile : ftpFiles) {
			if (ftpFile.isFile()) {
				retList.add(ftpFile.getName());
			}
		}
		return retList;
	}
	
	/**
	 * 根据相对路径获取绝对路径
	 * @param relativePath
	 * @return
	 */
	public String getFullPath(String relativePath){
		if(StringUtils.isBlank(relativePath))
			return this.basePath;
		relativePath = relativePath.trim();
		while(relativePath.startsWith("/")){
			relativePath = relativePath.substring(1);
		}
		return (this.basePath+relativePath).replaceAll("\\\\", "/").replaceAll("//", "/");
	}
	
	/**
	 * 格式化基础路径
	 */
	private void formatBasePath(){
		if(this.basePath == null){
			this.basePath = "/";
		}else{
			this.basePath = this.basePath.trim().replaceAll("\\\\", "/").replaceAll("//", "/");
			if(!this.basePath.startsWith("/")){
				this.basePath = "/"+this.basePath;
			}
			if(!this.basePath.endsWith("/")){
				this.basePath = this.basePath+"/";
			}
		}
	}
	
	/**
	 * 上传单个文件
	 * @param file 文件
	 * @param relativeDir 保存相对目录
	 * @param fileName 文件名
	 * @return
	 */
	public boolean uploadFile(File file, String relativeDir, String fileName) {
		if(!file.exists())
			return false;
		InputStream inputStream = null;
		try {
			inputStream = new FileInputStream(file);
		} catch (FileNotFoundException e) {
			logger.error("文件查找不到",e);
			return false;
		}
		return this.uploadFile(inputStream, relativeDir, fileName);
	}
	
	/**
	 * 上传流到ftp
	 * @param inputStream
	 * @param relativeDir  保存相对目录
	 * @param fileName
	 * @return
	 */
	public boolean uploadFile(InputStream inputStream, String relativeDir, String fileName) {
		if(inputStream == null)
			return false;
		try {
			ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
			ftpClient.enterLocalPassiveMode();
			ftpClient.setFileTransferMode(FTP.STREAM_TRANSFER_MODE);
			ftpClient.setControlEncoding("UTF-8");
			FTPClientConfig conf = new FTPClientConfig(FTPClientConfig.SYST_UNIX);
			conf.setServerLanguageCode("zh");
			
			this.makeDirectory(relativeDir);
			ftpClient.changeWorkingDirectory(this.getFullPath(relativeDir));
			
			logger.info("文件[{}]保存到[{}]",new Object[]{fileName, this.getFullPath(relativeDir)});
			return ftpClient.storeFile(fileName, inputStream);
		} catch (IOException e) {
			logger.error("将流上传到ftp出错"+e.getMessage(), e);
		}finally{
			if(inputStream != null){
				try {
					inputStream.close();
				} catch (IOException e) {
					logger.error("关闭流出错", e);
				}
			}
		}
		return false;
	}
	
	/**
	 * 
	 *功能说明: 上传文件
	 *@param out
	 *@param relativeDir
	 *@param fileName
	 *@return boolean
	 *
	 */
	public boolean uploadFile(ByteArrayOutputStream out, String relativeDir, String fileName) {
		if(out == null)
			return false;
		try {
			byte[] bytes = out.toByteArray();
			InputStream inputStream =  new ByteArrayInputStream(bytes);
			return this.uploadFile(inputStream, relativeDir, fileName);
		} catch (RuntimeException e) {
			logger.error("上传文件错误", e);
		} finally{
			if(out != null)
				try {
					out.close();
				} catch (IOException e) {
					logger.error("关闭流出现异常", e);
				}
		}
		return false;
	}
	
	/**
	 * 单个文件下载
	 * @param remoteFileName
	 * @param localFileName
	 * @return
	 */
	public boolean download(String remoteFileName, String localFileName) {
		boolean flag = false;
		File outfile = new File(localFileName);
		OutputStream oStream = null;
		try {
			oStream = new FileOutputStream(outfile);
			
			FTPClientConfig conf = new FTPClientConfig(FTPClientConfig.SYST_UNIX );
			conf.setServerLanguageCode("zh");
			flag = ftpClient.retrieveFile(remoteFileName, oStream);
			oStream.flush();
		}catch(Exception ex){
			ex.printStackTrace();
			logger.error(ex.getMessage(), ex);
		} finally {
			if (oStream != null) {
				try {
					oStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return flag;
	}
	
	/**
	 * 获取下载文件输入流
	 * @param remoteFileName
	 * @return
	 */
	public InputStream download(String remoteFileName){
		InputStream iStream = null;
		try {
			FTPClientConfig conf = new FTPClientConfig(FTPClientConfig.SYST_UNIX );
			conf.setServerLanguageCode("zh");
			ftpClient.setFileType(FTP.BINARY_FILE_TYPE); 
			iStream = ftpClient.retrieveFileStream(remoteFileName);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
			e.printStackTrace();
		}
		return iStream;
	}
	
	/**
	 * 下载ftp目录文件夹，压缩
	 * @param remoteDir
	 * @param localFileName
	 * @return
	 */
	public boolean downloadZip(String relativeDir, String localZipName) {
		boolean b = true;
		try {
			byte[] buffer = new byte[8192]; 
            int length = 0; 
            InputStream is = null;
			String zipDir = localZipName.substring(0,localZipName.lastIndexOf("/"));
    		File zipFile = new File(zipDir);
            if (!zipFile.exists()) {  
            	zipFile.mkdirs();
            }  
			ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(localZipName)); 
			ftpClient.changeWorkingDirectory(this.getFullPath(relativeDir));
			String[] fileNames = ftpClient.listNames();
			for (int i = 0; i < fileNames.length; i++) { 
                zos.putNextEntry(new ZipEntry(fileNames[i]));
                ftpClient.setFileType(FTP.BINARY_FILE_TYPE); 
                is = ftpClient.retrieveFileStream(fileNames[i]);
                if(null != is){
                	while ((length = is.read(buffer)) != -1) {
                		zos.write(buffer, 0, length);
           			}
                	is.close(); 
                	ftpClient.completePendingCommand();
                	zos.closeEntry(); 
                }
            }
            zos.close(); 
			
		} catch (Exception e) {
			b = false;
			logger.error(e.getMessage(), e);
		} 
		return b;
	}
	
	/**
	 * 批量下载ftp文件
	 * @param attachFileList
	 * @param localZipName
	 * @return
	 */
	public boolean downloadZip(List<AttachFile> attachFileList, String localZipName) {
		boolean b = true;
		try {
			byte[] buffer = new byte[8192]; 
            int length = 0; 
            InputStream is = null;
			String zipDir = localZipName.substring(0,localZipName.lastIndexOf("/"));
    		File zipFile = new File(zipDir);
            if (!zipFile.exists()) {  
            	zipFile.mkdirs();
            }  
			ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(localZipName)); 
//			ftpClient.changeWorkingDirectory(this.getFullPath(relativeDir));
//			String[] fileNames = ftpClient.listNames();
			for (int i = 0; i < attachFileList.size(); i++) { 
                zos.putNextEntry(new ZipEntry(attachFileList.get(i).getFileName()));
                ftpClient.setFileType(FTP.BINARY_FILE_TYPE); 
                is = ftpClient.retrieveFileStream(this.getFullPath(attachFileList.get(i).getFilePath()));
                if(null != is){
                	while ((length = is.read(buffer)) != -1) {
                		zos.write(buffer, 0, length);
           			}
                	is.close(); 
                	ftpClient.completePendingCommand();
                	zos.closeEntry(); 
                }
            }
            zos.close(); 
			
		} catch (Exception e) {
			b = false;
			logger.error(e.getMessage(), e);
		} 
		return b;
	}
	
	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getBasePath() {
		return basePath;
	}

	public void setBasePath(String basePath) {
		this.basePath = basePath;
	}

	public FTPClient getFtpClient() {
		return ftpClient;
	}

	public void setFtpClient(FTPClient ftpClient) {
		this.ftpClient = ftpClient;
	}
	
}
