<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>查看 </title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new ToolBar({items:[
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
	]});
	
	var signTr = $('#signTr');
	
	<c:forEach var="rfSign" items="${rfSigns}">
		$(':checkbox[value="${rfSign.fkOrganization}"]',signTr).attr('checked','checked')
				.next().children('input').val('${rfSign.signUpOther}')
				.parent()
				.next('input').val('${rfSign.signUp}')
				.next('input').val('<fmt:formatDate value="${rfSign.signTime}" pattern="yyyy-MM-dd"/>')
				.next('input').val('${rfSign.signUp2}')
				.next('input').val('<fmt:formatDate value="${rfSign.signTime2}" pattern="yyyy-MM-dd"/>');
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
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="90%"/>
					<tbody>
					
						    <tr>
					       		<td class="td-label">文件来源</td>
							  	<td class="td-value">
											<tag:dict dictCode="DICT_FILE_SOURCE" id="dictFileSource" value="${item.dictFileSource}" readonly="true"></tag:dict>
							  </td>
							 </tr>
							  <tr>
					       		<td class="td-label">收文号</td>
							  	<td class="td-value">
									    	${item.recNo}
							  </td>
							 </tr>
							 <tr>
					       		<td class="td-label">收文日期</td>
							  	<td class="td-value">
									   		<fmt:formatDate value="${item.recDate}" pattern="yyyy-MM-dd"/>
							  </td>
							 </tr>
							  <tr>
					       		<td class="td-label">来文单位</td>
							  	<td class="td-value">
											<%-- <tag:dict dictCode="DICT_REC_COMPANY" id="dictRecCompany" value="${item.dictRecCompany}" readonly="true"></tag:dict> --%>
											${item.dictRecCompany}
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文件类别</td>
							  	<td class="td-value">
											<tag:dict dictCode="DICT_FILE_CATEGORY" id="dictFileCategory" value="${item.dictFileCategory}" readonly="true"></tag:dict>
							  </td>
							 </tr>
							  <tr>
					       		<td class="td-label">文件标题</td>
							  	<td class="td-value">
									    	 <textarea type="text"  id="fileTitle" name="fileTitle" readonly="readonly" style="font-size:14px;">${item.fileTitle}</textarea>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文号</td>
							  	<td class="td-value">
									    	${item.fileCode}
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">密级</td>
							  	<td class="td-value">
											<tag:dict dictCode="DICT_DENSE" id="dictDense" value="${item.dictDense}" readonly="true"></tag:dict>
							  </td>
							 </tr>
							 <c:if test="${item.dictDense=='DENSE_MM' or item.dictDense=='DENSE_JIM' or item.dictDense=='DENSE_JUEM'}">
							     <tr>
						       		<td class="td-label">密级编号</td>
								  	<td class="td-value">
										    	${item.denseCode}
								  </td>
								 </tr>
							 </c:if>
						     <tr>
					       		<td class="td-label">等级</td>
							  	<td class="td-value">
											<tag:dict dictCode="DICT_GRADE" id="dictGrade" value="${item.dictGrade}" readonly="true"></tag:dict>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">文件数量</td>
							  	<td class="td-value">
									    	${item.fileCnt}
							  </td>
							 </tr>
							 <tr>
					       		<td class="td-label">是否急件</td>
							  	<td class="td-value">
									   	    <input type="radio" name="isDispatch" disabled="disabled" value="1" <c:if test="${item.isDispatch==1 or empty item.isDispatch}">  checked="checked"</c:if>>是</input>
										 <input type="radio" name="isDispatch" disabled="disabled" value="0" <c:if test="${item.isDispatch==0}">  checked="checked"</c:if>>否</input>
							  </td>
							 </tr>
						    <%--  <tr>
					       		<td class="td-label">是否办结</td>
							  	<td class="td-value">
									    	${item.isHandle}
							  </td>
							 </tr> --%>
							  <%-- <c:if  test="${recFile.dictFileSource == 'FILE_SOURCE_GAXT' or recFile.dictFileSource == 'FILE_SOURCE_WBXT'}"> --%>
							     <tr>
						       		<td class="td-label">是否拟办</td>
								  	<td class="td-value">
								  		 <input type="radio" disabled="disabled" name="isProposed" value="1" <c:if test="${item.isProposed==1 or empty item.isProposed}">  checked="checked"</c:if>>是</input>
										 <input type="radio" disabled="disabled" name="isProposed" value="0" <c:if test="${item.isProposed==0}">  checked="checked"</c:if>>否</input>
								  </td>
								 </tr>
							     <tr id="proposedCommentsTr" <c:if test="${item.isProposed==0}">style="display: none"</c:if>>
						       		<td class="td-label">拟办意见</td>
								  	<td class="td-value">
								  		 <textarea type="text"  id="proposedComments" name="proposedComments" readonly="readonly">${item.proposedComments}</textarea>
								  </td>
								 </tr>
								 <tr id="signTr" style="display:none">
									  <td class="td-label">签收单位</td>
									  <td class="td-value">
									  	  <c:set var="index" value="0"></c:set>
									   	  <c:forEach items="${organizationMap}" var="map">
									   	  		<tag:dict id="dictOrgCategory" dictCode="DICT_ORG_CATEGORY" readonly="true" value="${map.key}"></tag:dict>：<br/>
									   	  		<c:if test="${map.key != 'ORG_CATEGORY_QT'}">
									   	  			<input type="checkbox" onclick="checkAll(this, '${map.key}')" />全部<br/>
									   	  		</c:if>
										    	<c:forEach items="${map.value}" var="org">
										    		 <input type="checkbox" pid="${map.key}" name="recFileSigns[${index}].fkOrganization" value="${org.pkOrganization}"/><span style="width:180px;text-align:left;display:inline-block;">${org.orgCompany}&nbsp;&nbsp;<input type="text" name="recFileSigns[${index}].signUpOther" style="width:100px;<c:if test="${map.key != 'ORG_CATEGORY_QT'}">display:none</c:if>"/></span>
										    		 签收人：<input type="text" name="recFileSigns[${index}].signUp" style="width:100px;height:initial"></input>&nbsp;&nbsp;
										    		 签收时间： <input type="text" class="date" name="recFileSigns[${index}].signTime" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" style="width:120px;height:initial"/>&nbsp;&nbsp;
										    		 签收人：<input type="text" name="recFileSigns[${index}].signUp2" style="width:100px;height:initial"></input>&nbsp;&nbsp;
										    		 签收时间： <input type="text" class="date" name="recFileSigns[${index}].signTime2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" style="width:120px;height:initial"/>
										    		 <br/>
										    		 <c:set var="index" value="${index+1}" />
										    	</c:forEach>
										    	<br/>
										  </c:forEach>
										  
									  </td>
								 </tr>
								 <tr>
						       		<td class="td-label">是否签收</td>
								  	<td class="td-value">
										   	    <input type="radio" disabled="disabled" name="signUpStatus" value="1" <c:if test="${recFile.signUpStatus==1}">  checked="checked"</c:if>>是</input>
											 <input type="radio" disabled="disabled" name="signUpStatus" value="0" <c:if test="${recFile.signUpStatus==0 or empty recFile.signUpStatus}">  checked="checked"</c:if>>否</input>
								  </td>
								 </tr>
							 <%-- </c:if> --%>
							 <%-- <c:if test="${recFile.dictFileSource == 'FILE_SOURCE_BGSNBSW' or recFile.dictFileSource == 'FILE_SOURCE_JZDWCB'}"> --%>
							     <tr>
						       		<td class="td-label">局领导批示</td>
								  	<td class="td-value">
								  	 <textarea type="text"  id="proposedComments" name="proposedComments" readonly="readonly">${item.leaderIns}</textarea>
								  </td>
								 </tr>
								 <tr>
						       		<td class="td-label">领导签批</td>
								  	<td class="td-value">
								  		 <input type="radio" disabled="disabled" name="directorOper" value="1" <c:if test="${item.directorOper==1 or empty item.directorOper}">  checked="checked"</c:if>>局长批示</input>
										 <input type="radio" disabled="disabled" name="directorOper" value="2" <c:if test="${item.directorOper==2}">  checked="checked"</c:if>>局长圈阅</input>
								  </td>
								 </tr>
							 <%-- </c:if> --%>
							   <tr>
					       		<td class="td-label">办理时效</td>
							  	<td class="td-value">
									   		<fmt:formatDate value="${item.handlePres}" pattern="yyyy-MM-dd"/>
							  </td>
							 </tr>
							  <tr>
					       		<td class="td-label">附件</td>
							  	<td class="td-value">
							  			<textarea type="text"  id="attachment" name="attachment" readonly="readonly">${item.attachment}</textarea>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">备注</td>
							  	<td class="td-value">
							  	 <textarea type="text"  id="proposedComments" name="proposedComments" readonly="readonly">${item.memo}</textarea>
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
