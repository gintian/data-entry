/**  new PersonDlg("${ctx}","#id",function callback(data));
data[0]="1,2"
data[1]="john,pitty"

 * param = {roleCode:arr_roleCodes,pkBusinessGroup:arrBizGroups,persons:arrPerson}
 * eg:
 * var param = {
			roleCode:['role_mgr'],//角色code
			pkBusinessGroup:['1','2'],//业务组id
			sltIds:['1','2','3'],预先选中人员列表
			type:'user'//user or customer
			numLimit:1
			customerTypes=['CUSTOMER_TYPE_INVESTOR','CUSTOMER_TYPE_BORROWER']//当type=customer时有效
	};
				
 * callback 回调返回参数arr数组 arr[0]选中人员主键列表"," 分割串 arr[1] 选中人员姓名列表","分割串
 * bl_reamin_open 回调后是否保持窗口打开状态 false,自动关闭  true,不关闭
 */
function PersonDlg(ctx,param,callback,bl_reamin_open,vtitle){
    var sltPersonDlg;
    function formatUrl(){
    	result=ctx+"/pu/personPicker/UserSltPage?type=" +param.type ;
    	delete param.type;
    	if(param.numLimit){
    		result=result+"&numLimit="+param.numLimit;
    		delete param.numLimit;
    	}
    	
    	if(param){
    		var paramSufix = '';
    		for(var key in param){
    				if(param[key]){
    					if($.isArray(param[key])){
    					paramSufix += '&'+key+'='+param[key].join(',');
    					}
    					else{
    					paramSufix += '&'+key+'='+param[key];	
    					}
    				}
    		}
    		result = result + paramSufix;
    	}
    	return result;
    }
	this.url=formatUrl();
	if(vtitle){
		this.title=vtitle;
	}
	else{
		this.title='人员选择';
	}
	callingback=function(data){
		if(!bl_reamin_open){
			sltPersonDlg.hide();
		}
		callback&&callback(data);
	};
	this.open=function(){
		sltPersonDlg= $.openWin({url:this.url,"title":this.title,callback:callingback, width:600, height:700});
	}
	this.close = function(){
		sltPersonDlg.hide();
	}
}