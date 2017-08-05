<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow:hidden;">
<head>
    <title>部门 树</title>
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
				name: "deptName"
			},
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pid",
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
	
	var zNodes =${nodes};
	
	$(document).ready(function(){
		for(var i=0; i<zNodes.length; i++){
			zNodes[i].open = true;
		}
		
		zNodes.push({id:0,pid:null,deptName:"${rootName}"});
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
		$("#listFrame").css("height",$("#mainTable").css("height"));
	}
	
	function clickTree(treeNode){
		$("#listFrame").attr("src", "${ctx}/dept/goList?pid="+treeNode.id);
	}
	
	function addNode(id, name, pid){
		var parentNode = getNode(pid);
		var newNode = {"id":id, "name":name};
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
	
	function getNode(id){
		return zTree.getNodeByParam("id", id);
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
			<iframe id="listFrame" name="listFrame" frameborder=0 scrolling=auto width=100% ></iframe>
		</td>
	</tr>
</table>
</body>
</html>


