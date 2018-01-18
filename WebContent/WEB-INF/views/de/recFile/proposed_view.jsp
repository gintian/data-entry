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
    <style>
    	.formwrap .form-content1{display:block;line-height:1.1;overflow:hidden}
    	.form-col {
    		height: 1.8cm;
    	}
    	.form-col .form-title {
    		line-height: 1.8cm
    	}
    	.form-col .form-content {
    		height:1.8cm;
    		line-height:0.9cm
    	}
    	.form-col .form-content:after {
    		display: inline-block;
    		vertical-align:middle;
    		height:100%;
    		width:0;
    		content:'';
    	}
    	.form-col .form-vm {
    		display: inline-block;
    		vertical-align:middle;
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
<div class="formwrap">
	<c:if test="${item.isDispatch==1}"><span class="form-tag">急件</span></c:if>
    <h1 class="form-head">福州市公安局文件批办单</h1>
    <ul class="form-subtitle">
        <li>
            <span class="form-title">收文日期：</span>
            <span class="form-content form-font-en"><fmt:formatDate value="${item.recDate}" pattern="yyyy-MM-dd"/></span>
        </li>
        <li>
            <span class="form-title">收文号：</span>
            <span class="form-content form-font-en">${item.recNo}</span>
        </li>
    </ul>
    <div class="form-table">
        <ul class="form-row">
            <li class="form-col">
                <span class="form-title">来文单位：</span>
                <%-- <span class="form-content"><tag:dict dictCode="DICT_REC_COMPANY" id="dictRecCompany" value="${item.dictRecCompany}" readonly="true"></tag:dict></span> --%>
				<span class="form-content"><span class="form-vm">${item.dictRecCompany}</span></span>
            </li>
            <li class="form-col">
                <span class="form-title">文号：</span>
				<span class="form-content"><span class="form-vm">${item.fileCode}</span></span>
            </li>
        </ul>
        <div class="form-row form-row-fixtitle" style="height: 6cm">
            <p class="form-title com-strong">文件内容：</p>
            <c:choose>
            	<c:when test="${fn:length(item.fileTitle)<=80}">
					<p class="form-content com-strong" style="text-align:center;">${item.fileTitle}</p>
				</c:when>
				<c:when test="${fn:length(item.fileTitle)>80 and fn:length(item.fileTitle)<=136}">
					<p class="form-content com-strong" style="text-align:center;font-size:0.8cm;line-height:1.5;">${item.fileTitle}</p>
				</c:when>
				<c:when test="${fn:length(item.fileTitle)>136 and fn:length(item.fileTitle)<=170}">
					<p class="form-content com-strong" style="text-align:center;font-size:0.7cm;line-height:1.3;">${item.fileTitle}</p>
				</c:when>
				<c:when test="${fn:length(item.fileTitle)>170 and fn:length(item.fileTitle)<=240}">
					<p class="form-content com-strong" style="text-align:center;font-size:0.6cm;line-height:1.2;">${item.fileTitle}</p>
				</c:when>
				<c:otherwise>
					<p class="form-content com-strong" style="text-align:center;font-size:0.55cm;line-height:1.1;">${item.fileTitle}</p>
				</c:otherwise>
			</c:choose>
        </div>
        <div class="form-row form-row-fixtitle" style="height: 7cm">
            <p class="form-title com-strong">局领导批示：</p>
            <p class="form-content form-content-center font-font-song">${item.leaderIns}</p>
        </div>
        <div class="form-row form-row-fixtitle" style="height: 10cm">
            <p class="form-title com-strong">拟办意见：</p>
            <c:choose>
            	<c:when test="${fn:length(item.proposedComments)<=56}">
					 <p class="form-content form-content-center font-font-song">${item.proposedComments}</p>
					 <div class="form-opinion">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song">市局办公室</p>
		                    <p class="form-opinion-text font-font-song"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:when>
				<c:when test="${fn:length(item.proposedComments)>56 and fn:length(item.proposedComments)<=158}">
					 <p class="form-content form-content-center font-font-song" style="font-size:0.76cm;line-height:1.5;">${item.proposedComments}</p>
					 <div class="form-opinion">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="font-size:0.76cm;line-height:1.5;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="font-size:0.76cm;line-height:1.5;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:when>
				<c:when test="${fn:length(item.proposedComments)>158 and fn:length(item.proposedComments)<=236}">
					 <p class="form-content form-content-center font-font-song" style="font-size:0.7cm;line-height:1.3;">${item.proposedComments}</p>
					 <div class="form-opinion">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="font-size:0.7cm;line-height:1.3;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="font-size:0.7cm;line-height:1.3;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:when>
				<c:when test="${fn:length(item.proposedComments)>236 and fn:length(item.proposedComments)<=358}">
					 <p class="form-content form-content-center font-font-song" style="font-size:0.6cm;line-height:1.2;">${item.proposedComments}</p>
					 <div class="form-opinion">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="font-size:0.6cm;line-height:1.2;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="font-size:0.6cm;line-height:1.2;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:when>
				<c:otherwise>
					 <p class="form-content form-content-center font-font-song" style="font-size:0.55cm;line-height:1.1;">${item.proposedComments}</p>
					 <div class="form-opinion">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="font-size:0.55cm;line-height:1.1;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="font-size:0.55cm;line-height:1.1;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:otherwise>
			</c:choose>
        </div>
        <div class="form-row form-row-fixtitle">
            <p class="form-title com-strong">备注：</p>
            <p class="form-content form-content-center font-font-song">${item.memo}</p>
        </div>
        <c:if test="${not empty item.handlePres }">
        	<div class="form-row">
	            <p class="form-content form-content-only">此文请于<span class="time"><fmt:formatDate value="${item.handlePres}" pattern="yyyy-MM-dd"/></span>之前办结，请勿超期。</p>
	        </div>
        </c:if>
    </div>
</div>

</body>
</html>