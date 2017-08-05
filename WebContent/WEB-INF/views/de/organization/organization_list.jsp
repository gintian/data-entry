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
	$.openWin({url: "${ctx}/de/organization/goSave","title":'新增信息'});
}

function update(id){
	$.openWin({url: "${ctx}/de/organization/goUpdate?id="+id,"title":'编辑信息'});
}

function view(id){
	$.openWin({url: "${ctx}/de/organization/goView?id="+id,"title":'查看信息'});
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
		 	var url = "${ctx}/de/organization/doDelete";
			var reqParam = "ids="+idArr.join(',');
			ACF.ajaxForm.post(url,reqParam,function(obj){
				$.info(obj.msg, function(obj){
					grid.reload();
				});
			});
		}
	});
}
</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/de/organization/goList" method="post" id="page_form" >
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
								 	<td class="td-label">机构类别</td> 
								  	<td class="td-value">
											   <tag:dict id="DICT_ORG_CATEGORY" dictCode="DICT_ORG_CATEGORY" headerLabel="--请选择--" value="${paramMap.DICT_ORG_CATEGORY}"></tag:dict>
								  </td>
								  <td class="td-label">机构单位</td> 
								  	<td class="td-value">
										   	   <input type="text"  name="ORG_COMPANY" style="width:160px;" value="${paramMap.ORG_COMPANY}" />
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
                    	<a href="#" class="a1" onclick="add()">
					       <span>新增</span>
						</a>	
                    </li>
                	<li>
                    	<a href="#" class="a2" onclick="del()">
					       <span>删除</span>
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
					<col />
					<col />
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
									机构单位
								</th>
								<th>
									机构类别
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
										<input type="checkbox" value="${item.PK_ORGANIZATION }" index="${item_index.index+1}" status="${item.status}"/>
							</td>
							
									<td class="td-center">
										<a href="#" onclick="update('${item.PK_ORGANIZATION}')">
											编辑
										</a>
										<a href="#" onclick="view('${item.PK_ORGANIZATION}')">
												查看
										</a>
									</td>
										<td title="${item.ORG_COMPANY}">
													${item.ORG_COMPANY} 
										</td>
										<td title="">
													<tag:dict id="dictOrgCategory" dictCode="DICT_ORG_CATEGORY" readonly="true" value="${item.DICT_ORG_CATEGORY}"></tag:dict>
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