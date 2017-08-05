<%@ page language="java" pageEncoding="UTF-8" %>
<script language="javascript">
function showDiagram(ctx, processInstanceId) {
	var thisUrl = ctx + "/workflow/processInstance/index?processInstanceId=" + processInstanceId;
	$.openWin({url: thisUrl,"title":'流程图'});
}

/**
 * 
 * @param ctx
 * @param processDefinitionKey 流程模版key
 * @param taskDefinitionKey 流程任务节点key
 * @param taskName 任务名称
 * @param businessKey 业务key
 * @param processInstanceId 流程实例ID
 * @param taskId 任务ID
 * @param isEdit 是否编辑操作，1表示编辑
 */
function flowForm(ctx, processDefinitionKey, taskDefinitionKey, taskName, businessKey, processInstanceId, taskId, isEdit){

	//流程变量
	var flowEngineVars = 'currentTaskId='+taskId+"&processInstanceId="+processInstanceId+"&taskDefinitionKey="+taskDefinitionKey;
	var bl_forEdit = ("1" == isEdit);
	if('flowKeyProductFlow' == processDefinitionKey){//产品发布流程
		productFlowProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId,flowEngineVars, bl_forEdit);
	}


	if('flowKeyProductAuthRepayment' == processDefinitionKey){//自动还款授权
		flowKeyProductAuthRepayment(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId,flowEngineVars, bl_forEdit);
	}else if('flowKeyProductAuthPrincipal' == processDefinitionKey){//产品发布流程
		productAuthPrincipalProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId,flowEngineVars, bl_forEdit);
	}else if('flowKeyProductFailFlow' == processDefinitionKey){//产品发布流程
		productFailFlowProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId,flowEngineVars, bl_forEdit);
	}else if('flowKeyWithdrawals' == processDefinitionKey){//提现流程
		withdrawalsProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId,flowEngineVars, bl_forEdit);
	}else if('flowKeyRechargeFlow' == processDefinitionKey){//线下充值流程
		rechargeFlowProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId,flowEngineVars, bl_forEdit);
	}

}
	
/**
 * 产品发布
 */
function productFlowProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId, flowEngineVars, bl_forEdit){
	var url;
	var title = '产品发布';
	if(bl_forEdit){
		url = "${ctx}/p2p/product/productFlow/goUpdate?id="+businessKey+"&"+flowEngineVars;
	}else{
		url = "${ctx}/p2p/product/productFlow/goView?id="+businessKey+"&"+flowEngineVars;
	}
	
	$.openWin({url:url ,"title":title,callback:function(){
		window.grid.reload();
	}});
}

/**
 * 自动还款授权
 */
function flowKeyProductAuthRepayment(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId, flowEngineVars, bl_forEdit){
	var url;
	var title = '自动还款授权';
	if(bl_forEdit){
		url = "${ctx}/p2p/product/productAuthRepayment/goUpdate?id="+businessKey+"&"+flowEngineVars;
	}else{
		url = "${ctx}/p2p/product/productAuthRepayment/goView?id="+businessKey+"&"+flowEngineVars;
	}
	
	$.openWin({url:url ,"title":title,callback:function(){
		window.grid.reload();
	}});
}

function productAuthPrincipalProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId, flowEngineVars, bl_forEdit){
	var url;
	var title = '还本授权';
	if(bl_forEdit){
		url = "${ctx}/p2p/product/productAuthPrincipal/goUpdate?id="+businessKey+"&"+flowEngineVars;
	}else{
		url = "${ctx}/p2p/product/productAuthPrincipal/goView?id="+businessKey+"&"+flowEngineVars;
	}
	
	$.openWin({url:url ,"title":title,callback:function(){
		window.grid.reload();
	}});
}

function productFailFlowProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId, flowEngineVars, bl_forEdit){
	var url;
	var title = '手动流标';
	if(bl_forEdit){
		url = "${ctx}/p2p/member/productFailFlow/goUpdate?id="+businessKey+"&"+flowEngineVars;
	}else{
		url = "${ctx}/p2p/member/productFailFlow/goView?id="+businessKey+"&"+flowEngineVars;
	}
	
	$.openWin({url:url ,"title":title,callback:function(){
		window.grid.reload();
	}});
}

function withdrawalsProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId, flowEngineVars, bl_forEdit){
	var url;
	var title = '提现流程';
	if(bl_forEdit){
		url = "${ctx}/p2p/member/withdrawals/goUpdate?id="+businessKey+"&"+flowEngineVars;
	}else{
		url = "${ctx}/p2p/member/withdrawals/goView?id="+businessKey+"&"+flowEngineVars;
	}
	
	$.openWin({url:url ,"title":title,callback:function(){
		window.grid.reload();
	}});
}

function rechargeFlowProcess(ctx, processDefinitionKey, taskDefinitionKey,taskName, businessKey, processInstanceId, taskId, flowEngineVars, bl_forEdit){
	var url;
	var title = '线下充值流程';
	if(bl_forEdit){
		url = "${ctx}/p2p/member/rechargeFlow/goUpdate?id="+businessKey+"&"+flowEngineVars;
	}else{
		url = "${ctx}/p2p/member/rechargeFlow/goView?id="+businessKey+"&"+flowEngineVars;
	}
	
	$.openWin({url:url ,"title":title,callback:function(){
		window.grid.reload();
	}});
}

</script>