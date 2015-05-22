$(document).ready(function(){
	bind_project();
});

function bind_project()
{
	var href=$(".common-sprite2").parent().attr("href");
	 $("#flag").bind("click",function(){
  	 	 if($(this).attr("checked")=="checked"){
		 	$(".common-sprite2").parent().parent().removeClass("sh_dow");
			$(".common-sprite2").parent().attr("href",href);
		 }else{
		 	$(".common-sprite2").parent().parent().addClass("sh_dow");
			$(".common-sprite2").parent().attr("href","javascript:void(0);");
		 }
	 });
}
