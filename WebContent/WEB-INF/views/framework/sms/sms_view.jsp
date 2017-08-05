<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>查看 短信</title>
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
				<input type="hidden" id="id" name="id" value="${item.id}" />
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%"/>
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">短信内容</td>
							<td class="td-value" colspan="3">
								<div style="height:60px;" class="textAreaDiv">${item.content }</div>
							</td>
						</tr>
						<tr>
							<td class="td-label">接收号码</td>
							<td class="td-value">
								${item.toPhones}
							</td>
							<td class="td-label">创建时间</td>
							<td class="td-value">
								<fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
						<tr>
							<td class="td-label">自定义扩展号</td>
							<td class="td-value">
								${item.encode}
							</td>
							<td class="td-label">定时发送时间</td>
							<td class="td-value">
								${item.sendTime}
							</td>
							
						</tr>
						<tr>
							<td class="td-label">返回状态</td>
							<td class="td-value">
								${item.resStatus}
							</td>
							<td class="td-label">sid</td>
							<td class="td-value">
								${item.sid}
							</td>
						</tr>
						<tr>
							<td class="td-label">返回信息</td>
							<td class="td-value">
								<tag:dict id="S" dictCode="SMS_STATUS_CODE" value="${item.resStatus }" readonly="true"></tag:dict>
							</td>
							<td class="td-label">返回时间</td>
							<td class="td-value">
								<fmt:formatDate value="${item.recTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
						<tr>
							
							<td class="td-label">重发次数</td>
							<td class="td-value">
								${item.retryTime}
							</td>
							<td class="td-label">内容超70忽略</td>
							<td class="td-value">
								${item.overLengthIgnore}
							</td>
						</tr>
						<tr>
							<td class="td-label">是否实时发送</td>
							<td class="td-value">
								${item.sendRealTime}
							</td>
							<td class="td-label">原始id</td>
							<td class="td-value">
								${item.originalId}
							</td>
						</tr>
						<tr>
							<td class="td-label">短信类型</td>
							<td class="td-value">
								${item.smsType}
							</td>
							<td class="td-label">发送状态</td>
							<td class="td-value" colspan="3">
								<c:if test="${item.status == 1}">待发送</c:if>
								<c:if test="${item.status == 2}">发送成功</c:if>
								<c:if test="${item.status == 3}"><font color="red">发送失败</font></c:if>
								<c:if test="${item.status == 4}">忽略</c:if>
							</td>
						</tr>
						<tr>
							<td class="td-label">异常信息</td>
							<td class="td-value" colspan="3">
								<div style="height:140px;" class="textAreaDiv">${item.bisExpInfo }</div>
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
