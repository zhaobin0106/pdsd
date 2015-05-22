var code_timeer = null;
var code_lefttime = 0 ;
$(document).ready(function(){
	bind_user_register();
	$("#J_send_sms_verify").bind("click",function(){
			
			send_mobile_verify_sms();
	});
 });
function send_mobile_verify_sms(){
 	
	if(!$.checkMobilePhone($("#settings-mobile").val()))
	{
		$.showErr("手机号码格式错误");	
		return false;
	}
	
	if(!$.maxLength($("#settings-mobile").val(),11,true))
	{
		$.showErr("长度不能超过11位");	
		return false;
	}
	
	
	if($.trim($("#settings-mobile").val()).length == 0)
	{				
		$.showErr("手机号码不能为空");	
		return false;
	}

   	var ajaxurl = APP_ROOT+"/index.php?ctl=ajax&act=check_field";  
	var query = new Object();
		query.field_name = "mobile";
		query.field_data = $.trim($("#settings-mobile").val());
		 
		
			$.ajax({ 
			url: ajaxurl,
			data:query,
			type: "POST",
			dataType: "json",
			success: function(data){
				if(data.status==1)
				{	
					var sajaxurl = APP_ROOT+"/index.php?ctl=ajax&act=send_mobile_verify_code&is_only=1";
					var squery = new Object();
					squery.mobile = $.trim($("#settings-mobile").val());
					$.ajax({ 
						url: sajaxurl,
						data:squery,
						type: "POST",
						dataType: "json",
						success: function(sdata){
								
							if(sdata.status==1)
							{
								code_lefttime = 60;
								code_lefttime_func();
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
				else
				{	
				 	
					$.showErr(data.info);
					return false;
				}
			}
		});	
	}
	function code_lefttime_func(){
		clearTimeout(code_timeer);
		$("#J_send_sms_verify").val(code_lefttime+"秒后重新发送");
		$("#J_send_sms_verify").css({"color":"#f1f1f1"});
		code_lefttime--;
		if(code_lefttime >0){
			code_timeer = setTimeout(code_lefttime_func,1000);
		}
		else{
			code_lefttime = 60;
			$("#J_send_sms_verify").val("发送验证码");
			
			$("#J_send_sms_verify").css({"color":"#fff"});
			$("#J_send_sms_verify").bind("click",function(){
				send_mobile_verify_sms();
			});
		}
		
	}	
