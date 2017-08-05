<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<%request.setAttribute("resource", request.getContextPath()+"/html");%>
<%@include file="/html/jsp/common.jsp" %>

<script type="text/javascript">
	$(function(){
		$('#AjaxTest').click(function(){
			var url = '${ctx}/test/AjaxTest';
			var reqParam = "strB=陈";
			ACF.ajaxForm.post(url,reqParam,function(obj){
				$.info(obj.msg, function(obj){
					
				});
			},function(obj){
				
			});
		});
		
		$('#AjaxExceptionTest').click(function(){
			var url = '${ctx}/test/AjaxExceptionTest';
			var reqParam = {'strB':'陈'};
			ACF.ajaxForm.post(url,reqParam,function(obj){
				$.info(obj.msg, function(obj){
					
				});
			},function(obj){
				console.log(obj);
			});
		});
		
		$('#del_focus').click(function(){
			$('#test').removeAttr("onfocus");
		});
	});
</script>
</head>
<body>
<div class="infoBox" id="infoBoxDiv"></div>
<input type="button" value="test" id="AjaxTest">

<input type="button" value="AjaxExceptionTest" id="AjaxExceptionTest">

<input type="button" value="del focus" id="del_focus"/>

<input type="text" value="test11" id="test" onfocus="alert('1111');"/>
</body>
</html>