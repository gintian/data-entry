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
import org.whale.de.domain.RecFile;
import org.whale.de.domain.RecFileSign;
import org.whale.de.dto.RecFileSignDto;
import org.whale.de.service.OrganizationService;
import org.whale.de.service.RecFileService;
import org.whale.de.service.RecFileSignService;
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
@RequestMapping("/de/recFile")
public class RecFileController extends BaseController {

	@Autowired
	private RecFileService recFileService;
	@Autowired
	private DictCacheService dictCacheService;
	@Autowired
	SysSequenceService sysSequenceService;
	@Autowired
	private OrganizationService organizationService;
	@Autowired
	private RecFileSignService recFileSignService;
	
	@RequestMapping("/goList")
	public ModelAndView goList(HttpServletRequest request, HttpServletResponse response){
	
	
	 	recFileService.queryRecFilePage(this.newPage(request),getParamMap(request));
	    
		ModelAndView mav = new ModelAndView("de/recFile/recFile_list")
						.addObject(PARAM_MAP_KEY, getParamMap(request));
		mav.addObject(QUERY_MORE_PARAMETER_NAME,request.getParameter(QUERY_MORE_PARAMETER_NAME));
		
		return mav;
	}
	
	@RequestMapping("/goSignList")
	public ModelAndView goSignList(HttpServletRequest request, HttpServletResponse response){
		
	 	recFileService.queryRecFileSignPage(this.newPage(request),getParamMap(request));
	    
		ModelAndView mav = new ModelAndView("de/recFile/recFile_sign_list")
						.addObject(PARAM_MAP_KEY, getParamMap(request));
		mav.addObject(QUERY_MORE_PARAMETER_NAME,request.getParameter(QUERY_MORE_PARAMETER_NAME));
		
		return mav;
	}
	
	@RequestMapping("/goSave")
	public ModelAndView goSave(HttpServletRequest request, HttpServletResponse response, String dictFileSource){
		RecFile recFile = new RecFile();
		recFile.setDictFileSource(dictFileSource);
		return new ModelAndView("de/recFile/recFile_edit")
//			.addObject("nextRecNo", String.format("RN%s", TimeUtil.getCurrDate("yyyyMMddHHmmssS")))
			.addObject("nextRecNo", sysSequenceService.doGetNextVal(SeqType.REC_NO))
			.addObject("recFile", recFile)
			.addObject("organizationMap", organizationService.queryOrganizationMap(1, dictFileSource));
	}
	
	@RequestMapping("/goUpdate")
	public ModelAndView goUpdate(HttpServletRequest request, HttpServletResponse response, Long id){
		RecFile recFile = this.recFileService.get(id);
		if(recFile == null){
			throw new SysException("查找不到 id="+id);
		}
		List<RecFileSign> rfSigns = recFileSignService.query(id);
		
		return new ModelAndView("de/recFile/recFile_edit")
				.addObject("recFile", recFile)
				.addObject("organizationMap", organizationService.queryOrganizationMap(1, recFile.getDictFileSource()))
				.addObject("rfSigns", rfSigns);
	}
	
	@RequestMapping("/goView")
	public ModelAndView goView(HttpServletRequest request, HttpServletResponse response, Long id){
		RecFile recFile = this.recFileService.get(id);
		if(recFile == null){
			throw new SysException("查找不到 id="+id);
		}
		
		return new ModelAndView("de/recFile/recFile_view")
				.addObject("item", recFile);
	}
	
	@RequestMapping("/goProposedView")
	public ModelAndView goProposedView(HttpServletRequest request, HttpServletResponse response, Long id){
		RecFile recFile = this.recFileService.get(id);
		if(recFile == null){
			throw new SysException("查找不到 id="+id);
		}
		//文件类别是密码电报的拟办格式跟其他不一样
		ModelAndView mv = new ModelAndView();
		if("FILE_CATEGORY_MMDB".equals(recFile.getDictFileCategory())){
			mv.setViewName("de/recFile/mmdb_proposed_view");
		}else{
			mv.setViewName("de/recFile/proposed_view");
		}
		mv.addObject("item", recFile);
		return mv;
	}
	
	@RequestMapping("/goSuperviseView")
	public ModelAndView goSuperviseView(HttpServletRequest request, HttpServletResponse response, Long id){
		RecFile recFile = this.recFileService.get(id);
		if(recFile == null){
			throw new SysException("查找不到 id="+id);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("de/recFile/supervise_view");
		mv.addObject("item", recFile);
		return mv;
	}
	
	
	@RequestMapping("/doSave")
	public void doSave(HttpServletRequest request, HttpServletResponse response, RecFile recFile, RecFileSignDto dto){
		UserContext uc = this.getUserContext(request);
		this.recFileService.doSaveOrUpdate(recFile, dto);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doUpdate")
	public void doUpdate(HttpServletRequest request, HttpServletResponse response, RecFile recFile, RecFileSignDto dto){
		UserContext uc = this.getUserContext(request);
		this.recFileService.doSaveOrUpdate(recFile, dto);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doHandle")
	public void doHandle(HttpServletRequest request, HttpServletResponse response, Long id){
		UserContext uc = this.getUserContext(request);
		this.recFileService.doHandle(id);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response, String ids){
		List<Long> idS = LangUtil.splitIds(ids);
		if(idS == null || idS.size() < 1){
			WebUtil.printFail(request, response, "您要删除的记录，系统中并不存在，ids为：" + ids);
			return ;
		}
		this.recFileService.delete(idS);
		WebUtil.printSuccess(request, response);
	}
	/**
	 * 导出Excel表格
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/doExcel")
	public void doExcel(HttpServletRequest request, HttpServletResponse response, RecFile recFile) throws Exception{
		LinkedHashMap<String, ColumnHandlerComponent> titleMap=new LinkedHashMap<String, ColumnHandlerComponent>();
		titleMap.put("REC_NO", new ColumnHandlerComponent("收文号",null ));
		titleMap.put("REC_DATE", new ColumnHandlerComponent("收文日期",null ));
		titleMap.put("DICT_REC_COMPANY", new ColumnHandlerComponent("来文单位",new IColumnHandler() {
        	Dict dict=dictCacheService.getDict("DICT_REC_COMPANY");
			@Override
			public String handle(Object object,Map<String, Object> rowData) {
				if(object!=null){
				return DictUtil.getItemLabel(dict,object.toString());
				}
				else return "";
			}
		}));
		titleMap.put("FILE_TITLE", new ColumnHandlerComponent("文件标题",null ));
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
		this.recFileService.queryRecFilePage(page, paramMap);
		String fileName=page.getTotalNum()>ExcelConstant.MAX_EXPORT_PAGE_SIZE?"收文记录(Warn:超出"+ExcelConstant.MAX_EXPORT_PAGE_SIZE+"部分被忽略)"+".xls":"收文记录.xls";
		ExcelWebUtil.flushExcelOutputStream(request, response, "福州市公安局收文签收单", titleMap, page.getDatas(), fileName, "收文记录");
	}
	
	@RequestMapping("/doSignExcel")
	public void doSignExcel(HttpServletRequest request, HttpServletResponse response, RecFile recFile) throws Exception{
		LinkedHashMap<String, ColumnHandlerComponent> titleMap=new LinkedHashMap<String, ColumnHandlerComponent>();
		titleMap.put("REC_NO", new ColumnHandlerComponent("收文号",null ));
		titleMap.put("REC_DATE", new ColumnHandlerComponent("收文日期",null ));
		titleMap.put("DICT_REC_COMPANY", new ColumnHandlerComponent("来文单位",new IColumnHandler() {
        	Dict dict=dictCacheService.getDict("DICT_REC_COMPANY");
			@Override
			public String handle(Object object,Map<String, Object> rowData) {
				if(object!=null){
				return DictUtil.getItemLabel(dict,object.toString());
				}
				else return "";
			}
		}));
		titleMap.put("FILE_TITLE", new ColumnHandlerComponent("文件标题",null ));
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
		this.recFileService.queryRecFileSignPage(page, paramMap);
		String fileName=page.getTotalNum()>ExcelConstant.MAX_EXPORT_PAGE_SIZE?"收文记录(Warn:超出"+ExcelConstant.MAX_EXPORT_PAGE_SIZE+"部分被忽略)"+".xls":"收文记录.xls";
		ExcelWebUtil.flushExcelOutputStream(request, response, "福州市公安局收文签收单", titleMap, page.getDatas(), fileName, "收文记录");
	}
	
}