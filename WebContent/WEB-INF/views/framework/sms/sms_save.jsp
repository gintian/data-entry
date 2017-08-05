<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>新增 短信</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"save", func:"save()", text:"保存"},
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
	]});
});

function save(){
	if(!$("#dataForm").valid()) {return false;}
	toolBar.disableBut("saveBut");
	showAjaxHtml({"wait": true});
	
	var datas = $("#dataForm").serialize();
	$.ajax({
		url:'${ctx}/sms/doSave',
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
					$.getWinOpener().grid.reload();
					$.getWindow().close();
				});
	    	}else{
	    		toolBar.enableBut("saveBut");
	    	}
	    }
	 });
}

//校验函数
$(function() {
	$("#dataForm").validate({
		rules: {
			"content": {
				validIllegalChar: true,
				required: true
			},
			"smsType": {
				required: true
			},
			"toPhones": {
				validIllegalChar: true,
				required: true
			}
		}
	});
});

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
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">短信内容</td>
							<td class="td-value" colspan="3">
								<input type="text" id="content" name="content" style="width:560px;" value="${item.content}"   />
							</td>
							
						</tr>
						<tr>
							<td class="td-label">短信类型</td>
							<td class="td-value">
								<input type="text" id="smsType" name="smsType" style="width:160px;" value="${item.smsType}"  onkeyup="value=value.replace(/[^\d]/g,'')" />
							</td>
							<td class="td-label">接收号码</td>
							<td class="td-value">
								<input type="text" id="toPhones" name="toPhones" style="width:160px;" value="${item.toPhones}"   />
							</td>
							
						</tr>
						<tr>
							<td class="td-label">定时发送时间</td>
							<td class="td-value">
								<input type="text" id="sendTime" name="sendTime" style="width:160px;" value="${item.sendTime}"   />
							</td>
							<td class="td-label">自定义扩展号</td>
							<td class="td-value">
								<input type="text" id="encode" name="encode" style="width:160px;" value="${item.encode}"   />
							</td>
							
						</tr>
						<tr>
							<td class="td-label">内容超70忽略</td>
							<td class="td-value">
								<select style="width: 160px" id="overLengthIgnore" name="overLengthIgnore" >
									<option value="true">忽略</option>
									<option value="false">分条发送</option>
								</select>
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
