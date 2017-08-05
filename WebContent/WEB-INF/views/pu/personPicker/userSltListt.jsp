<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>资源列表</title>
<%@include file="/html/jsp/common.jsp"%>
<script src="${resource}/js/jquery.json.min.js" type="text/javascript">
</script>
<script type="text/javascript">
    //global varriable
    var dialog;
    var callback;
    var users = [];
    var jUserList
    $(function(){
    	//hook
		dialog = frameElement.dialog;
	    callback = dialog.get('callback');
	    
	    //repository
		jUserList = $("#userList");
    
        //deifne global function
		//TODO generate jquery object by user object
		function genJDom(user) {
			var jTr = $("<tr>");
			var jCheckBox = $("<input>").attr("type", "checkbox").val(
					user.userId).attr("name", "user").attr("userName",
					user.userName).attr("realName", user.realName);
			if (user.selected) {
				jCheckBox.attr("checked", "checked");
			}
			var jCheckBoxTd = $("<td>").append(jCheckBox);
			var jUserIdTd = $("<td>").text(user.userId);
			var jUserNameTd = $("<td>").text(user.userName);
			var jRealNameTd = $("<td>").text(user.realName);
			var jPhoneTd = $("<td>").text(user.phone);
			var jEmailTd = $("<td>").text(user.email);
			jTr.append(jCheckBoxTd);
			jTr.append(jUserNameTd);
			jTr.append(jRealNameTd);
			jTr.append(jPhoneTd);
			jTr.append(jEmailTd);
			return jTr;
		}
		//TODO fresh UI List
		function freshListUI() {
			jUserList.html("");
			for (var i = 0; i < users.length; i++) {
				var jTr = genJDom(users[i]);
				var jSeqTd = $("<td>").text(i + 1);
				jTr.prepend(jSeqTd);
				jUserList.append(jTr);
			}

		}
		//TODO  remove unckecked users before loading new ones
		function cleanUsers() {
			$.each(jUserList.children("tr"), function(i, item) {
				jCheckbox = $(":checked", item);
				if (jCheckbox.length == 1) {
					users[i].selected = "selected";
				} else {
					if (users[i].selected) {
						delete users[i].selected;
					}
				}
			});
			for (var i = 0; i < users.length;) {
				if (users[i].selected && users[i].selected == "selected") {
					i++
				} else {
					users.splice(i,1);
				}
			}
		}

		$("#reset").click(function() {
			var jQueryForm=$(".query-form");
			var userName=$("input[name='userName']",jQueryForm).val("");
			var role=$("select[name='role']  option",jQueryForm).eq(0).attr('selected', 'true');
			var realName=$("input[name='realName']",jQueryForm).val("");
			var belongGroups=$("select[name='belongGroups']   option",jQueryForm).eq(0).attr('selected', 'true');
		});

		$("#query").click(
				function() {
					var userIds = [];
					var param={};
					var pkBusinessGroup='${pkBusinessGroup}';
					param.pkBusinessGroup=pkBusinessGroup;
					$.each($(".content-list :checked"), function(i) {
						userIds.push($(this).val());
					})
					var sltIds =""+ userIds.join(",");
					param.sltIds=sltIds;
					var jQueryForm=$(".query-form");
					var userName=$("input[name='userName']",jQueryForm).val();
					param.userName=userName;
					var role=$("select[name='role']  option:selected",jQueryForm).val();
					param.role=role;
					var realName=$("input[name='realName']",jQueryForm).val();
					param.realName=realName;
					var belongGroups=$("select[name='belongGroups']   option:selected",jQueryForm).val();
					param.belongGroups=belongGroups;
					var roleIds="";
					var roleCode="${roleCode}";
					if(roleCode.length>0){
						$.each($("select[name='role']  option"),function(i,item){
							if($(item).val().length>0){
							roleIds+=$(item).val()+",";}
						});
						var length=roleIds.length;
						roleIds=roleIds.substr(0,length-1);
					}
					param.roleCode=roleCode;
					param.roleIds=roleIds;
					url = "${ctx}/pu/personPicker/queryUsers";
					ACF.ajaxForm.post(url,param,function(obj){
						 cleanUsers();
						 $.each(obj.datas, function(i, item) {
									users.push(item);});
						freshListUI();
					 },function(obj){alert("加载失败");});
					
				});

		$("#sure").click(function() {
			var userIds = [];
			var userNames = [];
			var realNames=[];
			var jCheckedList=$(".content-list :checked");
			var numLimit=parseInt($("#numLimit").val());
			if(numLimit!=-1 && numLimit<jCheckedList.length){
				alert("超过人数上限:"+numLimit);
				return;
			}
			$.each(jCheckedList, function(i) {
				userNames.push($(this).attr("userName"));
				userIds.push($(this).val());
				realNames.push($(this).attr("realName"));
			})
			var result=[];
			result.push(userIds.join(","));
			result.push(userNames.join(","));
			result.push(realNames.join(","));
			callback(result);
		});
   
    	 //running
		(function init() {
			var sltUsers='${sltUsers}';//json format data
			var myUsers='${users}';
			var sltIds='${sltIds}';
			var roleCode="${roleCode}";
			var pkBusinessGroup='${pkBusinessGroup}';
			var param={};
			param.sltIds=sltIds;
			param.pkBusinessGroup=pkBusinessGroup;
			param.roleCode=roleCode;
			$.each(eval(sltUsers),function(i){
				this.selected="selected";
				users.push(this);
			});
			$.each(eval(myUsers),function(i){
				users.push(this);
			});
			freshListUI();
			
		})();//end running
	});
</script>
</head>
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/resource/goList" method="post" id="page_form">
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" /> 
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				<input type="hidden" id="numLimit" name="numLimit" value="${numLimit}"/>
				<table cellpadding="0" cellspacing="0" width="100%">
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label">用户名</td>
							<td class="td-value" ><input type="text"
								id="userName" name="userName" style="width: 160px;"/></td>
							<td class="td-label">姓名</td>
							<td class="td-value"><input type="text"
								id="realName" name="realName" style="width: 160px;"/></td>
						</tr>
						<tr>
							<td class="td-label">业务组</td>
							<td class="td-value" ><select type="text"
								id="belongGroups" name="belongGroups" style="width: 160px;">
								            <c:if test="${fn:length(businessGroups)>1}">
								            <option value="" <c:if test='${item.businessGroupId==""}'>selected="selected"</c:if>>--请选择--</option>
								            </c:if>
											<c:forEach var="businessGroup" items="${businessGroups}">
												<option value="${businessGroup.pkBusinessGroup}" <c:if test="${item.businessGroupId==businessGroup.pkBusinessGroup}">selected="selected"</c:if> >${businessGroup.businessGroupName}</option>
											</c:forEach>
								</select></td>
							<td class="td-label">角色</td>
							<td class="td-value">
								<select type="text" id="role" name="role" style="width: 160px;">
									<c:if test="${fn:length(roles)>1}">
								  		<option value="">--请选择--</option>
									</c:if>
									<c:forEach var="role" items="${roles}">
										<option value="${role.roleId }" <c:if test="${item.roleId == role.roleId}">selected="selected"</c:if> >${role.roleName }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="6" class="td-btn">
								<div class="sch_qk_con">
									<input id="query" class="i-btn-s" type="button" value="检索" /> 
									<input id="reset" class="i-btn-s" type="button" value="清空" />
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<!--query-form-->
		<div class="pageContent">
			<div class="panelBar" id="panelBarDiv">
				<ul>
					<li><a href="#" class="a1" id="sure"> <span>提交</span>
					</a></li>

					<li class="line"></li>
				</ul>
				<div class="clear_float"></div>
			</div>
			<!--panelBar end-->
			<div class="content-list">
				<table cellpadding="0" cellspacing="0" id="gridTable">
					<col width="3%" />
					<col width="8%" />
					<col />
					<col />
					<col />
					<col />
					<thead>
						<tr>
							<th>序号</th>
							<th>操作</th>
							<th>用户名</th>
							<th>姓名</th>
							<th>联系电话</th>
							<th>电子邮箱</th>
						</tr>
					</thead>
					<tbody id="userList">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>