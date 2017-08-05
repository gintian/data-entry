<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 每个流程页面需静态include该页面片段 -->

<tr id="workflowComment_tr">
 	<td class="td-label">审批意见</td>
 	<td class="td-value">
 		<textarea id="workflowComment" name="workflowComment" style="width:100%;height: 160px;"></textarea>
 	</td>
</tr>

<tr <c:if test="${workflowComments== null || fn:length(workflowComments) == 0}">style="display: none;"</c:if>	>
 	<td class="td-label">流转意见</td>
 	<td class="td-value">
 	
 		<table class="table-layout-fixed" id="fix_layout_table">
 		<thead>
 		<tr>
 			<th width="15%">
 			处理人
 			</th>
 			<th width="15%">
 			处理时间
 			</th>
 			<th width="15%">
 			任务名称
 			</th>
 			<th width="15%">
 			操作类型
 			</th>
 			<th>
 			处理意见
 			</th>
 		</tr>
 		</thead>
 		<tbody id="dt_fix_table">
 		<c:forEach var="workflowComment_var" items="${workflowComments}">
	 		<tr>
	 			<td style="text-align:center;" >
	 			${workflowComment_var.userKey}
	 			</td>
	 			<td style="text-align:center;" >
	 			<fmt:formatDate value="${workflowComment_var.time}" pattern="yyyy-MM-dd HH:mm:ss"/>
	 			</td>
	 			<td style="text-align:center;" >
	 			${workflowComment_var.taskName}
	 			</td>
	 			<td style="text-align:center;" >
	 			${workflowComment_var.type}
	 			</td>
	 			<td style="text-align:left;" >
	 			${workflowComment_var.fullMessage}
	 			</td>
	 		</tr>
		</c:forEach>
		</tbody>
		</table>
 	</td>
</tr>

<tr style="display: none;">
 	<td class="td-label"></td>
 	<td class="td-value">
 		<input type="hidden" id="currentTaskId"  name="currentTaskId" value="${flowArgs.currentTaskId}"/>
 		<input type="hidden"  name="taskDefinitionKey" value="${flowArgs.taskDefinitionKey}"/>
		<input type="hidden"  name="processInstanceId" value="${flowArgs.processInstanceId}"/>
		<input type="hidden" id="nextUserNames"  name="nextUserNames"/>
 	</td>
</tr>

<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
	<ul class="menu"> 
	   <li><a href="#">首页</a></li> 
	   <li><a href="#">服务</a></li> 
	   <li><a href="#">案例</a></li> 
	   <li><a href="#">关于</a></li> 
	   <li><a href="#">BLOG</a></li> 
	</ul> 
</div>