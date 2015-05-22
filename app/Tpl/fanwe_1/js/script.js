(function($) { 
	/**
	 * 基于plupload的上传控件
	 */
	$.fn.ui_upload = function(options){
		
		var op = {url:UPLOAD_URL,multi:true,FilesAdded:null,FileUploaded:null,UploadComplete:null,Error:null}; 
		options = $.extend({},op, options);		
		var btn = $(this); 

		var uploader = new plupload.Uploader({
			browse_button : btn[0], 
			url : options.url,
			flash_swf_url : UPLOAD_SWF,
			silverlight_xap_url : UPLOAD_XAP,
			multi_selection:options.multi,
			filters : {
				max_file_size : MAX_IMAGE_SIZE,
				mime_types: [
					{title : "Image files", extensions : ALLOW_IMAGE_EXT}
				]
			}
		});

		uploader.init();
		

		/**
		 * 当文件添加到上传队列后触发
		 * 监听函数参数：(uploader,files)
		 * uploader为当前的plupload实例对象，files为一个数组，里面的元素为本次添加到上传队列里的文件对象
		 */
		uploader.bind('FilesAdded',function(uploader,files){
			if(options.FilesAdded!=null)
			{
				if(options.FilesAdded.call(null,files)!=false)
				{
					uploader.start();
				}
			}
			else
			{
				//添加完直接上传
				uploader.start();
			}	
		});
		
		

		/**
		 * 当队列中的某一个文件上传完成后触发
		 * 监听函数参数：(uploader,file,responseObject)
		 * uploader为当前的plupload实例对象，file为触发此事件的文件对象，responseObject为服务器返回的信息对象，它有以下3个属性：response
		 * responseHeaders：服务器返回的头信息
		 * status：服务器返回的http状态码，比如200
		 * 
		 * 返回到外部的为ajaxobj数据，status为false中止上传
		 */
		uploader.bind('FileUploaded',function(uploader,file,responseObject){
			if(options.FileUploaded!=null)
			{
				var ajaxobj = $.parseJSON(responseObject.response);
				options.FileUploaded.call(null,ajaxobj);
				if(ajaxobj.error!=0)
				{
					uploader.stop();
				}
			}
				
		});
		

		/**
		 * 当上传队列中所有文件都上传完成后触发
		 * 监听函数参数：(uploader,files)
		 * uploader为当前的plupload实例对象，files为一个数组，里面的元素为本次已完成上传的所有文件对象
		 */
		uploader.bind('UploadComplete',function(uploader,files){
			if(options.UploadComplete!=null)
				options.UploadComplete.call(null,files);
		});
		
		
		/**
		 * 当发生触发时触发
		 * 监听函数参数：(uploader,errObject)
		 * uploader为当前的plupload实例对象，errObject为错误对象，它至少包含以下3个属性(因为不同类型的错误，属性可能会不同)：
		 * code：错误代码，具体请参考plupload上定义的表示错误代码的常量属性
		 * file：与该错误相关的文件对象
		 * message：错误信息
		 */
		uploader.bind('Error',function(uploader,errObject){
			if(options.Error!=null)
				options.Error.call(null,errObject);
		});
				
	}
})(jQuery);

var ajax_callback = 0;
$(document).ready(function(){	
	$("#close_user_notify").bind("click",function(){
		$.ajax({ 
			url: APP_ROOT+"/index.php?ctl=ajax&act=close_notify",
			type: "POST",
			success: function(ajaxobj){
				$("#close_user_notify").remove();
			},
			error:function(ajaxobj)
			{
//				if(ajaxobj.responseText!='')
//				alert(ajaxobj.responseText);
			}
		});
	});
	
	if($("#mycenter").length>0)
	{
		$("#user_notify_tip").css("position","absolute");	
		//$("#user_notify_tip").css("top",$("#mycenter").position().top+$("#mycenter").height()+5);
		var px = ($("#user_notify_tip").outerWidth()-$("#mycenter").outerWidth())/2;
		$("#user_notify_tip").css("left",$("#mycenter").position().left-px);
		$("#user_notify_tip").show();
		
	
		var toppx = 0;
		try{
			toppx = parseInt($("#user_notify_tip").css("top").replace("px",""));
		}catch(ex)
		{
			
		}
		$(window).scroll(function(){
			//$("#user_notify_tip").css("top",$(document).scrollTop());
			try{
				toppx = parseInt($("#user_notify_tip").css("top").replace("px",""));
			}catch(ex)
			{
				
			}
			if(toppx<=27)
			{
				$("#user_notify_tip").css("top",27);
			}		
		});	
		//$("#user_notify_tip").css("top",$(document).scrollTop());	
		if(toppx<=27)
		{
			$("#user_notify_tip").css("top",27);
		}	
	}
	
	//加载主导航的焦点取消
	$("a").bind("focus",function(){
		$(this).blur();
	});
	bind_user_loginout();
	init_form_button_style();
	init_common_form_button_style();
	bind_ajax_form();
	
	try{
	bind_drop_panel($("#mymessage"),$("#mymessage_drop").html());
	$("#mymessage_drop").remove();
	bind_drop_panel($("#mycenter"),$("#mycenter_drop").html());
	$("#mycenter_drop").remove();
	}catch(ex){
		
	}
	
	try{
	bind_drop_panel($("#api_login_tip"),$("#api_login_tip_drop").html());
	$("#api_login_tip_drop").remove();
	}catch(ex){
		
	}
	
	
	init_gotop();
	bind_header_search();
	bindKindeditor();	
});



function init_form_button_style()
{

	$("input[name='submit_form']").bind("focus",function(){
		$(this).blur();
	});
}


//用于未来扩展的提示正确错误的JS
$.showErr = function(str,func)
{
	$.weeboxs.open(str, {boxid:'fanwe_error_box',contentType:'text',showButton:true, showCancel:false, showOk:true,title:'提示',width:250,type:'wee',onclose:func});
};

$.showSuccess = function(str,func)
{
	$.weeboxs.open(str, {boxid:'fanwe_success_box',contentType:'text',showButton:true, showCancel:false, showOk:true,title:'成功',width:250,type:'wee',onclose:func});
};
$.showConfirm = function(str,func)
{
	$.weeboxs.open(str, {boxid:'fanwe_confirm_box',contentType:'text',showButton:true, showCancel:true, showOk:true,title:'提示',width:250,type:'wee',onok:func});

};

/*验证*/
$.minLength = function(value, length , isByte) {
	var strLength = $.trim(value).length;
	if(isByte)
		strLength = $.getStringLength(value);
		
	return strLength >= length;
};

$.maxLength = function(value, length , isByte) {
	var strLength = $.trim(value).length;
	if(isByte)
		strLength = $.getStringLength(value);
		
	return strLength <= length;
};
$.getStringLength=function(str)
{
	str = $.trim(str);
	
	if(str=="")
		return 0; 
		
	var length=0; 
	for(var i=0;i <str.length;i++) 
	{ 
		if(str.charCodeAt(i)>255)
			length+=2; 
		else
			length++; 
	}
	
	return length;
};

$.checkMobilePhone = function(value){
	if($.trim(value)!='')
		return /^\d{6,}$/i.test($.trim(value));
	else
		return true;
};
$.checkEmail = function(val){
	var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; 
	return reg.test(val);
};


function close_pop()
{
	$(".dialog-close").click();
}

function bind_user_login()
{
	$("#user_login_form").find("input[name='submit_form']").bind("click",function(){

		do_login_user();
	});
	$("#user_login_form").find("input[name='user_pwd']").bind("keydown",function(e){
		if(e.keyCode==13)
		{
			do_login_user();
		}
	});
	$("#user_login_form").find("input[name='email']").bind("keydown",function(e){
		if(e.keyCode==9||e.keyCode==13)
		{
			$("#user_login_form").find("input[name='user_pwd']").val("");
			$("#user_login_form").find("input[name='user_pwd']").focus();
			return false;
		}
	});
	/*$("#user_login_form").find("input[name='email']").bind("focus",function(){
		if($.trim($(this).val())=="邮箱或者用户名")
		{
			$(this).val("");
		}
	});
	$("#user_login_form").find("input[name='email']").bind("blur",function(){
		if($.trim($(this).val())=="")
		{
			$(this).val("邮箱或者用户名");
		}

	});*/
	$("#user_login_form").bind("submit",function(){
		return false;
	});
}

function bind_user_loginout()
{
	$("#user_login_out").bind("click",function(){
		do_loginout($(this).attr("href"));
		return false;
	});
}

function do_login_user()
{
	
	if($.trim($("#user_login_form").find("input[name='email']").val())=="")
	{
		$.showErr("请输入账户信息",function(){			
			$("#user_login_form").find("input[name='email']").val("");
			$("#user_login_form").find("input[name='email']").focus();
			
		});
		return false;
	}
	if($.trim($("#user_login_form").find("input[name='user_pwd']").val())=="")
	{
		$.showErr("请输入密码",function(){
			
			$("#user_login_form").find("input[name='user_pwd']").val("");
			$("#user_login_form").find("input[name='user_pwd']").focus();
			
		});
		return false;
	}
	var ajaxurl = $("form[name='user_login_form']").attr("action");
	var query = $("form[name='user_login_form']").serialize() ;

	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		data:query,
		type: "POST",
		success: function(ajaxobj){
			if(ajaxobj.status==1)
			{
				//alert(ajaxobj.data);
				var integrate = $("<span id='integrate'>"+ajaxobj.data+"</span>");
				$("body").append(integrate);				
				$("#integrate").remove();
				close_pop();
				location.href = ajaxobj.jump;
				
			}
			else
			{
				$.showErr(ajaxobj.info);							
			}
		},
		error:function(ajaxobj)
		{
//			if(ajaxobj.responseText!='')
//			alert(ajaxobj.responseText);
		}
	});
}

function do_loginout(ajaxurl)
{	
	var query = new Object();
	query.ajax = 1;
	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		data:query,
		type: "POST",
		success: function(ajaxobj){
			if(ajaxobj.status==1)
			{
				//alert(ajaxobj.data);
				var integrate = $("<span id='integrate'>"+ajaxobj.data+"</span>");
				$("body").append(integrate);				
				$("#integrate").remove();
				location.href = ajaxobj.jump;
				
			}
			else
			{
				location.href = ajaxobj.jump;							
			}
		},
		error:function(ajaxobj)
		{
//			if(ajaxobj.responseText!='')
//			alert(ajaxobj.responseText);
		}
	});
}

function bind_drop_panel(o,html)
{
	var timer;
	var drop_o = $(html);
	$(drop_o).hide();
	$(drop_o).css("position","absolute");	
	$(drop_o).css("z-index",99999);	
	$(drop_o).css("top",$(o).position().top+$(o).height()+5);
	$("body").append(drop_o);
	
	$(o).hover(function(){
		var x = ($(drop_o).outerWidth()-$(o).outerWidth())/2;
		$(drop_o).css("left",$(o).position().left-x);
		$(this).addClass("hover");
		$(".drop_box").slideUp(300);
		clearTimeout(timer);
		$(drop_o).stop().slideDown(300);
	},function(){		
		 timer = setTimeout(function(){
			 $(drop_o).slideUp(300);
			 $(o).removeClass("hover");
	      },500);		
	});
	$(drop_o).hover(function(){		
	// 	$(".drop_box").slideUp(300);
		clearTimeout(timer);
		$(drop_o).slideDown(300);
	},function(){		
		timer = setTimeout(function(){
	 		$(drop_o).slideUp(300);
	 		$(o).removeClass("hover");
      	},500);		
	});
}

function del_weibo(o)
{
	$(o).parent().remove();
}

function add_weibo()
{
	var ajaxurl = APP_ROOT+"/index.php?ctl=user&act=add_weibo";
	$.ajax({ 
		url: ajaxurl,
		type: "POST",
		success: function(html){
			$("#weibo_list").append(html);
		},
		error:function(ajaxobj)
		{
//			if(ajaxobj.responseText!='')
//			alert(ajaxobj.responseText);
		}
	});
}


function init_common_form_button_style()
{

}

function bind_ajax_form()
{
	
	$(".ajax_form").find(".ui-button").bind("click",function(){
 		$(".ajax_form").submit();
	});
	$(".ajax_form").bind("submit",function(){
		
		var ajaxurl = $(this).attr("action");
		var query = $(this).serialize() ;
		$.ajax({ 
			url: ajaxurl,
			dataType: "json",
			data:query,
			type: "POST",
			success: function(ajaxobj){
				if(ajaxobj.status==1)
				{
					if(ajaxobj.info!="")
					{
						$.showSuccess(ajaxobj.info,function(){
							if(ajaxobj.jump!="")
							{
								location.href = ajaxobj.jump;
							}
						});	
					}
					else
					{
						if(ajaxobj.jump!="")
						{
							location.href = ajaxobj.jump;
						}
					}
				}
				else
				{
					if(ajaxobj.info!="")
					{
						$.showErr(ajaxobj.info,function(){
							if(ajaxobj.jump!="")
							{
								location.href = ajaxobj.jump;
							}
						});	
					}
					else
					{
						if(ajaxobj.jump!="")
						{
							location.href = ajaxobj.jump;
						}
					}							
				}
			},
			error:function(ajaxobj)
			{
				if(ajaxobj.responseText!='')
				alert(ajaxobj.responseText);
			}
		});
		return false;
	});
}

function bind_ajax_form_custom(str)
{
	$(str).find(".ui-button").bind("click",function(){
		$(str).submit();
	});
	$(str).bind("submit",function(){
		var ajaxurl = $(this).attr("action");
		var query = $(this).serialize() ;
		$.ajax({ 
			url: ajaxurl,
			dataType: "json",
			data:query,
			type: "POST",
			success: function(ajaxobj){
				if(ajaxobj.status==1)
				{
					if(ajaxobj.info!="")
					{
						$.showSuccess(ajaxobj.info,function(){
							if(ajaxobj.jump!="")
							{
								location.href = ajaxobj.jump;
							}
						});	
					}
					else
					{
						if(ajaxobj.jump!="")
						{
							location.href = ajaxobj.jump;
						}
					}
				}
				else
				{
					if(ajaxobj.info!="")
					{
						$.showErr(ajaxobj.info,function(){
							if(ajaxobj.jump!="")
							{
								location.href = ajaxobj.jump;
							}
						});	
					}
					else
					{
						if(ajaxobj.jump!="")
						{
							location.href = ajaxobj.jump;
						}
					}							
				}
			},
			error:function(ajaxobj)
			{
				if(ajaxobj.responseText!='')
				alert(ajaxobj.responseText);
			}
		});
		return false;
	});
}

function init_gotop()
{
	
	$(window).scroll(function(){
		
		var s_top = $(document).scrollTop()+$(window).height()-70;
		if($.browser.msie && $.browser.version =="6.0")
		{
			$("#gotop").css("top",s_top);
			if($(document).scrollTop()>0)
			{				
				$("#gotop").css("visibility","visible");	
			}
			else
			{
				$("#gotop").css("visibility","hidden");	
			}
		}	
		else
		{
			if($(document).scrollTop()>0)
			{
				if($("#gotop").css("display")=="none")
				$("#gotop").fadeIn();	
			}
			else
			{
				if($("#gotop").css("display")!="none")
				$("#gotop").fadeOut();
			}
		}
		
		
	});		
	
	$("#gotop").bind("click",function(){		
		$("html,body").animate({scrollTop:0},"fast","swing",function(){});		
	});
	var top = $(document).scrollTop()+$(window).height()-70;
	if($.browser.msie && $.browser.version =="6.0")
	{
		$("#gotop").css("top",top);
		if($(document).scrollTop()>0)
		{	
			$("#gotop").css("visibility","visible");
		}
		else
		{
			$("#gotop").css("visibility","hidden");
		}
	}
	else
	{
		if($(document).scrollTop()>0)
		{	
			if($("#gotop").css("display")=="none")
			$("#gotop").show();	
		}
		else
		{
			if($("#gotop").css("display")!="none")
			$("#gotop").hide();
		}
	}
	

}


function bind_header_search()
{
	$("#header_submit").bind("click",function(){
		var kw = $("#header_keyword").val();
		if($.trim(kw)==""||$.trim(kw)=="搜索项目")
		{
			$("#header_keyword").val("");
			$("#header_keyword").focus();
		}
		else
		{
			$("#header_search_form").submit();
		}
	});
	$("#header_search_form").bind("submit",function(){
		var kw = $("#header_keyword").val();
		if($.trim(kw)==""||$.trim(kw)=="搜索项目")
		{
			$("#header_keyword").val("");
			$("#header_keyword").focus();
			return false;
		}
		else
		{
			return true;
		}
	});
	$("#header_keyword").bind("blur",function(){
		var kw = $("#header_keyword").val();
		if($.trim(kw)=="")
		{
			$("#header_keyword").val("搜索项目");
		}
	});
	$("#header_keyword").bind("focus",function(){
		var kw = $("#header_keyword").val();
		if($.trim(kw)=="搜索项目")
		{
			$("#header_keyword").val("");
		}
	});
}

function show_pop_login()
{
	$.weeboxs.open(APP_ROOT+"/index.php?ctl=ajax&act=login", {boxid:'pop_user_login',contentType:'ajax',showButton:false, showCancel:false, showOk:false,title:'会员登录',width:1060,type:'wee'});

}

function send_message(user_id)
{
	var ajaxurl = APP_ROOT+"/index.php?ctl=ajax&act=usermessage&id="+user_id;

	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		type: "POST",
		success: function(ajaxobj){
			if(ajaxobj.status==1)
			{
				$.weeboxs.open(ajaxobj.html, {boxid:'send_message',contentType:'text',showButton:false, showCancel:false, showOk:false,title:'发送私信',width:500,type:'wee'});				
				$("#user_message_form").find("textarea[name='message']").focus();
				bind_usermessage_form();
			}
			else if(ajaxobj.status==2)
			{
				show_pop_login();
			}
			else
			{
				$.showErr(ajaxobj.info);							
			}
		},
		error:function(ajaxobj)
		{
//			if(ajaxobj.responseText!='')
//			alert(ajaxobj.responseText);
		}
	});
}

//格式化金额
function foramtmoney(price, len)   
{  
   len = len > 0 && len <= 20 ? len : 2;   
   price = parseFloat((price + "").replace(/[^\d\.-]/g, "")).toFixed(len) + "";   
   var l = price.split(".")[0].split("").reverse(),   
   r = price.split(".")[1];   
   t = "";   
   for(i = 0; i < l.length; i ++ )   
   {   
      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");   
   }   
   var re = t.split("").reverse().join("") + "." + r;
   return re.replace("-,","-");
} 

function bind_usermessage_form()
{
	

		$("#user_message_form").find(".ui-button").bind("click",function(){
			$("#user_message_form").submit();
		});
		$("#user_message_form").bind("submit",function(){
			if($.trim($("#user_message_form").find("textarea[name='message']").val())=="")
			{
				$("#user_message_form").find("textarea[name='message']").focus();
				return false;
			}
			var ajaxurl = $(this).attr("action");
			var query = $(this).serialize() ;
			$.ajax({ 
				url: ajaxurl,
				dataType: "json",
				data:query,
				type: "POST",
				success: function(ajaxobj){
					close_pop();
					if(ajaxobj.status==1)
					{
						if(ajaxobj.info!="")
						{
							$.showSuccess(ajaxobj.info,function(){
								if(ajaxobj.jump!="")
								{
									location.href = ajaxobj.jump;
								}
							});	
						}
						else
						{
							if(ajaxobj.jump!="")
							{
								location.href = ajaxobj.jump;
							}
						}
					}
					else
					{
						if(ajaxobj.info!="")
						{
							$.showErr(ajaxobj.info,function(){
								if(ajaxobj.jump!="")
								{
									location.href = ajaxobj.jump;
								}
							});	
						}
						else
						{
							if(ajaxobj.jump!="")
							{
								location.href = ajaxobj.jump;
							}
						}							
					}
				},
				error:function(ajaxobj)
				{
					if(ajaxobj.responseText!='')
					alert(ajaxobj.responseText);
				}
			});
			return false;
		});
	
}
//页面自适应满屏显示
var resetTimeact=null;
function resetWindowBox(){
	clearTimeout(resetTimeact);
	var main_height=$(window).height() - $("#J_footer").outerHeight() - $("#J_head").outerHeight();
	var box_height=$("#J_wrap").outerHeight();
	if($("#J_wrap").outerHeight() + $("#J_footer").outerHeight() + $("#J_head").outerHeight() < $(window).height())
	{	
		$("#J_wrap").css("height",main_height+"px");
	}
	resetTimeact = setTimeout(resetWindowBox,100);
}
$(document).ready(function(){
	// 项目分类
	funSelect("#industry_id_select","#industry_id_cur",'#industry_id_select option:selected');
	// 项目所属阶段
	funSelect("#phase_id_select","#phase_id_cur",'#phase_id_select option:selected');
	// 项目所属阶段
	funSelect("#year_select","#year_cur",'#year_select option:selected');
	funSelect("#month_select","#month_cur",'#month_select option:selected');
	// 企业所在城市
	funSelect("#cityid-1_select","#cityid-1_cur",'#cityid-1_select option:selected');
	funSelect("#cityid-2_select","#cityid-2_cur",'#cityid-2_select option:selected');
	// 公司是否已经成立
	funSelect("#found_company_select","#found_company_cur",'#found_company_select option:selected');
	// 是否还有其他项目
	funSelect("#has_otherpro_select","#has_otherpro_cur",'#has_otherpro_select option:selected');
});
//自定义select下拉菜单
function funSelect(mainSelect,curSelect,optionSelect){  //mainSelect:最外层  curSelect:选中后在span显示  optionSelect:当前选中的option
	$(document).ready(function(){
	$(curSelect).html(
		$(optionSelect).html()
	);
	});
	$(mainSelect).bind("change",
		function(){
			$(curSelect).html($(optionSelect).html());
		}
	);
}

//自定义select下拉菜单点击添加删除class
$(function selectClick(){
	$(".btn_select").bind({
		mouseover:function(){
			$(".btn_select").removeClass("cur");
			$(this).addClass("cur");
		},
  		click:function(e){
  			e.stopPropagation(); 
			$(".btn_select").removeClass("cur");
			$(this).addClass("cur");
  		},
  		mouseout:function(){
  			$(".btn_select").removeClass("cur");
  		}
	});
	$(document).click(function(){
		$(".btn_select").removeClass("cur");
	});
});

$(function(){
	//筛选
	$(".ui_check").click(function(){
		if($(this).find("input").attr("type")=="radio"){
			var rel=$(this).attr("rel");
			$(".ui_check[rel='"+rel+"']").removeClass("ui_checked");
			$(".ui_check[rel='"+rel+"'] input").attr("checked",false);
			$(this).addClass("ui_checked");
			$(this).find("input").attr("checked","checked");
		}
		else{
			if($(this).hasClass("ui_checked")){
				$(this).removeClass("ui_checked");
				$(this).find("input").attr("checked",false);
			}
			else{
				$(this).addClass("ui_checked");
				$(this).find("input").attr("checked","checked");
			}
		}
	});

	// 阶段数字转化
    $(".daxie").each(function(){
        if($(this).html() == 1){
            $(this).html("一");
        }
        if($(this).html() == 2){
            $(this).html("二");
        }
        if($(this).html() == 3){
            $(this).html("三");
        }
        if($(this).html() == 4){
            $(this).html("四");
        }
        if($(this).html() == 5){
            $(this).html("五");
        }
        if($(this).html() == 6){
            $(this).html("六");
        }
        if($(this).html() == 7){
            $(this).html("七");
        }
        if($(this).html() == 8){
            $(this).html("八");
        }
        if($(this).html() == 9){
            $(this).html("九");
        }
        if($(this).html() == 10){
            $(this).html("十");
        }
    });

   button_hover(".ui-button");
   button_hover(".ui_button");
   button_hover(".ui-small-button");
   button_hover(".ui-center-button");
});

// ui-button 鼠标悬浮替换颜色
function button_hover(hoverObj){
 	$(hoverObj).live('mouseover mouseout', function(){
		if($(this).hasClass("theme_bgcolor")){
			$(this).toggleClass("theme_bgcolor1");
		}
		if($(this).hasClass("bg_red")){
			$(this).toggleClass("bg_red1");
		}
		if($(this).hasClass("bg_gray")){
			$(this).toggleClass("bg_gray1");
		}
		if($(this).hasClass("bg_green")){
			$(this).toggleClass("bg_green1");
		}
	});
}
   
function bindKindeditor(){
	if ($("textarea.ketext").length >  0) {
		var K = KindEditor;
	}
	if ($("textarea.ketext").length > 0) {
		var editor = K.create('textarea.ketext', {
			allowFileManager: false,
			emoticonsPath: APP_ROOT + "/public/emoticons/",
			minWidth:400,
			afterBlur: function(){
				this.sync();
			}, //兼容jq的提交，失去焦点时同步表单值
			height: 300,
 			items : [
				'source','fsource', 'fullscreen', 'undo', 'redo', 'print', 'cut', 'copy', 'paste',
				 'justifyleft', 'justifycenter', 'justifyright',
				  'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
				'superscript', 'selectall','/',
				'title', 'fontname', 'fontsize', 'forecolor', 'hilitecolor', 'bold',
				'italic', 'underline', 'strikethrough', 'removeformat', 'image',
				'flash', 'media', 'table', 'hr', 'emoticons', 'link', 'unlink'
			]
		});
	}  
	
	bindKeUpload();
	
}


function bindKeUpload(){
	 if($(".keimg").length > 0) {
	 	if(K == undefined)
			var K = KindEditor;
	}
	if ($(".keimg").length > 0) {
		var ieditor = K.editor({
	       allowFileManager : false,
	       imageSizeLimit:MAX_FILE_SIZE               
	    });
		K('.keimg').unbind("click");
		K('.keimg').click(function(){
			var node = K(this);
			var dom = $(node).parent().parent().parent().parent();
			ieditor.loadPlugin('image', function(){
				ieditor.plugin.imageDialog({
					// imageUrl : K("#keimg_h_"+$(this).attr("rel")).val(),
					imageUrl: dom.find("#keimg_h_" + node.attr("rel")).val(),
					clickFn: function(url, title, width, height, border, align){
						dom.find("#keimg_a_" + node.attr("rel")).attr("href", url), dom.find("#keimg_m_" + node.attr("rel")).attr("src", url), dom.find("#keimg_h_" + node.attr("rel")).val(url), dom.find(".keimg_d[rel='" + node.attr("rel") + "']").show(), ieditor.hideDialog();
					}
				});
			});
		});
		
		/**
		 * 删除单图
		 */
		K('.keimg_d').unbind("click");
	    K('.keimg_d').click(function() {
	        var node = K(this);
			K(this).hide();
	        var dom =$(node).parent().parent().parent().parent();
	        dom.find("#keimg_a_"+node.attr("rel")).attr("href","");
	        dom.find("#keimg_m_"+node.attr("rel")).attr("src",ROOT_PATH + "/admin/Tpl/default/Common/images/no_pic.gif");
	        dom.find("#keimg_h_"+node.attr("rel")).val("");
	    });
	}
}

// 输入框提示文字显隐
function show_tip(){
	var $textbox = $(".textbox");
	$(".holder_tip").live('click',function(){
		$(this).hide();
		$(this).parent().find(".textbox").focus();
	});
	
	$textbox.live('focus',function(){
		$(this).parent().find(".holder_tip").hide();
	});
	$textbox.live('blur',function(){
		if($(this).val()==""){
			$(this).parent().find(".holder_tip").show();
		}
		else{
			$(this).parent().find(".holder_tip").hide();
		}
	});
	$textbox.each(function(){
		if($(this).val()==""){
			$(this).parent().find(".holder_tip").show();
		}
		else{
			$(this).parent().find(".holder_tip").hide();
		}
	});
}
function send_mobile_verify_sms_custom(type,mobile,verify_name){
			var sajaxurl = APP_ROOT+"/index.php?ctl=ajax&act=send_change_mobile_verify_code";
 			var squery = new Object();
 			if(type!=2){
				if($.trim(mobile).length == 0)
				{			
		 			$.showErr("手机号码不能为空");
					return false;
				}
		 		if(!$.checkMobilePhone(mobile))
				{
		 			$.showErr("手机号码格式错误");
					return false;
				}
 				if(!$.maxLength(mobile,11,true))
				{
					$.showErr("长度不能超过11位");
					return false;
				}
				squery.mobile = $.trim(mobile);
			}
 			squery.step =type;
			$.ajax({ 
				url: sajaxurl,
				data:squery,
				type: "POST",
				dataType: "json",
				success: function(sdata){
					if(sdata.status==1)
					{
 						code_lefttime = 60;
						code_lefttime_func_custom(type,mobile,verify_name,'mobile');
						$.showSuccess(sdata.info);
						return false;
					}
					else
					{
 	 					$.showErr(sdata.info);
						return false;
					}
				}
			});	
			
		}
	function send_email_verify(type,email,verify_name){
			var sajaxurl = APP_ROOT+"/index.php?ctl=ajax&act=send_email_verify_code";
 			var squery = new Object();
 			if(type!=2){
				if($.trim(email).length == 0)
				{			
		 			$.showErr("邮箱不能为空");
					return false;
				}
		 		if(!$.checkEmail(email))
				{
		 			$.showErr("邮箱格式错误");
					return false;
				}
 				 
				squery.email = $.trim(email);
			}
 			squery.step =type;
			$.ajax({ 
				url: sajaxurl,
				data:squery,
				type: "POST",
				dataType: "json",
				success: function(sdata){
					if(sdata.status==1)
					{
 						code_lefttime = 60;
						code_lefttime_func_custom(type,email,verify_name,'email');
						$.showSuccess(sdata.info);
						return false;
					}
					else
					{
 	 					$.showErr(sdata.info);
						return false;
					}
				}
			});	
			
		}
	function code_lefttime_func_custom(type,mobile,verify_name,fun_name){
  		clearTimeout(code_timeer);
		$(verify_name).val(code_lefttime+"秒后重新发送");
		$(verify_name).css({"color":"#f1f1f1"});
		code_lefttime--;
		if(code_lefttime >0){
 			code_timeer = setTimeout(function(){code_lefttime_func_custom(type,mobile,verify_name);},1000);
		}
		else{
			code_lefttime = 60;
			$(verify_name).val("发送验证码");
 			$(verify_name).css({"color":"#fff"});
			$(verify_name).bind("click",function(){
				if(fun_name=='mobile'){
					send_mobile_verify_sms_custom(type,mobile,verify_name);
				}else{
					if(fun_name=='email'){
						send_email_verify(type,mobile,verify_name);
					}
					
				}
				
			});
		}
		
	}