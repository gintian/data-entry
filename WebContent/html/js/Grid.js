var grid = {};
var Grid = function(a) {
	grid = this;
	this.height = a.height || 0;
	this.winH = a.winH || 0;
	this.bodyBoxDivId = a.bodyBoxDivId || "bodyBoxDiv";
	this.queryFromId = a.queryFromId || "page_form";
	this.gridTableId = a.gridTableId || "gridTable";
	this.panelBarId = a.panelBarId || "panelBarDiv";
	this.userClearFun = a.userClearFun;
	this.userValidate = a.userValidate;
	this.beforePage = a.beforePage;
	this.beforeSearch = a.beforeSearch;
	this.beforeLoadPage = a.beforeLoadPage;
	this.afterLoadPage = a.afterLoadPage;
	this.init()
};
Grid.prototype = {
	init : function() {
		this._doQueryMore($("#queryMoreFlag").val());
		this._cssTable();
		this._fixTable();
		this._pageBar();
		this._panelBar();
		this._titleTh();
		this.validate();
		this._initBindEvent();
		if ($.isFunction(this.afterLoadPage)) {
			this.afterLoadPage(this)
		}
	},
	_cssTable : function() {
		var a = $("#" + this.gridTableId).find("tbody>tr");
		a.hoverClass("hover").each(function() {
			$(this).click(function() {
				a.filter(".selected").removeClass("selected");
				$(this).addClass("selected")
			})
		})
	},
	_fixTable : function() {
		var e = $("#" + this.bodyBoxDivId);
		var f = $("#" + this.gridTableId);
		var b = $("#" + this.panelBarId);
		var g = $("#pageBar");
		var c = e.find("div.query-form");
		var d = e.find("div.pageContent");
		var a = e.find("div.content-list");
		if(this.height > 0){
			a.height(this.height + 23)
			if (!($.browser.msie && $.browser.version == "6.0")) {
				g.css({
					position : "fixed",
					left : 0,
					top : (this.winH - 25),
					"z-index" : 9999
				})
			}
		}else{
			if (parseInt(f.css("width")) - parseInt(f.parent().css("width")) > 0) {
				a.height(parseInt(a.height()) + 23)
			}
			d.height(b.height() + g.height() + a.height());
			e.height(d.height() + c.height());
			if (!($.browser.msie && $.browser.version == "6.0")) {
				g.css({
					position : "fixed",
					left : 0,
					top : ($.clientHeight() - 25),
					"z-index" : 9999
				})
			}
			if (e.height() < $.clientHeight()) {
				e.height($.clientHeight() - 4);
				d.height(e.height() - c.height());
				a.height(d.height() - b.height() - g.height() - 2)
			}
		}
		
	},
	_pageBar : function() {
		$("#pageBar").find("ul>li[name = 'page-li-click']").hoverClass(
				"page_hover")
	},
	_panelBar : function() {
		$("#" + this.panelBarId).find("ul>li[class != 'line']").hoverClass(
				"hover")
	},
	_titleTh : function() {
		var a = $("#" + this.gridTableId);
		a.find("th").each(function(b) {
			if (b > 1) {
				this.title = $.trim($(this).html())
			}
		})
	},
	_initBindEvent : function() {
		$("#jump_page_input").keydown(function(a) {
			if (a.keyCode == 13) {
				grid.goPage($("#jump_page_input").val())
			}
		});
		$("#page_size").change(function() {
			grid.goPage(1)
		});
		$("#page_form input[type='text']").keydown(function(a) {
			if (a.keyCode == 13) {
				grid.search()
			}
		})
	},
	checkAll : function() {
		$("#" + this.gridTableId).find("input[type='checkbox']").each(
				function() {
					this.checked = $("#ck_all").attr("checked")
				})
	},
	clearForm : function() {
		var queryForm = $("#" + this.queryFromId);
		queryForm.find("input[type='text']").val("");
		queryForm.find("select").each(function() {
			if ($.trim(this.options[0].value) == "") {
				$(this).val("")
			}
		});
		var clearButs = queryForm.find("a[class='i-btn-clear']");
		if (clearButs.length > 0) {
			var butName = "";
			clearButs.each(function() {
				butName = $(this).next().attr("id");
				eval("clear_" + butName + "()")
			})
		}
		if ($.isFunction(this.userClearFun)) {
			this.userClearFun()
		}
		queryForm.valid()
	},
	validate : function() {
		if ($.isFunction(this.userValidate)) {
			this.userValidate()
		} else {
			var a = $("#" + this.queryFromId);
			a.validate({});
			a.find("input[type='text']").each(function() {
				if (this.id == null || this.id == "") {
					this.id = this.name
				}
				$("#" + this.id).attr("maxLength", 100);
				$("#" + this.id).rules("add", {
					maxlength : 100,
					validIllegalChar : true
				})
			})
		}
	},
	queryMore : function(a) {
		this._doQueryMore(a);
		this.reload()
	},
	_doQueryMore : function(c) {
		var b = $("#" + this.queryFromId).find("tbody>tr");
		var a = b.length;
		if (a > 3) {
			if (c == "open") {
				$("#queryMoreFlag").val("open");
				b.each(function(d) {
					if (d > 1 && d < (a - 1)) {
						$(this).show();
						$(this).find("td").show()
					}
				});
				$("#open-query-more").hide();
				$("#close-query-more").show()
			} else {
				$("#queryMoreFlag").val("close");
				b.each(function(d) {
					if (d > 1 && d < (a - 1)) {
						$(this).hide();
						$(this).find("td").hide()
					}
				});
				$("#open-query-more").show();
				$("#close-query-more").hide()
			}
		} else {
			$("#open-query-more").hide();
			$("#close-query-more").hide()
		}
	},
	search : function() {
		if ($.isFunction(this.beforeSearch)) {
			this.beforeSearch()
		}
		this.loadPage(1)
	},
	goPage : function(a) {
		if ($.isFunction(this.beforePage)) {
			this.beforePage()
		}
		this.loadPage(a)
	},
	loadPage : function(b) {
		if ($.isFunction(this.beforeLoadPage)) {
			this.beforeLoadPage()
		}
		if (!$("#" + this.queryFromId).valid()) {
			return false
		}
		var d = $("#pageBar");
		if (typeof (b) == "undefined" || Number(b) == "NaN" || b < 1) {
			b = 1
		} else {
			var c = parseInt(d.attr("totalPages"));
			if (b > c) {
				b = c
			}
		}
		var a = $("#page_size").val();
		if (a < 1 || a > 1000) {
			a = 20
		}
		$("#pageNo").val(b);
		$("#pageSize").val(a);
		document.getElementById(this.queryFromId).submit()
	},
	reload : function() {
		this.goPage($("#pageBar").attr("pageNo"))
	},
	getSelectElements : function() {
		var a = [];
		$("#" + this.gridTableId).find("tbody input[type='checkbox']").each(
				function() {
					if (this.checked) {
						a.push(this)
					}
				});
		return a
	},
	getSelectIds : function() {
		var b = this.getSelectElements();
		var c = [];
		for (var a = 0; a < b.length; a++) {
			c.push(b[a].value)
		}
		return c
	},
	getSelectAttrs : function(a) {
		var b = [];
		$("#" + this.gridTableId).find("tbody input[type='checkbox']").each(
				function() {
					if (this.checked) {
						b.push($(this).attr(a))
					}
				});
		return b
	},
	getSelectLineNum : function() {
		var a = [];
		$("#" + this.gridTableId).find("tbody input[type='checkbox']").each(
				function() {
					if (this.checked) {
						a.push($(this).parent().prev().html())
					}
				});
		return a
	}
};