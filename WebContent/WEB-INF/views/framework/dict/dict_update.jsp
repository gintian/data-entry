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
		url:'${ctx}/dict/doUpdate',
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
					if($.trim($("#dictName").val()) != "${item.dictName}"){
						$.getWinOpener().parent.updateNode("${item.dictId}", $.trim($("#dictName").val()));
					}
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
			"dictName": {
				validIllegalChar: true,
				maxlength: 64,
				required: true
			},
			"dictCode": {
				validIllegalChar: true,
				maxlength: 32,
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
				<input type="hidden" id="dictId" name="dictId" value="${item.dictId }"/>
				<input type="hidden" id="status" name="status" value="${item.status }"/>
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>字典名</td>
							<td class="td-value"><input type="text" style="width:160px;" id="dictName" name="dictName" value="${item.dictName }" maxlength="64" title="最多64个字"/></td>
							<td class="td-label" ><span class="required">*</span>字典编码</td>
							<td class="td-value">${item.dictCode  }
								<input type="hidden" style="width:160px;" id="dictCode" name="dictCode" value="${item.dictCode }" maxlength="32" title="最多32个字"/>
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
