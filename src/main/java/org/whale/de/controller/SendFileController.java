package org.whale.de.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.whale.base.BaseController;
import org.whale.base.DictUtil;
import org.whale.base.TimeUtil;
import org.whale.de.domain.SendFile;
import org.whale.de.service.OrganizationService;
import org.whale.de.service.SendFileService;
import org.whale.pu.excel.ColumnHandlerComponent;
import org.whale.pu.excel.ExcelConstant;
import org.whale.pu.excel.ExcelWebUtil;
import org.whale.pu.excel.IColumnHandler;
import org.whale.system.auth.annotation.AuthUri;
import org.whale.system.cache.service.DictCacheService;
import org.whale.system.common.exception.SysException;
import org.whale.system.common.util.LangUtil;
import org.whale.system.common.util.WebUtil;
import org.whale.system.controller.login.UserContext;
import org.whale.system.dao.Page;
import org.whale.system.domain.Dict;


@AuthUri
@Controller
@RequestMapping("/de/sendFile")
public class SendFileController extends BaseController {

	@Autowired
	private SendFileService sendFileService;
	@Autowired
	private OrganizationService organizationService;
	@Autowired
	private DictCacheService dictCacheService;
	
	@RequestMapping("/goList")
	public ModelAndView goList(HttpServletRequest request, HttpServletResponse response, SendFile sendFile){
	
	
	 	sendFileService.querySendFilePage(this.newPage(request),getParamMap(request));
	    
		ModelAndView mav = new ModelAndView("de/sendFile/sendFile_list")
						.addObject(PARAM_MAP_KEY, getParamMap(request));
		mav.addObject(QUERY_MORE_PARAMETER_NAME,request.getParameter(QUERY_MORE_PARAMETER_NAME));
		
		return mav;
	}
	
	@RequestMapping("/goSave")
	public ModelAndView goSave(HttpServletRequest request, HttpServletResponse response){
		return new ModelAndView("de/sendFile/sendFile_edit")
		.addObject("nextSendNo", String.format("SN%s", TimeUtil.getCurrDate("yyyyMMddHHmmssS")))
		.addObject("organizationMap", organizationService.queryOrganizationMap());
	}
	
	@RequestMapping("/goUpdate")
	public ModelAndView goUpdate(HttpServletRequest request, HttpServletResponse response, Long id){
		SendFile sendFile = this.sendFileService.get(id);
		if(sendFile == null){
			throw new SysException("查找不到 id="+id);
		}
		
		return new ModelAndView("de/sendFile/sendFile_edit")
				.addObject("sendFile", sendFile)
				.addObject("organizationMap", organizationService.queryOrganizationMap());
	}
	
	@RequestMapping("/goView")
	public ModelAndView goView(HttpServletRequest request, HttpServletResponse response, Long id){
		SendFile sendFile = this.sendFileService.getById(id);
		if(sendFile == null){
			throw new SysException("查找不到 id="+id);
		}
		
		return new ModelAndView("de/sendFile/sendFile_view")
				.addObject("item", sendFile);
	}
	
	@RequestMapping("/doSave")
	public void doSave(HttpServletRequest request, HttpServletResponse response, SendFile sendFile){
		UserContext uc = this.getUserContext(request);
		this.sendFileService.save(sendFile);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doUpdate")
	public void doUpdate(HttpServletRequest request, HttpServletResponse response, SendFile sendFile){
		UserContext uc = this.getUserContext(request);
		this.sendFileService.update(sendFile);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response, String ids){
		List<Long> idS = LangUtil.splitIds(ids);
		if(idS == null || idS.size() < 1){
			WebUtil.printFail(request, response, "您要删除的记录，系统中并不存在，ids为：" + ids);
			return ;
		}
		this.sendFileService.delete(idS);
		WebUtil.printSuccess(request, response);
	}
	
	/**
	 * 导出Excel表格
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/doExcel")
	public void doExcel(HttpServletRequest request, HttpServletResponse response, SendFile sendFile) throws Exception{
		LinkedHashMap<String, ColumnHandlerComponent> titleMap=new LinkedHashMap<String, ColumnHandlerComponent>();
		titleMap.put("SEND_NO", new ColumnHandlerComponent("发文号",null ));
		titleMap.put("SEND_DATE", new ColumnHandlerComponent("发文日期",null ));
		titleMap.put("SEND_COMPANYS", new ColumnHandlerComponent("发送单位",null));
		titleMap.put("FILE_TITLE", new ColumnHandlerComponent("发文标题",null ));
		titleMap.put("FILE_CODE", new ColumnHandlerComponent("文号", null));
		titleMap.put("DICT_DENSE",new ColumnHandlerComponent("密级",new IColumnHandler() {
	        	Dict dict=dictCacheService.getDict("DICT_DENSE");
				@Override
				public String handle(Object object,Map<String, Object> rowData) {
					if(object!=null){
					return DictUtil.getItemLabel(dict,object.toString());
					}
					else return "";
				}
			}));
        titleMap.put("DE_SIGN_UP",new ColumnHandlerComponent("签收人",null));
		
		Page page=super.newPage(request);
		page.setPageNo(1);
		page.setPageSize(ExcelConstant.MAX_EXPORT_PAGE_SIZE);
		Map<String, String> paramMap=this.getParamMap(request);
		this.sendFileService.querySendFilePage(page, paramMap);
		String fileName=page.getTotalNum()>ExcelConstant.MAX_EXPORT_PAGE_SIZE?"发文记录(Warn:超出"+ExcelConstant.MAX_EXPORT_PAGE_SIZE+"部分被忽略)"+".xls":"发文记录.xls";
		ExcelWebUtil.flushExcelOutputStream(request, response, titleMap, page.getDatas(), fileName, "发文记录");
	}

}