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
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>用户名</td>
							<td class="td-value">${item.userName }</td>
							<td class="td-label" ><span class="required">*</span>真实姓名</td>
							<td class="td-value">${item.realName }</td>
						</tr>
						<tr>
							<td class="td-label">联系电话</td>
							<td class="td-value">${item.phone }</td>
							<td class="td-label" >邮箱地址</td>
							<td class="td-value">${item.email }</td>
						</tr>
						<tr>
							<td class="td-label">所属部门</td>
							<td class="td-value">${deptName }</td>
							<td class="td-label">状态</td>
							<td class="td-value">
								<c:if test="${item.status == 2}"><font color="red">禁用 </font></c:if> 
								<c:if test="${item.status == 1}">正常</c:if> 
							</td>
						</tr>
						<tr>
							<td class="td-label">登入时间</td>
							<td class="td-value"><fmt:formatDate value="${item.lastLoginTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class="td-label">登入IP</td>
							<td class="td-value">${item.loginIp }</td>
						</tr>
						<tr>
							<td class="td-label">创建时间</td>
							<td class="td-value"><fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class="td-label">创建人</td>
							<td class="td-value">${creator }</td>
						</tr>
						<tr>
							<td class="td-label" >附加信息</td>
							<td class="td-value" colspan="3">
								<div style="height:40px;" class="textAreaDiv">${item.addOn }</div>
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
			</form>
		</div>
	</div>
</div>
</body>
</html>
