<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>编辑信息</title>
<%@include file="/html/jsp/common.jsp" %>
<link href="${ctx}/html/css/flowPage.css" rel="stylesheet" />
<script src="${ctx}/html/js/flowPage.js" type="text/javascript"></script>

<script language="javascript">
$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"save", func:"save('saveBut')", text:"保存"},
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
	]});
});

function getActionUrl(actionBtn){
	var bl_hasPk = $('#pkOrganization').val()==''? false : true;
	var bizUrl;
	if(actionBtn == 'saveBut'){//保存按钮触发时,若存在主键为编辑操作;不存在主键为创建任务首环节操作
		bizUrl = bl_hasPk ? '/organization/doUpdate' : '/organization/doSave';		
	}else if(actionBtn == 'submitBut'){
		bizUrl = '/organization/doSubmit';	
	} 
	//模块url + 业务url
	return '${ctx}/de' + bizUrl;
}

function save(actionBtn){
	toolBar.disableBut(actionBtn);
	
	var dataForm = $("#dataForm");
	
	if(!dataForm.valid()) {toolBar.enableBut(actionBtn);return false;}

	var url = getActionUrl(actionBtn);
	
	var disElems = $('[disabled]').removeAttr('disabled');//jq序列化时过滤disabled控件,所以序列化时先enable控件再禁用 
	var datas = dataForm.serialize();
	disElems.attr('disabled','disabled');
	
	ACF.ajaxForm.post(url,datas,function(obj){
		$.info(obj.msg, function(obj){
			$.getWinOpener().grid.reload();
			$.getWindow().close();
		});
	},function(obj){
		toolBar.enableBut(actionBtn);
	});
}

//校验函数
$(function() {
	//1.初始化控件事件
	
	//2.联动控件事件
	
	//3.初始化控件值
	
	//4.各流程环节控件只读、禁用、隐藏配置项
	var dataForm = $('#dataForm');
	var currentFlowNode = $('#flowNode',dataForm).val(); 
	if(!currentFlowNode || currentFlowNode == '') currentFlowNode = 'NODE_RJDFQ';
	
	var nodesDomConf = {
			/*'NODE_RJDFQ':{//入金单发起
				readOnly:[],
				dis:[],
				hidden:[]
			}*/
	}
	
	var validateRules = {
			'dictOrgCategory':{
				required: true
			},
			'orgCompany':{
				required: true
			}
	}
	
	//初始化页面控件只读、禁用、隐藏、验证规则
	//节点-域配置项,验证规则,   点前流程节点,    domContainer
	ACF.FlowFormPage.initDomShowAndValidate(nodesDomConf,validateRules,currentFlowNode,dataForm);
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
					 	<input type="hidden" id="pkOrganization" name="pkOrganization" value="${organization.pkOrganization}" />
					 	<input type="hidden" id="createById" name="createById" value="${organization.createById}" />
					 	<input type="hidden" id="createByTime" name="createByTime" value="<fmt:formatDate value="${organization.createByTime}" type="both"/>" />
				
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="90%"/>
					<tbody>
						     <tr>
					       		<td class="td-label">机构类别</td>
							  	<td class="td-value">
										   <tag:dict id="dictOrgCategory" dictCode="DICT_ORG_CATEGORY" headerLabel="--请选择--" value="${organization.dictOrgCategory}"></tag:dict>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">机构单位</td>
							  	<td class="td-value">
									   	   <input type="text"  id="orgCompany" name="orgCompany" value="${organization.orgCompany}" />
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
