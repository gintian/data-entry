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
    <style>
    	p.form-content 
    	{
    		display:block;
    		line-height:2;
    		overflow:hidden;
    		font-size:.4cm;
    		position:absolute; top:800px; left:100px;
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
         <p class="form-content" style="font-size:<c:if test="${fn:length(item.proposedComments)>500}">.3cm</c:if>">${item.proposedComments}</p>
</div>

</body>
</html>