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
					       		<td class="td-label">机构类别</td>
							  	<td class="td-value">
											<tag:dict dictCode="DICT_ORG_CATEGORY" id="dictOrgCategory" value="${item.dictOrgCategory}" readonly="true"></tag:dict>
							  </td>
							 </tr>
						     <tr>
					       		<td class="td-label">机构单位</td>
							  	<td class="td-value">
									    	${item.orgCompany}
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
