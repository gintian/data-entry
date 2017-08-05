<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>资源列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function update(resId){
	$.openWin({url: "${ctx}/resource/goUpdate?resId="+resId,"title":'编辑资源'});
}
</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/resource/goList" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				
				<input type="hidden" id="authType" name="authType" value="${authType }"/>
				<input type="hidden" id="auth" name="auth" value="${auth }"/>
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">url</td>
							<td class="td-value" colspan="3">
								<input type="text" id="url" name="url" style="width:160px;" value="${url }" />
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
					<col width="8%"/>
					<col />
					<col />
					<col />
					<col />
					<thead>
						<tr>
							<th>
								序号
							</th>
							<th>
								操作
							</th>
							<th>
								url
							</th>
							<th>
								所属权限
							</th>
							<th>
								资源类型
							</th>
							
							<th>
								资源备注
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
						<tag:auth authCode="RESOURCE_UPDATE">
								<a href="#" onclick="update('${item.resId }')">
									修改
								</a>
						</tag:auth>
							</td>
							<td title="${item.url}">
								${item.url}
							</td>
							<td title="${item.authName}">
								${item.authName}
							</td>
							<td >
								<c:if test="${item.authType == 1 }">公共资源</c:if>
								<c:if test="${item.authType == 2 }">受控资源</c:if>
								<c:if test="${item.authType == 3 }">管理员资源</c:if>
							</td>
							<td title="${item.info}">
								${item.info}
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


