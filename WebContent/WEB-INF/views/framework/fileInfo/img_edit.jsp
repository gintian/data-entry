<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="overflow: hidden;">
<head>
	<title>缩放截图</title>
<%@include file="/html/jsp/common.jsp" %>
<script type="text/javascript">
var imgSel;
var emptyRs = {x1: 0,y1: 0,width:0, height:0};
var rs = emptyRs;
var flag = true;

$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"save", func:"save()", text:"保存"},
		{id:"enlargeBut", className:"enlarge", func:"enlarge('1','1')", text:"放大"},
		{id:"reduceBut", className:"reduce", func:"enlarge('-1','-1')", text:"缩小"},
		{id:"restoreBut", className:"restore", func:"resetImg('${fileInfo.width }','${fileInfo.height }')", text:"还原"},
		{id:"closeBut", className:"close", func:"$.closeWin();return false;", text:"关闭"}
	]});

	var pageHeight = $.clientHeight()-30;
	if(pageHeight < 360)
		pageHeight = 360;
	$("#imgFrame,#imgTable").css("height",pageHeight);
	$("#emptyDiv").css("height",pageHeight-180)
	
	$("#userWidth,#userHeight").keydown(function(event){
		if(event.keyCode == 13){
			resetImg(parseInt($('#userWidth').val()), parseInt($('#userHeight').val()));
		}
	}).blur(function(event){
		resetImg(parseInt($('#userWidth').val()), parseInt($('#userHeight').val()));
	});
});

function resetImg(width, height){
	zoom({radioX:0, radioY: 0, width: width, height: height});
	rs = emptyRs;
}

function enlarge(radioX, radioY){
	zoom({radioX:parseInt(radioX), radioY: parseInt(radioY), width: 0, height:0});
}

function zoom(param){
	var e={data:{stepX:param.radioX, stepY: param.radioY, width: param.width, height: param.height}};
	imgSel.zooming(e);
	$("#userWidth").val(imgFrame.getPicInfo().width);
	$("#userHeight").val(imgFrame.getPicInfo().height);
	
	$("#widthRadio").html(Math.round(imgFrame.getPicInfo().width/${fileInfo.width }*100) /100);
	$("#heightRadio").html(Math.round(imgFrame.getPicInfo().height/${fileInfo.height }*100) /100);
	rs = emptyRs;
}

function preview(img, selection) {
	rs = selection;
    $("#userWidth").val(selection.width);
    $("#userHeight").val(selection.height);
}

function save(){
	if(imgFrame.getPicInfo().width == ${fileInfo.width } && imgFrame.getPicInfo().height == ${fileInfo.height } && rs.x1 == 0){
		$.getWindow().close();
		return ;
	}
	var userWidth = parseInt($('#userWidth').val());
	var userHeight = parseInt($('#userHeight').val());
	
	if(userWidth<1 || userHeight<1){
		$.alert("图片长宽值不能小于1");
		return ;
	}
	
	if(userWidth>2000 || userHeight>2000){
		$.alert("图片长宽值不能大于2000");
		return ;
	}
	
	toolBar.disableBut(["saveBut","enlargeBut","reduceBut","restoreBut"]);
	showAjaxHtml({"wait": true});

	var datas = {fileId: "${fileId}",nodeX: rs.x1, nodeY: rs.y1, nodeW: rs.width,nodeH: rs.height, width: userWidth,height: userHeight,divWidth: imgFrame.getPicInfo().width,divHeight: imgFrame.getPicInfo().height};
	$.ajax({
		url:'${ctx}/fileInfo/doEditImg',
		type: 'post',
		data: datas,
		dataType: 'json',
		cache: false,
		error: function(obj){
			showAjaxHtml({"wait": false, "msg": '保存数据出错~'});
			toolBar.enableBut(["saveBut","enlargeBut","reduceBut","restoreBut"]);
	    },
	    success: function(obj){
	    	showAjaxHtml({"wait": false, "msg": obj.msg, "rs": obj.rs});
	    	if(obj.rs){
				$.info(obj.msg, function(){
					$.getWinOpener().changeImage_${tagId}(obj.datas);;
					$.getWindow().close();
				});
	    	}else{
	    		toolBar.enableBut(["saveBut","enlargeBut","reduceBut","restoreBut"]);
	    	}
	    }
	 });
}
</script>
</head>
<body style="overflow: hidden;">
<div class="body-box-form" style="height:100%">
	<div class="content-form" >
		<div class="panelBar" id="panelBarDiv"></div>
		<div class="infoBox" id="infoBoxDiv"></div>
		<div class="edit-form">
			<table cellspacing="0" cellpadding="0" width="100%" id="imgTable">
				<col  width="" />
				<col  width="200px"/>
				<tbody>
					<tr>
						<td>
							<iframe id="imgFrame" name="imgFrame" src="${ctx }/fileInfo/goSplitImg?fileId=${fileId }&finalWidth=${finalWidth }&finalHeight=${finalHeight }"
								width="100%" height="100%" frameborder="0" scrolling="auto" ></iframe>
						</td>
						<td>
							<div style="height: 95px;border:1px solid #879DB1;">
								<span style="color: #183152;font-weight: bold;line-height: 26px;">图片信息：</span><br/>
								<span style="margin-left:5px;">宽度:</span>
								<input type="text" id="userWidth" name="userWidth" value="${fileInfo.width }" title="截取图片宽度,最大2000px" onkeyup="value=value.replace(/[^\d]/g,'')" value="${finalWidth}" style="padding-left:5px;width: 35px;" maxlength="4"/>(px) <br/>
								<span style="margin-left:5px;">高度:</span>
								<input type="text" id="userHeight" name="userHeight" value="${fileInfo.height }" title="截取图片高度,最大2000px" onkeyup="value=value.replace(/[^\d]/g,'')" value="${finalHeight}" style="padding-left:5px;width: 35px;" maxlength="4"/>(px)<br/>
								<span style="margin-left:5px;">缩放:</span>
								<span id="widthRadio" style="padding:0px 2px 0px 2px;">1</span> : <span id="heightRadio" style="padding:0px 2px 0px 2px;">1</span> (倍)<br/>
							</div>
							
							<div style="height: 80px;border:1px solid #879DB1;margin-top: 2px;">
								<span style="color: #183152;font-weight: bold;line-height: 26px;">原图信息：</span><br/>
								<span style="margin-left:5px;">名称：</span> ${fileInfo.fileName }<br/>
								<span style="margin-left:5px;">像素：</span> ${fileInfo.width } * ${fileInfo.height } <br/>
								<span style="margin-left:5px;">大小：</span> ${fileInfo.sizeKB } (KB) <br/>
							</div>
							<div id="emptyDiv">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>