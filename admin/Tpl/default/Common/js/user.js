function account(user_id)
{
	$.weeboxs.open(ROOT+'?m=User&a=account&id='+user_id, {contentType:'ajax',showButton:false,title:LANG['USER_ACCOUNT'],width:600,height:180});
}
function account_detail(user_id)
{
	location.href = ROOT + '?m=User&a=account_detail&id='+user_id;
}

function consignee(user_id)
{
	location.href = ROOT + '?m=User&a=consignee&id='+user_id;
}

function weibo(user_id)
{
	location.href = ROOT + '?m=User&a=weibo&id='+user_id;
}

function send(id){
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要发送消息的会员");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要给选中的会员发送消息吗？"))
		$.weeboxs.open(ROOT+'?m=User&a=send&id='+id, {contentType:'ajax',showButton:false,title:"发消息",width:500,height:200});

}