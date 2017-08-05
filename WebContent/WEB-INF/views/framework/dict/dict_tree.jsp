<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow:hidden;">
<head>
    <title></title>
    <%@include file="/html/jsp/common.jsp" %>
    <script type="text/javascript">
	var zTree;

	var setting = {
		view: {
			dblClickExpand: false,
			showLine: true,
			selectedMulti: false,
			expandSpeed: ($.browser.msie && parseInt($.browser.version)<=6)?"":"fast"
		},
		
		data: {
			key: {
				name: "name"
			},
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: null
			}
		},

		callback: {
			beforeClick: function(treeId, treeNode) {
				if (treeNode.isParent) {
					zTree.expandNode(treeNode, true);
				}
				clickTree(treeNode);
				return true;
			}
		}
	};
	
	var zNodes = [];
	var dictNodes =${dictNodes};
	var itemNodes =${itemNodes};
	
	$(document).ready(function(){
		zNodes.push({id:"0", name:"字典管理", pId:null, isParent: true});
		for(var i=0; i<dictNodes.length; i++){
			zNodes.push({id: dictNodes[i].dictId+"", name: dictNodes[i].dictName, pId: "0", isParent: true });
		}
		for(var i=0; i<itemNodes.length; i++){
			zNodes.push({id: "I_"+itemNodes[i].dictItemId, name: itemNodes[i].itemName, pId: itemNodes[i].dictId+"", isParent: false});
		}
		
		zTree = $.fn.zTree.init($("#tree"), setting, zNodes);
		setSpace();
		var node = zTree.getNodeByParam("id", "${clkId}");
		if(node != null){
			zTree.expandNode(node);
			clickTree(node);
		}
	});
	
	function setSpace() {
		var width = parseInt(document.documentElement.scrollWidth);
		var height=$.clientHeight()-20;
		$("#mainTable").css("width",width+"px").css("height",height+"px");
		$("#tree").css("height",height+"px");
		$("#testIframe").css("height",$("#mainTable").css("height"));
	}
	
	function clickTree(treeNode){
		if(treeNode.id == 0){
			$("#testIframe").attr("src", "${ctx}/dict/goList");
		}else if(treeNode.pId == 0){
			$("#testIframe").attr("src", "${ctx}/dictItem/goList?dictId="+treeNode.id);
		}else{
			var id = treeNode.id;
			id=id.substring(2,id.length);
			$("#testIframe").attr("src", "${ctx}/dictItem/goView?dictItemId="+id);
		}
	}
	
	function addNode(id, name, pid, isParent){
		var parentNode = getNode(pid);
		var newNode = {"id":id, "name":name, "isParent": isParent};
		zTree.addNodes(parentNode, newNode);
	}
	
	function updateNode(id, name){
		var node = getNode(id);
		if(node != null){
			node.name = name;
			zTree.updateNode(node);
		}else{
			window.location.reload();
		}
	}
	
	function removeNode(id){
		var node = getNode(id);
		if(node != null)
			zTree.removeNode(node);
	}
	
	function getNode(dictId){
		
		return zTree.getNodeByParam("id", dictId);
	}
    </script>
</head>
<body style="width:100%;height:100%;border:0;overflow:hidden;">
<table id="mainTable" style="position: absolute;left: 0px;top: 0px;">
	<tr>
		<td width=200px align=left valign=top style="border: solid 1px #CCC;">
			<ul id="tree" class="ztree" style="width:200px; overflow:auto;"></ul>
		</td>
		<td align=left valign=top>
			<iframe id="testIframe" name="testIframe" frameborder=0 scrolling=auto width=100% ></iframe>
		</td>
	</tr>
</table>
</body>
</html>


