<%@page import="org.whale.system.common.constant.SysConstant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>角色列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/role/goSave","title":'新增角色'});
}

function update(roleId){
	$.openWin({url: "${ctx}/role/goUpdate?roleId="+roleId,"title":'编辑角色'});
}

function view(roleId){
	$.openWin({url: "${ctx}/role/goDetail?roleId="+roleId,"title":'查看角色'});
}

function setAuth(roleId){
	$.openWin({url:'${ctx}/role/goSetRoleAuth?roleId='+roleId, width:450, height:520,title: "分配权限"});
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
				url : "${ctx}/role/doDelete",
				data : "roleIdS="+idArr.join(','),
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

function setStatus(id,name,type){
	var url = "${ctx}/role/doChangeState?status=<%=SysConstant.STATUS_NORMAL%>";
	var opt = "启用";
	if(type == '<%=SysConstant.STATUS_UNUSE%>'){
		url = "${ctx}/role/doChangeState?status=<%=SysConstant.STATUS_UNUSE%>";
		opt = "禁用";
	}
	$.confirm({
		 info:'您确定要[ '+opt+' ]角色[ '+name+' ]吗？',
		 ok: function () {
	        $.ajax({
				url : url,
				data : "roleId="+id,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
					$.alert(opt+' 角色 '+name+' 出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
			    		grid.reload();
						$.info("设置角色状态成功");
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
			<form action="${ctx}/role/goList" method="post" id="page_form" >
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
							<td class="td-label">角色名称</td>
							<td class="td-value"><input type="text" id="roleName" name="roleName" style="width:160px;" value="${roleName }" /></td>
							<td class="td-label">角色编码</td>
							<td class="td-value"><input type="text" id="roleCode" name="roleCode" style="width:160px;"  value="${roleCode }" /></td>
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
            <tag:auth authCode="ROLE_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>添加</span>
						</a>	
                    </li>
            </tag:auth>
            <tag:auth authCode="ROLE_DEL">
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
					<col width="18%"/>
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
								角色名称
							</th>
							<th>
								角色编码
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
								<input type="checkbox" value="${item.roleid }" />
							</td>
							<td class="td-center">
						<tag:auth authCode="ROLE_UPDATE">
								<a href="#" onclick="update('${item.roleid }')">
									修改
								</a>
						</tag:auth>	
						
							<c:if test="${!fliterFlag || !item.fliter }">
						<tag:auth authCode="ROLE_AUTH">	
								<a href="#" onclick="setAuth('${item.roleid }')">
									设置权限
								</a>
						</tag:auth>
						<tag:auth authCode="ROLE_STATUS">	
								<c:if test="${item.status != usable}">
									<a href="#" class="a3" onclick="setStatus('${item.roleid }','${item.rolename}','<%=SysConstant.STATUS_NORMAL%>')">
										<span>启用</span>
									</a>
								</c:if>
			                 	<c:if test="${item.status == usable && item.roleid != ucId}">
									<a href="#" class="a4" onclick="setStatus('${item.roleid }','${item.rolename}','<%=SysConstant.STATUS_UNUSE%>')">
										<span>禁用</span>
									</a>
								</c:if>
						</tag:auth>		
							</c:if>
							</td>
							<td title="${item.rolename}">
									${item.rolename}
							</td>
							<td title="${item.rolecode}">
								${item.rolecode}
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


