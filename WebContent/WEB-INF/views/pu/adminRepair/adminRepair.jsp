<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>补录数据</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"save", func:"save()", text:"保存"},
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
	]});
});


function save(){
	toolBar.disableBut("saveBut");
	showAjaxHtml({"wait": true});
	var action = $("#action").val();
	var datas = $("#dataForm").serialize();
	
	$.ajax({
		url:'${ctx}/pu/adminRepair/' + action,
		type: 'post',
		data: datas,
		dataType: 'json',
		cache: false,
		error: function(obj){
			showAjaxHtml({"wait": false, "msg": '保存数据出错~'});
			toolBar.enableBut("saveBut");
	    },
	    success: function(obj){
	    	showAjaxHtml({"wait": false, "msg": obj.msg, "rs": obj.rs});
	    	if(obj.rs){
				$.info(obj.msg, function(){
					toolBar.enableBut("saveBut");
				});
	    	}else{
	    		toolBar.enableBut("saveBut");
	    	}
	    }
	 });
}
</script>
</head>
    
<body>
<div class="body-box-form" >
	<div class="content-form">
		<div class="panelBar" id="panelBarDiv"></div>
		<div class="infoBox" id="infoBoxDiv"></div>
		<div class="edit-form">
			<form action="" method="post" id="dataForm">
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="90%"/>
					<tbody>
						<tr>
				       		<td class="td-label"><span class="required">*</span>ACTION</td>
						  	<td class="td-value">
						  		<input type="text" id="action" name="action" value="" style="width:360px;" />
						 	</td>
						 </tr>
					     <tr>
							<td class="td-label">补录日期</td> 
						 	<td class="td-value">
										   	   <input type="text" id="DATE_BEGIN" name="DATE_BEGIN" title="还款时间" style="width:160px;" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.DATE_BEGIN}"/>
										   	   ~
										   	   <input type="text" id="DATE_END" name="DATE_END" title="还款时间" style="width:160px;" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.DATE_END}"/>
						    </td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
