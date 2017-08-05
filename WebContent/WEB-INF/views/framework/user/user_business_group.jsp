<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/html/jsp/common.jsp" %>

<script language="javascript">

$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"save", func:"save()", text:"保存"},
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
	]});
});

function save(){
	toolBar.disableBut("saveBut");
	showAjaxHtml({"wait": true});
	
	var idArr = [];
	$('input[name="businessGroup"]:checked').each(function(){
        var groupId=$(this).val();
           idArr.push(groupId);
        });
	
	$.ajax({
		url: "${ctx}/oa/common/businessGroup/doSetBusinessGroupSysUser",
		data : "userId=${userId}&groupIdS="+idArr.join(','),
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: 'json',
		cache: false,
		error: function(){
	        showAjaxHtml({"wait": false, "msg": '保存数据出错~'});
			toolBar.enableBut("saveBut");
	    },
	    success: function(obj){
	    	showAjaxHtml({"wait": false, "msg": obj.msg, "rs": obj.rs});
	    	if(obj.rs){
	    		$.info('设置用户业务组成功！');
	    		$.closeWin();
	    	}else{
	    		$.alert(obj.msg);
	    	}
		 }
	});
}

</script>
</head>
    
<body>
<div class="body-box-form" >
	<div class="content-form">
		<div class="panelBar" id="panelBarDiv"></div>
		<div class="infoBox" id="infoBoxDiv"></div>
		<div class="edit-form">
			<form action="" method="post" id="dataForm">
			  <table>
					     <c:forEach var="total" items="${totalBusinessGroup}" >
					     <tr>
					       <td>
					         <input name="businessGroup" type="checkbox" value="${total.pkBusinessGroup}"
					         <c:forEach var="has" items="${hasBusinessGroup}" >
					            <c:if test="${total.pkBusinessGroup == has.pkBusinessGroup}">
							      checked="checked"
					            </c:if>
					         </c:forEach>
					           />${total.businessGroupName}
					       </td>
					      </tr>
					     </c:forEach>
			 </table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
