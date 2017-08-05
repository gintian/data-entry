<%@page import="org.whale.system.common.constant.DictConstant"%>
<%@page import="org.whale.system.cache.service.DictCacheService"%>
<%@page import="org.whale.system.common.constant.SysConstant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>用户列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/user/goSave?deptId=${deptId}","title":'新增用户'});
}

function update(userId){
	$.openWin({url: "${ctx}/user/goUpdate?userId="+userId,"title":'编辑用户'});
}

function view(userId){
	$.openWin({url: "${ctx}/user/goView?userId="+userId,"title":'查看用户'});
}

function setRole(userId){
	$.openWin({url:'${ctx}/user/goSetUserRole?userId='+userId, width:450, height:520,title: "分配角色"});
}

function setBusinessGroup(userId){
	$.openWin({url:'${ctx}/oa/common/businessGroup/goSetBusinessGroupSysUser?userId='+userId, width:300, height:320,title: "分配业务组"});
}

function del(userId){
	var idArr = grid.getSelectIds();
	if(userId == ""){
		$.alert('请选择需要删除的记录');
		return ;
	}
	
	$.confirm({
		 info:'您确定要删除记录吗？',
		 ok: function () {
	        $.ajax({
				url : "${ctx}/user/doDelete?userId="+userId,
				data : null,
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

function resetPassword(userId){
	$.confirm({
		 info:'您确定要重置密码吗？',
		 ok: function () {
	        $.ajax({
				url : "${ctx}/user/doRestPassword",
				data : "userId="+userId,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
					$.alert('重置密码出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
						$.info("重置密码 [<font color=red>111111</font>] 成功");
			    	}else{
						$.alert(obj.msg);
			    	}
				}
			});
		}
	});
}

function setStatus(id,name,type){
	var url = "${ctx}/user/doChangeState?status=<%=SysConstant.STATUS_NORMAL%>";
	var opt = "启用";
	if(type == '1'){
		url = "${ctx}/user/doChangeState?status=<%=SysConstant.STATUS_UNUSE%>";
		opt = "禁用";
	}
	$.confirm({
		 info:'您确定要[ '+opt+' ]用户[ '+name+' ]吗？',
		 ok: function () {
	        $.ajax({
				url : url,
				data : "userId="+id,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
					$.alert(opt+' 用户 '+name+' 出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
			    		grid.reload();
						$.info("设置用户状态成功");
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
			<form action="${ctx}/user/goList" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				
				<input type="hidden" id="deptId" name="deptId" value="${deptId }"/>
			
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">用户名</td>
							<td class="td-value"><input type="text" id="userName" name="userName" style="width:160px;" value="${userName }" /></td>
							<td class="td-label">姓名</td>
							<td class="td-value"><input type="text" id="realName" name="realName" style="width:160px;"  value="${realName }" />							
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
            	<tag:auth authCode="USER_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>添加</span>
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
					<col width="28%"/>
					<col />
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
								操作
							</th>
							<th>
								用户名
							</th>
							<th>
								姓名
							</th>
							<th>
								手机号码
							</th>
							<th>
								邮箱地址
							</th>
							<th>
								所属部门
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
						<tag:auth authCode="USER_UPDATE">
								<a href="#" onclick="update('${item.userid }')">
									修改
								</a>
						</tag:auth>
						<c:if test="${item.userId != ucId }">
						<tag:auth authCode="USER_DEL">
								<a href="#" onclick="del('${item.userid }')">
									删除
								</a>
						</tag:auth>
						<tag:auth authCode="USER_ROLE">
								<a href="#" onclick="setRole('${item.userid }')">
									分配角色
								</a>
						</tag:auth>
<%-- 						<tag:auth authCode="USER_BUSINESSGROUP">
								<a href="#" onclick="setBusinessGroup('${item.userid }')">
									分配业务组
								</a>
						</tag:auth>		 --%>	
						<tag:auth authCode="USER_STATUS">
								<c:if test="${item.status != usable}">
									<a href="#" class="a3" onclick="setStatus('${item.userId }','${item.userName}','0')">
										<span>启用</span>
									</a>
								</c:if>
			                 	<c:if test="${item.status == usable}">
									<a href="#" class="a4" onclick="setStatus('${item.userId }','${item.userName}','1')">
										<span>禁用</span>
									</a>
								</c:if>
						</tag:auth>
						<tag:auth authCode="USER_PASS_REST">
								<a href="#" class="reset" onclick="resetPassword('${item.userid }')">
									<span>重置密码</span>
								</a>
						</tag:auth>
					</c:if>
							</td>
							<td align="center" style="text-align: center;" title="${item.userName}">
								<a href="#" onclick="view('${item.userid }')">
									${item.userName}
								</a>
							</td>
							<td title="${item.realName}">
								${item.realName}
							</td>
							
							<td title="${item.phone}">
								${item.phone}
							</td>
							<td title="${item.email}">
								${item.email}
							</td>
							<td title="${item.deptName}">
								<c:if test="${empty item.deptName}">
									<%=DictCacheService.getThis().getItemValue(DictConstant.DICT_SYS_CONF, "ITEM_DEPT_ROOT")%>
								</c:if>
								<c:if test="${!empty item.deptName}">
								${item.deptName}
								</c:if>
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


