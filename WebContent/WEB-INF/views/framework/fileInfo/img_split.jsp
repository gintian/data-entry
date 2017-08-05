<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	<title>缩放截图</title>
	
<link rel="stylesheet" type="text/css" href="${resource}/css/imgareaselect-default.css" />
<script language="javascript" src="${resource}/tool/jquery.js"></script>
<script type="text/javascript" src="${resource}/tool/jquery.imgareaselect.js"></script>

<script language="Javascript">
var vPath = "${resource}";

$(document).ready(function () {
	parent.imgSel = $('#imgSrcObj').imgAreaSelect({
	fadeSpeed: 200,
	instance: true,
	handles: true, 
	onSelectChange: preview
	});
});

function preview(img, selection){
	window.parent.preview(img, selection);
}

function getPicInfo(){
	return {"width": parseInt($("#imgSrcObj").css("width")),"height":parseInt($("#imgSrcObj").css("height"))};
}
</script>
</head>

<body style="padding:0;margin:0;">
	<div style="float:left" id="imgDiv">
		<img id="imgSrcObj" src="${fileInfo.urlPath }" width="${fileInfo.width }px" height="${fileInfo.height }px" border="0" />
	</div>
</body>
</html>
