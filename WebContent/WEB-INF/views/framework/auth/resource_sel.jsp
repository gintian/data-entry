<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>资源列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function sel(){
	var idArr = grid.getSelectIds();
	if(idArr.length < 1){
		$.alert('请选择记录');
		return ;
	}
    $.ajax({
		url : "${ctx}/resource/doSelRes?authId=${authId}&resIds="+idArr.join(','),
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: 'json',
		type: 'post',
		cache: false,
		error: function(){
	        $.alert('选择记录出现异常');
	    },
	    success: function(obj){
	    	if(obj.rs){
	    		$.info(obj.msg, function(){
					$.getWindow().close();
				});
	    	}else{
				$.alert(obj.msg);
	    	}
		}
	});
}

function colseWin(){
	$.closeWin();
	return false;
}
</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/resource/goSelList?authId=${authId}" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">url</td>
							<td class="td-value" colspan="3">
								<input type="text" id="url" name="url" style="width:160px;" value="${url }" />
							</td>
						</tr>
						<tr>
							<td colspan="6" class="td-btn">
								<div class="sch_qk_con"> 
									<input onclick="grid.goPage(1);"  class="i-btn-s" type="button"  value="检索"/>
									<input onclick="grid.clearForm();"  class="i-btn-s" type="button"  value="清空"/>
								</div>
						  	</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div><!--query-form-->
		<div class="pageContent">
		<!--panelBar-->
			<div class="panelBar" id="panelBarDiv">
            	<ul>
            <tag:auth authCode="AUTH_SEL">
                	<li>
                    	<a href="#" class="a1" onclick="sel()">
					       <span>选择</span>
						</a>	
                    </li>
            </tag:auth>
            	<li>
                   	<a href="#" class="a2" onclick="colseWin()">
				       <span>关闭</span>
					</a>	
                   </li>
                </ul>
				<div class="clear_float"> </div>
			</div><!--panelBar end-->
			<div class="content-list">
				<table cellpadding="0" cellspacing="0" id="gridTable">
					<col width="3%"/>
					<col width="3%"/>
					<col />
					<col />
					<col />
					<col />
					<thead>
						<tr>
							<th>
								序号
							</th>
							<th>
								
							</th>
							<th>
								url
							</th>
							<th>
								所属权限
							</th>
							<th>
								资源类型
							</th>
							
							<th>
								资源备注
							</th>
						</tr>
					</thead>
					<tbody>
						<%
								List<Long> resIds = (List<Long>)request.getAttribute("resIds");
								boolean check = true;
								if(resIds == null){
									check = false;
								}
							%>
						<c:forEach var="item" items="${page.datas}"  varStatus="item_index">
						<tr >
							<td class="td-seq">
								${item_index.index+1}
							</td>
							<td class="td-center">
							<%
								Map<String, Object> map = (Map<String, Object>)pageContext.getAttribute("item");
								if(check && resIds.contains(Long.parseLong(map.get("resId").toString()))){
									%><input type="checkbox" value="${item.resId }" checked="checked" /><%
								}else{
									%><input type="checkbox" value="${item.resId }" /><%
								}
							%>
							</td>
							<td title="${item.url}">
								${item.url}
							</td>
							<td title="${item.authName}">
								${item.authName}
							</td>
							<td >
								<c:if test="${item.authType == 1 }">公共资源</c:if>
								<c:if test="${item.authType == 2 }">受控资源</c:if>
								<c:if test="${item.authType == 3 }">管理员资源</c:if>
							</td>
							<td title="${item.info}">
								${item.info}
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<%@include file="/html/jsp/pager.jsp" %>
		</div> 
	</div>
</body>
</html>


