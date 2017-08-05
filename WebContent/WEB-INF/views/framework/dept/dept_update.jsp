<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>更新 部门</title>
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
		url:'${ctx}/dept/doUpdate',
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
					$.getWinOpener().parent.location.href="${ctx}/dept/goTree?clkId=${item.pid}"
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
			"deptName": {
				validIllegalChar: true,
				required: true,
				maxlength: 64
			},
			"deptCode": {
				validIllegalChar: true,
				required: true,
				maxlength: 32
			},
			"orderNo": {
				maxlength: 4
			},
			"remark": {
				maxlength: 256
			},
			"pid": {
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
				<input type="hidden" id="id" name="id" value="${item.id}" />
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">父部门</td>
							<td class="td-value">
								<c:if test="${empty pName }">
									${rootName }
								</c:if>
								<c:if test="${!empty pName }">
								${pName }
								</c:if>
								<input type="hidden" id="pid" name="pid" style="width:160px;" value="${item.pid}" />
							</td>
							<td class="td-label"><span class="required">*</span>部门名称</td>
							<td class="td-value">
								<input type="text" id="deptName" name="deptName" style="width:160px;" value="${item.deptName}" maxlength="64" title="最多64字"  />
							</td>
							
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>部门编码</td>
							<td class="td-value">
								<input type="text" id="deptCode" name="deptCode" style="width:160px;" value="${item.deptCode}" maxlength="32" title="最多32字"  />
							</td>
							<td class="td-label">排序</td>
							<td class="td-value">
								<input type="text" id="orderNo" name="orderNo" style="width:160px;" value="${item.orderNo}" maxlength="4" title="最多4字" onkeyup="value=value.replace(/[^\d]/g,'')" />
							</td>
						</tr>
						<tr>
							<td class="td-label">联系电话</td>
							<td class="td-value">
								<input type="text" id="deptTel" name="deptTel" style="width:160px;" value="${item.deptTel}" maxlength="32" title="最多32字"  />
							</td>
							<td class="td-label">联系地址</td>
							<td class="td-value">
								<input type="text" id="deptAddr" name="deptAddr" style="width:160px;" value="${item.deptAddr}" maxlength="128" title="最多128字"  />
							</td>
						</tr>
						<tr>
							<td class="td-label">备注</td>
							<td class="td-value" colspan="3">
								<textarea rows="4" cols="2" name="remark" id="remark" title="最多只能输入256个字">${item.remark}</textarea>
							</td>
						</tr>
						<tr>
							
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
