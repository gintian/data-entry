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
		url:'${ctx}/menu/doSave',
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
				$.info("保存成功", function(){
					$.getWinOpener().parent.addNode(obj.datas, $.trim($("#menuName").val()), $("#parentId").val(),$("#menuType").val());
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
			"menuName": {
				validIllegalChar: true,
				maxlength: 64,
				required: true
			},
			"menuUrl": {
				maxlength: 255
			},
			"inco": {
				maxlength: 128
			},
			"orderNo": {
				maxlength: 4
			}
		}
	});
});

function changeMenuType(){
	var val = parseInt($("#menuType").val());
	if(val == 1){
		$("#urlSign").css("visibility", "hidden");
		$("#menuUrl").css("visibility", "hidden").rules("remove","required");
	}else if(val == 2){
		$("#urlSign").css("visibility", "hidden");
		$("#menuUrl").css("visibility", "hidden").rules("remove","required");
	}else if(val == 3){
		$("#urlSign").css("visibility", "visible");
		$("#menuUrl").css("visibility", "visible").rules("add",{"required":true});
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
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>菜单名</td>
							<td class="td-value"><input type="text" style="width:160px;" id="menuName" name="menuName" maxlength="64" title="最多64个字"/></td>
							<td class="td-label" ><span class="required">*</span>所属菜单</td>
							<td class="td-value">
								<tag:tree nodeName="menuName" nodeId="menuId" id="parentId" nodes="${nodes }" nodePId="parentId" value="${parentId }"></tag:tree>
							</td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>菜单类型</td>
							<td class="td-value">
								<select id="menuType" name="menuType" style="width:165px" onchange="changeMenuType()" >
									<option value="1">tab菜单</option>
									<option value="2">文件夹菜单</option>
									<option value="3">叶子菜单</option>
								</select>
							</td>
							<td class="td-label">图标地址</td>
							<td class="td-value"><input type="text" style="width:160px;" id="inco" name="inco" maxlength="128" title="最多128个字"/></td>
							
						</tr>
						<tr>
							<td class="td-label">打开方式</td>
							<td class="td-value">
								<select id="openType" name="openType" style="width:165px">
									<option value="1">窗口内打开</option>
									<option value="2">弹出窗口</option>
								</select>
							</td>
							<td class="td-label">公共菜单</td>
							<td class="td-value" >
								<select id="isPublic" name="isPublic" style="width:165px">
									<option value="0">否</option>
									<option value="1">是</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="td-label"><span class="required" id="urlSign" style="visibility:hidden;">*</span>链接地址</td>
							<td class="td-value"><input type="text" style="width:160px;" id="menuUrl" name="menuUrl" maxlength="255" title="最多255个字"/></td>		
							<td class="td-label">排列顺序</td>
							<td class="td-value" ><input type="text" style="width:160px;" id="orderNo" name="orderNo" value="${nextNum }" onkeyup="value=value.replace(/[^\d]/g,'')" maxlength="4" title="最多4个字"/></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
