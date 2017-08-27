<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>列表</title>
<%@include file="/html/jsp/common.jsp" %>
<link href="${ctx}/html/css/flowPage.css" rel="stylesheet" />
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/de/recFile/goSave?dictFileSource="+$("#DICT_FILE_SOURCE").val(), "title":'新增信息'});
}

function update(id){
	$.openWin({url: "${ctx}/de/recFile/goUpdate?id="+id,"title":'编辑信息'});
}

function view(id){
	$.openWin({url: "${ctx}/de/recFile/goView?id="+id,"title":'查看信息'});
}

function del(id){
	var idArr = id || grid.getSelectIds();
	if(idArr.length < 1){
		$.alert('请选择需要删除的记录');
		return ;
	}
	 
	$.confirm({
		 info:'您确定要删除记录吗？',
		 ok: function () {
		 	var url = "${ctx}/de/recFile/doDelete";
			var reqParam = "ids="+idArr.join(',');
			ACF.ajaxForm.post(url,reqParam,function(obj){
				$.info(obj.msg, function(obj){
					grid.reload();
				});
			});
		}
	});
}

function handle(id){
	$.confirm({
		 info:'您确定要办结吗？',
		 ok: function () {
		 	var url = "${ctx}/de/recFile/doHandle";
			var reqParam = "id="+id;
			ACF.ajaxForm.post(url,reqParam,function(obj){
				$.info(obj.msg, function(obj){
					grid.reload();
				});
			});
		}
	});
}

function proposed(id){
	$.openWin({url: "${ctx}/de/recFile/goProposedView?id="+id,"title":'查看拟办单'});
}

/**
 * 导出Excel表格
 */
function doExcel(){
	$.form_submit($("#page_form").get(0), {
 		"action": "${ctx}/de/recFile/doSignExcel"
	}); 
	$("#page_form").attr("action","${ctx}/de/recFile/goSignList");
}
</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/de/recFile/goSignList" method="post" id="page_form" >
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
								 	<td class="td-label">收文日期</td> 
								  	<td class="td-value">
										   	  <input type="text" class="cdate" id="REC_DATE" name="REC_DATE"  onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.REC_DATE}"/>
								  </td>
								  <td class="td-label">文件标题</td> 
								  	<td class="td-value">
										   	   <input type="text"  name="FILE_TITLE" style="width:160px;" value="${paramMap.FILE_TITLE}" />
								  </td>
								 </tr>
							     <tr>
								 	<td class="td-label">签收单位</td> 
								  	<td class="td-value">
										   	   <input type="text"  name="ORG_COMPANY" style="width:160px;" value="${paramMap.ORG_COMPANY}" />
								  </td>
								  	 <td class="td-label">是否签收</td> 
								 	<td class="td-value">
											  <select name="SIGN_UP_STATUS" style="width:165px;">
											   		<option value=""  <c:if test="${paramMap.SIGN_UP_STATUS ==''}">selected="selected"</c:if>>--请选择--</option>
											   		<option value="1" <c:if test="${paramMap.SIGN_UP_STATUS == '1'}">selected='selected'</c:if>>是</option>
											   		<option value="0" <c:if test="${paramMap.SIGN_UP_STATUS == '0'}">selected='selected'</c:if>>否</option>
											   </select>
								 	 	</td>
								 </tr>
								 <tr>
								 	<td class="td-label">文号</td> 
								  	<td class="td-value">
										   	   <input type="text"  name="FILE_CODE" style="width:160px;" value="${paramMap.FILE_CODE}" />
								  </td>
								 </tr>
						<tr>
							<td colspan="4" class="td-btn">
								<div class="sch_qk_con"> 
									<input onclick="grid.goPage(1);"  class="i-btn-s" type="button"  value="检索"/>
									<input onclick="grid.clearForm();"  class="i-btn-s" type="button"  value="清空"/>
										<a href="#" onclick="grid.queryMore('open');" id="open-query-more" class="open" style="color: black;">展开</a>
										<a href="#" onclick="grid.queryMore('close');" id="close-query-more" class="close" style="display:none;color: black;">关闭</a>
										<input type="hidden" id="queryMoreFlag" value="${queryMoreFlag}" name="queryMoreFlag"/>									
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
            		<li>
						<a href="#" class="excelExport" onclick="doExcel()" title="导出检索条件数据">
							<span>导出</span>
						</a>
					</li>
                    <li class="line"></li>
                </ul>
				<div class="clear_float"> </div>
			</div><!--panelBar end-->

			<div class="content-list">
				<table cellpadding="0" cellspacing="0" id="gridTable">
				<!-- 	<col width="3%"/> -->
					<col width="3%"/>
					<col width="10%"/>
					<col width="6%"/>
					<col width="6%"/>
					<col width="8%"/>
					<col width="15%"/>
					<col width="8%"/>
					<col width="4%"/>
					<!-- <col width="6%"/> -->
					<col width="4%"/>
					<col width="4%"/>
					<col width="5%"/>
					<col width="8%"/>
					<col width="4%"/>
					<col width="4%"/>
					<thead>
						<tr>
							 <th>
								序号
							</th>
							<!--<th>
								<input type="checkbox" id="ck_all" onclick="grid.checkAll()" /> 
							</th> -->
								<!-- <th>
									操作
								</th> -->
								<!-- <th>
									文件来源
								</th> -->
								<th>
									收文号
								</th>
								<th>
									收文日期
								</th>
								<th>
									来文单位
								</th>
								<th>
									文件类别
								</th>
								<th>
									文件标题
								</th>
								<th>
									文号
								</th>
								<th>
									密级
								</th>
								<!-- <th>
									密级编号
								</th> -->
								<th>
									等级
								</th>
								<th>
									文件数量
								</th>
								<th>
									办理时效
								</th>
								<!-- <th>
									是否办结
								</th> -->
								<!-- <th>
									是否拟办
								</th> -->
								<th>
									签收单位
								</th>
								<th>
									签收状态
								</th>
								<th>
									修改用户
								</th>
					</thead>
					<tbody>
						<c:forEach var="item" items="${page.datas}"  varStatus="item_index">
						<tr <c:if test="${item.IS_OVERTIME == 1}">style="color:red"</c:if>>
							<td class="td-seq" style="color:#000">
								${item_index.index+1}
							</td>
							<%-- <td class="td-center">
										<input type="checkbox" value="${item.PK_REC_FILE }" index="${item_index.index+1}" status="${item.status}"/>
							</td> --%>
							
									<%-- <td class="td-center">
										<a href="#" onclick="update('${item.PK_REC_FILE}')">
											编辑
										</a>
										<a href="#" onclick="view('${item.PK_REC_FILE}')">
												查看
										</a>
										<c:if test="${item.IS_OVERTIME == 1}">
											<a href="#" onclick="handle('${item.PK_REC_FILE}')">
													办结
											</a>
										</c:if>
										<c:if  test="${item.IS_PROPOSED==1 and (paramMap.DICT_FILE_SOURCE == 'FILE_SOURCE_GAXT' or paramMap.DICT_FILE_SOURCE == 'FILE_SOURCE_WBXT')}">
											<a href="#" onclick="proposed('${item.PK_REC_FILE}')">
													拟办单
											</a>									
										</c:if>
									</td> --%>
										<%-- <td title="">
													<tag:dict id="dictFileSource" dictCode="DICT_FILE_SOURCE" readonly="true" value="${item.DICT_FILE_SOURCE}"></tag:dict>
										</td> --%>
										<td class="td-center" title="${item.REC_NO}">
													${item.REC_NO} 
										</td>
										<td class="td-center" title="${item.REC_DATE}">
													<fmt:formatDate value='${item.REC_DATE}' pattern='yyyy-MM-dd'/>
										</td>
										<td class="td-center" title="">
													<tag:dict id="dictRecCompany" dictCode="DICT_REC_COMPANY" readonly="true" value="${item.DICT_REC_COMPANY}"></tag:dict>
										</td>
										<td class="td-center" title="">
													<tag:dict id="dictFileCategory" dictCode="DICT_FILE_CATEGORY" readonly="true" value="${item.DICT_FILE_CATEGORY}"></tag:dict>
										</td>
										<td title="${item.FILE_TITLE}">
													${item.FILE_TITLE} 
										</td>
										<td class="td-center" title="${item.FILE_CODE}">
													${item.FILE_CODE} 
										</td>
										<td class="td-center" title="">
													<tag:dict id="dictDense" dictCode="DICT_DENSE" readonly="true" value="${item.DICT_DENSE}"></tag:dict>
										</td>
										<%-- <td title="${item.DENSE_CODE}">
													${item.DENSE_CODE} 
										</td> --%>
										<td title="" class="td-center">
													<tag:dict id="dictGrade" dictCode="DICT_GRADE" readonly="true" value="${item.DICT_GRADE}"></tag:dict>
										</td>
										<td title="${item.FILE_CNT}" class="td-center">
													${item.FILE_CNT} 
										</td>
										<td title="${item.HANDLE_PRES}" class="td-center">
													<fmt:formatDate value='${item.HANDLE_PRES}' pattern='yyyy-MM-dd'/>
										</td>
										<%-- <td title="${item.IS_HANDLE}">
													${item.IS_HANDLE} 
										</td> --%>
										<%-- <td title="${item.IS_PROPOSED}">
													<c:if test="${empty item.IS_PROPOSED or item.IS_PROPOSED==0}">否</c:if> 
													<c:if test="${item.IS_PROPOSED==1}">是</c:if>  --%>
										<td class="td-center">
													${item.ORG_COMPANY} 
										</td>
										<td class="td-center">
													<c:if test="${empty item.SIGN_UP_STATUS}">未知</c:if> 
													<c:if test="${item.SIGN_UP_STATUS==0}">否</c:if> 
													<c:if test="${item.SIGN_UP_STATUS==1}">是</c:if>
										</td>													
										<td class="td-center">
													${item.userName} 
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