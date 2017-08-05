package org.whale.pu.attach.utils;
 
import java.io.BufferedInputStream; 
import java.io.File; 
import java.io.FileInputStream; 
import java.io.FileOutputStream; 
import java.io.IOException; 
import java.util.ArrayList;
import java.util.List; 
import java.util.zip.*;

import org.whale.pu.attach.domain.AttachFile;

public class ZipUtil{     
   
    /** 
     * 递归压缩文件 
     * @param source 源路径,可以是文件,也可以目录 
     * @param destinct  目标路径,压缩文件名 
     * @throws IOException 
     */ 
    public static boolean doZip(String source,String destinct){ 
    	boolean b = true;
    	try{
    		List<File> fileList=loadFilename(new File(source));
    		String zipDir = destinct.substring(0,destinct.lastIndexOf("/"));
    		File zipFile = new File(zipDir);
            if (!zipFile.exists()) {  
            	zipFile.mkdirs();
            }  
            ZipOutputStream zos=new ZipOutputStream(new FileOutputStream(new File(destinct))); 
            
            byte[] buffere=new byte[8192]; 
            int length; 
            BufferedInputStream bis; 
            
            for(int i=0;i<fileList.size();i++){ 
                File file=(File) fileList.get(i); 
                String tmp_name = getEntryName(source,file);
                zos.putNextEntry(new ZipEntry(tmp_name)); 
                bis=new BufferedInputStream(new FileInputStream(file)); 
                
                while(true){ 
                    length=bis.read(buffere); 
                    if(length==-1) break; 
                    zos.write(buffere,0,length); 
                } 
                bis.close(); 
                zos.closeEntry(); 
            } 
            zos.close(); 
    	}catch(Exception e){
    		b = false;
    		System.out.println("===========压缩zip文件异常=============");
    		e.printStackTrace();
    	}
    	
    	return b;
    	
    } 
    
    /**
     * 根据文件列表批量导出压缩文件 
     * @param attachFileList
     * @param destinct
     * @return
     */
    public static boolean doZip(List<AttachFile> attachFileList,String destinct){ 
    	boolean b = true;
    	try{
    		String zipDir = destinct.substring(0,destinct.lastIndexOf("/"));
    		File zipFile = new File(zipDir);
            if (!zipFile.exists()) {  
            	zipFile.mkdirs();
            }  
            ZipOutputStream zos=new ZipOutputStream(new FileOutputStream(new File(destinct))); 
            
            byte[] buffere=new byte[8192]; 
            int length; 
            BufferedInputStream bis; 
            
            for(int i=0;i<attachFileList.size();i++){ 
                File file = new File(attachFileList.get(i).getAbsolutePath()); 
                zos.putNextEntry(new ZipEntry(attachFileList.get(i).getFileName())); 
                bis=new BufferedInputStream(new FileInputStream(file)); 
                
                while(true){ 
                    length=bis.read(buffere); 
                    if(length==-1) break; 
                    zos.write(buffere,0,length); 
                } 
                bis.close(); 
                zos.closeEntry(); 
            } 
            zos.close(); 
    	}catch(Exception e){
    		b = false;
    		System.out.println("===========压缩zip文件异常=============");
    		e.printStackTrace();
    	}
    	
    	return b;
    	
    } 
    /** 
     * 递归获得该文件下所有文件名(不包括目录名) 
     * @param file 
     * @return 
     */ 
    private static List<File> loadFilename(File file){ 
        List<File> filenameList=new ArrayList<File>(); 
        if(file.isFile()){ 
            filenameList.add(file); 
        } 
        if(file.isDirectory()){ 
            for(File f:file.listFiles()){ 
                filenameList.addAll(loadFilename(f)); 
            } 
        } 
        return filenameList; 
    } 
    /** 
     * 获得zip entry 字符串 
     * @param base 
     * @param file 
     * @return 
     */ 
    private static String getEntryName(String base,File file){ 
        File baseFile=new File(base); 
        String filename=file.getPath(); 
        //int index=filename.lastIndexOf(baseFile.getName()); 
        if(baseFile.getParentFile().getParentFile()==null) 
            return filename.substring(baseFile.getParent().length()+baseFile.getName().length()+1); 
        return filename.substring(baseFile.getParent().length()+baseFile.getName().length()+2); 
    }     
    
} 

 

 

    
 
