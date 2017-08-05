<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
<%@include file="/html/jsp/common.jsp" %>
    <script type="text/javascript">
    var initSelIds = [];
	var zTree;

	var setting = {
			check: {
				enable: true,
				nocheckInherit: true
			},
			data: {
				simpleData: {
					enable:true,
					idKey: "id",
					pIdKey: "pId"
				},
				key:{
					name: "name"
				}
			}
		};
	
	var zNodes = [];
	var totalRoles = ${totalRoles};
	var hasRoles = ${hasRoles};
	
	$(document).ready(function(){
		new ToolBar({items:[
			{id:"saveBut", className:"save", func:"save()", text:"保存"},
			{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
		]});
		if($.browser.msie && parseInt($.browser.version)<=6){
			document.execCommand("BackgroundImageCache",false,true);//IE6缓存背景图片
		}
		
		zNodes.push({"id": 0, "pId": null, "name": "设置角色", "isParent": true,"open":true});
		
		var checked = false;
		for(var i=0; i<totalRoles.length; i++){
			checked = false;
			for(var j=hasRoles.length-1; j>=0;j--){
				if(totalRoles[i].roleId == hasRoles[j].roleId){
					checked = true;
					hasRoles.splice(j,1);
					break;
				}
			}
			zNodes.push({"id": totalRoles[i].roleId, "pId": 0, "name": totalRoles[i].roleName, "isParent": false,"checked": checked});
		}
		
		for(var i=0; i<hasRoles.length; i++){
			zNodes.push({"id": hasRoles[i].roleId, "pId": 0, "name": hasRoles[i].roleName, "isParent": false,"checked": true,"chkDisabled":true});
		}
		
		$.fn.zTree.init($("#tree"), setting, zNodes);
		zTree = $.fn.zTree.getZTreeObj("tree");
		
		zTree.expandAll(true);
	});
	
	function save(){
		toolBar.disableBut("saveBut");
		showAjaxHtml({"wait": true});
		
		var nodes = zTree.getCheckedNodes(true);
		var idArr = [];
		if(nodes != null && nodes.length > 0){
			for(var i=0;i<nodes.length;i++){
				if(!nodes[i].isParent){
					idArr.push(nodes[i].id);
				}
			}
		}
		for(var i=0; i<hasRoles.length; i++){
			if(idArr.indexOf(hasRoles[i].roleId) == -1){
				idArr.push(hasRoles[i].roleId);
			}
		}
		
		$.ajax({
			url: "${ctx}/user/doSetUserRole",
			data : "userId=${userId}&roleIdS="+idArr.join(','),
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
		    		$.info('设置用户角色成功！');
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
		<div style="flow:left;height:420px;overflow:auto;" id="treeDiv">
			<ul id="tree" class="ztree"></ul>
		</div>
	</div>
</div>
</body>
</html>


