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
					       		<td class="td-label">发文号</td>
							  	<td class="td-value">
									    	${item.sendNo}
							  </td>
							 </tr>
							 <tr>
					       		<td class="td-label">发文日期</td>
							  	<td class="td-value">
									   		<fmt:formatDate value="${item.sendDate}" pattern="yyyy-MM-dd"/>
							  </td>
							 </tr>
							  <tr>
					       		<td class="td-label">发送单位</td>
							  	<td class="td-value">
									    	${item.sendCompanys}
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
									    	<textarea type="text" readonly="readonly">${item.fileTitle}</textarea>
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
						     <tr>
					       		<td class="td-label">密级编号</td>
							  	<td class="td-value">
									    	${item.denseCode}
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">备注</td>
							  	<td class="td-value">
									    	 <textarea type="text" readonly="readonly">${item.memo}</textarea>
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
