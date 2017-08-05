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
		url:'${ctx}/resource/doUpdate',
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
			"roleName": {
				validIllegalChar: true,
				maxlength: 16,
				required: true
			},
			"roleCode": {
				validIllegalChar: true,
				maxlength: 64,
				required: true
			},
			"remark":{
				validIllegalChar: true,
				maxlength: 500
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
				<input type="hidden" id="resId" name="resId" value="${item.resId }" />
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="20%"/>
					<col/>
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>资源URL</td>
							<td class="td-value">${item.url }</td>
						</tr>
						<tr>
							<td class="td-label" >所属权限</td>
							<td class="td-value">
								<tag:tree nodeName="name" nodeId="id" id="authId" nodes="${nodes }" nodePId="pid" canSelectParent="false" value="${item.authId }"></tag:tree>
							</td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>受控类型</td>
							<td class="td-value">
								<select id="authType" name="authType" style="width: 160px;">
									<option value="1" <c:if test="${item.authType == 1 }">selected="selected"</c:if> >公共资源</option>
									<option value="2" <c:if test="${item.authType == 2 }">selected="selected"</c:if> >受控资源</option>
									<option value="3" <c:if test="${item.authType == 3 }">selected="selected"</c:if> >管理员资源</option>
								</select>
							
							</td>
						</tr>
						<tr>
							<td class="td-label" >备注</td>
							<td class="td-value">
								<textarea id="info" name="info" rows="5" title="最多只能输入500个字">
									${remark }
								</textarea>
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
