/**
 * 流程页面公用js
 */
(function(){

	/**
	 * 根据流程当前所属环节控制控件只读、禁用、隐藏、初始化控件验证规则
	 */								//节点-域配置项,验证规则,   点前流程节点,    domContainer
	var _domShowAndValidateInit = function(nodesDomConf,validateRules,currentFlowNode,dataForm){
		
		var currentNodeDomConf = nodesDomConf[currentFlowNode];//当前节点只读、禁用、隐藏配置
		if(currentNodeDomConf){
			for(conf in currentNodeDomConf){//conf('readOnly,dis,hidden')
				var elemSelectors = currentNodeDomConf[conf];//节点对应控件jq选择器表达式
				if( !$.isArray(elemSelectors) || elemSelectors.length == 0 )continue;
				if(elemSelectors == '*'){
					elemSelectors=['input','select','textarea','a'];
				}
				var elems =  $( elemSelectors.join(',') ,dataForm);
				
				if(conf == 'readOnly'){//只读
					elems.each(function(){
						var _this = $(this);
						if(_this.css('display') == 'none') return true;//隐藏域不做转化
						var tagName = _this.prop('tagName');
						if(tagName == 'TABLE' || tagName == 'TR' || tagName == 'TD' || tagName == 'DIV'){
							return true;
						}
						
						if(tagName == 'A'){
							_this.remove();
							return true;
						}
						
						if( _this.is('input') ){
							var elemType = _this.attr('type');
							if(elemType == 'text'){
								_this.css({'border':'none','with':'80%'}).attr('readOnly','readOnly').unbind().die().removeAttr('onfocus').removeAttr('onclick');
								
								if(  _this.hasClass('cdate') || _this.hasClass('date') ){//日期控件
									_this.css({'width':'140px'});
								}
							}else if(elemType == 'checkbox' || elemType == 'radio' || elemType == 'button'){//单复选、按钮
								if(elemType == 'button'){//按钮只读，设置为隐藏
									_this.hide();
								}else{
									_this.attr('disabled','disabled');
								}
							}
						}else if( _this.is('select') ){//下拉框
							_this.hide();
							var sltOptionTxt = $('option:selected',_this).text();
							(sltOptionTxt == '--请选择--') ? '' : _this.after('<span>'+sltOptionTxt+'</span>');
						}else if(_this.is('textarea')){
							_this.css({'border':'none'}).attr('readOnly','readOnly').unbind().removeAttr('onfocus');
						}
					});
				}else if(conf == 'dis'){//禁用
					elems.attr('disabled','disabled');
				}else if(conf == 'hidden'){//隐藏
					$.each(elems,function(i,elem){
						$(elem).parent('td').parent('tr').hide();//基于目前的布局结构,隐藏配置元素所在行
					});
				}else if(conf == 'directHidden'){//单独隐藏指定表达式获取的元素
					$.each(elems,function(i,elem){
						$(elem).hide();
					});
				}
			}
		}
		
		//验证规则
		var requiSpanStr = '<span class="required">*</span>';
		//必选验证域加上*提示
		$('[name]',dataForm).each(function(i,nameEle){
			if( validateRules[nameEle.name] && validateRules[nameEle.name].required ){
				var firstTd = $(nameEle).parent('td').siblings('td').first();//基于当前布局
				var requiSpan = firstTd.find('span.required');
				if( !requiSpan || requiSpan.length == 0 ){
					firstTd.prepend(requiSpanStr);
				}
			}
		});
		dataForm.validate({ignore:':hidden',rules: validateRules}); 
	};
	

	
	
	var _showMenu = function() {
		//var cityObj = $("#flowBackBut");

		var flowBackOffset = $("#backBtn").offset();
		$("#menuContent").css({left:flowBackOffset.left + "px", top:flowBackOffset.top + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	var hideMenu = function() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	var onBodyDown = function(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "backBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
	
	var showMenu = function(){
		$(".menu").empty();
		var taskId = $("input:hidden[name='currentTaskId']").val();
		var getBackUrl = ACF.ctx + '/workflow/processInstance/getBackTaskList?taskId='+taskId;
		$.getJSON (getBackUrl,function(data){
			if(!data.rs){
				$.alert('获取可回退环节出错');
				return;
			}
			$.each(data.datas,function(i,item){
				$(".menu").append("<li class='c_menu' name='"+item.taskDefinitionKey+"'><a href='#' >"+item.taskDefinitionName+"</a></li> ");
			});
			_showMenu();
		});
	}
	
	
	//回退方法
	var _doback = function(callback){
		if(!$('#workflowComment').is(':hidden')){
			if(!$("#workflowComment").val()){
				$.alert("回退意见必须填写");
				return;
			}
		}
		showMenu();
		var taskId = $("input:hidden[name='currentTaskId']").val();
		var memo = $("#workflowComment").val();
		var taskBean = new Object();
		taskBean.taskId = taskId;
		taskBean.memo = memo;
		$(".menu").delegate(".c_menu","click",function(){
			taskBean.flowKey = $(this).attr('name');
			callback(taskBean);
		});
		
	}
	
	//移除工具条指定id的构造项
	function _removeBarItem(items,removeItemId){
		for(var i=0;i<items.length;i++){
			if(items[i].id == removeItemId){
				items.splice(i,1);
			}
		}
	}
	
	function _barItemPreProces(items,firstNode,currentFlowNode,isBizHasProIns){
		if(currentFlowNode == firstNode || currentFlowNode == 'NODE_END'){//首环节或结束环节不显示回退
			_removeBarItem(items,'backBtn');//命名约定
		}
		
		if(!isBizHasProIns || currentFlowNode != firstNode){//业务表未与流程关联,或者非首环节不显示作废
			_removeBarItem(items,'cancelBtn');//命名约定
		}
	}
	
	//人员选择	
	var _livePersonBtn = function (){
		$('.personBtn').live('click',function(){
			var _this = $(this);
			var type = _this.attr('personType');//user or member
			var roleCode = _this.attr('roleCode');
			var isBorrower =  _this.attr('isBorrower');
			var numLimit =  _this.attr('numLimit');
			var callback =  _this.attr('callback');
			
			var hidden_val_input = _this.next();
			var sltIds = hidden_val_input.val();
			
			var dlgParam = {
				type:type
			};
			
			if(numLimit && numLimit.length > 0 ){//选择人员个数限制
				dlgParam.numLimit = numLimit;
			}
			
			if(sltIds && sltIds.length >0 ){
				dlgParam.sltIds = sltIds.split(',');
			}
			
			if( roleCode ){
				dlgParam.roleCode = [roleCode];
			}
			
			if(isBorrower){
				dlgParam.isBorrower = isBorrower;
			}
			
			function defaultCallback(arr_idS_nameS_realNameS){
				var display_input = _this.prev();
				if(display_input.prop('tagName') == 'EM'){
					display_input = display_input.prev();
				}
				if(arr_idS_nameS_realNameS && arr_idS_nameS_realNameS[0] && arr_idS_nameS_realNameS[0].length > 0 ){//存在选中人员
					display_input.val(arr_idS_nameS_realNameS[2] );
					hidden_val_input.val(arr_idS_nameS_realNameS[0] );
					
				}else{//选中人员清空
					display_input.val('');
					hidden_val_input.val('');
				}
			}
			var dlgCallback;
			if(callback){
				dlgCallback = window[callback];
			}else{
				dlgCallback = defaultCallback;
			}
			
			var pkBusinessGroup = ACF.getBizGroupIds();
			if(pkBusinessGroup){
				dlgParam.pkBusinessGroup =pkBusinessGroup;
			}
			
			var dlg = new PersonDlg(ACF.ctx,dlgParam,dlgCallback).open();
			
		});
	}
	
	var _getAttachParam = function(){
		var arr_attachIds = $('#attachIframe')[0].window || $('#attachIframe')[0].contentWindow.getTaskNodeAttachs();
		if(arr_attachIds && arr_attachIds.length>0 ){
			return arr_attachIds.join(',');
		}
		return '';
	}
	ACF.FlowFormPage = function(){
		return {
			initDomShowAndValidate : _domShowAndValidateInit,
			doback : _doback,
			barItemPreProces : _barItemPreProces,
			arabiaToChinese : Arabia_to_Chinese,
			livePersonBtn : _livePersonBtn,
			getAttachParam : _getAttachParam
		}
	}();
	//小写金额转中文大写
	function Arabia_to_Chinese(Num,errorTip){
		if(errorTip)errorTip.hide();
	for(i=Num.length-1;i>=0;i--)
	{
	Num = Num.replace(",","")//替换tomoney()中的“,”
	Num = Num.replace(" ","")//替换tomoney()中的空格
	}
	Num = Num.replace("￥","")//替换掉可能出现的￥字符
	if(isNaN(Num)) { //验证输入的字符是否为数字
		if(errorTip){
			errorTip.text("请检查输入金额是否正确");
			errorTip.css({'display':'inline'});
		}
	return "";
	}

	for (i=0;Num.charAt(i)=='0'&&Num.length>1;){    //替换掉数字前面出现的0
		Num=Num.substr(1,Num.length);
		}
	//---字符处理完毕，开始转换，转换采用前后两部分分别转换---//
	part = String(Num).split(".");
	newchar = "";
	if(Num==""){newchar="零圆整"}
	//小数点前进行转化
	for(i=part[0].length-1;i>=0;i--){
	if(part[0].length > 10){  
		if(errorTip){
			errorTip.text("数额最大不能超过100亿");
			errorTip.css({'display':'inline'});
		}
		return "";}//若数量超过拾亿单位，提示

	tmpnewchar = ""
	perchar = part[0].charAt(i);
	switch(perchar){
	case "0": tmpnewchar="零" + tmpnewchar ;break;
	case "1": tmpnewchar="壹" + tmpnewchar ;break;
	case "2": tmpnewchar="贰" + tmpnewchar ;break;
	case "3": tmpnewchar="叁" + tmpnewchar ;break;
	case "4": tmpnewchar="肆" + tmpnewchar ;break;
	case "5": tmpnewchar="伍" + tmpnewchar ;break;
	case "6": tmpnewchar="陆" + tmpnewchar ;break;
	case "7": tmpnewchar="柒" + tmpnewchar ;break;
	case "8": tmpnewchar="捌" + tmpnewchar ;break;
	case "9": tmpnewchar="玖" + tmpnewchar ;break;
	}
	switch(part[0].length-i-1){
	case 0: tmpnewchar = tmpnewchar +"圆" ;break;
	case 1: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
	case 2: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
	case 3: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
	case 4: tmpnewchar= tmpnewchar +"万" ;break;
	case 5: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
	case 6: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
	case 7: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
	case 8: tmpnewchar= tmpnewchar +"亿" ;break;
	case 9: tmpnewchar= tmpnewchar +"拾" ;break;
	}
	newchar = tmpnewchar + newchar;
	}
	//小数点之后进行转化
	if(Num.indexOf(".")!=-1){
	if(part[1].length > 2) {
		if(errorTip){
			errorTip.text("数额精度不能超过分");
			errorTip.css({'display':'inline'});
		}
		return "";
		//part[1] = part[1].substr(0,2)
	}
	for(i=0;i<part[1].length;i++){
	tmpnewchar = ""
	perchar = part[1].charAt(i)
	switch(perchar){
	case "0": tmpnewchar="零" + tmpnewchar ;break;
	case "1": tmpnewchar="壹" + tmpnewchar ;break;
	case "2": tmpnewchar="贰" + tmpnewchar ;break;
	case "3": tmpnewchar="叁" + tmpnewchar ;break;
	case "4": tmpnewchar="肆" + tmpnewchar ;break;
	case "5": tmpnewchar="伍" + tmpnewchar ;break;
	case "6": tmpnewchar="陆" + tmpnewchar ;break;
	case "7": tmpnewchar="柒" + tmpnewchar ;break;
	case "8": tmpnewchar="捌" + tmpnewchar ;break;
	case "9": tmpnewchar="玖" + tmpnewchar ;break;
	}
	if(i==0)tmpnewchar =tmpnewchar + "角";
	if(i==1)tmpnewchar = tmpnewchar + "分";
	newchar = newchar + tmpnewchar;
	}
	}
	//替换所有无用汉字
	while(newchar.search("零零") != -1)
	newchar = newchar.replace("零零", "零");
	newchar = newchar.replace("零亿", "亿");
	newchar = newchar.replace("零万", "万");
	newchar = newchar.replace("亿万", "亿");
	newchar = newchar.replace("零角", "零");
	newchar = newchar.replace("零圆", "圆");
	newchar = newchar.replace("零分", "");
	if(newchar.charAt(0) == "圆"&&newchar.length!=1){
	  newchar=newchar.substr(1,newchar.length);
	}
	if(newchar.charAt(0) == "整"||newchar=="圆"){
	  newchar="零圆整";
	}

	if(newchar!="零圆整"&&newchar.charAt(newchar.length-1) == "零")
	newchar=newchar.substr(0,newchar.length-1);
	if (newchar.charAt(newchar.length-1) == "圆")
	newchar = newchar+"整"
	if(newchar=='')
		newchar="零圆整";
	
	return newchar;
	}
	
	$(function(){
		$('input.cash').each(function(){//金额控件初始化
			var _this = $(this);
			
			//根据实际值初始化控件值与大写提示信息
			var unit = _this.attr('unit') == 'ten-thousand' ? 10000 : 1;//是否有指定单位
			
			var bindValEle = null;
			var initRealVal;
			var initDisplayVal;
			var bindAttr = _this.attr('bind');
			if(bindAttr && bindAttr.length>0){//有指定绑定值元素
				bindValEle = $('#'+bindAttr);
				if(bindValEle.length == 0 ){
					bindValEle = null;
				}else{
					initRealVal = bindValEle.val();
				}
			}else{//没有指定绑定元素
				initRealVal = _this.val();
			}
			
			if($.isNumeric(initRealVal) && unit != 1){
				initDisplayVal = Number(initRealVal).div(unit);
				if(initDisplayVal.toString().split(".")[1]){
					var _length = initDisplayVal.toString().split(".")[1].length;
					if(_length>6){
						initDisplayVal = initDisplayVal.toFixed(6);
					}
				}
				
			}else{
				initDisplayVal = initRealVal;
			}
			_this.val(initDisplayVal);
			
			
			//金额大写提示
			var ctip = _this.attr('ctip');
			var cash_BigAmount;
			var errTip;
			if(ctip && ctip =='zh' ){
				cash_BigAmount = _this.siblings('.cash_BigAmount');
				if(cash_BigAmount.length == 0){
					cash_BigAmount = $('<span class="cash_BigAmount"><span>');
					_this.after("<span></span>").after(cash_BigAmount);
				}
				errTip = _this.siblings('.cash_errorTip');
				if(errTip.length == 0){
					errTip = $('<span class="cash_errorTip"></span>');
					cash_BigAmount.after(errTip);
				}
				cash_BigAmount.text(Arabia_to_Chinese(initRealVal+'',errTip));
			}
			
			_this.bind('keyup',function(){
				var inputVal = _this.val();//输入值
				var realVal;//经过单位转换后的实际值
				if($.isNumeric(inputVal) && unit != 1){
					realVal = Number(inputVal).mul(unit);
				}else{
					realVal = inputVal;
				}
				//是否指定绑定到的控件
				if(bindValEle != null ){
					bindValEle.val(realVal);
				}
				
				if(errTip){
					cash_BigAmount.text(Arabia_to_Chinese(realVal+'',errTip));
				}
			});
		});
	});
	//小写金额转大写end
	
})(ACF);