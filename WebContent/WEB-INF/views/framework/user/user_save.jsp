<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
		url:'${ctx}/user/doSave',
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
			"userName": {
				validIllegalChar: true,
				maxlength: 16,
				required: true
			},
			"password": {
				validIllegalChar: true,
				required: true,
				minlength: 6,
				maxlength: 12,
				validPwd: true
			},
			"repassword": {
				validIllegalChar: true,
				required: true,
				minlength: 6,
				maxlength: 12,
				validPwd: true,
				equalTo: "#password"
			},
			"realName":{
				validIllegalChar: true,
				required: true,
				maxlength: 32
			},
			"phone": {
				validIllegalChar: true,
				required: true,
				isMobile: true,
				maxlength: 11
			},
			"email": {
				validIllegalChar: true,
				maxlength: 32,
				email: true
			},
			"addOn":{
				maxlength: 1024
			},
			"deptId":{
				required: true
			},
			"remark":{
				validIllegalChar: true,
				maxlength: 500
			}
		}
	});
});

function addRoot(){
	zNodes_deptId.push({id:0,pid:null,deptName:"${rootName}"});
}

function filterRoot(treeId,treeNode){
	if(treeNode.id == 0)
		return false;
	return true;
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
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>用户名</td>
							<td class="td-value"><input type="text" style="width:160px;" id="userName" name="userName" maxlength="16" title="最多16个字"/></td>
							<td class="td-label" ><span class="required">*</span>真实姓名</td>
							<td class="td-value"><input type="text" style="width:160px;" id="realName" name="realName" maxlength="32" title="最多32位"/></td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>密码</td>
							<td class="td-value"><input type="password" style="width:160px;" id="password" name="password" maxlength="12" title="最少6位，最多12位"/></td>
							<td class="td-label" ><span class="required">*</span>重复密码</td>
							<td class="td-value"><input type="password" style="width:160px;" id="repassword" name="repassword" maxlength="12" title="最少6位，最多12位"/></td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>联系电话</td>
							<td class="td-value"><input type="text" style="width:160px;" id="phone" name="phone" maxlength="11" onkeyup="value=value.replace(/[^\d]/g,'')" title="最多11个字"/></td>
							<td class="td-label" >邮箱地址</td>
							<td class="td-value"><input type="text" style="width:160px;" id="email" name="email" maxlength="32" title="最多32位"/></td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>所属部门</td>
							<td class="td-value">
								<tag:tree nodeName="deptName" nodeId="id" id="deptId" nodes="${nodes }" nodePId="pid" mulitSel="false" value="${deptId }" beforeLoadTree="addRoot" beforeClick="filterRoot"></tag:tree>
							</td>
							<td class="td-label" >附加信息</td>
							<td class="td-value"><input type="text" style="width:160px;" id="addOn" name="addOn" title="最多只能输入1024个字" maxlength="1024" /></td>
						</tr>
						<tr>
							<td class="td-label" >备注</td>
							<td class="td-value" colspan="3">
								<textarea id="remark" name="remark" rows="5" title="最多只能输入500个字"></textarea>
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
