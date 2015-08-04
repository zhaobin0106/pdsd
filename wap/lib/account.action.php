<?php
require APP_ROOT_PATH.'wap/app/page.php';
class accountModule{
	 function __construct() {
        if(!$GLOBALS['user_info'])
		app_redirect(url_wap("user#login"));
		$GLOBALS['tmpl']->assign('now',NOW_TIME);
     }
	
	public function index()
	{	
		 
		$GLOBALS['tmpl']->assign("page_title","支持的项目");
		$page_size = intval($GLOBALS['m_config']['page_size']);;
		$page = intval($_REQUEST['p']);
		if($page==0)
		$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
		
		$order_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal_order where user_id = ".intval($GLOBALS['user_info']['id'])." and type=0  order by create_time desc limit ".$limit);
		foreach($order_list as $k=>$v){
			if($v['repay_make_time']==0&&$v['repay_time']>0){
				$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
				$repay_make_date=$v['repay_time']+$left_date*24*3600;
				if($repay_make_date<=get_gmtime()){
 					$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set repay_make_time =  ".get_gmtime()." where id = ".$v['id'] );
					$order_list[$k]['repay_make_time']=get_gmtime();
				}
			}
		}
		$order_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal_order where user_id = ".intval($GLOBALS['user_info']['id'])." and type=0 ");
		
		$page = new Page($order_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		$deal_ids=array();
		foreach($order_list as $k=>$v){
			$deal_ids[] =  $v['deal_id'];
		}
		if($deal_ids!=null){
			$deal_list_array=$GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal where  is_effect = 1 and is_delete = 0 and id in (".implode(',',$deal_ids).")  and type=0 ");
			$deal_list=array();
			foreach($deal_list_array as $k=>$v){
				if($v['id']){
					$deal_list[$v['id']]=$v;
				}
			}
			foreach($order_list as $k=>$v)
			{
	 			$order_list[$k]['deal_info'] =$deal_list[$v['deal_id']];
			}
			 
			$GLOBALS['tmpl']->assign('order_list',$order_list);
		}
 		
		$GLOBALS['tmpl']->display("account_index.html");
	}
	
	public function xianhuo()
	{
			
		$GLOBALS['tmpl']->assign("page_title","购买的商品");
		$page_size = intval($GLOBALS['m_config']['page_size']);;
		$page = intval($_REQUEST['p']);
		if($page==0)
			$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
	
		$order_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal_xianhuo_order where user_id = ".intval($GLOBALS['user_info']['id'])." and type=0  order by create_time desc limit ".$limit);
		foreach($order_list as $k=>$v){
			if($v['repay_make_time']==0&&$v['repay_time']>0){
				$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
				$repay_make_date=$v['repay_time']+$left_date*24*3600;
				if($repay_make_date<=get_gmtime()){
					$GLOBALS['db']->query("update ".DB_PREFIX."deal_xianhuo_order set repay_make_time =  ".get_gmtime()." where id = ".$v['id'] );
					$order_list[$k]['repay_make_time']=get_gmtime();
				}
			}
		}
		$order_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal_xianhuo_order where user_id = ".intval($GLOBALS['user_info']['id'])." and type=0 ");
	
		$page = new Page($order_count,$page_size);   //初始化分页对象
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		$deal_ids=array();
		foreach($order_list as $k=>$v){
			$deal_ids[] =  $v['deal_id'];
		}
		if($deal_ids!=null){
			$deal_list_array=$GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal where  is_effect = 1 and is_delete = 0 and id in (".implode(',',$deal_ids).")  and type=0 ");
			$deal_list=array();
			foreach($deal_list_array as $k=>$v){
				if($v['id']){
					$deal_list[$v['id']]=$v;
				}
			}
			foreach($order_list as $k=>$v)
			{
				$order_list[$k]['deal_info'] =$deal_list[$v['deal_id']];
			}
	
			$GLOBALS['tmpl']->assign('order_list',$order_list);
		}
			
		$GLOBALS['tmpl']->display("account_xianhuo.html");
	}
	
	
	public function shichi()
	{
			
		$GLOBALS['tmpl']->assign("page_title","报名的活动");
		$page_size = intval($GLOBALS['m_config']['page_size']);;
		$page = intval($_REQUEST['p']);
		if($page==0)
			$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
	
		$order_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."fore_item_order where user_id = ".intval($GLOBALS['user_info']['id'])." and type=0  order by create_time desc limit ".$limit);
		foreach($order_list as $k=>$v){
			if($v['repay_make_time']==0&&$v['repay_time']>0){
				$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
				$repay_make_date=$v['repay_time']+$left_date*24*3600;
				if($repay_make_date<=get_gmtime()){
					$GLOBALS['db']->query("update ".DB_PREFIX."fore_item_order set repay_make_time =  ".get_gmtime()." where id = ".$v['id'] );
					$order_list[$k]['repay_make_time']=get_gmtime();
				}
			}
		}
		$order_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."fore_item_order where user_id = ".intval($GLOBALS['user_info']['id'])." and type=0 ");
	
		$page = new Page($order_count,$page_size);   //初始化分页对象
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		$deal_ids=array();
		foreach($order_list as $k=>$v){
			$deal_ids[] =  $v['fore_id'];
		}
		if($deal_ids!=null){
			$deal_list_array=$GLOBALS['db']->getAll("select * from ".DB_PREFIX."fore where  is_effect = 1 and is_delete = 0 and id in (".implode(',',$deal_ids).")  and type=0 ");
			$deal_list=array();
			foreach($deal_list_array as $k=>$v){
				if($v['id']){
					$deal_list[$v['id']]=$v;
				}
			}
			foreach($order_list as $k=>$v)
			{
				$order_list[$k]['deal_info'] =$deal_list[$v['fore_id']];
			}
	
			$GLOBALS['tmpl']->assign('order_list',$order_list);
		}
			
		$GLOBALS['tmpl']->display("account_shichi.html");
	}
	public function view_order()
	{
		$id = intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id']));
		if(!$order_info)
		{
			showErr("无效的项目支持",0,get_gopreview_wap());
		}
		
		//========如果超过系统设置的时间，则自动设置收到回报 start
		if($order_info['repay_make_time']==0 && $order_info['repay_time'] > 0){
			$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
			$repay_make_date=$order_info['repay_time']+$left_date*24*3600;
			if($repay_make_date>get_gmtime()&&$order_info['repay_time']>0){
				$order_info['repay_make_date']=date('Y-m-d H:i:s',$repay_make_date);
			}else{
				
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set repay_make_time =  ".get_gmtime()." where id = ".$id);
				$order_info['repay_make_time']=get_gmtime();
			}
		}
		//=============如果超过系统设置的时间，则自动设置收到回报 end
		$GLOBALS['tmpl']->assign("order_info",$order_info);
		$deal_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal where id = ".$order_info['deal_id']." and is_delete = 0 and is_effect = 1");
		$GLOBALS['tmpl']->assign("deal_info",$deal_info);
		
		if($order_info['order_status'] == 0)
		{
			$payment_list = get_payment_list("wap");
			
			$GLOBALS['tmpl']->assign("payment_list",$payment_list);
			
			$max_pay = $order_info['total_price'] - $order_info['credit_pay'];
			$GLOBALS['tmpl']->assign("max_pay",$max_pay);
			$GLOBALS['tmpl']->assign("page_title","订单支付");
		}else{
			$GLOBALS['tmpl']->assign("page_title","订单详情");
		}
		
		
		$GLOBALS['tmpl']->display("account_view_order.html");
	}
	

	public function view_shichi_order()
	{
		$id = intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."fore_item_order where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id']));
		if(!$order_info)
		{
			showErr("无效的报名",0,get_gopreview_wap());
		}
	
		//========如果超过系统设置的时间，则自动设置收到回报 start
		if($order_info['repay_make_time']==0 && $order_info['repay_time'] > 0){
			$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
			$repay_make_date=$order_info['repay_time']+$left_date*24*3600;
			if($repay_make_date>get_gmtime()&&$order_info['repay_time']>0){
				$order_info['repay_make_date']=date('Y-m-d H:i:s',$repay_make_date);
			}else{
	
				$GLOBALS['db']->query("update ".DB_PREFIX."fore_item_order set repay_make_time =  ".get_gmtime()." where id = ".$id);
				$order_info['repay_make_time']=get_gmtime();
			}
		}
		//=============如果超过系统设置的时间，则自动设置收到回报 end
		$GLOBALS['tmpl']->assign("order_info",$order_info);
		$deal_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."fore where id = ".$order_info['fore_id']." and is_delete = 0 and is_effect = 1");
		$GLOBALS['tmpl']->assign("deal_info",$deal_info);
	
		if($order_info['order_status'] == 0)
		{
			$payment_list = get_payment_list("wap");
				
			$GLOBALS['tmpl']->assign("payment_list",$payment_list);
				
			$max_pay = $order_info['total_price'] - $order_info['credit_pay'];
			$GLOBALS['tmpl']->assign("max_pay",$max_pay);
			$GLOBALS['tmpl']->assign("page_title","订单支付");
		}else{
			$GLOBALS['tmpl']->assign("page_title","订单详情");
		}
	
	
		$GLOBALS['tmpl']->display("account_view_shichi_order.html");
	}
	public function view_xianhuo_order()
	{
		$id = intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_xianhuo_order where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id']));
		if(!$order_info)
		{
			showErr("无效的项目支持",0,get_gopreview_wap());
		}
	
		//========如果超过系统设置的时间，则自动设置收到回报 start
		if($order_info['repay_make_time']==0 && $order_info['repay_time'] > 0){
			$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
			$repay_make_date=$order_info['repay_time']+$left_date*24*3600;
			if($repay_make_date>get_gmtime()&&$order_info['repay_time']>0){
				$order_info['repay_make_date']=date('Y-m-d H:i:s',$repay_make_date);
			}else{
	
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_xianhuo_order set repay_make_time =  ".get_gmtime()." where id = ".$id);
				$order_info['repay_make_time']=get_gmtime();
			}
		}
		//=============如果超过系统设置的时间，则自动设置收到回报 end
		$GLOBALS['tmpl']->assign("order_info",$order_info);
		$deal_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal where id = ".$order_info['deal_id']." and is_delete = 0 and is_effect = 1");
		$GLOBALS['tmpl']->assign("deal_info",$deal_info);
	
		if($order_info['order_status'] == 0)
		{
			$payment_list = get_payment_list("wap");
				
			$GLOBALS['tmpl']->assign("payment_list",$payment_list);
				
			$max_pay = $order_info['total_price'] - $order_info['credit_pay'];
			$GLOBALS['tmpl']->assign("max_pay",$max_pay);
			$GLOBALS['tmpl']->assign("page_title","订单支付");
		}else{
			$GLOBALS['tmpl']->assign("page_title","订单详情");
		}
	
	
		$GLOBALS['tmpl']->display("account_view_xianhuo_order.html");
	}
	public function del_order()
	{
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
			showErr("",$ajax,url_wap("user#login"));
		}
		$order_id = intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where order_status = 0 and user_id = ".intval($GLOBALS['user_info']['id'])." and id = ".$order_id);
		if(!$order_info)
		{
			showErr("无效的订单",$ajax,"");
		}
		else
		{
			$money = $order_info['credit_pay'];
			$GLOBALS['db']->query("delete from ".DB_PREFIX."deal_order where id = ".$order_id." and user_id = ".intval($GLOBALS['user_info']['id'])." and order_status = 0");
			if($GLOBALS['db']->affected_rows()>0)
			{
				if($money>0)
				{
					require_once APP_ROOT_PATH."system/libs/user.php";
					modify_account(array("money"=>$money),intval($GLOBALS['user_info']['id']),"删除".$order_info['deal_name']."项目支付，退回支付款。");						
				}
			}
			showSuccess("",$ajax,get_gopreview());
		}
	}
	
	public function del_shichi_order()
	{
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
			showErr("",$ajax,url_wap("user#login"));
		}
		$order_id = intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."fore_item_order where order_status = 0 and user_id = ".intval($GLOBALS['user_info']['id'])." and id = ".$order_id);
		if(!$order_info)
		{
			showErr("无效的订单",$ajax,"");
		}
		else
		{
			$money = $order_info['credit_pay'];
			$GLOBALS['db']->query("delete from ".DB_PREFIX."fore_item_order where id = ".$order_id." and user_id = ".intval($GLOBALS['user_info']['id'])." and order_status = 0");
			if($GLOBALS['db']->affected_rows()>0)
			{
				if($money>0)
				{
					require_once APP_ROOT_PATH."system/libs/user.php";
					modify_account(array("money"=>$money),intval($GLOBALS['user_info']['id']),"删除".$order_info['deal_name']."项目支付，退回支付款。");
				}
			}
			showSuccess("",$ajax,get_gopreview());
		}
	}

	public function del_xianhuo_order()
	{
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
			showErr("",$ajax,url("user#login"));
		}
		$order_id = intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_xianhuo_order where order_status = 0 and user_id = ".intval($GLOBALS['user_info']['id'])." and id = ".$order_id);
		if(!$order_info)
		{
			showErr("无效的订单",$ajax,"");
		}
		else
		{
			$money = $order_info['credit_pay'];
			$GLOBALS['db']->query("delete from ".DB_PREFIX."deal_xianhuo_order where id = ".$order_id." and user_id = ".intval($GLOBALS['user_info']['id'])." and order_status = 0");
			if($GLOBALS['db']->affected_rows()>0)
			{
				if($money>0)
				{
					require_once APP_ROOT_PATH."system/libs/user.php";
					modify_account(array("money"=>$money),intval($GLOBALS['user_info']['id']),"删除".$order_info['deal_name']."商品支付，退回支付款。");
				}
			}
			showSuccess("",$ajax,get_gopreview());
		}
	}
	public function go_order_pay(){
		$id = intval($_REQUEST['order_id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id'])." and order_status = 0");
		if(!$order_info)
		{
			showErr("项目支持已支付",0,get_gopreview_wap());
		}
		else
		{
			$credit = doubleval($_REQUEST['credit']);
			$payment_id = intval($_REQUEST['payment']);
			
			if($credit>0)
			{				
				$max_pay = $order_info['total_price'] - $order_info['credit_pay'];
				$max_credit= $max_pay<$GLOBALS['user_info']['money']?$max_pay:$GLOBALS['user_info']['money'];
				$credit = $credit>$max_credit?$max_credit:$credit;		
				if($credit>0)
				{	
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set credit_pay = credit_pay + ".$credit." where id = ".$order_info['id']);//追加使用余额支付
				
				require_once APP_ROOT_PATH."system/libs/user.php";
				modify_account(array("money"=>"-".$credit),intval($GLOBALS['user_info']['id']),"支持".$order_info['deal_name']."项目支付");		
				}		
			}
			$result = pay_order($order_info['id']);

			if($result['status']==0)
			{
				$money = $result['money'];
				$payment_notice['create_time'] = NOW_TIME;
				$payment_notice['user_id'] = intval($GLOBALS['user_info']['id']);
				$payment_notice['payment_id'] = $payment_id;
				$payment_notice['money'] = $money;
				$payment_notice['bank_id'] = strim($_REQUEST['bank_id']);
				$payment_notice['order_id'] = $order_info['id'];
				$payment_notice['memo'] = $order_info['support_memo'];
				$payment_notice['deal_id'] = $order_info['deal_id'];
				$payment_notice['deal_item_id'] = $order_info['deal_item_id'];
				$payment_notice['deal_name'] = $order_info['deal_name'];
				
				do{
					$payment_notice['notice_sn'] = to_date(NOW_TIME,"YmdHis").rand(100,999);
					$GLOBALS['db']->autoExecute(DB_PREFIX."payment_notice",$payment_notice,"INSERT","","SILENT");
					$notice_id = $GLOBALS['db']->insert_id();
				}while($notice_id==0);
				
		
				app_redirect(url_wap("account#jump",array("id"=>$notice_id)));
			}
			else
			{
				app_redirect(url_wap("account#view_order",array("id"=>$order_info['id'])));  
			}
		}
	}
	public function go_shichi_order_pay(){
		$id = intval($_REQUEST['order_id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."fore_item_order where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id'])." and order_status = 0");
		if(!$order_info)
		{
	showErr("试吃报名已支付",0,get_gopreview_wap());
	}
	else
	{
		$credit = doubleval($_REQUEST['credit']);
		$payment_id = intval($_REQUEST['payment']);
			
		if($credit>0)
		{
			$max_pay = $order_info['total_price'] - $order_info['credit_pay'];
			$max_credit= $max_pay<$GLOBALS['user_info']['money']?$max_pay:$GLOBALS['user_info']['money'];
			$credit = $credit>$max_credit?$max_credit:$credit;
			if($credit>0)
			{
				$GLOBALS['db']->query("update ".DB_PREFIX."fore_item_order set credit_pay = credit_pay + ".$credit." where id = ".$order_info['id']);//追加使用余额支付
	
				require_once APP_ROOT_PATH."system/libs/user.php";
				modify_account(array("money"=>"-".$credit),intval($GLOBALS['user_info']['id']),"报名".$order_info['deal_name']."项目支付");
			}
		}
		$result = pay_fore_order($order_info['id']);
	
		if($result['status']==0)
		{
			$money = $result['money'];
			$payment_notice['create_time'] = NOW_TIME;
			$payment_notice['user_id'] = intval($GLOBALS['user_info']['id']);
			$payment_notice['payment_id'] = $payment_id;
			$payment_notice['money'] = $money;
			$payment_notice['bank_id'] = strim($_REQUEST['bank_id']);
			$payment_notice['order_id'] = $order_info['id'];
			$payment_notice['memo'] = $order_info['support_memo'];
			$payment_notice['fore_id'] = $order_info['fore_id'];
			$payment_notice['fore_item_id'] = $order_info['fore_item_id'];
			$payment_notice['deal_name'] = $order_info['deal_name'];
	
			do{
				$payment_notice['notice_sn'] = to_date(NOW_TIME,"YmdHis").rand(100,999);
				$GLOBALS['db']->autoExecute(DB_PREFIX."payment_notice",$payment_notice,"INSERT","","SILENT");
				$notice_id = $GLOBALS['db']->insert_id();
			}while($notice_id==0);
	
	
			app_redirect(url_wap("account#jump",array("id"=>$notice_id)));
		}
		else
		{
			app_redirect(url_wap("account#view_shichi_order",array("id"=>$order_info['id'])));
		}
	}
	}
	
	public function go_xianhuo_order_pay(){
		$id = intval($_REQUEST['order_id']);
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_xianhuo_order where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id'])." and order_status = 0");
		if(!$order_info)
		{
			showErr("商品购买已支付",0,get_gopreview_wap());
		}
		else
		{
			$credit = doubleval($_REQUEST['credit']);
			$payment_id = intval($_REQUEST['payment']);
				
			if($credit>0)
			{
				$max_pay = $order_info['total_price'] - $order_info['credit_pay'];
				$max_credit= $max_pay<$GLOBALS['user_info']['money']?$max_pay:$GLOBALS['user_info']['money'];
				$credit = $credit>$max_credit?$max_credit:$credit;
				if($credit>0)
				{
					$GLOBALS['db']->query("update ".DB_PREFIX."deal_xianhuo_order set credit_pay = credit_pay + ".$credit." where id = ".$order_info['id']);//追加使用余额支付
	
					require_once APP_ROOT_PATH."system/libs/user.php";
					modify_account(array("money"=>"-".$credit),intval($GLOBALS['user_info']['id']),"购买".$order_info['deal_name']."商品支付");
				}
			}
			$result = pay_xianhuo_order($order_info['id']);
	
			if($result['status']==0)
			{
				$money = $result['money'];
				$payment_notice['create_time'] = NOW_TIME;
				$payment_notice['user_id'] = intval($GLOBALS['user_info']['id']);
				$payment_notice['payment_id'] = $payment_id;
				$payment_notice['money'] = $money;
				$payment_notice['bank_id'] = strim($_REQUEST['bank_id']);
				$payment_notice['order_id'] = $order_info['id'];
				$payment_notice['memo'] = $order_info['support_memo'];
				$payment_notice['deal_id'] = $order_info['deal_id'];
				$payment_notice['deal_xianhuo_id'] = $order_info['deal_xianhuo_id'];
				$payment_notice['deal_name'] = $order_info['deal_name'];
	
				do{
					$payment_notice['notice_sn'] = to_date(NOW_TIME,"YmdHis").rand(100,999);
					$GLOBALS['db']->autoExecute(DB_PREFIX."payment_notice",$payment_notice,"INSERT","","SILENT");
					$notice_id = $GLOBALS['db']->insert_id();
				}while($notice_id==0);
	
				
				app_redirect(url_wap("account#jump",array("id"=>$notice_id)));
			}
			else
			{
				app_redirect(url_wap("account#view_xianhuo_order",array("id"=>$order_info['id'])));
			}
		}
	}
	
	public function bujiao()
	{
		if(!$GLOBALS['user_info']){
		app_redirect(url_wap("user#login"));
		}	
					$id=intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("SELECT * FROM ".DB_PREFIX."deal_order WHERE user_id = ".intval($GLOBALS['user_info']['id'])." and id =".$id);
		$GLOBALS['tmpl']->assign("order_info",$order_info);
	
		$GLOBALS['tmpl']->display("account_bujiao.html");
	}
	
	public function do_bujiao()
	{
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
		app_redirect(url_wap("user#login"));	
		}
		$money = doubleval($_REQUEST['money']);
		if($money<=0)
		{
			showErr("充值的金额不正确",$ajax,"");
		}
		$deal_id=intval($_REQUEST['deal_id']);
		$deal_list_array=$GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal where  is_effect = 1 and type=0 and is_delete = 0 and id =".$deal_id);
		if(!$deal_list_array)
		{
			showErr('该项目已不存在',$ajax,"");
		}
		$order_id=intval($_REQUEST['order_id']);
		$order_info = $GLOBALS['db']->getRow("SELECT * FROM ".DB_PREFIX."deal_order WHERE user_id = ".intval($GLOBALS['user_info']['id'])." and id =".$order_id);
		if(!$order_info)
		{
			showErr('该订单已不存在',$ajax,"");
		}
		if($GLOBALS['user_info']['money'] < $money)
		{
			showErr('余额不足，请先充值',$ajax,"");
		}else {
			$GLOBALS ['db']->query ( "update " . DB_PREFIX . "deal_order set total_price =  total_price + " . $money . ",credit_pay = credit_pay + " . $money . ",kuaidi_price = kuaidi_price + " . $money . "  where id = " . $order_id );
			$GLOBALS ['db']->query ( "update " . DB_PREFIX . "deal set pay_amount = pay_amount + " . $money . ",delivery_fee_amount = delivery_fee_amount + " . $money . " where id = " . $deal_id . " and is_effect = 1 and is_delete = 0" );
			require_once APP_ROOT_PATH . "system/libs/user.php";
			$re = modify_account ( array (
					"money" => "-" . $money 
			), intval ( $GLOBALS ['user_info'] ['id'] ), "补交" . $order_info ['deal_name'] . "项目快递费用" );
		}
		showSuccess("",$ajax,url_wap('account'));
	}
	public function sbujiao()
	{
		if(!$GLOBALS['user_info'])
			app_redirect(url("user#login"));
		$id=intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("SELECT * FROM ".DB_PREFIX."deal_xianhuo_order WHERE user_id = ".intval($GLOBALS['user_info']['id'])." and id =".$id);
		$GLOBALS['tmpl']->assign("order_info",$order_info);
		 
		$GLOBALS['tmpl']->display("account_sbujiao.html");
	}
	public function scbujiao()
	{
		if(!$GLOBALS['user_info'])
			app_redirect(url("user#login"));
		$id=intval($_REQUEST['id']);
		$order_info = $GLOBALS['db']->getRow("SELECT * FROM ".DB_PREFIX."fore_item_order WHERE user_id = ".intval($GLOBALS['user_info']['id'])." and id =".$id);
		$GLOBALS['tmpl']->assign("order_info",$order_info);
			
		$GLOBALS['tmpl']->display("account_scbujiao.html");
	}
	public function do_sbujiao()
	{
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
			showErr("",$ajax,url_wap("user#login"));
		}
		$money = doubleval($_REQUEST['money']);
		if($money<=0)
		{
			showErr("充值的金额不正确",$ajax,"");
		}
		$order_id=intval($_REQUEST['order_id']);
		$order_info = $GLOBALS['db']->getRow("SELECT * FROM ".DB_PREFIX."deal_xianhuo_order WHERE user_id = ".intval($GLOBALS['user_info']['id'])." and id =".$order_id);
		if(!$order_info)
		{
			showErr('该订单已不存在',$ajax,"");
		}
		if($GLOBALS['user_info']['money'] < $money)
		{
			showErr('余额不足，请先充值',$ajax,"");
		}else {
			$GLOBALS['db']->query("update ".DB_PREFIX."deal_xianhuo_order set total_price =  total_price + ".$money.",credit_pay = credit_pay + ".$money.",kuaidi_jiage = kuaidi_jiage + ".$money."  where id = ".$order_id);
			require_once APP_ROOT_PATH."system/libs/user.php";
			$re=modify_account(array("money"=>"-".$money),intval($GLOBALS['user_info']['id']),"补交".$order_info['deal_name']."商品快递费用");
				
		}
		showSuccess("",$ajax,url_wap('account#xianhuo'));
	}
	
	public function do_scbujiao()
	{
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
			app_redirect(url_wap("user#login"));
		}
		$money = doubleval($_REQUEST['money']);
		if($money<=0)
		{
			showErr("充值的金额不正确",$ajax,"");
		}
		$deal_id=intval($_REQUEST['deal_id']);
		$deal_list_array=$GLOBALS['db']->getRow("select * from ".DB_PREFIX."fore where  is_effect = 1 and type=0 and is_delete = 0 and id =".$deal_id);
		if(!$deal_list_array)
		{
			showErr('该项目已不存在',$ajax,"");
		}
		$order_id=intval($_REQUEST['order_id']);
		$order_info = $GLOBALS['db']->getRow("SELECT * FROM ".DB_PREFIX."fore_item_order WHERE user_id = ".intval($GLOBALS['user_info']['id'])." and id =".$order_id);
		if(!$order_info)
		{
			showErr('该订单已不存在',$ajax,"");
		}
		if($GLOBALS['user_info']['money'] < $money)
		{
			showErr('余额不足，请先充值',$ajax,"");
		}else {
			$GLOBALS['db']->query("update ".DB_PREFIX."fore_item_order set total_price =  total_price + ".$money.",credit_pay = credit_pay + ".$money.",kuaidi_jiage = kuaidi_jiage + ".$money."  where id = ".$order_id);
			$GLOBALS['db']->query("update ".DB_PREFIX."deal set pay_amount = pay_amount + ".$money.",delivery_fee_amount = delivery_fee_amount + ".$money." where id = ".$deal_id." and is_effect = 1 and is_delete = 0");
			require_once APP_ROOT_PATH."system/libs/user.php";
			$re=modify_account(array("money"=>"-".$money),intval($GLOBALS['user_info']['id']),"补交".$order_info['deal_name']."项目快递费用");
	
		}
		showSuccess("",$ajax,url_wap('account#shichi'));
	}
	public function project()
	{
 		$GLOBALS['tmpl']->assign("page_title","我的项目");
		if(!$GLOBALS['user_info'])
		app_redirect(url_wap("user#login"));	

		$page_size = intval($GLOBALS['m_config']['page_size']);;
		$page = intval($_REQUEST['p']);
		if($page==0)
		$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
		
		$deal_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal where user_id = ".intval($GLOBALS['user_info']['id'])." and is_delete = 0 order by create_time desc limit ".$limit);
		$deal_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal where user_id = ".intval($GLOBALS['user_info']['id'])." and is_delete = 0");
		
		$page = new Page($deal_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		$GLOBALS['tmpl']->assign('deal_list',$deal_list);
		
		$GLOBALS['tmpl']->display("account_project.html");
	}
	public function eat()
	{
		$GLOBALS['tmpl']->assign("page_title","我的试吃");
		if(!$GLOBALS['user_info'])
			app_redirect(url_wap("user#login"));
	
		$page_size = intval($GLOBALS['m_config']['page_size']);;
		$page = intval($_REQUEST['p']);
		if($page==0)
			$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
	
		$deal_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."fore where user_id = ".intval($GLOBALS['user_info']['id'])." and is_delete = 0 order by create_time desc limit ".$limit);
		$deal_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."fore where user_id = ".intval($GLOBALS['user_info']['id'])." and is_delete = 0");
	
		$page = new Page($deal_count,$page_size);   //初始化分页对象
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		$GLOBALS['tmpl']->assign('deal_list',$deal_list);
	
		$GLOBALS['tmpl']->display("account_eat.html");
	}
	public function focus()
	{
 		$GLOBALS['tmpl']->assign("page_title","关注的项目");
		if(!$GLOBALS['user_info'])
		app_redirect(url_wap("user#login"));		
		
		$page_size = intval($GLOBALS['m_config']['page_size']);;
		$page = intval($_REQUEST['p']);
		if($page==0)
		$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
		
		$s = intval($_REQUEST['s']);
		if($s==3)
		$sort_field = " d.support_amount desc ";
		if($s==1)
		$sort_field = " d.support_count desc ";
		if($s==2)
		$sort_field = " d.support_amount - d.limit_price desc ";
		if($s==0)
		$sort_field = " d.end_time asc ";
		
		$GLOBALS['tmpl']->assign("s",$s);
		
		$f = intval($_REQUEST['f']);
		if($f==0)
		$cond = " 1=1 ";
		if($f==1)
		$cond = " d.begin_time < ".NOW_TIME." and (d.end_time = 0 or d.end_time > ".NOW_TIME.") ";
		if($f==2)
		$cond = " d.end_time <> 0 and d.end_time < ".NOW_TIME." and d.is_success = 1 "; //过期成功
		if($f==3)
		$cond = " d.end_time <> 0 and d.end_time < ".NOW_TIME." and d.is_success = 0 "; //过期失败
		$GLOBALS['tmpl']->assign("f",$f);
		
		
		
		$app_sql = " ".DB_PREFIX."deal_focus_log as dfl left join ".DB_PREFIX."deal as d on d.id = dfl.deal_id where dfl.user_id = ".intval($GLOBALS['user_info']['id']).
				   " and d.is_effect = 1 and d.is_delete = 0 and ".$cond." ";

		$deal_list = $GLOBALS['db']->getAll("select d.*,dfl.id as fid from ".$app_sql." order by ".$sort_field." limit ".$limit);
		$deal_count = $GLOBALS['db']->getOne("select count(*) from ".$app_sql);
		
		foreach($deal_list as $k=>$v)
		{
			$deal_list[$k]['remain_days'] = ceil(($v['end_time'] - NOW_TIME)/(24*3600));
			$deal_list[$k]['percent'] = round($v['support_amount']/$v['limit_price']*100);
		}
		
		$page = new Page($deal_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);

		$GLOBALS['tmpl']->assign('deal_list',$deal_list);
		
		$GLOBALS['tmpl']->display("account_focus.html");
	}
	public function del_focus()
	{
		if(!$GLOBALS['user_info'])
		app_redirect(url("user#login"));
		
		$id = intval($_REQUEST['id']);
		$deal_id = $GLOBALS['db']->getOne("select deal_id from ".DB_PREFIX."deal_focus_log where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id']));
		$GLOBALS['db']->query("delete from ".DB_PREFIX."deal_focus_log where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id']));
		$GLOBALS['db']->query("update ".DB_PREFIX."deal set focus_count = focus_count - 1 where id = ".intval($deal_id));
		$GLOBALS['db']->query("delete from ".DB_PREFIX."user_deal_notify where user_id = ".intval($GLOBALS['user_info']['id'])." and deal_id = ".$deal_id);
							
		app_redirect(get_gopreview_wap());
	}
	public function credit(){
		$GLOBALS['tmpl']->assign("page_title","收支明细");
		if(!$GLOBALS['user_info'])
		app_redirect(url_wap("user#login"));
		
		$page_size = intval($GLOBALS['m_config']['page_size']);
		$page = intval($_REQUEST['p']);
		if($page==0)
		$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
		
		$log_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."user_log where user_id = ".intval($GLOBALS['user_info']['id'])." order by log_time desc limit ".$limit);
 		$log_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."user_log where user_id = ".intval($GLOBALS['user_info']['id']));
  		$page = new Page($log_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		foreach($log_list as $k=>$v){
			$log_list[$k]['money']=doubleval($log_list[$k]['money']);
			if($log_list[$k]['money']>0){
				$log_list[$k]['money_type']="增加";
			}else{
				$log_list[$k]['money_type']="减少";
			}
		}
		$GLOBALS['tmpl']->assign('log_list',$log_list);
		 
 		$GLOBALS['tmpl']->display("account_credit.html");
	}
	public function record(){
		if(!$GLOBALS['user_info'])
			app_redirect(url_wap("user#login"));
		$GLOBALS['tmpl']->assign("page_title","充值管理");
		$page_size = intval($GLOBALS['m_config']['page_size']);
		$page = intval($_REQUEST['p']);
		if($page==0)
			$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
 		
		$record_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."payment_notice where user_id = ".intval($GLOBALS['user_info']['id'])." and order_id=0 AND deal_id=0 AND deal_item_id=0 AND deal_name='' order by create_time desc limit ".$limit);
		foreach($record_list as $k=>$v){
			if($v['is_paid']==0){
				$record_list[$k]['pay_url']=url_wap("account#record_pay",array("notice_id"=>$v['id']));
			}
		}
		$record_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."payment_notice where user_id = ".intval($GLOBALS['user_info']['id'])." and order_id=0 AND deal_id=0 AND deal_item_id=0 AND deal_name=''");
		$page = new Page($record_count,$page_size);   //初始化分页对象
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		/*
		foreach($record_list as $k=>$v)
		{
			$record_list[$k]['deal_info'] = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal where id = ".$v['deal_id']." and is_effect = 1 and is_delete = 0");
		}
		*/
		$GLOBALS['tmpl']->assign('record_list',$record_list);
		$GLOBALS['tmpl']->display("account_record.html");
 	}
 	public function record_pay(){
 		$id=intval($_REQUEST['notice_id']);
 		$payment_info=$GLOBALS['db']->getRow("select * from ".DB_PREFIX."payment_notice where id=".$id);
 		$payment_list=get_payment_list("wap");
  		$GLOBALS['tmpl']->assign("page_title","充值");
  		$GLOBALS['tmpl']->assign('payment_info',$payment_info);
  		$GLOBALS['tmpl']->assign('payment_list',$payment_list);
  		$GLOBALS['tmpl']->display("account_record_pay.html");
  	}
  	public function record_go_pay(){
  		$return=array('status'=>1,'info'=>'','jump'=>'');
 		$id=intval($_REQUEST['notice_id']);
 		$payment_id=intval($_REQUEST['payment_id']);
 		
 		$GLOBALS['db']->query("update ".DB_PREFIX."payment_notice set payment_id=$payment_id where id=$id ");
 		$return['jump']=url_wap("account#jump",array('id'=>$id));
 		
 		ajax_return($return);
  	}
 	public function incharge(){
 		$GLOBALS['tmpl']->display("account_incharge.html");
 	}
 	public function do_incharge()
	{		
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
			showErr("",$ajax,url_wap("user#login"));
		}
		$money = doubleval($_REQUEST['money']);
		if($money<=0)
		{
			showErr("充值的金额不正确",$ajax,"");
		}
		
		showSuccess("",$ajax,url_wap("account#pay",array("money"=>round($money*100))));
	}
 	public function pay(){
		$money = doubleval(intval($_REQUEST['money'])/100);
		if($money<=0)
		{
			app_redirect(url_wap("account#incharge"));
		}
		
		$GLOBALS['tmpl']->assign("money",$money);
		$payment_list = get_payment_list("wap");
		$GLOBALS['tmpl']->assign("payment_list",$payment_list);
		$GLOBALS['tmpl']->display("account_pay.html");
	}
	public function go_pay()
	{
		$ajax = intval($_REQUEST['ajax']);
 		$payment_id = intval($_REQUEST['payment']);
		if($payment_id==0)
		{
			app_redirect(url_wap("account#pay"));
		}
		
		$money = doubleval($_REQUEST['money']);
		if($money<=0)
		{
			app_redirect(url_wap("account#pay"));
		}
		
		$payment_notice['create_time'] = NOW_TIME;
		$payment_notice['user_id'] = intval($GLOBALS['user_info']['id']);
		$payment_notice['payment_id'] = $payment_id;
		$payment_notice['money'] = $money;
		$payment_notice['bank_id'] = strim($_REQUEST['bank_id']);
		
		do{
			$payment_notice['notice_sn'] = to_date(NOW_TIME,"YmdHis").rand(100,999);
			$GLOBALS['db']->autoExecute(DB_PREFIX."payment_notice",$payment_notice,"INSERT","","SILENT");
			$notice_id = $GLOBALS['db']->insert_id();
		}while($notice_id==0);
 		app_redirect(url_wap("account#jump",array("id"=>$notice_id,"from"=>strim($_REQUEST['from']))));	

	}
	public function jump()
	{
 		$notice_id = intval($_REQUEST['id']);
		$notice_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."payment_notice where id = ".$notice_id." and is_paid = 0 and user_id = ".intval($GLOBALS['user_info']['id']));
		if(!$notice_info)
		{
				$data['pay_status'] = 1;
				$data['pay_info'] = '订单生成失败.';
				$data['show_pay_btn'] = 0;
 				$GLOBALS['tmpl']->assign('data',$data);
 				$GLOBALS['tmpl']->display('pay_order_index.html');
		}else{
			$payment_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."payment where id = ".$notice_info['payment_id']);
			if(!$payment_info){
				$data['pay_status'] = 1;
				$data['pay_info'] = '支付方式不存在.';
				$data['show_pay_btn'] = 0;
 				$GLOBALS['tmpl']->assign('data',$data);
 				$GLOBALS['tmpl']->display('pay_order_index.html');
			}
			$class_name = $payment_info['class_name']."_payment";
			require_once APP_ROOT_PATH."system/payment/".$class_name.".php";
			$o = new $class_name;
			
			//header("Content-Type:text/html; charset=utf-8");
			$pay= $o->get_payment_code($notice_id);
			
			app_redirect($pay['notify_url']);
		}
		
	}
	//提现列表
	public function refund_list(){
		$page_size =intval($GLOBALS['m_config']['page_size']);
		$page = intval($_REQUEST['p']);
		if($page==0)$page = 1;		
		$limit = (($page-1)*$page_size).",".$page_size	;
		$refund_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."user_refund where user_id = ".intval($GLOBALS['user_info']['id'])." order by create_time desc limit ".$limit);
		$refund_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."user_refund where user_id = ".intval($GLOBALS['user_info']['id']));
	
 		$GLOBALS['tmpl']->assign("refund_list",$refund_list);
 		$page = new Page($refund_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		$GLOBALS['tmpl']->display("account_refund_list.html");
	}
	//提现申请
 	public function refund(){
 		$GLOBALS['tmpl']->assign("user_info",$GLOBALS['user_info']);
		
 		$GLOBALS['tmpl']->display("account_refund.html");
 	}
 	
 	public function submitrefund(){
  		$ajax = intval($_REQUEST['ajax']);
 		
		if(!$GLOBALS['user_info'])
		{
			showErr("",$ajax,url_wap("user#login"));
		}
		
		$money = doubleval($_REQUEST['money']);
		$memo = strim($_REQUEST['memo']);
		
		if($money<=0)
		{
			showErr("提现金额出错",$ajax);
		}
		
		$ready_refund_money =doubleval($GLOBALS['db']->getOne("select sum(money) from ".DB_PREFIX."user_refund where user_id = ".intval($GLOBALS['user_info']['id'])." and is_pay = 0"));
		if($ready_refund_money + $money > $GLOBALS['user_info']['money'])
		{
			showErr("提现超出限制",$ajax);
		}
		
		$refund_data['money'] = $money;
		$refund_data['user_id'] = $GLOBALS['user_info']['id'];
		$refund_data['create_time'] = NOW_TIME;
		$refund_data['memo'] = $memo;
		$GLOBALS['db']->autoExecute(DB_PREFIX."user_refund",$refund_data);
		
		showSuccess("提交成功",$ajax,get_gopreview_wap());
 	}
 	public function delrefund()
	{
		$ajax = intval($_REQUEST['ajax']);
		if(!$GLOBALS['user_info'])
		{
			showErr("",$ajax,url_wap("user#login"));
		}
		
		$id = intval($_REQUEST['id']);
		$GLOBALS['db']->query("delete from ".DB_PREFIX."user_refund where id = ".$id." and user_id = ".intval($GLOBALS['user_info']['id']));
		if($GLOBALS['db']->affected_rows()>0)
		{
			showSuccess("删除成功",$ajax);
		}
		else
		{
			showErr("删除失败",$ajax);
		}
		
	}
	
	public function mortgate_pay()
  	{
  		if(!$GLOBALS['user_info'])
			app_redirect(url("user#login"));
  		$GLOBALS['tmpl']->assign("page_title","充值诚意金");
  	 
  		$new_money=user_need_mortgate();
  		$has_money=$GLOBALS['db']->getOne("select mortgage_money from ".DB_PREFIX."user where id=".$GLOBALS['user_info']['id']);
   		$money = $new_money-$has_money;
   		if($money<=0)
  		{
  			//app_redirect(url("account#mortgate_incharge"));
  			showSuccess("您的诚意金已支付，无需再支付！");
  		}
  		 
  		$GLOBALS['tmpl']->assign("money",$money);
  		$payment_list = get_payment_list("wap");
		$GLOBALS['tmpl']->assign("payment_list",$payment_list);
  		$GLOBALS['tmpl']->display("account_mortgate_pay.html");
  	}
 	public function mine_investor_status(){
  		if(!$GLOBALS['user_info'])
		app_redirect(url_wap("user#login"));
		
  		$user_id=$GLOBALS['user_info']['id'];
  		$type=intval($_REQUEST['type']);
    	$page_size = ACCOUNT_PAGE_SIZE;
		$page = intval($_REQUEST['p']);
		if($page==0)
			$page = 1;
		$limit = (($page-1)*$page_size).",".$page_size;
   		$investor_list=$GLOBALS['db']->getAll("select invest.*,d.end_time,d.pay_end_time,d.begin_time,d.name as deal_name ,d.image as deal_image,d.id as deal_id" .
   				" from  ".DB_PREFIX."investment_list as invest left join ".DB_PREFIX."deal as d on d.id=invest.deal_id where  invest.type=$type and invest.user_id=$user_id order by invest.id desc limit $limit ");
    	$investor_list_num=$GLOBALS['db']->getOne("select count(*) from  ".DB_PREFIX."investment_list where  type=$type and user_id=$user_id  ");
  		$now_time=NOW_TIME;
 		if($type==0||$type==2||$type==1){
   			foreach($investor_list as $k=>$v){
   				if($type==1){
   					if($now_time>$v['end_time']){
						$investor_list[$k]['status']=2;
						$GLOBALS['db']->query("UPDATE  ".DB_PREFIX."investment_list set status=2 where id= ".$v['id']);
   					}
   				}
				if($v['investor_money_status']==0&&$now_time>$v['end_time']){
					$investor_list[$k]['investor_money_status']=2;
					$GLOBALS['db']->query("UPDATE  ".DB_PREFIX."investment_list set investor_money_status=2 where id= ".$v['id']);
   				}elseif($v['investor_money_status']==1&&$now_time>$v['pay_end_time']){
   					$investor_list[$k]['investor_money_status']=4;
					deal_invest_break($v['id']);   				
   				}
   			}
		} 
   		
   		$title='';
   		switch($type){
  			case 1:
  			$title='领投列表';
  			break;
  			case 2:
  			$title='跟投列表';
  			break;
  			case 0:
  			$title='询价列表';
  			break;
  		}
  		$page = new Page($investor_list_num,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
   		$GLOBALS['tmpl']->assign('type',$type);
   		$GLOBALS['tmpl']->assign('title',$title);
   		$GLOBALS['tmpl']->assign('investor_list',$investor_list);
  		$GLOBALS['tmpl']->display("account_mine_investor.html");
  	}
  	/*我的推荐列表*/
  	public function recommend(){
  		if(!$GLOBALS['user_info'])
  		{
  			showErr("",0,url_wap("user#login"));
  		}
  		$page_size = ACCOUNT_PAGE_SIZE;
  		$page = intval($_REQUEST['p']);
  		if($page==0)$page = 1;
  		$limit = (($page-1)*$page_size).",".$page_size;
  		$user_id=intval($GLOBALS['user_info']['id']);
  		$recommend_info=$GLOBALS['db']->getAll("SELECT * FROM ".DB_PREFIX."recommend WHERE user_id=".$user_id." ORDER BY create_time DESC limit $limit");
  		$recommend_count=$GLOBALS['db']->getOne("SELECT count(*) FROM ".DB_PREFIX."recommend WHERE user_id=".$user_id);
  		$page = new Page($recommend_count,$page_size);   //初始化分页对象
  		$p  =  $page->show();
  		$GLOBALS['tmpl']->assign('pages',$p);
  		$GLOBALS['tmpl']->assign("recommend_info",$recommend_info);
  		$GLOBALS['tmpl']->display("account_recommend.html");
  	}
  	
  	public function add_leader_info(){
  		if(!$GLOBALS['user_info']){
  			app_redirect(url_wap("user#login"));
  		}
  		$id=intval($_REQUEST['id']);
  		$leader_info=$GLOBALS['db']->getRow("select invest.*,d.name as deal_name from ".DB_PREFIX."investment_list as invest left join ".DB_PREFIX."deal as d on d.id=invest.deal_id where invest.id=".$id);
  		if($GLOBALS['user_info']['id']!=$leader_info['user_id']){
  			showErr("该页面不存在",0,"");
  			return false;
  		}
  		$file=unserialize($leader_info['leader_moban']);
  		$GLOBALS['tmpl']->assign('file',$file);
  		$GLOBALS['tmpl']->assign('leader_info',$leader_info);
  		$GLOBALS['tmpl']->assign('title','上传领投信息');
  		$GLOBALS['tmpl']->display("account_add_leader_info.html");
  	}
  	
 }
?>