<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <title>管理平台</title>
  <head>
    <script language="javascript" src="${resource}/tool/jquery.js"></script>
    <script type="text/javascript">
    	$(function(){
    		if(window.opener == null){
    			window.top.location = "${ctx}/";
    		}else{
    			window.opener.top.location = "${ctx}/";
    			window.close();
    		}
    	});
    </script>
  </head>
  <body>
  </body>
</html>
