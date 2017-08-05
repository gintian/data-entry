<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>短信列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/sms/goSave","title":'新增短信'});
}

function view(id){
	$.openWin({url: "${ctx}/sms/goView?id="+id,"title":'查看短信'});
}

</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/sms/goList" method="post" id="page_form" >
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
							<td class="td-label">短信内容</td>
							<td class="td-value">
								<input type="text" id="content" name="content" style="width:160px;" value="${item.content}" />
							</td>
							<td class="td-label">短信类型</td>
							<td class="td-value">
								<input type="text" id="smsType" name="smsType" style="width:160px;" value="${item.smsType}" />
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
            <tag:auth authCode="SMS_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>手工添加短信</span>
						</a>	
                    </li>
            </tag:auth>
                    <li class="line"></li>
                </ul>
				<div class="clear_float"> </div>
			</div><!--panelBar end-->
			
			<div class="content-list">
				<table cellpadding="0" cellspacing="0" id="gridTable">
					<col width="3%"/>
					<col width="25%"/>
					<col width="10%"/>
					<col/>
					<col width="20%"/>
					<col width="10%"/>
					<col width="4%"/>
					<col width="10%"/>
					<col width="6%"/>
					<thead>
						<tr>
							<th>
								序号
							</th>
							<th>
								短信内容
							</th>
							<th>
								短信类型
							</th>
							<th>
								接收号码
							</th>
							<th>
								返回信息
							</th>
							<th>
								返回时间
							</th>
							<th>
								重发次数
							</th>
							<th>
								返回状态
							</th>
							<th>
								状态
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${page.datas}"  varStatus="item_index">
						<tr >
							<td class="td-seq">
								${item_index.index+1}
							</td>
							<td title="${item.content}">
								<a href="#" onclick="view('${item.id}')">${item.content}</a>
							</td>
							<td title="${item.smsType}">
								${item.smsType}
							</td>
							<td title="${item.toPhones}">
								${item.toPhones}
							</td>
							<td title="${item.resMsg}">
								${item.resMsg}
							</td>
							<td>
								<fmt:formatDate value="${item.recTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td title="${item.retryTime}">
								${item.retryTime}
							</td>
							<td>
								<tag:dict id="S" dictCode="SMS_STATUS_CODE" value="${item.resStatus }" readonly="true"></tag:dict>
							</td>
							<td>
								<c:if test="${item.status == 1}">待发送</c:if>
								<c:if test="${item.status == 2}">发送成功</c:if>
								<c:if test="${item.status == 3}"><font color="red">发送失败</font></c:if>
								<c:if test="${item.status == 4}">忽略</c:if>
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