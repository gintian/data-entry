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
	var bl_hasPk = $('#pkSendFile').val()==''? false : true;
	var bizUrl;
	if(actionBtn == 'saveBut'){//保存按钮触发时,若存在主键为编辑操作;不存在主键为创建任务首环节操作
		bizUrl = bl_hasPk ? '/sendFile/doUpdate' : '/sendFile/doSave';		
	}else if(actionBtn == 'submitBut'){
		bizUrl = '/sendFile/doSubmit';	
	} 
	//模块url + 业务url
	return '${ctx}/de' + bizUrl;
}

function save(actionBtn){
	toolBar.disableBut(actionBtn);
	
	var dataForm = $("#dataForm");
	
	if(!dataForm.valid()) {toolBar.enableBut(actionBtn);return false;}
	
	var dictDenseVal = $("#dictDense").val();
	if(dictDenseVal == 'DENSE_MM' || dictDenseVal == 'DENSE_JIM' || dictDenseVal == 'DENSE_JUEM'){
		/* var sendCompanysCnt = $('input[name="organization"]:checked').length + ($('#sendCompanysOther').val() ? 1 : 0);
		var denseCodeCnt = parseInt($('#denseCode').val());
		if(sendCompanysCnt != denseCodeCnt){
			$.alert("密级编号填写有误，请核查发送单位");
			toolBar.enableBut(actionBtn);return false;
		} */
		var denseCode = $('#denseCode').val();
		var patt = /^(\d+)[\-](\d+)$/;
		if(denseCode && !patt.test(denseCode)){
			$.alert("密级编号填写有误");
			toolBar.enableBut(actionBtn);
			return false;
		}
	}
	
	// 处理发送单位sendCompanys
	var sendCompanysId = [];
	$('input[name="organization"]:checked').each(function(){
		sendCompanysId.push($(this).val()); 
	});
	$("#sendCompanys").val(sendCompanysId.join(","));
	
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

function checkAll(obj, str){
	$(':checkbox[oc="'+ str +'"]').prop('checked', obj.checked);
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
			'dictFileCategory':{
				required: true
			},
			'sendDate':{
				required: true
			},
			'fileTitle':{
				required: true
			},
			'dictDense':{
				required: true
			}
	}
	
	//初始化页面控件只读、禁用、隐藏、验证规则
	//节点-域配置项,验证规则,   点前流程节点,    domContainer
	ACF.FlowFormPage.initDomShowAndValidate(nodesDomConf,validateRules,currentFlowNode,dataForm);
	
	$("#dictDense").change(function(){
		var selVal = $(this).children('option:selected').val();
		//只有当选项是秘密或机密或绝密时，才出现密级编号
		if(selVal == 'DENSE_MM' || selVal == 'DENSE_JIM' || selVal == 'DENSE_JUEM'){
			$('#denseCodeTr').show();
		}else{
			$('#denseCodeTr').hide();
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
					 	<input type="hidden" id="pkSendFile" name="pkSendFile" value="${sendFile.pkSendFile}" />
					 	<input type="hidden" id="createById" name="createById" value="${sendFile.createById}" />
					 	<input type="hidden" id="createByTime" name="createByTime" value="<fmt:formatDate value="${sendFile.createByTime}" type="both"/>" />
				
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="90%"/>
					<tbody>
							<tr>
					       		<td class="td-label">发文号</td>
							  	<td class="td-value">
									 <input type="text"  id="sendNo" name="sendNo" value="<c:choose><c:when test="${empty sendFile.sendNo}">${nextSendNo}</c:when><c:otherwise>${sendFile.sendNo}</c:otherwise></c:choose>" readonly="readonly"/>
									   	   
							  </td>
							 </tr>
							 <tr>
					       		<td class="td-label">发文日期</td>
							  	<td class="td-value">
									   	   <input type="text" class="date" id="sendDate" name="sendDate"  onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${sendFile.sendDate}" pattern="yyyy-MM-dd"/>"/>
							  </td>
							 </tr>
							  <tr>
					       		<td class="td-label">发送单位</td>
							  	<td class="td-value">
									   	  <input type="hidden" id="sendCompanys" name="sendCompanys" value="${sendFile.sendCompanys}" />
									   	  <c:set var= "scArr" value=""></c:set>
									   	  <c:if test="${not empty sendFile.sendCompanys }">
									   	  		<c:set var= "scArr" value="${fn:split(sendFile.sendCompanys,',')}"></c:set>
									   	  </c:if>
									   	  <c:forEach items="${organizationMap}" var="map" varStatus="status">
												<tag:dict id="dictOrgCategory" dictCode="DICT_ORG_CATEGORY" readonly="true" value="${map.key}"></tag:dict>：<input type="checkbox" onclick="checkAll(this, '${map.key}')" />全部&nbsp;&nbsp;&nbsp;&nbsp;
										    	<c:forEach items="${map.value}" var="org">
										    		 <input type="checkbox" name="organization" oc="${map.key}" value="${org.pkOrganization}" <c:forEach var="sc" items="${scArr }" begin="0" end="${fn:length(scArr)}"><c:if test="${sc == org.pkOrganization }">checked="checked"</c:if></c:forEach>>${org.orgCompany}</input>&nbsp;&nbsp;&nbsp;&nbsp;
										    	</c:forEach>
										    	<br/><br/>
										    	<%-- <c:if test="${!(fn:length(organizationMap)==status.index+1)}"><br/><br/></c:if> --%>
										  </c:forEach>
										  其他：<input type="text" id="sendCompanysOther" name="sendCompanysOther" value="${sendFile.sendCompanysOther}"/>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文件类别</td>
							  	<td class="td-value">
										   <tag:dict id="dictFileCategory" dictCode="DICT_FILE_CATEGORY_OPT" headerLabel="--请选择--" value="${sendFile.dictFileCategory}"></tag:dict>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文件标题</td>
							  	<td class="td-value">
							  			<textarea type="text"  id="fileTitle" name="fileTitle">${sendFile.fileTitle}</textarea>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文号</td>
							  	<td class="td-value">
									   	   <input type="text"  id="fileCode" name="fileCode" value="${sendFile.fileCode}" />
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">密级</td>
							  	<td class="td-value">
										   <tag:dict id="dictDense" dictCode="DICT_DENSE" headerLabel="--请选择--" value="${sendFile.dictDense}"></tag:dict>
							  </td>
							 </tr>
						      <tr id="denseCodeTr" <c:if test="${empty sendFile.dictDense or sendFile.dictDense=='DENSE_FM' or sendFile.dictDense=='DENSE_NBWJ' }">style="display: none"</c:if>>
					       		<td class="td-label">密级编号</td>
							  	<td class="td-value">
									   	   <input type="text" id="denseCode" name="denseCode" value="${sendFile.denseCode}" /> <span>(格式：数字-数字，例如3-10)</span>
							  </td>
							 </tr>
							 <c:if test="${isDense }">
								 <tr >
						       		<td class="td-label">机要编号</td>
								  	<td class="td-value">
											  <input type="text"  id="confidentialCode" name="confidentialCode" value="${sendFile.confidentialCode}" />
								  </td>
								 </tr>
							 </c:if>
							 <tr>
					       		<td class="td-label">备注</td>
							  	<td class="td-value">
							  			<textarea type="text"  id="memo" name="memo">${sendFile.memo}</textarea>
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
