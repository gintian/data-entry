<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="UTF-8">
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	<link rel="stylesheet" href="${ctx }">
    <title>督办单</title>
    <%@include file="/html/jsp/common.jsp" %>
    <link href="${resource}/css/proposed-style.css" rel="stylesheet" />
    <style>
    	.text{
    		width: 1cm;
    		height: 1cm;
    		display: inline-block;
    		border-bottom: 1px solid #000;
    		vertical-align:bottom;
    	}
    </style>
    <script language="javascript">
	    var hkey_root,hkey_path,hkey_key
	    hkey_root="HKEY_CURRENT_USER"
	    hkey_path="SoftwareMicrosoftInternet ExplorerPageSetup"
	    function pagesetup_null(){
	    	try{
	    		var RegWsh = new ActiveXObject("WScript.Shell")
	    		hkey_key="header" 
	    		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
	    		hkey_key="footer"
	    		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
	    	}catch(e){}
	    }
	    function printProposed(){
	    	pagesetup_null();
	    	var tit = document.title;
	        document.title = "";
	        $("#panelBarDiv").hide();
	        window.print();
	        document.title = tit;
	        $("#panelBarDiv").show();
	    }
	    $(function(){
	    	new ToolBar({items:[
	    		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"},
	    		{id:"printBut", className:"print", func:"printProposed();return false;", text:"打印"}
	    	]});
	    });
    </script>
</head>
<body>
<div class="panelBar" id="panelBarDiv"></div>
<div class="infoBox" id="infoBoxDiv"></div>
<div class="filewrap" style="height: 33.3cm; padding-top: 10cm">
    <div class="file-header">
        <h3 class="file-title">文件办理告知单</h3>
        <p class="file-subline">(${item.recNo})</p>
    </div>
    <div class="file-container">
        <p class="file-content-title"><span class="text" style="width:4cm;"></span>并<span class="text" style="width:2.5cm;"></span>：</p>   
        <p class="file-content"><span class="text"></span>月<span class="text"></span>日，省厅党委委员、副市长，公安局长潘东升在《${item.fileTitle}》（${item.fileCode}）文件上批示：<span class="text" style="width:4.5cm;"></span></p>                  
        <p class="file-content">现将领导批示转给你们，请于<span class="text"></span>月<span class="text"></span>日前将落实情况反馈潘局长。联系人：郝炬，87026166；传真号码：87026009。</p>                  
        <p class="file-content">附件：${item.attachment}</p>                  
    </div>
    <div class="file-footer">
        <div class="file-footerbox">
            <p class="file-footer-infor">市局办公室</p>
            <p class="file-footer-infor"><fmt:formatDate value="${item.recDate}" pattern="yyyy年MM月dd日"/></p>
        </div>
    </div>
    <p class="file-fix">注：领导批示为工作秘密，不得擅自扩散。</p>
</div>

</body>
</html>