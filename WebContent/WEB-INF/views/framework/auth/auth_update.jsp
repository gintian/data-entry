<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/html/jsp/common.jsp" %>

<script language="javascript">

$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"save", func:"save()", text:"保存"},
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"},
		{id:"addBind", className:"addBind", func:"addTr()", text:"增加URL"}
	]});
});

function save(){
	if(!$("#dataForm").valid()) {return false;}
	toolBar.disableBut("saveBut");
	showAjaxHtml({"wait": true});
	
	var datas = $("#dataForm").serialize();
	$.ajax({
		url:'${ctx}/auth/doUpdate',
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
			"authName": {
				validIllegalChar: true,
				maxlength: 16,
				required: true
			},
			"authCode": {
				validIllegalChar: true,
				maxlength: 64,
				required: true
			},
			"menuId": {
				required: true
			},
			"remark":{
				validIllegalChar: true,
				maxlength: 500
			}
		}
	});
});

function fliterMenuType(treeId, treeNode){
	if(treeNode.menuType != 3)
		return false;
	return true;
}

function changeMenuIcon(){
	var nodes = zNodes_menuId;
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].menuType != 3){
			nodes[i].isParent = true;
		}
	}
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
				<input type="hidden" name="authId" value="${item.authId }" />
				<input type="hidden" name="oldAuthCode" value="${item.authCode }" />
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>权限名称</td>
							<td class="td-value"><input type="text" style="width:160px;" id="authName" name="authName" value="${item.authName }" maxlength="16" title="最多16个字"/></td>
							<td class="td-label" ><span class="required">*</span>权限编码</td>
							<td class="td-value">
								<input type="text" style="width:160px;" id="authCode" name="authCode" value="${item.authCode }" maxlength="64" title="最多64个字"/>
							</td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>所属菜单</td>
							<td class="td-value" colspan="3">
								<tag:tree nodeName="menuName" nodeId="menuId" id="menuId" nodes="${nodes }" nodePId="parentId" value="${item.menuId }" canSelectParent="false" beforeClick="fliterMenuType" beforeLoadTree="changeMenuIcon"></tag:tree>
							</td>
						</tr>
						<tr>
							<td class="td-label" >备注</td>
							<td class="td-value" colspan="3">
								<textarea id="remark" name="remark" rows="5" title="最多只能输入500个字">${item.remark }</textarea>
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
