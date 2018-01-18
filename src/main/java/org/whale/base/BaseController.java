package org.whale.base;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.WebDataBinder;
import org.whale.system.common.util.WebUtil;
import org.whale.system.dao.Page;

public class BaseController extends org.whale.system.controller.BaseController{
	/**
	 * 查询参数map key名称(前台根据该key回填查询参数值)
	 */
	public static final String PARAM_MAP_KEY = "paramMap";
	
	/**
	 * 更多查询标识
	 */
	public static final String QUERY_MORE_PARAMETER_NAME = "queryMoreFlag";
	
	/**
	 * 更多查询标识 展开
	 */
	public static final String QUERY_MORE_OPEN = "open";
	
	/**
	 * 前端勾选的导出记录PK
	 */
	public static final String EXPORT_IDS_KEY = "EXPORT_IDS";
	
	@Override
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDatePropertyEditor());
	}
	
	@Override
	protected Page newPage(HttpServletRequest request) {
		int pageNo = WebUtil.getInt(request, "pageNo", Integer.valueOf(1))
				.intValue();
		request.getParameter("pageSize");
		int pageSize = WebUtil.getInt(request, "pageSize", Integer.valueOf(20))
				.intValue();
		if (pageSize < 1)
			pageSize = 20;
		if (pageSize > 1000)
			pageSize = 20;
		if (pageNo < 1)
			pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);

		request.setAttribute("page", page);
		return page;
	}




	/**
	 * 根据请求对象获得参数Map
	 * 主要是将Map从Map<String, String[]> 转换成Map<String, String>
	 * 字符串数组的话，则转换成,分割的字符串
	 * @param request
	 * @return Map<String, String> paramMap
	 */
	protected Map<String, String> getParamMap(HttpServletRequest request) {
		// getParameterMap获得的Map的value是数组类型，java官方的本意是防止参数同名，也可以获取到对应的value。实际上一般常用的写法不允许参数同名。
		// 如果遇到同名的参数，那么将获取到的数组，转换成String，用,分割（除非checkbox类的，参数会同名）
		@SuppressWarnings("unchecked")
		Map<String, String[]> paramMap = request.getParameterMap(); 
		Map<String, String> returnParamMap = new HashMap<String, String>();
		if(paramMap != null && paramMap.size() > 0 ){
			Set<String> keySet = paramMap.keySet();
			String url_zh_param_prefix = "url_zh_param_";
			for(String key : keySet){
				String[] values = request.getParameterValues(key);
				if(values != null && values.length > 0) {
					if( key.startsWith(url_zh_param_prefix) ){
						try {
							String paramVal = URLDecoder.decode(request.getParameter(key), "UTF-8");
							returnParamMap.put(key.substring(key.indexOf(url_zh_param_prefix) + url_zh_param_prefix.length()), paramVal);
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}else{
						returnParamMap.put(key, org.apache.commons.lang3.StringUtils.join(values, ","));
					}
				}
			}
		}
		return returnParamMap;
	}

}
