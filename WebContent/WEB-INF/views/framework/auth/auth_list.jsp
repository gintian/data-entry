<%@page import="org.whale.system.common.constant.SysConstant"%>
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
	$.openWin({url: "${ctx}/auth/goSave?menuId=${menuId}","title":'新增权限'});
}

function update(authId){
	$.openWin({url: "${ctx}/auth/goUpdate?authId="+authId,"title":'编辑权限'});
}

function view(authId){
	$.openWin({url: "${ctx}/auth/goView?authId="+authId,"title":'查看权限'});
}

function selRes(authId, authName){
	$.openWin({url: "${ctx}/resource/goSelList?authId="+authId,"title":'选择 ['+authName+'] 资源'});
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
				url : "${ctx}/auth/doDelete",
				data : "authIdS="+idArr.join(','),
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


function setStatus(id,name,type){
	var url = "${ctx}/auth/doChangeState?status=<%=SysConstant.STATUS_NORMAL%>";
	var opt = "启用";
	if(type == '<%=SysConstant.STATUS_UNUSE%>'){
		url = "${ctx}/auth/doChangeState?status=<%=SysConstant.STATUS_UNUSE%>";
		opt = "禁用";
	}
	$.confirm({
		 info:'您确定要[ '+opt+' ]权限[ '+name+' ]吗？',
		 ok: function () {
	        $.ajax({
				url : url,
				data : "authId="+id,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
					$.alert(opt+' 权限 '+name+' 出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
			    		grid.reload();
						$.info("设置权限状态成功");
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
			<form action="${ctx}/auth/goList" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				<input type="hidden" id="menuId" name="menuId" value="${menuId }"/>
				
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">权限名称</td>
							<td class="td-value"><input type="text" id="authName" name="authName" style="width:160px;" value="${authName }" /></td>
					
							<td class="td-label">权限编码</td>
							<td class="td-value"><input type="text" id="authCode" name="authCode" style="width:160px;" value="${authCode }" /></td>
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
            <tag:auth authCode="AUTH_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>新增</span>
						</a>	
                    </li>
            </tag:auth>
            <tag:auth authCode="AUTH_DEL">
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
					<col width="25%"/>
					<col />
					<col />
					<col />
					<col />
					<col width="6%"/>
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
								权限名称
							</th>
							
							<th>
								权限编码
							</th>
							<th>
								所属菜单
							</th>
							<th>
								备注
							</th>
							<th>
								状态
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
								<input type="checkbox" value="${item.authId }" />
							</td>
							<td class="td-center">
							<tag:auth authCode="AUTH_VIEW">
								<a href="#" onclick="view('${item.authId }')">
									查看
								</a>
						</tag:auth>
						<tag:auth authCode="AUTH_UPDATE">
								<a href="#" onclick="update('${item.authId }')">
									修改
								</a>
						</tag:auth>
						<tag:auth authCode="AUTH_STATUS">
							<c:if test="${item.status != usable}">
									<a href="#" class="a3" onclick="setStatus('${item.authId }','${item.authName}','<%=SysConstant.STATUS_NORMAL%>')">
										<span>启用</span>
									</a>
								</c:if>
			                 	<c:if test="${item.status == usable}">
									<a href="#" class="a4" onclick="setStatus('${item.authId }','${item.authName}','<%=SysConstant.STATUS_UNUSE%>')">
										<span>禁用</span>
									</a>
								</c:if>
						</tag:auth>
						
						<tag:auth authCode="AUTH_SEL">
								<a href="#" onclick="selRes('${item.authId }','${item.authName}' )">
									选择资源
								</a>
						</tag:auth>
							</td>
							<td title="${item.authName}">
								${item.authName}
							</td>
							
							<td title="${item.authCode}">
								${item.authcode}
							</td>
							<td title="${item.menuName}">
								${item.menuName}
							</td>
							<td title="${item.remark}">
								${item.remark}
							</td>
							<td align="center" style="text-align: center;">
								<c:if test="${item.status != usable}"><font color="red">禁用</font></c:if>
								<c:if test="${item.status == usable}">启用</c:if>
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


