<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<%request.setAttribute("resource", request.getContextPath()+"/html");%>
<%@include file="/html/jsp/common.jsp" %>
<link href="${ctx}/html/css/flowPage.css" rel="stylesheet" />
<script src="${ctx}/html/js/flowPage.js" type="text/javascript"></script>
<style type="text/css">
.cash_BigAmount{
	color: #643699;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	font-weight: bolder;
}

.cash_errorTip{
	color: #666;
	font-size: 12px;
}
</style>
<script type="text/javascript">

	$(function(){
		$('#AjaxTest').click(function(){
			$.getWindow().close();
		});		
	});
	
</script>
</head>
<body>
<div class="infoBox" id="infoBoxDiv"></div>
<input type="button" value="close" id="AjaxTest">


</body>
</html>