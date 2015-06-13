function pay(id)
{
	$.weeboxs.open(ROOT+'?m=Deal&a=pay&id='+id, {contentType:'ajax',showButton:false,title:'发放筹款',width:600,height:180});
}

function offline(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要下架的项目");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要下架选中的项目吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=delete&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}

function deal_item(id)
{
	location.href = ROOT + '?m=Deal&a=deal_item&id='+id;
}
function deal_xianhuo(id)
{
	location.href = ROOT + '?m=Deal&a=deal_xianhuo&id='+id;
}
function pay_log(id)
{
	location.href = ROOT + '?m=Deal&a=pay_log&id='+id;
}

function deal_log(id)
{
	location.href = ROOT + '?m=Deal&a=deal_log&id='+id;
}
function add_deal_log(id)
{
	$.weeboxs.open(ROOT+'?m=Deal&a=add_deal_log&id='+id, {contentType:'ajax',showButton:false,title:"更新动态",width:600,height:220});
	
}

function add_deal_item(deal_id)
{
	location.href = ROOT + '?m=Deal&a=add_deal_item&id='+deal_id;
}
function add_deal_xianhuo(deal_id)
{
	location.href = ROOT + '?m=Deal&a=add_deal_xianhuo&id='+deal_id;
}
function deal_item_addshouhuo(deal_id)
{
	location.href = ROOT + '?m=Deal&a=deal_item_addshouhuo&id='+deal_id;
}
function deal_xianhuo_addshouhuo(deal_id)
{
	location.href = ROOT + '?m=Deal&a=deal_xianhuo_addshouhuo&id='+deal_id;
}
function add_investor(){
	location.href = ROOT+'?m=Deal&a=add_investor';
}

function edit_deal_item(item_id)
{
	location.href = ROOT + '?m=Deal&a=edit_deal_item&id='+item_id;
}

function edit_deal_xianhuo(item_id)
{
	location.href = ROOT + '?m=Deal&a=edit_deal_xianhuo&id='+item_id;
}
function edit_deal_item_shouhuo(item_id)
{
	location.href = ROOT + '?m=Deal&a=edit_deal_item_shouhuo&id='+item_id;
}
function edit_deal_xianhuo_shouhuo(item_id)
{
	location.href = ROOT + '?m=Deal&a=edit_deal_xianhuo_shouhuo&id='+item_id;
}
function deal_item_shouhuolist(item_id)
{
	location.href = ROOT + '?m=Deal&a=deal_item_shouhuolist&id='+item_id;
}
function deal_xianhuo_shouhuolist(item_id)
{
	location.href = ROOT + '?m=Deal&a=deal_xianhuo_shouhuolist&id='+item_id;
}
function del_deal_item(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要删除的项目");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要删除选中的项目吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=Deal&"+VAR_ACTION+"=del_deal_item&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}
function del_deal_xianhuo(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要删除的项目");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要删除选中的项目吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=Deal&"+VAR_ACTION+"=del_deal_xianhuo&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}
function zhongjiang(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要设为中奖的支持者");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要设置选中的支持者为中奖吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=DealOrder&"+VAR_ACTION+"=zhongjiang&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}
function weizhongjiang(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要设为未中奖的支持者");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要设置选中的支持者为未中奖吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=DealOrder&"+VAR_ACTION+"=weizhongjiang&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}
function del_deal_item_shouhuo(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要删除的项目");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要删除选中的项目吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=Deal&"+VAR_ACTION+"=del_deal_item_shouhuo&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}

function del_deal_xianhuo_shouhuo(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要删除的项目");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要删除选中的项目吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=Deal&"+VAR_ACTION+"=del_deal_xianhuo_shouhuo&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}
function add_pay_log(deal_id)
{
	$.weeboxs.open(ROOT+'?m=Deal&a=add_pay_log&id='+deal_id, {contentType:'ajax',showButton:false,title:"发放筹款",width:600,height:220});
}

function del_pay_log(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要删除的项目");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要删除选中的项目吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=Deal&"+VAR_ACTION+"=del_pay_log&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}

function del_deal_log(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert("请选择需要删除的项目");
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm("确定要删除选中的项目吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"=Deal&"+VAR_ACTION+"=del_deal_log&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}

