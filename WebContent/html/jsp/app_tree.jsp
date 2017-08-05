<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <%@include file="/html/jsp/common.jsp" %>
    <script type="text/javascript">
    var mark = 1;
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
				clickTree(treeNode);
				return true;
			}
		}
	};
	
	var zNodes =${nodes};
	var t = [];
	var obj = {};
	
	$(document).ready(function(){
		initTree();
		
		for (var i=0, l=zNodes.length; i<l; i++) {
			zNodes[i].ino=i;
			t[zNodes[i]["id"]] = zNodes[i];
			if(!obj[zNodes[i]["pId"]]){
				obj[zNodes[i]["pId"]] = [];
			}
			if(Object.prototype.toString.apply(obj[zNodes[i]["pId"]]) === "[object Array]"){
				obj[zNodes[i]["pId"]].push(zNodes[i]);
			}
		}
		setSpace();
	});
	
	function initTree(){
		zTree = $.fn.zTree.init($("#tree"), setting, zNodes);
		extendNode();
	}
	
	function extendNode(){
		var node = zTree.getNodeByParam("id", "0");
		if(node != null){
			//zTree.expandNode(node);
			clickTree(node);
		}
	}
	
	function setSpace() {
		var width = parseInt(document.documentElement.scrollWidth);
		var height=$.clientHeight()-20;
		$("#mainTable").css("width",width+"px").css("height",height+"px");
		$("#tree").css("height",(height-25)+"px");
		$("#testIframe").css("height",$("#mainTable").css("height"));
	}
	
	//0-根节点 1-应用A 10-后台服务B  11-前台服务C 2-后台模块D  12-前台模块E  3-后台服务S 13-前台服务F 4-后台版本V  14-前台版本X
	function clickTree(treeNode){
		var appId="";
		var className="";
		var methodName="";
		var version="";
		
		if(treeNode.type == 1){
			appId = treeNode.appId;
		}
		if(treeNode.type == 2){
			appId= treeNode.getParentNode().appId;
			className = treeNode.className;
		}
		if(treeNode.type == 3){
			appId= treeNode.getParentNode().getParentNode().appId;
			className = treeNode.getParentNode().className;
			methodName = treeNode.methodName;
		}
		if(treeNode.type == 4){
			appId= treeNode.getParentNode().getParentNode().getParentNode().appId;
			className = treeNode.getParentNode().getParentNode().className;
			methodName = treeNode.getParentNode().methodName;
			version = treeNode.version;
		}
		
		if(typeof(beforeClkTree) == "function"){
			if(!beforeClkTree(appId, className, methodName, version)){
				return ;
			}
		}
		
		$("#appId").val(appId);
		$("#serviceInterface").val(className);
		$("#serviceMethod").val(methodName);
		$("#serviceVersion").val(version);
		
		var datas = $("#dataForm").serialize();
		
		setUrl(datas);
		
		if (treeNode.isParent) {
			zTree.expandNode(treeNode, true);
		}
		zTree.selectNode(treeNode);
	}
	
	function getNode(id){
		return zTree.getNodeByParam("id", id);
	}
	
	function search(){
		$("#searchText").keydown(function(event){
			if(event.keyCode == 13){
				var val = $.trim(this.value);
				if(val == ""){
					initTree();
					return ;
				}
				var dn = [];
				for (var i=0, l=zNodes.length; i<l; i++) {
					if(zNodes[i]["name"].indexOf(val) > -1){
						dn.push(zNodes[i]);
					}
				}
				var pns = [];
				for (i=0, l=dn.length; i<l; i++) {
					var node = dn[i];
					while(node["pId"] != null && t[node["pId"]]){
						if($.inArray(t[node["pId"]], pns) == -1){
							pns.push(t[node["pId"]]);
						}
						node = t[node["pId"]];
					}
				}
				var cNodes = [];
				for (i=0, l=dn.length; i<l; i++) {
					cNodes = cNodes.concat(pac(obj, dn[i],"id"));
				}
				var an = dn.concat(cNodes).concat(pns);
				for(i=an.length; i>=0; i--){
					for(var j=i-1; j>=0; j--){
						if(an[i] == an[j]){
							an.splice(j,1);
						}
					}
				}
				an=an.sort(function(a,b){return a.ino - b.ino;});
				zTree = $.fn.zTree.init($("#tree"), setting, an);
				
				var nodes = zTree.getNodesByParam("pId", "0");
				if(nodes.length < 10)
					zTree.expandAll(true);
			}
		});
	}
	
	
	function pac(obj, pn,mm){
		var ns = [];
		var cn = obj[pn[mm]];
		if(cn && Object.prototype.toString.apply(cn) === "[object Array]" && cn.length > 0){
			ns = ns.concat(cn);
			for(var i=0; i<cn.length; i++){
				ns= ns.concat(pac(obj,cn[i],mm));
			}
		}
		return ns;
	}
    </script>
</head>
<body style="width:100%;height:100%;border:0;overflow:hidden;">
<form action="" method="post" id="dataForm" style="width: 0px;height: 0px;display: none;">
	<input type="hidden" id="appId" name="appId" />
	<input type="hidden" id="serviceInterface" name="serviceInterface" />
	<input type="hidden" id="serviceMethod" name="serviceMethod" />
	<input type="hidden" id="serviceVersion" name="serviceVersion" />
</form>
<table id="mainTable" style="position: absolute;left: 0px;top: 0px;">
	<tr>
		<td width=200px align=left valign=top style="border: solid 1px #CCC;">
			<div >
				<input type="text" id="searchText" name="searchText" onkeyup="search()" title="搜索" style="width:187px;margin-left: 10px;margin-top: 3px;background-image: url('${resource}/images/search.jpg');background-repeat:no-repeat;background-position:right;"/>
			</div>
			<ul id="tree" class="ztree" style="width:200px; overflow:auto;margin-top: -4px;"></ul>
		</td>
		<td align=left valign=top>
			<iframe id="testIframe" name="testIframe" frameborder=0 scrolling=auto width=100% ></iframe>
		</td>
	</tr>
</table>
</body>
</html>


