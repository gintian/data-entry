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
	
	var zNodes =[{"id":0, "pid":-1, "name":"资源管理",open: true},{"id":1, "pid":0, "name":"公共资源"},{"id":2, "pid":0, "name":"受控资源",open: true},{"id":3, "pid":0, "name":"管理员资源"},{"id":4, "pid":2, "name":"未分配受控资源"},{"id":5, "pid":2, "name":"已分配受控资源"}];
	
	$(document).ready(function(){
		zTree = $.fn.zTree.init($("#tree"), setting, zNodes);
		setSpace();
		var node = zTree.getNodeByParam("id", "${clkId}");
		if(node != null){
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
		var url = "${ctx}/resource/goList?authType="+treeNode.id;
		if(treeNode.id == 4){
			url = "${ctx}/resource/goList?auth=false&authType=2";
		}
		if(treeNode.id == 5){
			url = "${ctx}/resource/goList?auth=true&authType=2";
		}
		if(treeNode.id == 0){
			url = "${ctx}/resource/goList";
		}
		
		$("#testIframe").attr("src", url);
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
			<iframe id="testIframe" name="testIframe" frameborder=0 scrolling=auto width=100% src="${ctx}/resource/goList?auth=false&authType=2"></iframe>
		</td>
	</tr>
</table>
</body>
</html>


