一.前端页面以iframe形式嵌套，例如<iframe frameborder="0" id="attachIframe"  name="attachIframe"  height="100%" width="100%" src="${ctx}/attach/goFileUpload?businessKey=&processInstanceId=&taskDefinitionKey=&businessTableName=&saveWay=&readOnly="></iframe>
     其中各参数说明：businessKey(业务表实例ID)、
     			processInstanceId(流程实例ID)、
     			taskDefinitionKey(流程任务节点key)、
     			businessTableName(业务表表名)、
     			saveWay(保存方式，目前支持 1.本地磁盘、2.ftp、3.两种同时保存方式，默认支持本地磁盘保存)、
     			readOnly(是否只读，控制删除附件功能)

二.获取当前环节所提交的附件列表接口：($('#attachIframe')[0].window || $('#attachIframe')[0].contentWindow).getTaskNodeAttachs();

三.流程环节保存或者提交时，更新附件列表中的流程相关参数，AttachFileService.updateEngineInfo();
