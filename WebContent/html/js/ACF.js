Date.prototype.format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

Date.prototype.addDays = function (days) {
	var d=this;
	d.setDate(d.getDate()+days);
};

Date.prototype.addMonths = function (months) {
	var d=this.getDate();
	this.setMonth(this.getMonth() + months)
	
	if(this.getDate() < d){
		this.setDate(0);
	}
};

Date.prototype.addSeconds = function (seconds) {
	var d=this;
	d.setSeconds(d.getSeconds()+seconds); 
};


var ACF = {};


(function(){
	var showFailureMsg = function(msg){
		if (typeof (msg) == "undefined") {
			msg = "";
		}
		$("#infoBoxDiv").html(msg).css("display", "block");
	};
	
	var clearFailureMsg = function(){
		$("#infoBoxDiv").html("").css("display", "none");
	};
	
	var callback = function(obj, fnCallback,failure){
		if(obj.rs){
			fnCallback && fnCallback(obj);
		}else{
			if(obj&&obj.msg=='needPersonException'){
				var dlgParam = {
					roleCode:obj.datas,
					pkBusinessGroup:ACF.getBizGroupIds(),
					type:'user'
				};
				
				toolBar.enableBut('submitBtn');//选人时可能直接关闭窗口
				var dlg = new PersonDlg(ACF.ctx,dlgParam,function(arr_idS_nameS){
					if( arr_idS_nameS && arr_idS_nameS.length > 1 && arr_idS_nameS[1].length > 0 ){
						$('#nextUserNames').val(arr_idS_nameS[1]);
						dlg.close();
						save('submitBtn');
					}else{
						$.info("请选择任务接收人");
					}
				},true,'下一环节任务接收人');
				
				dlg.open();
			}else{
				showFailureMsg(obj.msg);
				failure&&failure(obj);
			}
		}
	};
	
	/**
	 * jquery ajax方法封装
	 */
	var call = function(ajaxType,_url, _param, _success, method, async,failure){
		
		var setting = {};

		if(method)
			setting.type = method;
		else
			setting.type='POST';
		
		setting.url = _url;
		
		if(ajaxType=='json'){
			setting.data = JSON.stringify(_param);
			setting.contentType = 'application/json;charset=UTF-8';
			setting.dataType = 'json';
		}else if(ajaxType=='form'){
			setting.contentType = 'application/x-www-form-urlencoded; charset=UTF-8';	
			setting.data = _param;
			setting.traditional = true;//采用传统方法序列化
		}else if(ajaxType=='page'){
			setting.dataType = 'html';
		}
		
		setting.beforeSend = function(xhr){
			clearFailureMsg();
			waitObj = $.wait();
		};
		
		setting.complete = function(XMLHttpRequest,textStatus){
			waitObj.close();
		};
		
		setting.error = function(xhr, textStatus,errorThrown){
			waitObj.close();
			if(xhr.status != 200 &&  xhr.readyState != 0){
				showFailureMsg('保存数据出错!' + '错误码:'+xhr.status);
			}
		};
		
		setting.success = function(obj)
		{
			waitObj.close(); 
			callback(obj,_success,failure);
		};


		if(async!=undefined){
			setting.async = async;
		}

		setting.cache=false;
		
		//设置ajax默认超时时间为120秒
		setting.timeout = 120*1000;
		
		$.ajax(setting);
	};
	
	
	/**
	 * json数据的ajax调用后台方法
	 */
	ACF.ajaxJson = function()
	{
		
		var _get = function(_url, _param, _success,async)
		{
			call('json',_url, _param, _success, 'GET',async);
		};
		
		var _post = function(_url, _param, _success,async)
		{
			call('json',_url, _param, _success, 'POST',async);
		};
		
		var _sGet = function(_url, _param, _success)
		{
			_get(_url, _param, _success,false);
		};
		
		var _sPost = function(_url, _param, _success)
		{
			_post(_url, _param, _success,false);
		};
				
		return {
			get : _get,
			post : _post,
			sGet:_sGet,
			sPost:_sPost
		};
		
	}();
	
	
	/**
	 * FORM表单数据的ajax提交
	 */
	ACF.ajaxForm = function(){

		var _get = function(_url,_param,_success,_failure)
		{
			call('form',_url, _param, _success, 'GET',true,_failure);
		};
		
		var _post = function(_url,_param,_success,_failure)
		{
			call('form',_url, _param, _success, 'POST',true,_failure);
		};
		
		var _sGet = function(_url, _param, _success){
			_get(_url, _param, _success,false);
		};
		
		var _sPost = function(_url, _param, _success){
			_post(_url, _param, _success,false);
		};
		
		return {
			get : _get,
			post : _post,
			sGet:_sGet,
			sPost:_sPost
		};
	}();
	
	
	
})($)