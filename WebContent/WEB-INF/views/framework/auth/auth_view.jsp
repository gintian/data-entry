<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
				<input type="hidden" name="authId" value="${item.authId }" />
				<input type="hidden" name="oldAuthCode" value="${item.authCode }" />
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>权限名称</td>
							<td class="td-value">${item.authName }</td>
							<td class="td-label" ><span class="required">*</span>权限编码</td>
							<td class="td-value">
								${item.authCode }
							</td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>所属菜单</td>
							<td class="td-value" colspan="3">
								${menuName }
							</td>
						</tr>
						<tr>
							<td class="td-label" >备注</td>
							<td class="td-value" colspan="3">
								<div style="height:40px;" class="textAreaDiv">${item.remark }</div>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="table-layout-fixed" id="fix_layout_table">
					<thead>
						<tr isHead="1">
							<th style="width: 30px;">序号</th>
							<th style="width: 300px;">链接URL</th>
							<th style="width: 300px;">资源类型</th>
							<th>链接说明</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${resourceList}" varStatus="item_index" var="resource">
						<tr index="${item_index.index+1}">
							<td class="td-seq">${item_index.index+1}</td>
							<td>${resource.url }</td>
							<td >
								<c:if test="${resource.authType == 1 }">公共资源</c:if>
								<c:if test="${resource.authType == 2 }">受控资源</c:if>
								<c:if test="${resource.authType == 3 }">管理员资源</c:if>
							</td>
							<td>${resource.info }</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
