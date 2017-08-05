<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>菜单列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/menu/goSave?parentId=${item.parentId}","title":'新增菜单'});
}

function update(menuId){
	$.openWin({url: "${ctx}/menu/goUpdate?view=0&menuId="+menuId,"title":'编辑菜单'});
}

function view(menuId){
	$.openWin({url: "${ctx}/menu/goDetail?from=list&menuId="+menuId,"title":'查看菜单'});
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
				url : "${ctx}/menu/doDelete",
				data : "menuIdS="+idArr.join(','),
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
			        $.alert('删除记录出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
						$.info(obj.msg);
						window.parent.location.reload();
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
			<form action="${ctx}/menu/goList" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				<input type="hidden" id="parentId" name="parentId" value="${item.parentId }"/>
				
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">菜单名</td>
							<td class="td-value" colspan="3"><input type="text" id="menuName" name="menuName" style="width:160px;" value="${menuName }" /></td>
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
            <tag:auth authCode="MENU_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>新增</span>
						</a>	
                    </li>
            </tag:auth>
            <tag:auth authCode="MENU_DEL">
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
					<col />
					<col />
					<col />
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
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
								菜单名称
							</th>
							
							<th>
								链接地址
							</th>
							<th>
								图标
							</th>
							<th>
								菜单类型
							</th>
							<th>
								打开方式
							</th>
							<th>
								公共菜单
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
								<input type="checkbox" value="${item.menuid }" />
							</td>
							<td class="td-center">
						<tag:auth authCode="MENU_UPDATE">
								<a href="#" onclick="update('${item.menuid }')">
									修改
								</a>
						</tag:auth>
							</td>
							<td title="${item.menuname}">
								${item.menuname}
							</td>
							
							<td title="${item.menuurl}">
								${item.menuurl}
							</td>
							<td title="${item.inco}">
								${item.inco}
							</td>
							<td align="center">
								<c:if test="${item.menutype == 1}">tab菜单</c:if>
								<c:if test="${item.menutype == 2}">文件夹菜单</c:if>
								<c:if test="${item.menutype == 3}">叶子菜单</c:if>
							</td>
							<td align="center">
								<c:if test="${item.opentype == 1}">窗口内打开</c:if>
								<c:if test="${item.opentype == 2}">弹出窗口</c:if>
							</td>
							<td align="center">
								<c:if test="${item.ispublic != 1}">否</c:if>
								<c:if test="${item.ispublic == 1}">是</c:if>
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


