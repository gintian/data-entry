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
	var bl_hasPk = $('#pkRecFile').val()==''? false : true;
	var bizUrl;
	if(actionBtn == 'saveBut'){//保存按钮触发时,若存在主键为编辑操作;不存在主键为创建任务首环节操作
		bizUrl = bl_hasPk ? '/recFile/doUpdate' : '/recFile/doSave';		
	}else if(actionBtn == 'submitBut'){
		bizUrl = '/recFile/doSubmit';	
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
			'dictFileCategory':{
				required: true
			},
			'dictRecCompany':{
				required: true
			},
			'recDate':{
				required: true
			},
			'fileTitle':{
				required: true
			},
			'dictDense':{
				required: true
			},
			'fileCnt':{
				number:true
			}
	}
	
	//初始化页面控件只读、禁用、隐藏、验证规则
	//节点-域配置项,验证规则,   点前流程节点,    domContainer
	ACF.FlowFormPage.initDomShowAndValidate(nodesDomConf,validateRules,currentFlowNode,dataForm);
	
	var isProposedRadios = $(':radio[name="isProposed"]'); 
	//是否拟办
	isProposedRadios.click(function(){
		var _this = $(this);
		var _val = _this.val();
		if(_val == 0){
			$('#proposedCommentsTr').hide();
		}else if(_val == 1){
			$('#proposedCommentsTr').show();
		}
	});
	
	$("#dictDense").change(function(){
		var selVal = $(this).children('option:selected').val();
		//只有当选项是秘密或机密或绝密时，才出现密级编号
		if(selVal == 'DENSE_MM' || selVal == 'DENSE_JIM' || selVal == 'DENSE_JUEM'){
			$('#denseCodeTr').show();
		}else{
			$('#denseCodeTr').hide();
		}
	});
	
	$('input:checkbox').click(function(){
		if($(this).attr('checked')){
			$(this).nextAll('input').removeAttr("readonly");
		}else{
			$(this).nextAll('input').attr("readonly","readonly");
			//$(this).nextAll('input').val('');
		}
	}); 
	
	var signTr = $('#signTr');
	
	<c:forEach var="rfSign" items="${rfSigns}">
		$(':checkbox[value="${rfSign.fkOrganization}"]',signTr).attr('checked','checked')
				.next('input').val('${rfSign.signUpOther}')
				.next('input').val('${rfSign.signUp}')
				.next('input').val('<fmt:formatDate value="${rfSign.signTime}" pattern="yyyy-MM-dd HH:mm:ss"/>');
	</c:forEach> 
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
					 	<input type="hidden" id="pkRecFile" name="pkRecFile" value="${recFile.pkRecFile}" />
					 	<input type="hidden" id="createById" name="createById" value="${recFile.createById}" />
					 	<input type="hidden" id="createByTime" name="createByTime" value="<fmt:formatDate value="${recFile.createByTime}" type="both"/>" />
				
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="90%"/>
					<tbody>
						     <tr style="display:none">
					       		<td class="td-label">文件来源</td>
							  	<td class="td-value">
										   <tag:dict id="dictFileSource" dictCode="DICT_FILE_SOURCE" headerLabel="--请选择--" value="${recFile.dictFileSource}"></tag:dict>
							  </td>
							 </tr>
							   <tr>
					       		<td class="td-label">收文号</td>
							  	<td class="td-value">
									   	   <input type="text"  id="recNo" name="recNo" value="<c:choose><c:when test="${empty recFile.recNo}">${nextRecNo}</c:when><c:otherwise>${recFile.recNo}</c:otherwise></c:choose>" readonly="readonly"/>
							  </td>
							 </tr>
							  <tr>
					       		<td class="td-label">收文日期</td>
							  	<td class="td-value">
									   	   <input type="text" class="date" id="recDate" name="recDate"  onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${recFile.recDate}" pattern="yyyy-MM-dd"/>"/>
							  </td>
							 </tr>
							 <tr>
					       		<td class="td-label">来文单位</td>
							  	<td class="td-value">
										   <tag:dict id="dictRecCompany" dictCode="DICT_REC_COMPANY" headerLabel="--请选择--" value="${recFile.dictRecCompany}"></tag:dict>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文件类别</td>
							  	<td class="td-value">
										   <tag:dict id="dictFileCategory" dictCode="DICT_FILE_CATEGORY" headerLabel="--请选择--" value="${recFile.dictFileCategory}"></tag:dict>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文件标题</td>
							  	<td class="td-value">
							  				 <textarea type="text"  id="fileTitle" name="fileTitle">${recFile.fileTitle}</textarea>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文号</td>
							  	<td class="td-value">
									   	   <input type="text"  id="fileCode" name="fileCode" value="${recFile.fileCode}" />
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">密级</td>
							  	<td class="td-value">
										   <tag:dict id="dictDense" dictCode="DICT_DENSE" headerLabel="--请选择--" value="${recFile.dictDense}"></tag:dict>
							  </td>
							 </tr>
						     <tr id="denseCodeTr" <c:if test="${empty recFile.dictDense or recFile.dictDense=='DENSE_FM' or recFile.dictDense=='DENSE_NBWJ' }">style="display: none"</c:if>>
					       		<td class="td-label">密级编号</td>
							  	<td class="td-value">
									   	   <input type="text"  id="denseCode" name="denseCode" value="${recFile.denseCode}" />
								 </td>
							 </tr>
						     <tr>
					       		<td class="td-label">等级</td>
							  	<td class="td-value">
										   <tag:dict id="dictGrade" dictCode="DICT_GRADE" headerLabel="--请选择--" value="${recFile.dictGrade}"></tag:dict>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文件数量</td>
							  	<td class="td-value">
									   	   <input type="text"  id="fileCnt" name="fileCnt" value="${recFile.fileCnt}" />
							  </td>
							 </tr>
							 <tr>
					       		<td class="td-label">是否急件</td>
							  	<td class="td-value">
									   	    <input type="radio" name="isDispatch" value="1" <c:if test="${recFile.isDispatch==1 or empty recFile.isDispatch}">  checked="checked"</c:if>>是</input>
										 <input type="radio" name="isDispatch" value="0" <c:if test="${recFile.isDispatch==0}">  checked="checked"</c:if>>否</input>
							  </td>
							 </tr>
						     <%-- <tr>
					       		<td class="td-label">是否办结</td>
							  	<td class="td-value">
									   	   <input type="text"  id="isHandle" name="isHandle" value="${recFile.isHandle}" />
							  </td>
							 </tr> --%>
							 <%-- <c:if  test="${recFile.dictFileSource == 'FILE_SOURCE_GAXT' or recFile.dictFileSource == 'FILE_SOURCE_WBXT'}"> --%>
							     <tr>
						       		<td class="td-label">是否拟办</td>
								  	<td class="td-value">
								  		 <input type="radio" name="isProposed" value="1" <c:if test="${recFile.isProposed==1 or empty recFile.isProposed}">  checked="checked"</c:if>>是</input>
										 <input type="radio" name="isProposed" value="0" <c:if test="${recFile.isProposed==0}">  checked="checked"</c:if>>否</input>
								  </td>
								 </tr>
							     <tr id="proposedCommentsTr">
						       		<td class="td-label">拟办意见</td>
								  	<td class="td-value">
								  			 <textarea type="text"  id="proposedComments" name="proposedComments">${recFile.proposedComments}</textarea>
								  </td>
								 </tr>
								 <tr id="signTr">
									  <td class="td-label">签收单位</td>
									  <td class="td-value">
									  	  <c:set var="index" value="0"></c:set>
									   	  <c:forEach items="${organizationMap}" var="map">
									   	  		<tag:dict id="dictOrgCategory" dictCode="DICT_ORG_CATEGORY" readonly="true" value="${map.key}"></tag:dict>：<br/>
										    	<c:forEach items="${map.value}" var="org">
										    		 <input type="checkbox" name="recFileSigns[${index}].fkOrganization" value="${org.pkOrganization}">${org.orgCompany}</input>
										    		 <input type="text" name="recFileSigns[${index}].signUpOther" <c:if test="${map.key != 'ORG_CATEGORY_QT'}">style="display:none"</c:if>/>&nbsp;&nbsp;
										    		 签收人：<input type="text" name="recFileSigns[${index}].signUp" style="width:100px;height:initial"></input>&nbsp;&nbsp;
										    		 签收时间： <input type="text" class="date" name="recFileSigns[${index}].signTime" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:120px;height:initial"/>
										    		 <br/>
										    		 <c:set var="index" value="${index+1}" />
										    	</c:forEach>
										    	<br/>
										  </c:forEach>
										  
									  </td>
								 </tr>
							<%-- </c:if> --%>
							<%-- <c:if test="${recFile.dictFileSource == 'FILE_SOURCE_BGSNBSW' or recFile.dictFileSource == 'FILE_SOURCE_JZDWCB'}"> --%>
							     <tr>
						       		<td class="td-label">局领导批示</td>
								  	<td class="td-value">
								  	 		<textarea type="text"  id="leaderIns" name="leaderIns">${recFile.leaderIns}</textarea>
								  </td>
								 </tr>
								  <tr>
						       		<td class="td-label">领导签批</td>
								  	<td class="td-value">
								  		 <input type="radio" name="directorOper" value="1" <c:if test="${recFile.directorOper==1 or empty recFile.directorOper}">  checked="checked"</c:if>>局长批示</input>
										 <input type="radio" name="directorOper" value="2" <c:if test="${recFile.directorOper==2}">  checked="checked"</c:if>>局长圈阅</input>
								  </td>
								 </tr>
							 <%-- </c:if> --%>
							  <tr>
					       		<td class="td-label">办理时效</td>
							  	<td class="td-value">
									   	   <input type="text" class="date" id="handlePres" name="handlePres"  onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${recFile.handlePres}" pattern="yyyy-MM-dd"/>"/>
							  </td>
							 </tr>
							 <tr>
					       		<td class="td-label">附件</td>
							  	<td class="td-value">
							  			<textarea type="text"  id="attachment" name="attachment">${recFile.attachment}</textarea>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">备注</td>
							  	<td class="td-value">
							  			<textarea type="text"  id="memo" name="memo">${recFile.memo}</textarea>
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
