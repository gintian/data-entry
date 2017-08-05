<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改密码</title>
	<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function() {
	new ToolBar({items:[
		{id:"saveBut", className:"save", func:"save()", text:"保存"},
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
	]});
	$("#oldPassword")[0].focus();
});

function save(){
	if(!$("#dataForm").valid()) {return false;}//表单校验

	toolBar.disableBut("saveBut");
	showAjaxHtml({"wait": true});
	
	var datas = $("#dataForm").serialize();
	$.ajax({
		url:'${ctx}/user/doChangePassword',
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
				$.info('修改密码成功，请重新登入！', function(){
					window.top.location.href="${ctx}/";
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
			"oldPassword": {
				validIllegalChar: true,
				maxlength: 12,
				minlength: 6,
				required: true
			},
			"newPassword1": {
				validIllegalChar: true,
				maxlength: 12,
				minlength: 6,
				required: true
			},
			"newPassword2": {
				validIllegalChar: true,
				maxlength: 12,
				minlength: 6,
				required: true,
				equalTo: "#newPassword1"
			}
		},
		messages:{
			"newPassword2": {
				equalTo: "密码不一致"
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
			<form action="" method="post" id="dataForm" enctype="multipart/form-data" >
				<table width="100%">
					<col  width="100"/>
					<col  width="350"/>
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>旧密码</td>
							<td class="td-value"><input type="password" id="oldPassword" name="oldPassword" maxlength="10" style="width:160px;"  title="请输入密码,6~10位."/></td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>新密码</td>
							<td class="td-value"><input type="password" style="width:160px;" id="newPassword1" maxlength="10" name="newPassword1" title="请输入密码,6~10位." /></td>
							
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>确认新密码</td>
							<td class="td-value"><input type="password" style="width:160px;" id="newPassword2" maxlength="10" name="newPassword2" title="请输入密码,6~10位." /></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>