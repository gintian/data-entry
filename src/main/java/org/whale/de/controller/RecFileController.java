package org.whale.de.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.whale.base.BaseController;
import org.whale.base.DictUtil;
import org.whale.base.TimeUtil;
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
		
		Map<String, String> paramMap = getParamMap(request);
		
	 	recFileService.queryRecFilePage(this.newPage(request), paramMap, 1);
	 	
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		
		ModelAndView mav = new ModelAndView("de/recFile/recFile_list")
						.addObject(PARAM_MAP_KEY, paramMap);
		mav.addObject(QUERY_MORE_PARAMETER_NAME,request.getParameter(QUERY_MORE_PARAMETER_NAME));
		mav.addObject("isDense", isDense);
		
		return mav;
	}
	
	@RequestMapping("/goSignList")
	public ModelAndView goSignList(HttpServletRequest request, HttpServletResponse response){
		
		Map<String, String> paramMap = getParamMap(request);
		
	 	recFileService.queryRecFileSignPage(this.newPage(request),paramMap, 1);

		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
	 	
		ModelAndView mav = new ModelAndView("de/recFile/recFile_sign_list")
						.addObject(PARAM_MAP_KEY, paramMap);
		mav.addObject(QUERY_MORE_PARAMETER_NAME,request.getParameter(QUERY_MORE_PARAMETER_NAME));
		mav.addObject("isDense", isDense);
		
		return mav;
	}
	
	@RequestMapping("/goSave")
	public ModelAndView goSave(HttpServletRequest request, HttpServletResponse response, String dictFileSource){
		RecFile recFile = new RecFile();
		recFile.setDictFileSource(dictFileSource);
		recFile.setRecDate(new Date());
		recFile.setIsDispatch(0);
		recFile.setIsNeedFeedback(0);
		recFile.setProposedDate(new Date());
		recFile.setProposedComments("呈XX副局长阅示，拟请XX阅处。");
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));

		return new ModelAndView("de/recFile/recFile_edit")
//			.addObject("nextRecNo", String.format("RN%s", TimeUtil.getCurrDate("yyyyMMddHHmmssS")))
			.addObject("isDense", isDense)
			//.addObject("nextRecNo", sysSequenceService.doGetNextVal(SeqType.REC_NO))
			.addObject("recFile", recFile)
			.addObject("organizationMap", organizationService.queryOrganizationMap(1, dictFileSource));
	}
	
	@RequestMapping("/goUpdate")
	public ModelAndView goUpdate(HttpServletRequest request, HttpServletResponse response, Long id){
		RecFile recFile = this.recFileService.get(id);
		if(recFile == null){
			throw new SysException("查找不到 id="+id);
		}
		// 收文创建用户、管理员才能操作
		UserContext uc = this.getUserContext(request);
		if(!(uc.getUserId().equals(recFile.getCreateById()) || uc.isSuperAdmin())){
			throw new BusinessException("无修改权限，请重新操作");
		}
		
		List<RecFileSign> rfSigns = recFileSignService.query(id);
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		
		return new ModelAndView("de/recFile/recFile_edit")
				.addObject("isDense", isDense)
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
		List<RecFileSign> rfSigns = recFileSignService.query(id);
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		
		return new ModelAndView("de/recFile/recFile_view")
				.addObject("item", recFile)
				.addObject("isDense", isDense)
				.addObject("organizationMap", organizationService.queryOrganizationMap(1, recFile.getDictFileSource()))
				.addObject("rfSigns", rfSigns);
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
	public synchronized void doSave(HttpServletRequest request, HttpServletResponse response, RecFile recFile, RecFileSignDto dto){
		UserContext uc = this.getUserContext(request);
		String recNo = "";
		boolean isDense = SysConstant.LOGIC_TRUE.equalsIgnoreCase(dictCacheService.getItemValue("DICT_SYS_CONF", "DENSE_CFG"));
		if(null != recFile && null != recFile.getRecDate()){
			// 新增收文，优先使用被删除的收文号
			recNo = this.recFileService.getRecNoFromDeleted(recFile.getRecDate());
			if(StringUtils.isBlank(recNo)){
				// 新增之前的收文，取最大的收文号+1
				if(TimeUtil.compareToDay(recFile.getRecDate(), new Date()) > 0){
					recNo = this.recFileService.getRecNoByHistory(recFile.getRecDate(), isDense);
				} else{
					//新增当天的收文，取序列值
					recNo = sysSequenceService.doGetNextVal(isDense, SeqType.REC_NO);
				}
			}
		}
		recFile.setRecNo(recNo);
		if(recFile.getIsProposed().equals(0)){
			recFile.setProposedComments(null);
			recFile.setProposedDate(null);
		}
		this.recFileService.doSaveOrUpdate(recFile, dto);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doUpdate")
	public void doUpdate(HttpServletRequest request, HttpServletResponse response, RecFile recFile, RecFileSignDto dto){
		UserContext uc = this.getUserContext(request);
		if(recFile.getIsProposed().equals(0)){
			recFile.setProposedComments(null);
			recFile.setProposedDate(null);
		}
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
		RecFile recFile = null;
		// 收文创建用户、管理员才能操作
		UserContext uc = this.getUserContext(request);
		for (Long long1 : idS) {
			recFile = this.recFileService.get(long1);
			if(!(uc.getUserId().equals(recFile.getCreateById()) || uc.isSuperAdmin())){
//				throw new BusinessException("无删除权限，请重新操作");
				WebUtil.printSuccess(request, response, "无删除权限，请重新操作");
				return;
			}
		}
//		this.recFileService.delete(idS);
		this.recFileService.deleteFake(idS);
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
		
		IColumnHandler icolumnHandler = new IColumnHandler() {
			@Override
			public String handle(Object object,Map<String, Object> rowData) {
				if(object!=null){
					Integer val=(Integer)object;
					return convert(val);
				}else {
					return "";
				}
			}
			private String convert(int status) {
				String retVal = "";
				switch (status) {
					case 1:
						retVal = "是";
						break;
					case 0:
						retVal = "否";
						break;
					default:
						break;
				}
				return retVal;
			}   
		};
		
		LinkedHashMap<String, ColumnHandlerComponent> titleMap=new LinkedHashMap<String, ColumnHandlerComponent>();
		titleMap.put("REC_NO", new ColumnHandlerComponent("收文号",null ));
		titleMap.put("REC_DATE", new ColumnHandlerComponent("收文日期",null ));
		titleMap.put("DICT_REC_COMPANY", new ColumnHandlerComponent("来文单位",null));
		titleMap.put("FILE_CODE", new ColumnHandlerComponent("文号", null));
		titleMap.put("FILE_TITLE", new ColumnHandlerComponent("文件标题",22));
		titleMap.put("PROPOSED_COMMENTS", new ColumnHandlerComponent("拟办意见",22));
		titleMap.put("LEADER_INS", new ColumnHandlerComponent("局领导批示",22));
		/*titleMap.put("DE_SIGN_UP_COMPANYS",new ColumnHandlerComponent("签收单位",null));
		titleMap.put("DE_SIGN_UP",new ColumnHandlerComponent("签收人",null));
		titleMap.put("DE_SIGN_TIME",new ColumnHandlerComponent("签收时间",null));*/
		titleMap.put("HANDLE_PRES", new ColumnHandlerComponent("办理时效", new IColumnHandler(){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			@Override
			public String handle(Object object,Map<String, Object> rowData) {
				if(object!=null){
					Date date=(Date)object;
					return sdf.format(date);
				}
				else return "";
			}
		}));
		titleMap.put("IS_PROPOSED", new ColumnHandlerComponent("是否拟办", icolumnHandler));
		titleMap.put("IS_NEED_FEEDBACK", new ColumnHandlerComponent("是否需反馈", icolumnHandler));
		titleMap.put("MEMO", new ColumnHandlerComponent("备注", null));
		
		/*titleMap.put("DICT_FILE_CATEGORY", new ColumnHandlerComponent("文件类别",new IColumnHandler() {
    	Dict dict=dictCacheService.getDict("DICT_FILE_CATEGORY");
		@Override
		public String handle(Object object,Map<String, Object> rowData) {
			if(object!=null){
			return DictUtil.getItemLabel(dict,object.toString());
			}
			else return "";
			}
		}));*/
		/*titleMap.put("DICT_DENSE",new ColumnHandlerComponent("密级",new IColumnHandler() {
    	Dict dict=dictCacheService.getDict("DICT_DENSE");
		@Override
		public String handle(Object object,Map<String, Object> rowData) {
			if(object!=null){
			return DictUtil.getItemLabel(dict,object.toString());
			}
			else return "";
		}
			}));
		titleMap.put("DICT_GRADE",new ColumnHandlerComponent("等级",new IColumnHandler() {
			Dict dict=dictCacheService.getDict("DICT_GRADE");
			@Override
			public String handle(Object object,Map<String, Object> rowData) {
				if(object!=null){
				return DictUtil.getItemLabel(dict,object.toString());
				}
				else return "";
			}
		}));
		titleMap.put("FILE_CNT", new ColumnHandlerComponent("文件数量", null));
		titleMap.put("IS_DISPATCH", new ColumnHandlerComponent("是否急件",icolumnHandler));*/
		
		Page page=super.newPage(request);
		page.setPageNo(1);
		page.setPageSize(ExcelConstant.MAX_EXPORT_PAGE_SIZE);
		Map<String, String> paramMap=this.getParamMap(request);
		this.recFileService.queryRecFilePage(page, paramMap, 2);
		String fileName=page.getTotalNum()>ExcelConstant.MAX_EXPORT_PAGE_SIZE?"收文记录(Warn:超出"+ExcelConstant.MAX_EXPORT_PAGE_SIZE+"部分被忽略)"+".xls":"收文记录.xls";
		ExcelWebUtil.flushExcelOutputStream(request, response, "福州市公安局收文签收单", titleMap, page.getDatas(), fileName, "收文记录");
	}
	
	@RequestMapping("/doSignExcel")
	public void doSignExcel(HttpServletRequest request, HttpServletResponse response, RecFile recFile) throws Exception{
		LinkedHashMap<String, ColumnHandlerComponent> titleMap=new LinkedHashMap<String, ColumnHandlerComponent>();
		titleMap.put("DICT_FILE_SOURCE", new ColumnHandlerComponent("文件来源",new IColumnHandler() {
        	Dict dict=dictCacheService.getDict("DICT_FILE_SOURCE");
			@Override
			public String handle(Object object,Map<String, Object> rowData) {
				if(object!=null){
				return DictUtil.getItemLabel(dict,object.toString());
				}
				else return "";
			}
		}));
		titleMap.put("REC_NO", new ColumnHandlerComponent("收文号",null ));
		titleMap.put("REC_DATE", new ColumnHandlerComponent("收文日期",null ));
		titleMap.put("DICT_REC_COMPANY", new ColumnHandlerComponent("来文单位",null));
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
		titleMap.put("ORG_COMPANY",new ColumnHandlerComponent("签收单位",null));
        titleMap.put("DE_SIGN_UP",new ColumnHandlerComponent("签收人",null));
		
		Page page=super.newPage(request);
		page.setPageNo(1);
		page.setPageSize(ExcelConstant.MAX_EXPORT_PAGE_SIZE);
		Map<String, String> paramMap=this.getParamMap(request);
		this.recFileService.queryRecFileSignPage(page, paramMap, 2);
		String fileName=page.getTotalNum()>ExcelConstant.MAX_EXPORT_PAGE_SIZE?"收文记录(Warn:超出"+ExcelConstant.MAX_EXPORT_PAGE_SIZE+"部分被忽略)"+".xls":"收文记录.xls";
		ExcelWebUtil.flushExcelOutputStream(request, response, "福州市公安局收文签收单", titleMap, page.getDatas(), fileName, "收文记录");
	}
	
	
	@RequestMapping("/queryRecCompanys")
	public void queryRecCompanys(HttpServletRequest request,HttpServletResponse response,String dictRecCompany){
		try {
			List<Map<String,Object>> reList = this.recFileService.queryRecCompanys(dictRecCompany);
			WebUtil.printSuccess(request, response, reList);
		} catch (Exception e) {
			WebUtil.printFail(request, response,"");
		}
		
	}
	
}