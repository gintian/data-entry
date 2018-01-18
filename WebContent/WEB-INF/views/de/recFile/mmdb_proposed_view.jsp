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
    	div.formwrap
    	{
    		display:block;
    		line-height:1.2;
    		overflow:hidden;
    		width: 21.8cm;
    		margin: 0 auto;
    		position:absolute; 
    		top:1130px; 
    		left:100px;
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
         <%-- <p class="form-content" <c:if test="${fn:length(item.proposedComments)>500}">style="font-size:.2cm"</c:if>>${item.proposedComments}</p> --%>
         <c:choose>
            	<c:when test="${fn:length(item.proposedComments)<=76}">
					 <p class="form-content form-content-center font-font-song" style="line-height:1.1;">${item.proposedComments}</p>
					 <div class="form-opinion" style="padding-right:2.3cm;padding-top:0.1cm;">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="line-height:1.2;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="line-height:1.2;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:when>
				<c:when test="${fn:length(item.proposedComments)>76 and fn:length(item.proposedComments)<=134}">
					 <p class="form-content form-content-center font-font-song" style="font-size:0.65cm;line-height:1.1;">${item.proposedComments}</p>
					 <div class="form-opinion" style="padding-right:2.3cm;padding-top:0.1cm;">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="font-size:0.65cm;line-height:1.2;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="font-size:0.65cm;line-height:1.2;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:when>
				<c:when test="${fn:length(item.proposedComments)>134 and fn:length(item.proposedComments)<=210}">
					 <p class="form-content form-content-center font-font-song" style="font-size:0.5cm;line-height:1.1;">${item.proposedComments}</p>
					 <div class="form-opinion" style="padding-right:2.3cm;padding-top:0.1cm;">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="font-size:0.5cm;line-height:1.2;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="font-size:0.5cm;line-height:1.2;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:when>
				<c:otherwise>
					 <p class="form-content form-content-center font-font-song" style="font-size:0.4cm;line-height:1.1;">${item.proposedComments}</p>
					 <div class="form-opinion" style="padding-right:2.3cm;padding-top:0.1cm;">
		                <div class="form-opinion-inner">
		                    <p class="form-opinion-text font-font-song" style="font-size:0.4cm;line-height:1.2;">市局办公室</p>
		                    <p class="form-opinion-text font-font-song" style="font-size:0.4cm;line-height:1.2;"><fmt:formatDate value="${item.proposedDate}" pattern="yyyy.MM.dd"/></p>
		                </div>
		            </div>
				</c:otherwise>
			</c:choose>
</div>

</body>
</html>