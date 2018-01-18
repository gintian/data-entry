<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>列表</title>
<%@include file="/html/jsp/common.jsp" %>
<link href="${ctx}/html/css/flowPage.css" rel="stylesheet" />
<script language="javascript">
$(function(){
	new Grid({beforeLoadPage:setExportIds});
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

function supervise(id){
	$.openWin({url: "${ctx}/de/recFile/goSuperviseView?id="+id,"title":'查看督办单', height:700});
}

/**
 * 导出Excel表格
 */
function doExcel(){
	setExportIds();
	$.form_submit($("#page_form").get(0), {
 		"action": "${ctx}/de/recFile/doExcel"
	}); 
	$("#page_form").attr("action","${ctx}/de/recFile/goList");
	// 导出后去掉取消勾选的记录
	$("#EXPORT_IDS").val("");
	if(grid.getSelectIds().length > 0){
		// grid.checkAll();
		$("#gridTable").find("input[type='checkbox']").each(function() {this.checked = "";})
	}
}

function setExportIds(){
	var exportIds = $("#EXPORT_IDS").val();
	var idArr = grid.getSelectIds();
	if(idArr.length > 0){
		if(exportIds){
			exportIds = exportIds + "," + idArr.join(',');
		} else{
			exportIds = idArr.join(',');
		}
	}
	$("#EXPORT_IDS").val(exportIds);
}

</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/de/recFile/goList" method="post" id="page_form">
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
										   	   <input type="text" id="REC_DATE" name="MIN_REC_DATE" title="收文日期" style="width:160px;" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.MIN_REC_DATE}"/>
										   	   ~
										   	   <input type="text" id="REC_DATE" name="MAX_REC_DATE" title="收文日期" style="width:160px;" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.MAX_REC_DATE}"/>
								    </td>	
								  	<%-- <td class="td-value">
										   	  <input type="text" class="cdate" id="REC_DATE" name="REC_DATE"  onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.REC_DATE}"/>
								    </td> --%>
								 	<td class="td-label">收文号</td> 
								  	<td class="td-value">
											    <input type="text"  name="REC_NO" style="width:160px;" value="${paramMap.REC_NO}" />
								  </td>
								 </tr>
							     <tr>
								  <td class="td-label">文件标题</td> 
								  	<td class="td-value">
										   	   <input type="text"  name="FILE_TITLE" style="width:160px;" value="${paramMap.FILE_TITLE}" />
								  </td>
								   <td class="td-label">文号</td> 
								  	<td class="td-value">
										   	   <input type="text"  name="FILE_CODE" style="width:160px;" value="${paramMap.FILE_CODE}" />
								    </td>
								 </tr>
								 <tr>
									 <td class="td-label">来文单位</td> 
									  <td class="td-value">
												   <%-- <tag:dict id="DICT_REC_COMPANY" dictCode="DICT_REC_COMPANY" headerLabel="--请选择--" value="${paramMap.DICT_REC_COMPANY}"></tag:dict> --%>
												    <input type="text"  name="DICT_REC_COMPANY" style="width:160px;" value="${paramMap.DICT_REC_COMPANY}" />
									  </td>
								 	<td class="td-label">文件类别</td> 
								  	<td class="td-value">
								  				<c:if test="${isDense }">
									  				<tag:dict id="DICT_FILE_CATEGORY" dictCode="DICT_FILE_CATEGORY" headerLabel="--请选择--" value="${paramMap.DICT_FILE_CATEGORY}"></tag:dict>
									  			</c:if>
												<c:if test="${empty isDense or !isDense}">
									  				<tag:dict id="DICT_FILE_CATEGORY" dictCode="DICT_FILE_CATEGORY_OPT" headerLabel="--请选择--" value="${paramMap.DICT_FILE_CATEGORY}"></tag:dict>
									  			</c:if>
											   <%-- <tag:dict id="DICT_FILE_CATEGORY" dictCode="DICT_FILE_CATEGORY" headerLabel="--请选择--" value="${paramMap.DICT_FILE_CATEGORY}"></tag:dict> --%>
								  </td>
								 </tr>
							     <tr>
								 	<td class="td-label">是否需办理反馈</td> 
										<td class="td-value">
											 <select name="IS_NEED_FEEDBACK" style="width:165px;">
											   		<option value=""  <c:if test="${paramMap.IS_NEED_FEEDBACK ==''}">selected="selected"</c:if>>--请选择--</option>
											   		<option value="1" <c:if test="${paramMap.IS_NEED_FEEDBACK == '1'}">selected='selected'</c:if>>是</option>
											   		<option value="0" <c:if test="${paramMap.IS_NEED_FEEDBACK == '0'}">selected='selected'</c:if>>否</option>
											   </select>
								 	 	</td>
								    </td>
								 	<td class="td-label">等级</td> 
								  	<td class="td-value">
											   <tag:dict id="DICT_GRADE" dictCode="DICT_GRADE" headerLabel="--请选择--" value="${paramMap.DICT_GRADE}"></tag:dict>
								  </td>
								 </tr>
								 <tr>
								 	<td class="td-label">密级</td> 
								  	<td class="td-value">
										  		<c:if test="${isDense }">
									  				<tag:dict id="dictDense" dictCode="DICT_DENSE" headerLabel="--请选择--" value="${paramMap.DICT_DENSE}"></tag:dict>
									  			</c:if>
												<c:if test="${empty isDense or !isDense}">
									  				<tag:dict id="dictDense" dictCode="DICT_DENSE_OPT" headerLabel="--请选择--" value="${paramMap.DICT_DENSE}"></tag:dict>
									  			</c:if>
											   <%-- <tag:dict id="DICT_DENSE" dictCode="DICT_DENSE" headerLabel="--请选择--" value="${paramMap.DICT_DENSE}"></tag:dict> --%>
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
								   	<td class="td-label">领导签批</td> 
									  	<td class="td-value">
												<select name="DIRECTOR_OPER" style="width:165px;">
											   		<option value="">--请选择--</option>
											   		<option value="1" <c:if test="${paramMap.DIRECTOR_OPER == 1}">selected='selected'</c:if>>局长批示</option>
											   		<option value="2" <c:if test="${paramMap.DIRECTOR_OPER == 2}">selected='selected'</c:if>>局长圈阅</option>
											   </select>
									  </td>
									 	<%--  <td class="td-label">文件来源</td> 
									  	<td class="td-value">
												   <tag:dict id="DICT_FILE_SOURCE" dictCode="DICT_FILE_SOURCE" headerLabel="--请选择--" value="${paramMap.DICT_FILE_SOURCE}"></tag:dict>
									  </td> --%>
									 </tr>
								 <input type="hidden" id="DICT_FILE_SOURCE" name="DICT_FILE_SOURCE" value="${paramMap.DICT_FILE_SOURCE}"/>
								 <input type="hidden" id="EXPORT_IDS" name="EXPORT_IDS" value="${paramMap.EXPORT_IDS}"/>
								 <input type="hidden" id="FLAG" name="FLAG" value="${paramMap.FLAG}"/>
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
            		<c:if test="${empty paramMap.FLAG}">
	                	<li>
	                    	<a href="#" class="a1" onclick="add()">
						       <span>新增</span>
							</a>	
	                    </li>
	                	<li>
	                    	<a href="#" class="a2" onclick="del()">
						       <span>删除</span>
							</a>	
	                    </li>
	                </c:if>
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
					<col width="3%"/>
					<col width="3%"/>
					<col width="14%"/>
					<c:if test="${not empty paramMap.FLAG and paramMap.FLAG == 'SIGN_LIST'}">
						<col width="5%"/>	
					</c:if>
					<col width="10%"/>
					<col width="6%"/>
					<col width="10%"/>
					<col width="6%"/>
					<col width="14%"/>
					<col width="10%"/>
					<col width="6%"/>
					<!-- <col width="6%"/> -->
					<col width="4%"/>
					<!-- <col width="4%"/> -->
					<col width="6%"/>
					<col width="5%"/>
					<col width="5%"/>
					<col width="5%"/>
					<thead>
						<tr>
							<th>
								序号
							</th>
							<th>
								<input type="checkbox" id="ck_all" onclick="grid.checkAll()" /> 
							</th>
								<th>
									操作
								</th>
								<c:if test="${not empty paramMap.FLAG and paramMap.FLAG == 'SIGN_LIST'}">
									<th>
										文件来源
									</th>
								</c:if>
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
								<!-- <th>
									文件数量
								</th> -->
								<th>
									办理时效
								</th>
								<!-- <th>
									是否办结
								</th> -->
								<th>
									是否需办理反馈
								</th>
								<th>
									是否签收
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
							<td class="td-center">
										<input type="checkbox" value="${item.PK_REC_FILE }" index="${item_index.index+1}" status="${item.status}" <c:if test="${fn:contains(','.concat(paramMap.EXPORT_IDS.concat(',')) , ','.concat(item.PK_REC_FILE.toString().concat(',')) )}">checked="checked"</c:if> />
							</td>
							
									<td class="td-center">
										<a href="#" onclick="update('${item.PK_REC_FILE}')">
											编辑
										</a>
										<a href="#" onclick="view('${item.PK_REC_FILE}')">
												查看
										</a>
										<a href="#" onclick="supervise('${item.PK_REC_FILE}')">
													督办单
										</a>
										<c:if test="${item.IS_OVERTIME == 1}">
											<a href="#" onclick="handle('${item.PK_REC_FILE}')">
													办结
											</a>
										</c:if>
										<c:if  test="${item.IS_PROPOSED==1 and (item.DICT_FILE_SOURCE == 'FILE_SOURCE_GAXT' or item.DICT_FILE_SOURCE == 'FILE_SOURCE_WBXT')}">
											<a href="#" onclick="proposed('${item.PK_REC_FILE}')">
													拟办单
											</a>									
										</c:if>
									</td>
										<c:if test="${not empty paramMap.FLAG and paramMap.FLAG == 'SIGN_LIST'}">
											<td title="">
														<tag:dict id="dictFileSource" dictCode="DICT_FILE_SOURCE" readonly="true" value="${item.DICT_FILE_SOURCE}"></tag:dict>
											</td>
										</c:if>
										<td class="td-center" title="${item.REC_NO}">
													${item.REC_NO} 
										</td>
										<td class="td-center" title="${item.REC_DATE}">
													<fmt:formatDate value='${item.REC_DATE}' pattern='yyyy-MM-dd'/>
										</td>
										<td class="td-center" title="">
													<%-- <tag:dict id="dictRecCompany" dictCode="DICT_REC_COMPANY" readonly="true" value="${item.DICT_REC_COMPANY}"></tag:dict> --%>
													${item.DICT_REC_COMPANY} 
										</td>
										<td class="td-center" title="">
													<c:if test="${isDense }">
										  				<tag:dict id="dictFileCategory" dictCode="DICT_FILE_CATEGORY" readonly="true" value="${item.DICT_FILE_CATEGORY}"></tag:dict>
										  			</c:if>
													<c:if test="${empty isDense or !isDense}">
										  				<tag:dict id="dictFileCategory" dictCode="DICT_FILE_CATEGORY_OPT" readonly="true" value="${item.DICT_FILE_CATEGORY}"></tag:dict>
										  			</c:if>
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
										<%-- <td title="${item.FILE_CNT}" class="td-center">
													${item.FILE_CNT} 
										</td> --%>
										<td title="${item.HANDLE_PRES}" class="td-center">
													<fmt:formatDate value='${item.HANDLE_PRES}' pattern='yyyy-MM-dd'/>
										</td>
										<%-- <td title="${item.IS_HANDLE}">
													${item.IS_HANDLE} 
										</td> --%>
										<td title="${item.IS_NEED_FEEDBACK}" class="td-center">
													<c:if test="${empty item.IS_NEED_FEEDBACK or item.IS_NEED_FEEDBACK==0}">否</c:if> 
													<c:if test="${item.IS_NEED_FEEDBACK==1}">是</c:if>
										</td>
										<td class="td-center">
													<c:if test="${empty item.SIGN_UP_STATUS or item.SIGN_UP_STATUS==0}">否</c:if> 
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