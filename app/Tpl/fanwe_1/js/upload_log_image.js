
function upd_file(obj,file_id,uploading,image_upd,image,img)
{	

	$("input[name='"+file_id+"']").bind("change",function(){	
		$(obj).hide();
		$(obj).parent().find("."+uploading+"").removeClass("hide");
		$(obj).parent().find("."+uploading+"").removeClass("show");
		$(obj).parent().find("."+uploading+"").addClass("show");
		  $.ajaxFileUpload
		   (
			   {
				    url:APP_ROOT+'/xinupload_item.php?key='+file_id,
				    type:'GET',
				    secureuri:false,
				    fileElementId:file_id,
				    dataType: 'json',
				    success: function (data, status)
				    {
				   		$(obj).show();
				   		$(obj).parent().find("."+uploading+"").removeClass("hide");
						$(obj).parent().find("."+uploading+"").removeClass("show");
						$(obj).parent().find("."+uploading+"").addClass("hide");
				   		if(data.status==1)
				   		{
				   			$("."+image_upd+"").find("."+img+"").attr("src",data.url);
				   			$("."+image_upd+"").find("input[name='"+image+"']").val(data.url);
				   			$("."+image_upd+"").show();				 
				   		}
				   		else
				   		{
				   			$.showErr(data.msg);
				   		}
				   		
				    },
				    error: function (data, status, e)
				    {
						$.showErr(data.responseText);;
				    	$(obj).show();
				    	$(obj).parent().find("."+uploading+"").removeClass("hide");
						$(obj).parent().find("."+uploading+"").removeClass("show");
						$(obj).parent().find("."+uploading+"").addClass("hide");
				    }
			   }
		   );
		  $("input[name='"+file_id+"']").unbind("change");
	});	
}