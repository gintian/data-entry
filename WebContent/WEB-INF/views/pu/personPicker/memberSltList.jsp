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
var members = [];
var jMemberList
$(function(){
	//hook
	/**/
	dialog = frameElement.dialog;
    callback = dialog.get('callback');
    
    //repository
	jMemberList = $("#memberList");

    //deifne global function
	//TODO generate jquery object by user object
	function genJDom(member) {
		var jTr = $("<tr>");
		var jCheckBox = $("<input/>").attr("type", "checkbox").val(
				member.memberId).attr("name", "member").attr("loginName",
				member.loginName).attr("realName", member.realName);
		if (member.selected) {
			jCheckBox.attr("checked", "checked");
		}
		var jCheckBoxTd = $("<td>").append(jCheckBox);
		var jLoginNameTd = $("<td>").text(member.loginName);
		var jRealNameTd = $("<td>").text(member.realName);
		var jPhoneNumberTd = $("<td>").text(member.phoneNumber);
		var jEmailTd = $("<td>").text(member.email);
		var jIsBorrower=$("<td>");
		if(member.isBorrower==1){
			jIsBorrower.text("是");
		}
		else {
			jIsBorrower.text("否");
		}
		jTr.append(jCheckBoxTd);
		jTr.append(jLoginNameTd);
		jTr.append(jRealNameTd);
		jTr.append(jPhoneNumberTd);
		jTr.append(jEmailTd);
		jTr.append(jIsBorrower);
		return jTr;
	}
	//TODO fresh UI List
	function freshListUI() {
		jMemberList.html("");
		for (var i = 0; i < members.length; i++) {
			var jTr = genJDom(members[i]);
			var jSeqTd = $("<td>").text(i + 1);
			jTr.prepend(jSeqTd);
			jMemberList.append(jTr);
		}

	}
	//TODO  remove unckecked users before loading new ones
	function cleanMembers() {
		$.each(jMemberList.children("tr"), function(i, item) {
			jCheckbox = $(":checked", item);
			if (jCheckbox.length == 1) {
				members[i].selected = "selected";
			} else {
				if (members[i].selected) {
					delete members[i].selected;
				}
			}
		});
		for (var i = 0; i < members.length;) {
			if (members[i].selected && members[i].selected == "selected") {
				i++
			} else {
				members.splice(i,1);
			}
		}
	}

	$("#reset").click(function() {
		var jQueryForm=$(".query-form");
		var loginName=$("input[name='loginName']",jQueryForm).val("");
		var isBorrower=$("select[name='isBorrower']  option",jQueryForm).eq(0).attr('selected', 'true');
		var realName=$("input[name='realName']",jQueryForm).val("");
		});
    
	$("#query").click(
			function() {
				var memberIds = [];
				var param={};
				$.each($(".content-list :checked"), function(i) {
					memberIds.push($(this).val());
				})
				var sltIds =""+ memberIds.join(",");
				param.sltIds=sltIds;
				var jQueryForm=$(".query-form");
				var loginName=$("input[name='loginName']",jQueryForm).val();
				param.loginName=loginName;
				var isBorrower=$("select[name='isBorrower']  option:selected",jQueryForm).val();
				param.isBorrower=isBorrower;
				var realName=$("input[name='realName']",jQueryForm).val();
				param.realName=realName;
			
				
				url = "${ctx}/pu/personPicker/queryMembers";
				ACF.ajaxForm.post(url,param,function(obj){
					 cleanMembers();
					 $.each(obj.datas, function(i, item) {
								members.push(item);});
					freshListUI();
				 },function(obj){alert("加载失败");});
				
			});
 
	$("#sure").click(function() {
		var memberIds = [];
		var loginNames = [];
		var realNames=[];
		var jCheckedList=$(".content-list :checked");
		var numLimit=parseInt($("#numLimit").val());
		if(numLimit!=-1 && numLimit<jCheckedList.length){
			alert("超过人数上限:"+numLimit);
			return false;
		}
		$.each(jCheckedList, function(i) {
			loginNames.push($(this).attr("loginName"));
			memberIds.push($(this).val());
			realNames.push($(this).attr("realName"));
		})
		var result=[];
		result.push(memberIds.join(","));
		result.push(loginNames.join(","));
		result.push(realNames.join(","));
		callback(result);
	});
	 //running
	(function init() {
		var myMembers='${members}';//json format data
		var sltMembers='${sltMembers}';
		var param={};
		$.each(eval(sltMembers),function(i){
			this.selected="selected";
			members.push(this);
		});
		$.each(eval(myMembers),function(i){
			members.push(this);
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
				<input type="hidden" id="numLimit" name="numLimit" value="${paramMap.numLimit}"/>
				<table cellpadding="0" cellspacing="0" width="100%">
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label">用户登入名</td>
							<td class="td-value" ><input type="text"
								id="loginName" name="loginName" style="width: 160px;" value="${paramMap.loginName}"/></td>
							<td class="td-label">姓名</td>
							<td class="td-value"><input type="text"
								id="realName" name="realName" style="width: 160px;" value="${paramMap.realName}"/></td>
						</tr>
						<tr>
							<td class="td-label">是否为借款人</td>
							<td class="td-value" >
							<select name="isBorrower">
							   <c:choose>
							       <c:when test='${paramMap.isBorrower=="1"}'>
							       		<option value="1" selected="selected">是</option>
							       </c:when>
							       <c:otherwise>
							       		<option value="" selected="selected">---请选择---</option>
							       		<option value="1">是</option>
							       </c:otherwise>
							   </c:choose>
							</select>
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
							<th>是否为借款人</th>
						</tr>
					</thead>
					<tbody id="memberList">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>