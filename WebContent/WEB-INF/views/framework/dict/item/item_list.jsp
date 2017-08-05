<%@page import="org.whale.system.common.constant.SysConstant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>字典元素列表</title>
<%@include file="/html/jsp/common.jsp" %>
<script language="javascript">
$(function(){
	new Grid({});
});

function add(){
	$.openWin({url: "${ctx}/dictItem/goSave?dictId=${dictId}","title":'新增字典元素'});
}

function update(dictItemId){
	$.openWin({url: "${ctx}/dictItem/goUpdate?view=0&dictItemId="+dictItemId,"title":'编辑字典元素'});
}

function del(){
	var idArr = grid.getSelectIds();
	if(idArr.length < 1){
		$.alert('请选择需要删除的记录');
		return ;
	}
	
	$.confirm({
		 info:'您确定要删除记录吗？',
		 ok: function () {
	        $.ajax({
				url : "${ctx}/dictItem/doDelete",
				data : "dictItemIdS="+idArr.join(','),
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
						window.parent.location.href="${ctx}/dict/goTree?clkId=${dictId}";
			    	}else{
						$.alert(obj.msg);
			    	}
				}
			});
		}
	});
}

function setStatus(id,name,type){
	var url = "${ctx}/dictItem/doChangeState?status=<%=SysConstant.STATUS_NORMAL%>";
	var opt = "启用";
	if(type == '<%=SysConstant.STATUS_UNUSE%>'){
		url = "${ctx}/dictItem/doChangeState?status=<%=SysConstant.STATUS_UNUSE%>";
		opt = "禁用";
	}
	$.confirm({
		 info:'您确定要[ '+opt+' ]字典元素[ '+name+' ]吗？',
		 ok: function () {
	        $.ajax({
				url : url,
				data : "dictItemId="+id,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: 'json',
				type: 'post',
				cache: false,
				error: function(){
					$.alert(opt+' 字典元素 '+name+' 出现异常');
			    },
			    success: function(obj){
			    	if(obj.rs){
			    		grid.reload();
						$.info("设置字典元素状态成功");
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
			<form action="${ctx}/dictItem/goList" method="post" id="page_form" >
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }" />
				<input type="hidden" id="totalPages" name="totalPages" value="${page.totalPages }" />
				<input type="hidden" id="dictId" name="dictId" value="${dictId }" />
				
				<table cellpadding="0" cellspacing="0" width="100%">
						<col  width="10%" />
						<col  width="40%"/>
						<col  width="10%"/>
						<col  width="40%"/>
					<tbody>
						<tr>
							<td class="td-label">元素名称</td>
							<td class="td-value"><input type="text" id="itemName" name="itemName" style="width:160px;" value="${itemName }" /></td>
							<td class="td-label">元素编码</td>
							<td class="td-value"><input type="text" id="itemCode" name="itemCode" style="width:160px;" value="${itemCode }" /></td>
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
           <tag:auth authCode="ITEM_SAVE">
                	<li>
                    	<a href="#" class="a1" onclick="add()">
					       <span>新增元素</span>
						</a>	
                    </li>
           </tag:auth>
           <tag:auth authCode="ITEM_DEL">
                	<li>
						<a href="#" class="a2" onclick="del()">
							<span>删除元素</span>
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
					<col width="3%"/>
					<col width="8%"/>
					<col />
					<col />
					<col />
					<col width="8%"/>
					<col />
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
								元素名称
							</th>
							<th>
								元素编码
							</th>
							<th>
								元素值
							</th>
							<th>
								排序
							</th>
							<th>
								备注
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
							<td class="td-center">
								<input type="checkbox" value="${item.dictitemid }" />
							</td>
							<td class="td-center">
						<tag:auth authCode="ITEM_UPDATE">
								<a href="#" onclick="update('${item.dictitemid }')">
									修改
								</a>
						</tag:auth>
						<tag:auth authCode="ITEM_STATUS">	
								<c:if test="${item.status != usable}">
									<a href="#" class="a3" onclick="setStatus('${item.dictitemid }','${item.itemname}','<%=SysConstant.STATUS_NORMAL%>')">
										<span>启用</span>
									</a>
								</c:if>
			                 	<c:if test="${item.status == usable}">
									<a href="#" class="a4" onclick="setStatus('${item.dictitemid }','${item.itemname}','<%=SysConstant.STATUS_UNUSE%>')">
										<span>禁用</span>
									</a>
								</c:if>
						</tag:auth>	
							</td>
							<td title="${item.itemname}">
								${item.itemname}
							</td>
							
							<td title="${item.itemcode}">
								${item.itemcode}
							</td>
							<td title="${item.itemval}">
								${item.itemval}
							</td>
							<td title="${item.orderNo}">
								${item.orderNo}
							</td>
							<td title="${item.remark}">
								${item.remark}
							</td>
							<td align="center" style="text-align: center;">
								<c:if test="${item.status != usable}"><font color="red">禁用</font></c:if>
								<c:if test="${item.status == usable}">启用</c:if>
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


