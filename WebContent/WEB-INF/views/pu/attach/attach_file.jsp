<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.whale.pu.attach.domain.AttachFile"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>文件列表管理</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript" src="${resource}/webuploader/webuploader.js"></script>
<style>
.attachwrap { border: 1px solid #dddddd; border-bottom: none; }
.attachwrap .mainlink { position: relative; display: block; height: 35px; line-height: 35px; background:#e6f2fe; padding: 0 10px; font-size: 16px; color: #666; border-bottom: 1px solid #5bc0de; }
.attachwrap .attachlist li { position: relative; height: 40px; border-bottom: 1px solid #dddddd; }
.attachwrap .attachlist li a.name { display: inline-block;max-width:85%; height: 40px; line-height: 40px; padding: 0 10px; font-size: 14px; color: #666; vertical-align: middle; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;  }
.attachwrap .attachlist li a.name_wn { cursor: default; display: inline-block;max-width:85%; height: 40px; line-height: 40px; padding: 0 10px; font-size: 14px; color: #666; vertical-align: middle; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;  }
.attachwrap .attachlist li a.btn_del { display: block; position: absolute; top: 8px; right: 10px; width: 25px; height: 25px; line-height: 25px;font-family: "Arial"; border-radius: 50%; background: rgba(0,0,0,0.2); text-align: center; font-size: 16px; color: #ffffff; }
.attachwrap .attachlist li a.btn_del:hover { opacity: 0.7;}
.attachwrap .attachlist li a.btn_del:active { opacity: 1; background: rgba(0,0,0,0.4);}
.attachwrap .attachlist li a.name:hover { text-decoration: underline;}
.attachwrap .attachlist li a.name:active { text-decoration: underline; color: #333; }
.attachwrap .attachlist li a.btn_download { display: block; position: absolute; top: 8px; right: 45px; width: 25px; height: 25px; line-height: 25px; border-radius: 50%; background: url(${resource}/images/btn_download.png) rgba(0,0,0,0.2); }
.attachwrap .attachlist li a.upload_cancle { display: inline-block; height: 40px; line-height: 40px; padding-left: 20px; vertical-align: middle; margin:0 20px; }
.attachwrap .attachlist li a.upload_cancle:hover { text-decoration: underline;}
.attachwrap .attachlist li a.upload_cancle:active { text-decoration: underline; color: #333; }
.attachwrap .progress { display: inline-block; height: 40px; line-height: 40px; padding-left: 20px; vertical-align: middle; margin:0 20px; }
.attachwrap .progress.status_yes { background: url(${resource}/images/upload_yes.png) no-repeat left center; }
.attachwrap .progress.status_no { background: url(${resource}/images/upload_no.png) no-repeat left center; }
.attachwrap .progress.status_wait { background: url(${resource}/images/upload_wait.gif) no-repeat left center; }
.attachwrap .btn_downloads { position: relative; display: inline-block; cursor: pointer; background: #e6f2fe; padding: 5px 15px; margin:10px; color: #666; text-align: center; border-radius: 3px; border: none; overflow: hidden; }
</style>
<script language="javascript">
//存放流程某个环节上传的附件ID
var attachIdArr = [];
$(function() {
	var $list_attach = $('.attachlist'),
		uploader_attach;
		
	uploader_attach = WebUploader.create({
		auto: true,
		swf: '${resource}/webuploader/Uploader.swf',
		server: '${ctx}/attach/doFileUpload',
		pick: window.parent.document.getElementById('attachmentUploadBtn'),
		duplicate:true,
		fileSingleSizeLimit: 1024*1024*100,
		formData: {
			saveWay: "${saveWay }"
		}
	});

	uploader_attach.on('fileQueued', function(file) {
		$list_attach.append('<li id="' + file.id + '" class="item">' +
			'<a href="#" class="name_wn">' +file.name+'</a>'+
			'<a href="#" onclick="downAttach(this)" class="btn_download"></a>'+
			'<a href="#" onclick="delAttach(this)" class="btn_del">X</a>'+
		'</li>'
		);
		document.getElementById(file.id).scrollIntoView();
	});

	uploader_attach.on('uploadProgress', function(file, percentage) {
		var $li = $('#'+file.id ),
			$percent = $li.find('.progress');
		if(!$percent.length) {
			$percent = $li.find('.name_wn').after('<span class="progress status_wait"></span>').find('span');
		}
		$percent.html('正在上传');
	});

	uploader_attach.on('uploadSuccess', function(file, response) {
		if(response.rs){
			$( '#'+file.id ).attr('fileid',response.datas.pkAttachFile);
			var $n = $( '#'+file.id ).find('.name_wn');
			if(response.datas.fileType == 2){
				$n.attr('class','name').attr("onclick", "browsePic('"+response.datas.urlPath+"')");
			}
			var $a = $( '#'+file.id ).find('.btn_download');
			$a.attr('fileid',response.datas.pkAttachFile).attr('url', response.datas.urlPath);
			var fileVal = $('#attachHiddenId').val();
			if(fileVal == '' || fileVal == null || fileVal == undefined){
				$('#attachHiddenId').val(response.datas.pkAttachFile + ",");
			}else{
				$('#attachHiddenId').val(fileVal + response.datas.pkAttachFile + ",");
			}
			var newItemNum = parseInt($('#itemNumId').html()) + 1;
			$('#itemNumId').html(newItemNum);
			newItemNum > 0 ? $('#batchDown').css({'display':'block'}) : $('#batchDown').css({'display':'none'});
			$( '#'+file.id ).find('.progress').removeClass('status_wait').addClass('status_yes').html('上传成功');
			attachIdArr.push(response.datas.pkAttachFile);
		}else{
			uploadError(file, response);
		}
	});

	uploader_attach.on('uploadError', function(file, response) {
		uploadError(file, response);
	});

	uploader_attach.on('uploadFinished', function(file) {
	});
	
	uploader_attach.on('error', function(type) {
		if(type == 'F_EXCEED_SIZE'){
			$.alert('文件超过100M，请重新选择上传！');
		}
	});
	
	function uploadError(file, response) {
		$( '#'+file.id ).find('.progress').removeClass('status_wait').addClass('status_no').html('上传失败:'+response.msg);
	}
	
	$(".mainlink").on("click",function(){
		var own = $(this).siblings(".attachlist");
		if(own.hasClass("current")){
			own.removeClass("current");
			own.slideDown();
		}
		else{
			own.addClass("current");
			own.slideUp();
		}
	});	
	
	$("#batchDown").on("click",function(){
		var attachIds = $("#attachHiddenId").val();
		if(attachIds && attachIds.length > 0){
			attachIds = attachIds.substring(0, attachIds.length-1);
		}
		window.location.href = '${ctx}/attach/doBatchDownload?attachIds='+attachIds+'&saveWay=${saveWay }';
	});	
	
 });
	/**
	 *  单附件下载
	 */
	function downAttach(obj){
		var attachId = $(obj).attr('fileid');
		window.location.href = '${ctx}/attach/doDownload?attachId='+attachId;
	}
	/**
	 *  图片浏览
	 */
	function browsePic(urlPath){
		window.open(urlPath) ;
	}
	/**
	 *  附件删除
	 */
	function delAttach(ob){
		var fileId = $(ob).parent().attr('fileid');
		$.confirm({info:'您确定要删除该附件吗？', ok: function(){
		$.ajax({
			url: '${ctx}/attach/doDelete?attachId='+fileId,
			type: 'post',
			data: null,
			dataType: 'json',
			cache: false,
			error: function(obj){$.alert('删除附件出错');},
		    success: function(obj){
		    	if(obj.rs){
					$(ob).parent().remove();
					//删除本环节提交的附件列表
					for(var k=0; k<attachIdArr.length; k++){
						if(parseInt(attachIdArr[k]) == parseInt(fileId)){
							attachIdArr.splice(k, 1);
							break;
						}
					}
					var fileVal = $('#attachHiddenId').val();
					if(fileVal != null && fileVal.length > 0){
						var fileVals = fileVal.split(',');
						for(var i=0; i<fileVals.length; i++){
							if(parseInt(fileVals[i]) == parseInt(fileId)){
								fileVals.splice(i, 1);
								$('#attachHiddenId').val(fileVals.join(','));
							}
						}
					}
					var newItemNum = parseInt($('#itemNumId').html()) - 1;
					$('#itemNumId').html(newItemNum);
					newItemNum <= 0 ? $('#batchDown').css({'display':'none'}) : $('#batchDown').css({'display':'block'});
		    	}else{
		    		$.alert(obj.msg);
		    	}
		    }
		 });
	}});
 }
	/**
	 *  获取当前环节上传的附件列表
	 */
	function getTaskNodeAttachs(){
		return  attachIdArr; 
	}
	
	
</script>
</head>
<body>

	<div id="attachDiv" class="attachwrap">
		<a href="#" class="mainlink">附件（<span id="itemNumId">${fn:length(list) }</span>）</a>
			<ul class="attachlist">
				<%
					String attachIds = "";
					int i = 0;
					List atList = (List)request.getAttribute("list");
				%>
				<c:forEach var="item" items="${list}"  varStatus="item_index">
					<li id="${item.pkAttachFile}" class="item" fileid="${item.pkAttachFile}">
						<c:choose>
							<c:when test="${item.fileType == 2}">
								<a href="#" onclick="browsePic('${item.urlPath }')" class="name">${item.realFileName }</a>
							</c:when>
							<c:otherwise>
								<a href="#" class="name_wn">${item.realFileName }</a>
							</c:otherwise>
						</c:choose>
						<a href="#" onclick="downAttach(this)" fileid="${item.pkAttachFile}" url="${item.urlPath }" class="btn_download"></a>
						<c:if test="${readOnly==false }">
							<a href="#" onclick="delAttach(this)" class="btn_del">X</a>
						</c:if>
					</li>
					<%  
						attachIds += ((AttachFile)atList.get(i++)).getPkAttachFile() + ",";
					%>
				</c:forEach>
			</ul>
		<input type="hidden" id="attachHiddenId" name="attachHiddenId" value="<%=attachIds%>"/>
		<button id="batchDown" class="btn_downloads" style="
			<c:if test="${fn:length(list) <= 0}">
			  display:none;
			</c:if>
		">批量下载</button>
	</div>
</body>
</html>