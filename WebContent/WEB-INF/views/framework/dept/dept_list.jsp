<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>部门列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/dept/goSave?pid=${dept.pid}","title":'新增部门'});
}

function update(id){
	$.openWin({url: "${ctx}/dept/goUpdate?id="+id,"title":'修改部门'});
}

function view(id){
	$.openWin({url: "${ctx}/dept/goView?id="+id,"title":'查看部门'});
}

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
				url : "${ctx}/dept/doDelete",
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
			    		window.parent.location.href="${ctx}/dept/goTree?clkId=${dept.pid}";
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
			<form action="${ctx}/dept/goList" method="post" id="page_form" >
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
							<td class="td-label">部门名称</td>
							<td class="td-value">
								<input type="text" id="deptName" name="deptName" style="width:160px;" value="${item.deptName}" />
							</td>
							<td class="td-label">部门编码</td>
							<td class="td-value">
								<input type="text" id="deptCode" name="deptCode" style="width:160px;" value="${item.deptCode}" />
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
            <tag:auth authCode="DEPT_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>新增</span>
						</a>	
                    </li>
            </tag:auth>
            <tag:auth authCode="DEPT_DEL">
                	<li>
						<a href="#" class="a2" onclick="del()">
							<span>删除</span>
						</a>
					</li>
			</tag:auth>
                    <li class="line"></li>
                </ul>
				<div class="clear_float"> </div>
			</div><!--panelBar end-->

			<div class="content-list">
				<table cellpadding="0" cellspacing="0" id="gridTable">
					<col width="3%"/>
					<col width="3%"/>
					<col width="8%"/>
					<col width="18%"/>
					<col width="15%"/>
					<col width="12%"/>
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
								部门名称
							</th>
							<th>
								部门编码
							</th>
							<th>
								联系电话
							</th>
							<th>
								联系地址
							</th>
							<th>
								备注
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
								<input type="checkbox" value="${item.id}" />
							</td>
							<td class="td-center">
						<tag:auth authCode="DEPT_UPDATE">
								<a href="#" onclick="update('${item.id}')">
									修改
								</a>
						</tag:auth>	
							</td>
							<td title="${item.deptName}">
								${item.deptName}
							</td>
							<td title="${item.deptCode}">
								${item.deptCode}
							</td>
							<td title="${item.deptTel}">
								${item.deptTel}
							</td>
							<td title="${item.deptAddr}">
								${item.deptAddr}
							</td>
							<td title="${item.remark}">
								${item.remark}
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