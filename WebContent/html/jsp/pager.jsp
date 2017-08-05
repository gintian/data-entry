<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="pagebar" id="pageBar" pageno="${page.pageNo }" totalPages="${page.totalPages }" totalHit="${page.totalNum }" >
	<div class="pages">
		<span>第[&nbsp;<font color="red">${page.pageNo }</font>&nbsp;]页 &nbsp;&nbsp;共[&nbsp;<font color="red">${page.totalNum }</font>&nbsp;]条&nbsp;&nbsp; 共[&nbsp;<font color="red">${page.totalPages }</font>&nbsp;]页&nbsp;&nbsp;&nbsp;&nbsp;每页
		<select id="page_size" style="width:55px;">
			<option value="20" <c:if test="${page.pageSize == 20 }">selected="selected"</c:if>>20</option>
			<option value="50" <c:if test="${page.pageSize == 50 }">selected="selected"</c:if>>50</option>
			<option value="100" <c:if test="${page.pageSize == 100 }">selected="selected"</c:if>>100</option>
			<option value="300" <c:if test="${page.pageSize == 300 }">selected="selected"</c:if>>300</option>
			<option value="500" <c:if test="${page.pageSize == 500 }">selected="selected"</c:if>>500</option>
			<option value="1000" <c:if test="${page.pageSize == 1000 }">selected="selected"</c:if>>1000</option>
		</select>条
		</span>
	</div>
	<div class="pagination">
		<ul>
		<c:if test="${page.pageNo <=1}">
			<li class="disabled j-first" >
				<span class="first" disabled="disabled">
					<span>首页</span>
				</span>
			</li>
		</c:if>
		<c:if test="${page.pageNo >1}">
			<li class="j-first" name="page-li-click">
				<a class="first" onclick="grid.goPage(1); return false;">
					<span>首页</span>
				</a>
			</li>
		</c:if>

		<c:if test="${page.previous}">
			<li class="j-prev" name="page-li-click">
				<a class="previous" onclick="grid.goPage(${page.pageNo -1 }); return false;">
					<span>上一页</span>
				</a>
			</li>
		</c:if>
		<c:if test="${!page.previous}">
			<li class="disabled j-prev">
				<span class="previous" disabled="disabled">
					<span>上一页</span>
				</span>
			</li>
		</c:if>

		<c:if test="${page.next}">
			<li class="j-next" name="page-li-click">
				<a class="next" onclick="grid.goPage(${page.pageNo +1}); return false;">
					<span>下一页</span>
				</a>
			</li>
		</c:if>

		<c:if test="${!page.next}">
			<li class="disabled j-next">
				<span class="next" disabled="disabled">
					<span>下一页</span>
				</span>
			</li>
		</c:if>

		<c:if test="${page.pageNo < page.totalPages}">
			<li class="j-last" name="page-li-click">
				<a class="last" onclick="grid.goPage(${page.totalPages }); return false;">
					<span>末页</span>
				</a>
			</li>
		</c:if>
		<c:if test="${page.pageNo >= page.totalPages}">
			<li class="disabled j-last">
				<span class="last" disabled="disabled">
					<span>末页</span>
				</span>
			</li>
		</c:if>
			<li class="jumpto">
				<input class="textInput" type="text" value="1" id="jump_page_input" style="line-height:13px;" onkeyup="value=value.replace(/[^\d]/g,'')" maxlength="5" />
				<input class="goto" type="button" value="确定" onclick="grid.goPage(document.getElementById('jump_page_input').value); return false;" />
			</li>
		</ul>
	</div>
</div>