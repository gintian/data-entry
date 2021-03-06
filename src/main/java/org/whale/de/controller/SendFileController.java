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
import org.whale.base.sequence.domain.SysSequence.SeqType;
import org.whale.base.sequence.service.SysSequenceService;
import org.whale.de.domain.SendFile;
import org.whale.de.service.OrganizationService;
import org.whale.de.service.SendFileService;
import org.whale.pu.excel.ColumnHandlerComponent;
import org.whale.pu.excel.ExcelConstant;
import org.whale.pu.excel.ExcelWebUtil;
import org.whale.pu.excel.IColumnHandler;
import org.whale.system.auth.annotation.AuthUri;
import org.whale.system.cache.service.DictCacheService;
import org.whale.system.common.constant.SysConstant;
import org.whale.system.common.exception.BusinessException;
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
	@Autowired
	SysSequenceService sysSequenceService;
	
	@RequestMapping("/goList")
	public ModelAndView goList(HttpServletRequest request, HttpServletResponse response, SendFile sendFile){
	
	
	 	sendFileService.querySendFilePage(this.newPage(request),getParamMap(request));
	    
	 	boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
	 	
		ModelAndView mav = new ModelAndView("de/sendFile/sendFile_list")
						.addObject(PARAM_MAP_KEY, getParamMap(request));
		mav.addObject(QUERY_MORE_PARAMETER_NAME,request.getParameter(QUERY_MORE_PARAMETER_NAME))
		.addObject("isDense", isDense);
		
		return mav;
	}
	
	@RequestMapping("/goSave")
	public ModelAndView goSave(HttpServletRequest request, HttpServletResponse response){
		
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		
		return new ModelAndView("de/sendFile/sendFile_edit")
//		.addObject("nextSendNo", String.format("SN%s", TimeUtil.getCurrDate("yyyyMMddHHmmssS")))
//		.addObject("nextSendNo", sysSequenceService.doGetNextVal(SeqType.SEND_NO))
		.addObject("organizationMap", organizationService.queryOrganizationMap(2, null))
		.addObject("isDense", isDense);
	}
	
	@RequestMapping("/goUpdate")
	public ModelAndView goUpdate(HttpServletRequest request, HttpServletResponse response, Long id){
		SendFile sendFile = this.sendFileService.get(id);
		if(sendFile == null){
			throw new SysException("???????????? id="+id);
		}
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		// ??????????????????????????????????????????
		UserContext uc = this.getUserContext(request);
		if(!(uc.getUserId().equals(sendFile.getCreateById()) || uc.isSuperAdmin())){
			throw new BusinessException("?????????????????????????????????");
		}
		
		return new ModelAndView("de/sendFile/sendFile_edit")
				.addObject("sendFile", sendFile)
				.addObject("organizationMap", organizationService.queryOrganizationMap(2, null))
				.addObject("isDense", isDense);
	}
	
	@RequestMapping("/goView")
	public ModelAndView goView(HttpServletRequest request, HttpServletResponse response, Long id){
		SendFile sendFile = this.sendFileService.getById(id);
		if(sendFile == null){
			throw new SysException("???????????? id="+id);
		}
		
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		
		return new ModelAndView("de/sendFile/sendFile_view")
				.addObject("item", sendFile)
				.addObject("isDense", isDense);
	}
	
	@RequestMapping("/doSave")
	public void doSave(HttpServletRequest request, HttpServletResponse response, SendFile sendFile){
		UserContext uc = this.getUserContext(request);
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		if(null != sendFile){
			sendFile.setSendNo(sysSequenceService.doGetNextVal(isDense, SeqType.SEND_NO));
		}
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
			WebUtil.printFail(request, response, "????????????????????????????????????????????????ids??????" + ids);
			return ;
		}
		SendFile sendFile = null;
		// ??????????????????????????????????????????
		UserContext uc = this.getUserContext(request);
		for (Long long1 : idS) {
			sendFile = this.sendFileService.get(long1);
			if(!(uc.getUserId().equals(sendFile.getCreateById()) || uc.isSuperAdmin())){
//				throw new BusinessException("?????????????????????????????????");
				WebUtil.printSuccess(request, response, "?????????????????????????????????");
				return;
			}
		}
		this.sendFileService.delete(idS);
		WebUtil.printSuccess(request, response);
	}
	
	/**
	 * ??????Excel??????
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/doExcel")
	public void doExcel(HttpServletRequest request, HttpServletResponse response, SendFile sendFile) throws Exception{
		LinkedHashMap<String, ColumnHandlerComponent> titleMap=new LinkedHashMap<String, ColumnHandlerComponent>();
		titleMap.put("SEND_NO", new ColumnHandlerComponent("?????????",null ));
		titleMap.put("SEND_DATE", new ColumnHandlerComponent("????????????",null ));
		titleMap.put("SEND_COMPANYS", new ColumnHandlerComponent("????????????",new IColumnHandler() {
			
			@Override
			public String handle(Object object, Map<String, Object> rowData) {
				if(null == object){
					return "";
				}
				return object.toString().replaceAll(",", "\n");
			}
		}));
		titleMap.put("FILE_TITLE", new ColumnHandlerComponent("????????????",null ));
		titleMap.put("FILE_CODE", new ColumnHandlerComponent("??????", null));
		titleMap.put("DICT_DENSE",new ColumnHandlerComponent("??????",new IColumnHandler() {
	        	Dict dict=dictCacheService.getDict("DICT_DENSE");
				@Override
				public String handle(Object object,Map<String, Object> rowData) {
					if(object!=null){
					return DictUtil.getItemLabel(dict,object.toString());
					}
					else return "";
				}
			}));
		titleMap.put("CONFIDENTIAL_CODE", new ColumnHandlerComponent("????????????", null));
		titleMap.put("DENSE_CODE",new ColumnHandlerComponent("????????????",new IColumnHandler() {
			
			@Override
			public String handle(Object object, Map<String, Object> rowData) {
				if(object == null || "".equals(object.toString())){
					return "";
				}
				String[] dcArr = object.toString().split("-");
				Integer startIndex = Integer.parseInt(dcArr[0]);
				Integer endIndex = Integer.parseInt(dcArr[1]);
				if(startIndex > endIndex){
					Integer temp = endIndex;
					endIndex = startIndex;
					startIndex = temp;
				}
				String outDenseCode = "";
				for(int i=startIndex; i<=endIndex; i++){
					outDenseCode = outDenseCode + i + "\n";
				}
				return outDenseCode.substring(0, outDenseCode.length()-1);
			}
		}));
        titleMap.put("DE_SIGN_UP",new ColumnHandlerComponent("?????????",null));
		
		Page page=super.newPage(request);
		page.setPageNo(1);
		page.setPageSize(ExcelConstant.MAX_EXPORT_PAGE_SIZE);
		Map<String, String> paramMap=this.getParamMap(request);
		this.sendFileService.querySendFilePage(page, paramMap);
		String fileName=page.getTotalNum()>ExcelConstant.MAX_EXPORT_PAGE_SIZE?"????????????(Warn:??????"+ExcelConstant.MAX_EXPORT_PAGE_SIZE+"???????????????)"+".xls":"????????????.xls";
		ExcelWebUtil.flushExcelOutputStream(request, response, "?????????????????????????????????", titleMap, page.getDatas(), fileName, "????????????");
	}

}