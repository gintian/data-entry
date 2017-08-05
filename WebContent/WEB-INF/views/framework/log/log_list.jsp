<%@page import="org.whale.system.common.util.TimeUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>日志列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function view(id){
	$.openWin({url: "${ctx}/log/goView?id="+id,"title":'查看日志'});
}
</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/log/goList" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="8%" />
						<col  width="25%"/>
						<col  width="8%" />
						<col  width="25%"/>
						<col  width="8%" />
						<col  width="25%"/>
					<tbody>
						<tr>
							<td class="td-label">操作类型</td>
							<td class="td-value">
								<select id="opt" name="opt" style="width: 165px;">
									<option value="">--请选择--</option>
									<option value="save" <c:if test="${item.opt == 'save' }">selected="selected"</c:if> >新增</option>
									<option value="update" <c:if test="${item.opt == 'update' }">selected="selected"</c:if> >修改</option>
									<option value="delete" <c:if test="${item.opt == 'delete' }">selected="selected"</c:if> >删除</option>
									<option value="saveBatch" <c:if test="${item.opt == 'saveBatch' }">selected="selected"</c:if> >批量新增</option>
									<option value="updateBatch" <c:if test="${item.opt == 'updateBatch' }">selected="selected"</c:if> >批量修改</option>
									<option value="deleteBatch" <c:if test="${item.opt == 'deleteBatch' }">selected="selected"</c:if> >批量删除</option>
								</select>
							</td>
							
							<td class="td-label">表名称</td>
							<td class="td-value">
								<input type="text" id="tableName" name="tableName" style="width:160px;" value="${item.tableName}" />
							</td>
							<td class="td-label">uri</td>
							<td class="td-value">
								<input type="text" id="uri" name="uri" style="width:160px;" value="${item.uri}" />
							</td>
						</tr>
						<tr>
							<td class="td-label">操作人</td>
							<td class="td-value">
								<tag:tree nodeName="name" nodeId="id" id="creator" nodes="${nodes }" nodePId="pid" value="${item.creator }" canSelectParent="false"></tag:tree>
							</td>
							<td class="td-label">操作时间</td>
							<td class="td-value" colspan="3">
								<input type="text" style="width:160px;" id="startTime" name="startTime" class="i-date" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,maxDate:'#F{$dp.$D(\'endTime\')}'})"  value="${startTime }"/>
								至
								<input type="text" style="width:160px;" id="endTime" name="endTime" class="i-date" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,minDate:'#F{$dp.$D(\'startTime\')}'})" value="${endTime }"/>
							</td>
							
						</tr>
						<tr>
							<td colspan="6" class="td-btn">
								<div class="sch_qk_con"> 
									<input onclick="grid.goPage(1);"  class="i-btn-s" type="button"  value="检索"/>
									<input onclick="grid.clearForm();"  class="i-btn-s" type="button"  value="清空"/>
								</div>
						  	</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div><!--query-form-->
		<div class="pageContent">
			<div class="content-list">
				<table cellpadding="0" cellspacing="0" id="gridTable">
					<col width="3%"/>
					<col width="6%"/>
					<col />
					<col />
					<col width="7%"/>
					<col width="8%"/>
					<col />
					<col width="6%"/>
					<col width="9%"/>
					<col />
					<col width="8%"/>
					<col width="9%"/>
					<thead>
						<tr>
							<th>
								序号
							</th>
							<th>
								操作
							</th>
							<th>
								对象名称
							</th>
							<th>
								表名称
							</th>
							<th>
								方法耗时(ms)
							</th>
							<th>
								调用耗时(ms)
							</th>
							<th>
								uri
							</th>
							<th>
								操作类型
							</th>
							<th>
								ip地址
							</th>
							<th>
								创建时间
							</th>
							<th>
								操作人
							</th>
							<th>
								结果
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${page.datas}"  varStatus="item_index">
						<tr >
							<td class="td-seq">
								${item_index.index+1}
							</td>
							<td class="td-center">
								<a href="#" onclick="view('${item.id }')">查看</a>
							</td>
							<td title="${item.cnName}">
								${item.cnName}
							</td>
							<td title="${item.tableName}">
								${item.tableName}
							</td>
							<td title="${item.methodCostTime}">
								${item.methodCostTime}
							</td>
							<td title="${item.costTime}">
								${item.costTime}
							</td>
							<td title="${item.uri}">
								${item.uri}
							</td>
							<td title="${item.opt}">
								<c:if test="${item.opt == 'save' }">新增</c:if>
								<c:if test="${item.opt == 'update' }">修改</c:if>
								<c:if test="${item.opt == 'delete' }">删除</c:if>
								<c:if test="${item.opt == 'saveBatch' }">批量新增</c:if>
								<c:if test="${item.opt == 'updateBatch' }">批量修改</c:if>
								<c:if test="${item.opt == 'deleteBatch' }">批量删除</c:if>
							</td>
							<td title="${item.ip}">
								${item.ip}
							</td>
							<td>
								<%
									Map<String, Object> map = (Map<String, Object>)pageContext.getAttribute("item");
									Long createTime = Long.parseLong(map.get("createTime").toString());
											
									out.print(TimeUtil.formatTime(createTime, "yyyy-MM-dd HH:mm:ss"));
								%>
							</td>
							<td title="${item.realName}">
								${item.realName}
							</td>
							<td >
								<c:if test="${item.rsType == 1 }">正常</c:if>
								<c:if test="${item.rsType == 2 }"><span style="color: red;">系统异常</span></c:if>
								<c:if test="${item.rsType == 3 }"><span style="color: red;">OrmException</span></c:if>
								<c:if test="${item.rsType == 4 }"><span style="color: red;">运行时异常</span></c:if>
								<c:if test="${item.rsType == 5 }"><span style="color: #F6941D;">业务异常</span></c:if>
								<c:if test="${item.rsType == 0 }"><span style="color: red;">未知异常</span></c:if>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<%@include file="/html/jsp/pager.jsp" %>
		</div> 
	</div>
</body>
</html>