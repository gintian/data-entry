<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/html/jsp/common.jsp" %>

<script language="javascript">
$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"a3", func:"update()", text:"修改"}
	]});
});

function update(menuId){
	$.openWin({url: "${ctx}/menu/goUpdate?menuId=${item.menuId}&view=1","title":'编辑菜单'});
}
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
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>菜单名</td>
							<td class="td-value">${item.menuName }</td>
							<td class="td-label" ><span class="required">*</span>所属菜单</td>
							<td class="td-value">
								${parentName }
							</td>
						</tr>
						<tr>
							<td class="td-label"><span class="required">*</span>菜单类型</td>
							<td class="td-value">
								<c:if test="${item.menuType == 1}">tab菜单</c:if>
								<c:if test="${item.menuType == 2}">文件夹菜单</c:if>
								<c:if test="${item.menuType == 3}">叶子菜单</c:if>
							</td>
							<td class="td-label"><span class="required">*</span>打开方式</td>
							<td class="td-value">
								<c:if test="${item.openType == 1}">窗口内打开</c:if>
								<c:if test="${item.openType == 2}">弹出窗口</c:if>
							</td>
						</tr>
						<tr>
							<td class="td-label">链接地址</td>
							<td class="td-value">${item.menuUrl }</td>
							<td class="td-label">图标地址</td>
							<td class="td-value">${item.inco }</td>
						</tr>
						<tr>
							<td class="td-label">展开状态</td>
							<td class="td-value">
							<c:if test="${item.openState == 1}">收缩</c:if>
							<c:if test="${item.openState == 2}">展开</c:if>
							</td>
							<td class="td-label">排列顺序</td>
							<td class="td-value">${item.orderNo }</td>
						</tr>
						<tr>
							<td class="td-label">公共菜单</td>
							<td class="td-value" colspan="3">
									<c:if test="${item.isPublic != 1}">否</c:if>
									<c:if test="${item.isPublic == 1}">是</c:if>
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
