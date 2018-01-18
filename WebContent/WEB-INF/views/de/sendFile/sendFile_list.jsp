<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/de/sendFile/goSave","title":'新增信息'});
}

function update(id){
	$.openWin({url: "${ctx}/de/sendFile/goUpdate?id="+id,"title":'编辑信息'});
}

function view(id){
	$.openWin({url: "${ctx}/de/sendFile/goView?id="+id,"title":'查看信息'});
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
		 	var url = "${ctx}/de/sendFile/doDelete";
			var reqParam = "ids="+idArr.join(',');
			ACF.ajaxForm.post(url,reqParam,function(obj){
				$.info(obj.msg, function(obj){
					grid.reload();
				});
			});
		}
	});
}

/**
 * 导出Excel表格
 */
function doExcel(){
	$.form_submit($("#page_form").get(0), {
 		"action": "${ctx}/de/sendFile/doExcel"
	}); 
	$("#page_form").attr("action","${ctx}/de/sendFile/goList");
}
</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/de/sendFile/goList" method="post" id="page_form" >
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
					 				<td class="td-label">发文日期</td> 
					 				<td class="td-value">
										   	   <input type="text" id="SEND_DATE" name="MIN_SEND_DATE" title="发文日期" style="width:160px;" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.MIN_SEND_DATE}"/>
										   	   ~
										   	   <input type="text" id="SEND_DATE" name="MAX_SEND_DATE" title="发文日期" style="width:160px;" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.MAX_SEND_DATE}"/>
								    </td>
								  	<%-- <td class="td-value">
										   	   <input type="text"  name="SEND_DATE" style="width:160px;" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" value="${paramMap.SEND_DATE}"/>
								 	 </td> --%>
								 	 <td class="td-label">发文号</td> 
								  	<td class="td-value">
										   	   <input type="text"  name="SEND_NO" style="width:160px;" value="${paramMap.SEND_NO}" />
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
							     	<td class="td-label">文件类别</td> 
								  	<td class="td-value">
											   <tag:dict id="DICT_FILE_CATEGORY" dictCode="DICT_FILE_CATEGORY" headerLabel="--请选择--" value="${paramMap.DICT_FILE_CATEGORY}"></tag:dict>
								  	</td>
								  	<td class="td-label">机要编号</td> 
								  	<td class="td-value">
											  <input type="text"  name="CONFIDENTIAL_CODE" style="width:160px;" value="${paramMap.CONFIDENTIAL_CODE}" />
								 	</td>
								 	<%-- <td class="td-label">密级</td> 
								  	<td class="td-value">
											   <tag:dict id="DICT_DENSE" dictCode="DICT_DENSE" headerLabel="--请选择--" value="${paramMap.DICT_DENSE}"></tag:dict>
								  	</td> --%>
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
                    	<a href="#" class="a1" onclick="add()">
					       <span>新增</span>
						</a>	
                    </li>
                	<li>
                    	<a href="#" class="a2" onclick="del()">
					       <span>删除</span>
						</a>	
                    </li>
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
					<col width="8%"/>
					<col width="12%"/>
					<col width="8%"/>
					<col/>
					<col width="6%"/>
					<col width="18%"/>
					<col width="8%"/>
					<col width="6%"/>
					<col width="6%"/>
					<col width="8%"/>
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
								<th>
									发文号
								</th>
								<th>
									发文日期
								</th>
								<th>
									发送单位
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
								<th>
									机要编号
								</th>
								<th>
									修改用户
								</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${page.datas}"  varStatus="item_index">
						<tr >
							<td class="td-seq">
								${item_index.index+1}
							</td>
							<td class="td-center">
										<input type="checkbox" value="${item.PK_SEND_FILE }" index="${item_index.index+1}" status="${item.status}"/>
							</td>
							
									<td class="td-center">
										<a href="#" onclick="update('${item.PK_SEND_FILE}')">
											编辑
										</a>
										<a href="#" onclick="view('${item.PK_SEND_FILE}')">
												查看
										</a>
									</td>
										<td title="${item.SEND_NO}" class="td-center">
													${item.SEND_NO} 
										</td>
										<td title="${item.SEND_DATE}" class="td-center">
													<fmt:formatDate value='${item.SEND_DATE}' pattern='yyyy-MM-dd'/>
										</td>
										<td title="${item.SEND_COMPANYS}" class="td-center">
													${item.SEND_COMPANYS} 
										</td>
										<td title="" class="td-center">
													<tag:dict id="dictFileCategory" dictCode="DICT_FILE_CATEGORY" readonly="true" value="${item.DICT_FILE_CATEGORY}"></tag:dict>
										</td>
										<td title="${item.FILE_TITLE}">
													${item.FILE_TITLE} 
										</td>
										<td title="${item.FILE_CODE}" class="td-center">
													${item.FILE_CODE} 
										</td>
										<td title="" class="td-center">
													<tag:dict id="dictDense" dictCode="DICT_DENSE" readonly="true" value="${item.DICT_DENSE}"></tag:dict>
										</td>
										<td title="${item.CONFIDENTIAL_CODE}">
													${item.CONFIDENTIAL_CODE} 
										</td>
										<td title="${item.userName}" class="td-center">
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