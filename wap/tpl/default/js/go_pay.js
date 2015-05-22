$(document).ready(function(){
	bind_pay_form();
});



function bind_pay_form()
{
	$(".pay_form").find(".ui-button").bind("click",function(){
		$(".pay_form").submit();
	});
	$(".pay_form").bind("submit",function(){		
		
		if($(this).find("input[name='payment']:checked").length==0)
		{
			$.showErr("请选择支付方式");
			return false;
		}		
		else
		{
 			return true;
		}
		
	});
}

