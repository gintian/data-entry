<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="UTF-8">
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	<link rel="stylesheet" href="${ctx }">
    <title>拟办单</title>
    <%@include file="/html/jsp/common.jsp" %>
    <link href="${resource}/css/proposed-style.css" rel="stylesheet" />
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
<div class="formwrap">
	<span class="form-tag"><tag:dict dictCode="DICT_GRADE" id="dictGrade" value="${item.dictGrade}" readonly="true"></tag:dict></span>
    <h1 class="form-head">福州市公安局文件批办单</h1>
    <ul class="form-subtitle">
        <li>
            <span class="form-title">收文日期：</span>
            <span class="form-content"><fmt:formatDate value="${item.recDate}" pattern="yyyy-MM-dd"/></span>
        </li>
        <li>
            <span class="form-title">收文号：</span>
            <span class="form-content">${item.recNo}</span>
        </li>
    </ul>
    <div class="form-table">
        <ul class="form-row">
            <li>
                <span class="form-title">来文单位：</span>
                <span class="form-content"><tag:dict dictCode="DICT_REC_COMPANY" id="dictRecCompany" value="${item.dictRecCompany}" readonly="true"></tag:dict></span>
            </li>
            <li>
                <span class="form-title">文号：</span>
                <span class="form-content">${item.fileCode}</span>
            </li>
        </ul>
        <div class="form-row form-row-fixtitle">
            <p class="form-title">文件内容：</p>
            <p class="form-content">${item.fileTitle}</p>
        </div>
        <div class="form-row form-row-fixtitle">
            <p class="form-title">局领导批示：</p>
            <p class="form-content">${item.leaderIns}</p>
        </div>
        <div class="form-row form-row-fixtitle">
            <p class="form-title">拟办意见：</p>
            <p class="form-content">${item.proposedComments}</p>
        </div>
        <div class="form-row form-row-fixtitle">
            <p class="form-title">备注：</p>
            <p class="form-content">${item.memo}</p>
        </div>
        <c:if test="${not empty item.handlePres }">
        	<div class="form-row">
	            <p class="form-content form-content-only">此文请于<span class="time"><fmt:formatDate value="${item.handlePres}" pattern="yyyy-MM-dd"/></span>日之前办结，请勿超期。</p>
	        </div>
        </c:if>
    </div>
</div>

</body>
</html>