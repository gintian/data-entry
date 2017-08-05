<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>应用列表</title>
<%@include file="/html/jsp/common.jsp" %>
<%@include file="/html/jsp/flowForm.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function del(){
	var idArr = grid.getSelectIds();
	if(idArr.length < 1){
		$.alert('请选择需要删除的记录');
		return ;
	}
	
	$.confirm({
		 info:'您确定要删除记录吗？',
		 ok: function () {
	        $.ajax({
				url : "${ctx}/engine/actDraft/doDelete",
				data : "ids="+idArr.join(','),
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
			        $.alert('删除记录出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
			    		grid.reload();
						$.info(obj.msg);
			    	}else{
						$.alert(obj.msg);
			    	}
				}
			});
		}
	});
}

</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/engine/actDraft/goList" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">标题</td>
							<td class="td-value">
								<input type="text" id="processInstanceName" name="processInstanceName" style="width:160px;" value="${item.PROCESS_INSTANCE_NAME}" />
							</td>
							<td class="td-label">所属流程</td>
							<td class="td-value">
								<input type="text" id="flowKey" name="flowKey" style="width:160px;" value="${item.FLOW_KEY}" />
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
			<!--panelBar-->
			<div class="panelBar" id="panelBarDiv">
            	<ul>
                	<li>
						<a href="#" class="a2" onclick="del()">
							<span>删除</span>
						</a>
					</li>
                    <li class="line"></li>
                </ul>
				<div class="clear_float"> </div>
			</div><!--panelBar end-->

			<div class="content-list">
				<table cellpadding="0" cellspacing="0" id="gridTable">
					<col width="3%"/>
					<col width="3%"/>
					<col width="8%"/>
					<col />
					<col />
					<col />
					<thead>
						<tr>
							<th>
								序号
							</th>
							<th>
								<input type="checkbox" id="ck_all" onclick="grid.checkAll()" /> 
							</th>
							<th>
								操作
							</th>
							<th>
								标题
							</th>
							<th>
								所属流程
							</th>
							<th>
								创建时间
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
								<input type="checkbox" value="${item.PK_ACT_DRAFT}" />
							</td>
							<td class="td-center">
									<a href="#" onclick="flowForm('${ctx}', '${item.FLOW_KEY }', '', '', '${item.BUSINESS_KEY }', '', '', 1);">
										办理
									</a>
							</td>
							<td title="${item.PROCESS_INSTANCE_NAME}">
								${item.PROCESS_INSTANCE_NAME}
							</td>
							<td title="${item.FLOW_KEY}">
								${item.FLOW_KEY}
							</td>
							<td title="${item.CREATE_BY_TIME}">
								${item.CREATE_BY_TIME}
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