<%@page import="org.whale.system.common.util.TimeUtil"%>
<%@page import="org.whale.sms.domain.Log"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>查看 日志</title>
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
							<td class="td-label">操作类型</td>
							<td class="td-value">
								<c:if test="${item.opt == 'save' }">新增</c:if>
								<c:if test="${item.opt == 'update' }">修改</c:if>
								<c:if test="${item.opt == 'delete' }">删除</c:if>
								<c:if test="${item.opt == 'saveBatch' }">批量新增</c:if>
								<c:if test="${item.opt == 'updateBatch' }">批量修改</c:if>
								<c:if test="${item.opt == 'deleteBatch' }">批量删除</c:if>
							</td>
							<td class="td-label">对象名称</td>
							<td class="td-value">
								${item.cnName}
							</td>
						</tr>
						<tr>
							<td class="td-label">表名称</td>
							<td class="td-value">
								${item.tableName}
							</td>
							<td class="td-label">ip地址</td>
							<td class="td-value">
								${item.ip}
							</td>
						</tr>
						<tr>
							<td class="td-label">操作人</td>
							<td class="td-value">
								${userName}
							</td>
							<td class="td-label">创建时间</td>
							<td class="td-value">
								<%
									Log log = (Log)request.getAttribute("item");
									out.print(TimeUtil.formatTime(log.getCreateTime(), "yyyy-MM-dd HH:mm:ss"));
								%>
							</td>
						</tr>
						<tr>
							<td class="td-label">uri</td>
							<td class="td-value">
								${item.uri}
							</td>
							<td class="td-label">调用链顺序</td>
							<td class="td-value">
								${item.callOrder}
							</td>
						</tr>
						<tr>
							<td class="td-label">方法耗时</td>
							<td class="td-value">
								${item.methodCostTime}(ms)
							</td>
							<td class="td-label">总耗时</td>
							<td class="td-value">
								${item.costTime}(ms)
							</td>
						</tr>
						<tr>
							<td class="td-label">处理结果</td>
							<td class="td-value" colspan="3">
								<c:if test="${item.rsType == 1 }">正常</c:if>
								<c:if test="${item.rsType == 2 }"><span style="color: red;">系统异常</span></c:if>
								<c:if test="${item.rsType == 3 }"><span style="color: red;">OrmException</span></c:if>
								<c:if test="${item.rsType == 4 }"><span style="color: red;">运行时异常</span></c:if>
								<c:if test="${item.rsType == 5 }"><span style="color: #F6941D;">业务异常</span></c:if>
								<c:if test="${item.rsType == 0 }"><span style="color: red;">未知异常</span></c:if>
							</td>
						</tr>
						<tr>
							<td class="td-label">数据</td>
							<td class="td-value" colspan="3">
								<div style="height:100px;" class="textAreaDiv">${item.datas}</div>
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
