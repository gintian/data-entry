<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/html/jsp/common.jsp" %>

<script language="javascript">
$(function(){
	new ToolBar({items:[
		{id:"saveBut", className:"a3", func:"update()", text:"修改"}
	]});
});

function update(){
	$.openWin({url: "${ctx}/dictItem/goUpdate?dictItemId=${item.dictItemId}&view=1","title":'编辑字典元素'});
}
</script>

</head>
    
<body>
<div class="body-box-form" >
	<div class="content-form">
		<div class="panelBar" id="panelBarDiv"></div>
		<div class="infoBox" id="infoBoxDiv"></div>
		<div class="edit-form">
			<form action="" method="post" id="dataForm">
				<input type="hidden" id="dictId" name="dictId" value="${item.dictId }" />
				<input type="hidden" id="dictItemId" name="dictItemId" value="${item.dictItemId }" />
				<table cellspacing="0" cellpadding="0" width="100%">
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
					<tbody>
						<tr>
							<td class="td-label"><span class="required">*</span>元素名称</td>
							<td class="td-value">${item.itemName }</td>
							<td class="td-label" ><span class="required">*</span>元素编码</td>
							<td class="td-value">${item.itemCode }</td>
						</tr>
						<tr>
							<td class="td-label">元素值</td>
							<td class="td-value">${item.itemVal }</td>
							<td class="td-label" >排列顺序</td>
							<td class="td-value">${item.orderNo }</td>
						</tr>
						<tr>
							<td class="td-label" >备注</td>
							<td class="td-value" colspan="3">
								<div style="height:40px;" class="textAreaDiv">${item.remark }</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>
