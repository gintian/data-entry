<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>管理系统</title>
    <link href="${resource}/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="${resource}/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <script src="${resource}/tool/jquery.js" type="text/javascript"></script>
    <script src="${resource}/js/Common.js" type="text/javascript"></script>
    <script src="${resource}/ligerUI/js/ligerui.all.js" type="text/javascript"></script> 
    <script src="${resource}/zTree/js/jquery.ztree.all-3.5.js" type="text/javascript"></script>
    <script src="${resource}/tool/cookie.js" type="text/javascript"></script>
    
<script type="text/javascript">
var tab = null;
var accordion = null;
var tabNum = 0;

var zIndex = 1000;

var setting = {
	view: {
		dblClickExpand: false,
		showLine: true,
		selectedMulti: false,
		expandSpeed:""
	},
	
	data: {
		simpleData: {
			enable:true,
			idKey: "menuId",
			pIdKey: "parentId"
		},
		key:{
			name: "menuName"
		}
	},

	callback: {
		onClick: function(event, treeId, treeNode){
			var openType = treeNode.openType; //打开类型 
			var menuType = treeNode.menuType; //菜单类型
			var sUrl = "${ctx}" + treeNode.menuUrl;

			if(menuType == 3){
				if(openType && openType == 1){
                	f_addTab(treeNode.menuId, treeNode.menuName, sUrl);
				}else if(openType && openType == 2){
					$.fnShowWindow_mid(sUrl);
				}
			}else if(menuType == 2){
				zTree = $.fn.zTree.getZTreeObj(treeId);
				zTree.expandNode(treeNode, !treeNode.open);
			}
		}
	}
};

$(function (){
	$("#layout1").ligerLayout({ leftWidth: 190, height: '100%',heightDiff:-25,space:4, onHeightChanged: f_heightChanged });
	var height = $(".l-layout-center").height();
	$("#framecenter").ligerTab({ height: height });
	$("#accordion1").ligerAccordion({ height: height - 24, speed: null, changeHeightOnResize: true});
	$(".l-link").hover(function (){
		$(this).addClass("l-link-over");
	}, function (){
		$(this).removeClass("l-link-over");
	});
	tab = $("#framecenter").ligerGetTabManager();
	accordion = $("#accordion1").ligerGetAccordionManager();
	
	${js}
	$("#pageloading").hide();
	
	var h=parseInt($("#div_${firstTabId }").css("height"))-12;
	$("#layout1 div ul[class='ztree']").css("height" , h);
	
	try{
		$.fn.zTree.getZTreeObj("tab_17").expandAll(true);
		$.fn.zTree.getZTreeObj("tab_18").expandAll(true);
		$.fn.zTree.getZTreeObj("tab_71").expandAll(true);
		$.fn.zTree.getZTreeObj("tab_2").expandAll(true);
		$.fn.zTree.getZTreeObj("tab_34").expandAll(true);
		$.fn.zTree.getZTreeObj("tab_99").expandAll(true);
	}catch(e){
	}
});

function f_heightChanged(options){
	if(tab)
		tab.addHeight(options.diff);
	if(accordion && options.middleHeight - 24 > 0)
		accordion.setHeight(options.middleHeight - 24);
	var h=parseInt($("#div_${firstTabId }").css("height"))-12;
	$("#layout1 div ul[class='ztree']").css("height" , h);
}

function f_addTab(tabid,text, url){
    
	if(tab.isTabItemExist(tabid)){
        tab.selectTabItem(tabid);
    	tab.reload(tabid);
    }else{
    	if(tab.getTabItemCount() >= 15){
	    	$.alert('你打开的窗口太多，请先关闭一些再打开！');
	    	return ;
	    }
	    while(url.indexOf('//')==0){
	    	url = url.substring(1,url.length);
	    }
	    
	   	tab.addTabItem({ tabid : tabid,text: text, url: url });
    }
}

function loginOut(){
	$.ajax({
		    url: "${ctx}/loginOut",
		    type: 'post',
		    data: null,
		    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   	dataType: 'json',
		    error: function(){
		        window.location.href="${ctx}";
		    },
		    success: function(obj){
		    	$.cookie("userName", null);
	    		$.cookie("encryptedPwd", null); 
		    	window.location.href="${ctx}";
			}
		});
}

function changePassword(){
	$.openWin({url:"${ctx }/user/goChangePassword", width: 600, height: 300});
}
</script> 

<style type="text/css"> 
    body,html{height:100%;}
    body{ padding:0px; margin:0;   overflow:hidden;}  
    .l-link{ display:block; height:26px; line-height:26px; padding-left:10px; text-decoration:underline; color:#333;}
    .l-link2{text-decoration:underline; color:white; margin-left:2px;margin-right:2px;}
    .l-layout-top{background:#102A49; color:White;}
    .l-layout-bottom{ background:#E5EDEF; text-align:center;}
    #pageloading{position:absolute; left:0px; top:0px; background:white url('${resource}/images/loading.gif') no-repeat center; width:100%; height:100%;z-index:99999;}
    .l-link{ display:block; line-height:22px; height:22px; padding-left:16px;border:1px solid white; margin:4px;}
    .l-link-over{ background:#FFEEAC; border:1px solid #DB9F00;} 
    .l-winbar{ background:#2B5A76; height:30px; position:absolute; left:0px; bottom:0px; width:100%; z-index:99999;}
    .space{ color:#E7E7E7;}
 .l-topmenu{ margin:0; padding:0; height:40px; line-height:31px; background:url('${resource}/images/top.jpg') repeat-x bottom;  position:relative; border-top:1px solid #1D438B;  }
 .l-topmenu-logo{ color:#E7E7E7; padding-left:35px; line-height:40px;) no-repeat 10px 0px;}
 .l-topmenu-welcome{  position:absolute; height:40px; line-height:40px;  right:30px; top:0px;color:#070A0C;}
.l-topmenu-welcome a{ color:#E7E7E7; text-decoration:underline} 
 </style>
</head>
<body style="padding:0px;background:#EAEEF5;">  
<div id="pageloading"></div>  
<div id="topmenu" class="l-topmenu">
    <div class="l-topmenu-logo"> &nbsp;</div>
    <div class="l-topmenu-welcome">
        <span style="color: #E7E7E7;">${realName }&nbsp;您好</span>
        <span class="space">|</span>
        <a href="#" class="l-link2" onclick="changePassword()">修改密码</a> 
        <span class="space">|</span>
         <a href="#" class="l-link2" onclick="loginOut()">退出</a>
    </div> 
</div>
	<div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; "> 
	        <div position="left"  title="功能菜单" id="accordion1"> 
	              ${html }
	        </div>
	        <div position="center" id="framecenter"> 
	        <div tabid="home" title="我的主页" style="height:300px" >
            <iframe frameborder="0" name="home" id="home" src="${ctx }/user/goUserMainPage"></iframe>
        </div> 
	    </div> 
	</div>
	<div  style="height:25px; line-height:25px; text-align:center;margin:0px;">
	           Copyright &copy; 2017-2017 All rights reserved.  
    </div>
</body>
</html>
