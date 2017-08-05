<%@page import="org.whale.system.common.util.TimeUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>用户列表</title>
<%@include file="/html/jsp/common.jsp" %>
<style type="text/css">
.clist{ position:relative; overflow-y:hidden;overflow-x:auto; width:100%;}
.clist table { position:relative; z-index:10; table-layout:fixed;}
.clist table { border-collapse:collapse; width: 100%; }
.clist table td.td-center{text-align:center;}
.clist table td.td-seq{background-color:#F1F2F2;text-align:center; background:url(${resource}/images/tableth.png); }
.clist table tr {background:#FFF; height:21px;}
.clist table th, .clist table td{ border:1px solid #EDEDED; padding:1px 2px; text-align:left;  white-space: nowrap;text-overflow:ellipsis; overflow:hidden; }
.clist table th{ background:url(${resource}/images/tableth.png); text-align:center;cursor:pointer;}
.clist table th.headerSortUp{ background:#F1F1F1 url(${resource}/images/asc.gif) no-repeat right;}
.clist table th.headerSortDown{ background:#F1F1F1 url(${resource}/images/desc.gif) no-repeat right;}
.clist table a:hover{ text-decoration:underline;}
.clist table a{ color:#3C7FB1; line-height:20px; text-decoration:none;}
.clist table tbody tr.hover{background-color:#e4f5ff; background-color:#F1F1F1}
.clist table tbody tr.selected{background-color:#7cc5e5; border-color:#b8d0d6; }
</style>

<script language="javascript">

function loginOut(sessionId){
	$.confirm({
		 info:'您确定要将该用户强制退出吗？',
		 ok: function () {
	        $.ajax({
				url : "${ctx}/doForceLoginOut?sessionId="+sessionId,
				data : null,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
			        $.alert('用户强制退出出现异常');
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
			<form action="${ctx}/goWhoAreOnline" method="post" id="page_form" >
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">用户名</td>
							<td class="td-value" colspan="3"><input type="text" id="userName" name="userName" style="width:160px;" value="${userName }" /></td>
						</tr>
						<tr>
							<td colspan="6" class="td-btn">
								<div class="sch_qk_con"> 
									<input onclick="grid.goPage(1);"  class="i-btn-s" type="button"  value="检索"/>
								</div>
						  	</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div><!--query-form-->
		<div class="pageContent">
		<%
			String mySessionId = (String)request.getAttribute("mySessionId");
			Map<Long, Map<String, Object>> users = (Map<Long, Map<String, Object>>)request.getAttribute("users");
			for(Map<String, Object> map : users.values()){
		%>
			<div style="padding-top: 3px;">
				<div class="query-form">
					<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="8%" />
						<col  width="25%"/>
						<col  width="8%" />
						<col  width="25%"/>
						<col  width="8%" />
						<col  width="25%"/>
						<tbody>
							<tr>
								<td class="td-label">用户名</td>
								<td class="td-value"><%=map.get("userName") %></td>
								<td class="td-label">真实姓名</td>
								<td class="td-value"><%=map.get("realName") %></td>
								<td class="td-label">所属部门</td>
								<td class="td-value"><%=map.get("department") %></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div align="center" class="clist">
					<table cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
						<col width="3%"/>
						<col />
						<col />
						<col />
						<col width="12%"/>
						<thead>
							<tr>
								<th>
									序号
								</th>
								<th>
									IP地址
								</th>
								<th>
									登录时间
								</th>
								<th>
									sessionId
								</th>
								<th>
									操作
								</th>
							</tr>
						</thead>
						<tbody>
							<%
								List<String> ips = (List<String>)map.get("ip");
								List<Date> loginTimes = (List<Date>)map.get("loginTime");
								List<String> sessionIds = (List<String>)map.get("sessionId");
								for(int i=0; i<ips.size(); i++){
							%>
							<tr >
								<td class="td-seq">
									<%=i+1 %>
								</td>
								<td>
									<%=ips.get(i) %>
								</td>
								<td>
									<%=TimeUtil.formatTime(loginTimes.get(i), TimeUtil.COMMON_FORMAT) %>
								</td>
								<td>
									<%=sessionIds.get(i) %>
								</td>
								<td>
									<%
										if(!mySessionId.equals(sessionIds.get(i))){
									%>
									<a href="#" onclick="loginOut('<%=sessionIds.get(i) %>')">强制退出</a>
									<%
										}
									%>
								</td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		<%
			}
		%>
		</div>
	</div>
</body>
</html>


