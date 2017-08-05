(function(a) {
	a.fn.extend({
		hoverClass : function(b) {
			var c = b || "hover";
			return this.each(function() {
				a(this).hover(function() {
					a(this).addClass(c)
				}, function() {
					a(this).removeClass(c)
				})
			})
		}
	})
})(jQuery);
String.prototype.trim = function() {
	return this.replace(/(^\s+)|(\s+$)/g, "")
};
var winOpener = null;
var winDialog = null;
var waitObj = null;
(function(a) {
	a.extend({
		clientHeight : function() {
			var b;
			if (window.innerHeight) {
				b = window.innerHeight
			} else {
				if ((document.body) && (document.body.clientHeight)) {
					b = document.body.clientHeight
				}
			}
			if (document.documentElement
					&& document.documentElement.clientHeight) {
				b = document.documentElement.clientHeight
			}
			return b
		},
		clientWidth : function() {
			var b;
			if (window.innerWidth) {
				b = window.innerWidth
			} else {
				if ((document.body) && (document.body.clientWidth)) {
					b = document.body.clientWidth
				}
			}
			if (document.documentElement
					&& document.documentElement.clientWidth) {
				b = document.documentElement.clientWidth
			}
			return b
		},
		openWin : function(f) {
			var h = a.trim(f.url);
			var e = f.title || "窗口";
			var d = f.modal === false ? false : true;
			var c = f.allowClose === false ? false : true;
			if (!window.winOpener) {
				window.winOpener = window.top.winOpener
			}
			window.top.winOpener = window;
			var g = f.height || screen.availHeight * 0.75;
			var b = f.width || screen.availWidth * 0.85;
			winDialog = window.top.$.ligerDialog.open({
				url : h,
				title : e,
				width : b,
				height : g,
				showMax : true,
				isResize : true,
				isHidden : true,
				modal : d,
				name : f.name,
				allowClose : c,
				onClose : f.onClose,
				callback : f.callback
			});
			window.top.winDialog = winDialog;
			return winDialog
		},
		getWinOpener : function() {
			return window.winOpener || window.top.winOpener
		},
		getWindow : function() {
			if (a.getWinOpener()) {
				return a.getWinOpener().winDialog || window.top.winDialog
			} else {
				return window.top.winDialog
			}
		},
		closeWin : function() {
			a.getWindow().hide()
		},
		confirm : function(b) {
			return window.top.$.ligerDialog.confirm(b.info, function(c) {
				if (c) {
					if (a.isFunction(b.ok)) {
						b.ok()
					}
				} else {
					if (a.isFunction(b.cancel)) {
						b.cancel()
					}
				}
			})
		},
		info : function(c, e, b) {
			var d = b || "";
			window.top.manager = window.top.$.ligerDialog.alert(c, d,
					"success", e);
			window.top.mark = true;
			window.top.setTimeout(function() {
				if (window.top.mark && window && window.top
						&& window.top.manager) {
					window.top.manager.close();
					if (a.isFunction(e)) {
						e()
					}
				}
			}, 3000);
			return window.top.manager
		},
		alert : function(c, e, b) {
			var d = b || "";
			return window.top.$.ligerDialog.alert(c, d, "warn", e)
		},
		wait : function(b) {
			var c = b || "正在保存中,请稍候...";
			return window.top.$.ligerDialog.waitting(c)
		},
		resolvChar : function(c) {
			var b = /<.*?>/g;
			if (b.test(c)) {
				return true
			}
			return false
		},
		form_submit : function(submit_form, param) {
			if (param.action) {
				submit_form.action = param.action
			}
			if (param.method) {
				submit_form.method = param.method
			}
			if (param.pageNo) {
				$("input[name=pageNo]", $(submit_form)).val(param.pageNo)
			}
			if (param.pageSize) {
				$("input[name=pageSize]", $(submit_form)).val(param.pageSize)
			}
			submit_form.submit()
		}
	})
})(jQuery);
function showAjaxHtml(a) {
	if (a.wait) {
		$("#infoBoxDiv").html("").css("display", "none");
		waitObj = $.wait()
	} else {
		waitObj.close();
		if (!a.rs) {
			if (typeof (a.msg) == "undefined") {
				a.msg = ""
			}
			$("#infoBoxDiv").html(a.msg).css("display", "block")
		}
	}
}
$(function() {
	if ($.browser.msie) {
		window.setInterval("CollectGarbage();", 10000)
	}
});
function getByteLen(c) {
	var a = 0;
	for (var b = 0; b < c.length; b++) {
		if (c.charCodeAt(b) > 255) {
			a += 2
		} else {
			a++
		}
	}
	return a
}
function banBackSpace(h) {
	var d = h || window.event;
	var g = d.target || d.srcElement;
	var c = g.type || g.getAttribute("type");
	var f = g.getAttribute("readonly");
	var i = g.getAttribute("enabled");
	f = (f == null) ? false : f;
	i = (i == null) ? true : i;
	var b = (d.keyCode == 8
			&& (c == "password" || c == "text" || c == "textarea") && (f == true
			|| f == "readonly" || i != true)) ? true : false;
	var a = (d.keyCode == 8 && c != "password" && c != "text" && c != "textarea") ? true
			: false;
	if (a) {
		return false
	}
	if (b) {
		return false
	}
}
document.onkeypress = banBackSpace;
document.onkeydown = banBackSpace;
function goBack() {
	history.go(-1)
};