package org.whale.de.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.whale.base.BaseController;
import org.whale.de.domain.Organization;
import org.whale.de.service.OrganizationService;
import org.whale.system.auth.annotation.AuthUri;
import org.whale.system.common.exception.SysException;
import org.whale.system.common.util.LangUtil;
import org.whale.system.common.util.WebUtil;
import org.whale.system.controller.login.UserContext;


@AuthUri
@Controller
@RequestMapping("/de/organization")
public class OrganizationController extends BaseController {

	@Autowired
	private OrganizationService organizationService;
	
	@RequestMapping("/goList")
	public ModelAndView goList(HttpServletRequest request, HttpServletResponse response, Organization organization){
	
	
	 	organizationService.queryOrganizationPage(this.newPage(request),getParamMap(request));
	    
		ModelAndView mav = new ModelAndView("de/organization/organization_list")
						.addObject(PARAM_MAP_KEY, getParamMap(request));
		mav.addObject(QUERY_MORE_PARAMETER_NAME,request.getParameter(QUERY_MORE_PARAMETER_NAME));
		
		return mav;
	}
	
	@RequestMapping("/goSave")
	public ModelAndView goSave(HttpServletRequest request, HttpServletResponse response){
		return new ModelAndView("de/organization/organization_edit");
	}
	
	@RequestMapping("/goUpdate")
	public ModelAndView goUpdate(HttpServletRequest request, HttpServletResponse response, Long id){
		Organization organization = this.organizationService.get(id);
		if(organization == null){
			throw new SysException("查找不到 id="+id);
		}
		
		return new ModelAndView("de/organization/organization_edit")
				.addObject("organization", organization);
	}
	
	@RequestMapping("/goView")
	public ModelAndView goView(HttpServletRequest request, HttpServletResponse response, Long id){
		Organization organization = this.organizationService.get(id);
		if(organization == null){
			throw new SysException("查找不到 id="+id);
		}
		
		return new ModelAndView("de/organization/organization_view")
				.addObject("item", organization);
	}
	
	@RequestMapping("/doSave")
	public void doSave(HttpServletRequest request, HttpServletResponse response, Organization organization){
		UserContext uc = this.getUserContext(request);
		this.organizationService.save(organization);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doUpdate")
	public void doUpdate(HttpServletRequest request, HttpServletResponse response, Organization organization){
		UserContext uc = this.getUserContext(request);
		this.organizationService.update(organization);
		
		WebUtil.printSuccess(request, response);
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response, String ids){
		List<Long> idS = LangUtil.splitIds(ids);
		if(idS == null || idS.size() < 1){
			WebUtil.printFail(request, response, "您要删除的记录，系统中并不存在，ids为：" + ids);
			return ;
		}
		this.organizationService.delete(idS);
		WebUtil.printSuccess(request, response);
	}

}