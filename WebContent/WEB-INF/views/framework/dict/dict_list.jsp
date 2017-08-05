<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>字典列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/dict/goSave","title":'新增字典'});
}

function update(dictId){
	$.openWin({url: "${ctx}/dict/goUpdate?dictId="+dictId,"title":'编辑字典'});
}

function del(dictId){
	if(dictId == ""){
		$.alert('请选择需要删除的记录');
		return ;
	}
	
	$.confirm({
		 info:'您确定要删除记录吗？',
		 ok: function () {
	        $.ajax({
				url : "${ctx}/dict/doDelete?dictId="+dictId,
				data : null,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
			        $.alert('删除记录出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
						$.info(obj.msg);
						window.parent.location.href="${ctx}/dict/goTree?clkId=0";
			    	}else{
						$.alert(obj.msg);
			    	}
				}
			});
		}
	});
}
</script>
</head>
    
<body>
	<div class="body-box-list" id="bodyBoxDiv">
		<div class="query-form">
			<form action="${ctx}/dict/goList" method="post" id="page_form" >
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
							<td class="td-label">字典名称</td>
							<td class="td-value"><input type="text" id="dictName" name="dictName" style="width:160px;" value="${dictName }" /></td>
							<td class="td-label">字典编码</td>
							<td class="td-value"><input type="text" id="dictCode" name="dictCode" style="width:160px;" value="${dictCode }" /></td>
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
            <tag:auth authCode="DICT_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>新增字典</span>
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
					<col width="15%"/>
					<col />
					<col />
					<col />
					<thead>
						<tr>
							<th>
								序号
							</th>
							<th>
								操作
							</th>
							<th>
								字典名称
							</th>
							<th>
								字典编码
							</th>
							<th>
								备注
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
						<tag:auth authCode="DICT_UPDATE">
								<a href="#" onclick="update('${item.dictid }')">
									修改
								</a>
						</tag:auth>
						<tag:auth authCode="DICT_DEL">
								<a href="#" onclick="del('${item.dictid }')">
									删除
								</a>
						</tag:auth>
							</td>
							<td title="${item.dictname}">
								${item.dictname}
							</td>
							
							<td title="${item.dictcode}">
								${item.dictcode}
							</td>
							<td title="${item.remark}">
								${item.remark}
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


