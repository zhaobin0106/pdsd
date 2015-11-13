<?php
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------

class DealOrderAction extends CommonAction{
	public function index()
	{
		if($_REQUEST['type']=='NULL'){
			unset($_REQUEST['type']);
		}
		$order_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal_order where repay_make_time=0 and repay_time>0  ");
		foreach($order_list as $k=>$v){
				$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
				$repay_make_date=$v['repay_time']+$left_date*24*3600;
				if($repay_make_date<=get_gmtime()){
 					$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set repay_make_time =  ".get_gmtime()." where id = ".$v['id'] );
				}
 		}
		//列表过滤器，生成查询Map对象
		//$map = $this->_search ();
		//追加默认参数
		if($this->get("default_map"))
		$map = array_merge($map,$this->get("default_map"));
		
		if(trim($_REQUEST['deal_name'])!='')
		{
			$map['deal_name'] = array('like','%'.trim($_REQUEST['deal_name']).'%');
		}
		if(trim($_REQUEST['dingdanhao'])!='')
		{
			$map['dingdanhao'] = array('like','%'.trim($_REQUEST['dingdanhao']).'%');
		}
		if(trim($_REQUEST['deal_id'] != ''))
		{
			$map['deal_id'] = intval($_REQUEST['deal_id']);
		}
		if(trim($_REQUEST['user_name'])!='')
		{
			$map['user_name'] = array('like','%'.trim($_REQUEST['user_name']).'%');
		}
		
		if(intval($_REQUEST['is_refund'])==1)
		{
			$map['is_refund'] = 0;
		}
		
		if(intval($_REQUEST['is_refund'])==2)
		{
			$map['is_refund'] = 1;
		}
		if(intval($_REQUEST['order_status'])==1)
		{
			$map['order_status'] = 0;
		}
		
		if(intval($_REQUEST['order_status'])==2)
		{
			$map['order_status'] = 1;
		}
		if(intval($_REQUEST['order_status'])==3)
		{
			$map['order_status'] = 2;
		}
		
		if(intval($_REQUEST['order_status'])==4)
		{
			$map['order_status'] = 3;
		}
		
		
		if(intval($_REQUEST['make_type'])==1)
		{
			$map['is_success'] = 0;
		}
		
		if(intval($_REQUEST['make_type'])==2)
		{
			$map['is_success'] = 1;
			$map['repay_make_time']=0;
			$map['repay_time'] = 0;
		}
		if(intval($_REQUEST['make_type'])==3)
		{
			$map['is_success'] = 1;
			$map['repay_make_time']=0;
			$map['repay_time'] = array('gt',1);
		}
		
		if(intval($_REQUEST['make_type'])==4)
		{
			$map['is_success'] = 1;
			$map['repay_make_time']=array('gt',1);
		}
		if (method_exists ( $this, '_filter' )) {
			$this->_filter ( $map );
		}
		
		$name=$this->getActionName();
		$model = D ($name);
		if (! empty ( $model )) {
			$this->_list ( $model, $map );
		}
		$this->display ();
		return;
	}
	
	public function delete() {
		//彻底删除指定记录
		$ajax = intval($_REQUEST['ajax']);
		$id = $_REQUEST ['id'];
		if (isset ( $id )) {
				$condition = array ('id' => array ('in', explode ( ',', $id ) ) );
				$rel_data = M(MODULE_NAME)->where($condition)->findAll();				
				foreach($rel_data as $data)
				{
					$info[] = "[".$data['deal_name'].$data['deal_price']."支持人:".$data['user_name']."状态:".$data['order_status']."]";						
				}
				if($info) $info = implode(",",$info);
				$list = M(MODULE_NAME)->where ( $condition )->delete();		
						
				if ($list!==false) {
//					$deal_id=$GLOBALS['db']->getOne("select deal_id from  ".DB_PREFIX."deal_order where id=$id");
//					syn_deal($deal_id);
					save_log($info."成功删除",1);
					$this->success ("成功删除",$ajax);
				} else {
					save_log($info."删除出错",0);					
					$this->error ("删除出错",$ajax);
				}
			} else {
				$this->error (l("INVALID_OPERATION"),$ajax);
		}
	}

	public function delete_goumai() {
		//彻底删除指定记录
		$ajax = intval($_REQUEST['ajax']);
		$id = $_REQUEST ['id'];
		if (isset ( $id )) {
			$condition = array ('id' => array ('in', explode ( ',', $id ) ) );
			$rel_data = M("DealXianhuoOrder")->where($condition)->findAll();
			foreach($rel_data as $data)
			{
				$info[] = "[".$data['deal_name'].$data['deal_price']."购买者:".$data['user_name']."状态:".$data['order_status']."]";
			}
			if($info) $info = implode(",",$info);
			$list = M("DealXianhuoOrder")->where ( $condition )->delete();
	
			if ($list!==false) {
				//					$deal_id=$GLOBALS['db']->getOne("select deal_id from  ".DB_PREFIX."deal_order where id=$id");
				//					syn_deal($deal_id);
				save_log($info."成功删除",1);
				$this->success ("成功删除",$ajax);
			} else {
				save_log($info."删除出错",0);
				$this->error ("删除出错",$ajax);
			}
		} else {
			$this->error (l("INVALID_OPERATION"),$ajax);
		}
	}
	public function zhongjiang()
	{
		$ajax = intval($_REQUEST['ajax']);
		$id = $_REQUEST ['id'];
		if (isset ( $id )) {
			$arrlist = explode(',', $id);
			foreach($arrlist as $v)
			{
				$list=M("DealOrder")->where("id=".$v)->setField("is_zhongjiang",1);	
			}
		
			if ($list!==false) {
				$this->success ("设置成功",$ajax);
			} else {
				$this->error ("设置失败",$ajax);
			}
		} else {
			$this->error (l("INVALID_OPERATION"),$ajax);
		}
	}
	public function weizhongjiang()
	{
		$ajax = intval($_REQUEST['ajax']);
		$id = $_REQUEST ['id'];
		if (isset ( $id )) {
			$arrlist = explode(',', $id);
			foreach($arrlist as $v)
			{
				$list=M("DealOrder")->where("id=".$v)->setField("is_zhongjiang",2);
			}
	
			if ($list!==false) {
				$this->success ("设置成功",$ajax);
			} else {
				$this->error ("设置失败",$ajax);
			}
		} else {
			$this->error (l("INVALID_OPERATION"),$ajax);
		}
	}
	public function view()
	{
		$order_info = M("DealOrder")->getById(intval($_REQUEST['id']));
		if(!$order_info)$this->error("没有该项目的支持");
		
		
		$payment_notice_list = M("PaymentNotice")->where("order_id=".$order_info['id']." and is_paid = 1 and deal_item_id = ".$order_info['deal_item_id'])->findAll();
		$this->assign("payment_notice_list",$payment_notice_list);
		
		$this->assign("order_info",$order_info);		
		$this->display();
	}
	public function goumai_view()
	{
		$order_info = M("DealXianhuoOrder")->getById(intval($_REQUEST['id']));
		if(!$order_info)$this->error("没有该项目的支持");
	
	
		$payment_notice_list = M("PaymentNotice")->where("order_id=".$order_info['id']." and is_paid = 1")->findAll();
		$this->assign("payment_notice_list",$payment_notice_list);
	
		$this->assign("order_info",$order_info);
		$this->display();
	}
	public function refund()
	{
		$id = intval($_REQUEST['id']);
		$order_info = M("DealOrder")->getById($id);
		if($order_info)
		{
			if($order_info['is_refund']==0)
			{
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set is_refund = 1 where id = ".$id." and is_refund = 0");
				if($GLOBALS['db']->affected_rows()>0)
				{
					require_once APP_ROOT_PATH."system/libs/user.php";				
					modify_account(array("money"=>$order_info['total_price']),$order_info['user_id'],$order_info['deal_name']."退款");
				}
				
				$this->success("成功退款到会员余额");
			}
			else
			{
				$this->error("已经退款");
			}
		}
		else
		{
			$this->error("没有该项目的支持");
		}
	}
	
	public function goumai_refund()
	{
		$id = intval($_REQUEST['id']);
		$order_info = M("DealXianhuoOrder")->getById($id);
		if($order_info)
		{
			if($order_info['is_refund']==0)
			{
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_xianhuo_order set is_refund = 1 where id = ".$id." and is_refund = 0");
				if($GLOBALS['db']->affected_rows()>0)
				{
					require_once APP_ROOT_PATH."system/libs/user.php";
					modify_account(array("money"=>$order_info['total_price']),$order_info['user_id'],$order_info['deal_name']."退款");
				}
	
				$this->success("成功退款到会员余额");
			}
			else
			{
				$this->error("已经退款");
			}
		}
		else
		{
			$this->error("没有该项目的支持");
		}
	}
	
	public function incharge()
	{
		$id = intval($_REQUEST['id']);
		$order_info = M("DealOrder")->getById($id);
		if($order_info)
		{
			if($order_info['order_status']==0)
			{
				$result = pay_order($order_info['id']);				
				$money = $result['money'];
				$payment_notice['create_time'] = get_gmtime();
				$payment_notice['user_id'] = $order_info['user_id'];
				$payment_notice['payment_id'] = 0;
				$payment_notice['money'] = $money;
				$payment_notice['bank_id'] = "";
				$payment_notice['order_id'] = $order_info['id'];
				$payment_notice['memo'] = "管理员收款";
				$payment_notice['deal_id'] = $order_info['deal_id'];
				$payment_notice['deal_item_id'] = $order_info['deal_item_id'];
				$payment_notice['deal_name'] = $order_info['deal_name'];
				
				do{
					$payment_notice['notice_sn'] = to_date(get_gmtime(),"Ymd").rand(100,999);
					$GLOBALS['db']->autoExecute(DB_PREFIX."payment_notice",$payment_notice,"INSERT","","SILENT");
					$notice_id = $GLOBALS['db']->insert_id();
				}while($notice_id==0);
				
				require_once APP_ROOT_PATH."system/libs/cart.php";
				$rs = payment_paid($payment_notice['notice_sn'],"");	
				$this->error("收款完成");
			}
			else
			{
				$this->error("已经付过款");
			}
		}
		else
		{
			$this->error("没有该项目的支持");
		}
	}
	public function goumai_incharge()
	{
	$id = intval($_REQUEST['id']);
	$order_info = M("DealXianhuoOrder")->getById($id);
	if($order_info)
	{
		if($order_info['order_status']==0)
		{
			$result = pay_xianhuo_order($order_info['id']);
			$money = $result['money'];
			$payment_notice['create_time'] = get_gmtime();
			$payment_notice['user_id'] = $order_info['user_id'];
			$payment_notice['payment_id'] = 0;
			$payment_notice['money'] = $money;
			$payment_notice['bank_id'] = "";
			$payment_notice['order_id'] = $order_info['id'];
			$payment_notice['memo'] = "管理员收款";
			$payment_notice['deal_id'] = $order_info['deal_id'];
			$payment_notice['deal_xianhuo_id'] = $order_info['deal_xianhuo_id'];
			$payment_notice['deal_name'] = $order_info['deal_name'];
	
			do{
				$payment_notice['notice_sn'] = to_date(get_gmtime(),"Ymd").rand(100,999);
				$GLOBALS['db']->autoExecute(DB_PREFIX."payment_notice",$payment_notice,"INSERT","","SILENT");
				$notice_id = $GLOBALS['db']->insert_id();
			}while($notice_id==0);
	
			require_once APP_ROOT_PATH."system/libs/cart.php";
			$rs = payment_goumai_paid($payment_notice['notice_sn'],"");
			$this->error("收款完成");
		}
		else
		{
			$this->error("已经付过款");
		}
	}
	else
	{
		$this->error("没有该项目的支持");
	}
	}
	
	//导出电子表
	public function export_csv($page = 1)
	{
		$pagesize = 10;
		set_time_limit(0);
		$limit = (($page - 1)*intval($pagesize)).",".(intval($pagesize));
	//	$limit=((0).",".(10));
		//echo $limit;exit;
		//$where = " 1=1 ";
		//定义条件
		if(trim($_REQUEST['deal_name'])!='')
		{
			$where['deal_name'] = array('like','%'.trim($_REQUEST['deal_name']).'%');
		}
		if(trim($_REQUEST['deal_id'] != ''))
		{
			$where['deal_id'] = intval($_REQUEST['deal_id']);
		}
		if(trim($_REQUEST['user_name'])!='')
		{
			$where['user_name'] = array('like','%'.trim($_REQUEST['user_name']).'%');
		}
		
		if(intval($_REQUEST['is_refund'])==1)
		{
			$where['is_refund'] = 0;
		}
		
		if(intval($_REQUEST['is_refund'])==2)
		{
			$where['is_refund'] = 1;
		}
		if(intval($_REQUEST['order_status'])==1)
		{
			$where['order_status'] = 0;
		}
		
		if(intval($_REQUEST['order_status'])==2)
		{
			$where['order_status'] = 1;
		}
		if(intval($_REQUEST['order_status'])==3)
		{
			$where['order_status'] = 2;
		}
		
		if(intval($_REQUEST['order_status'])==4)
		{
			$where['order_status'] = 3;
		}
		
		
		if(intval($_REQUEST['make_type'])==1)
		{
			$where['is_success'] = 0;
		}
		
		if(intval($_REQUEST['make_type'])==2)
		{
			$where['is_success'] = 1;
			$where['repay_make_time']=0;
			$where['repay_time'] = 0;
		}
		if(intval($_REQUEST['make_type'])==3)
		{
			$where['is_success'] = 1;
			$where['repay_make_time']=0;
			$where['repay_time'] = array('gt',1);
		}
		
		if(intval($_REQUEST['make_type'])==4)
		{
			$where['is_success'] = 1;
			$where['repay_make_time']=array('gt',1);
		}
		if(trim($_REQUEST['deal_item_id'])!='')
		{
			$where['deal_item_id'] = intval($_REQUEST['deal_item_id']);
		}
		$list = M("DealOrder")
				->where($where)
				->field(DB_PREFIX.'deal_order.*')
				->order('id desc')
				->limit($limit)->findAll();
		
		if($list)
		{
			register_shutdown_function(array(&$this, 'export_csv'), $page+1);
			
			$order_value = array('id'=>'""' ,'dingdanhao'=>'""', 'deal_name'=>'""', 'user_name'=>'""','num'=>'""', 'total_price'=>'""','credit_pay'=>'""','online_pay'=>'""','pay_time'=>'""','pay_status'=>'""','repay_make'=>'""','is_refund'=>'""','repay_time'=>'""','create_time'=>'""','kuaidi_desc'=>'""','province'=>'""','zip'=>'""','consignee'=>'""','mobile'=>'""','support_memo'=>'""','repay_memo'=>'""');
			    	if($page == 1)
	    	{
		    	$content = iconv("utf-8","gbk","编号,订单号,项目名称,支持者,购买数量,应付总额,余额支付,在线支付,支付时间,支付状态,确认收货,退款,回报日期,下单日期,配送信息,收货地址,邮编,收货人,手机号,支持者备注,发货信息");	    		    	
		    	$content = $content . "\n";
	    	}
	
			foreach($list as $k=>$v)
			{

				if($v['order_status']==0)$v['pay_status']="未支付";
				if($v['order_status']==1)$v['pay_status']="过期支付";
				if($v['order_status']==2)$v['pay_status']="限额已满";
				if($v['order_status']==3)$v['pay_status']="已支付";
				$order_value['id'] = '"' . iconv('utf-8','gbk',$v['id']) . '"';
				$order_value['dingdanhao'] = '"' . iconv('utf-8','gbk','D'.$v['dingdanhao']) . '"';
				$order_value['deal_name'] = '"' . iconv('utf-8','gbk',$v['deal_name']) . '"';
				$order_value['user_name'] = '"' . iconv('utf-8','gbk',$v['user_name']) . '"';
				$order_value['num'] = '"' . iconv('utf-8','gbk',$v['num']) . '"';
				$order_value['total_price'] = '"' . iconv('utf-8','gbk',$v['total_price']) . '"';
				$order_value['credit_pay'] = '"' . iconv('utf-8','gbk',$v['credit_pay']) . '"';
				$order_value['online_pay'] = '"' . iconv('utf-8','gbk',$v['online_pay']) . '"';
				$order_value['pay_time'] ='"' . iconv('utf-8','gbk',to_date($v['pay_time'],'Y-m-d H:i:s')) . '"';
				$order_value['pay_status'] = '"' . iconv('utf-8','gbk',$v['pay_status']) . '"';
				$order_value['repay_make'] = $v['repay_make_time'] > 1?'"' . iconv('utf-8','gbk','是') . '"':'"' . iconv('utf-8','gbk','否') . '"';
				$order_value['is_refund'] = $v['is_refund'] > 0?'"' . iconv('utf-8','gbk','是') . '"':'"' . iconv('utf-8','gbk','否') . '"';
				$order_value['repay_time'] ='"' . iconv('utf-8','gbk',to_date($v['repay_time'],'Y-m-d H:i:s')) . '"';
				$order_value['create_time'] ='"' . iconv('utf-8','gbk',to_date($v['create_time'],'Y-m-d H:i:s')) . '"';
				$order_value['kuaidi_desc'] = '"' . iconv('utf-8','gbk',$v['kuaidi_desc']) . '"';
				$order_value['province'] = '"' . iconv('utf-8','gbk',$v['province']) . '"'. iconv('utf-8','gbk',$v['city']) . iconv('utf-8','gbk',$v['address']);
				$order_value['zip'] = '"' . iconv('utf-8','gbk',$v['zip']) . '"';
				$order_value['consignee'] = '"' . iconv('utf-8','gbk',$v['consignee']). '"' ;
				$order_value['mobile'] = '"' . iconv('utf-8','gbk',$v['mobile']) . '"';
				$order_value['support_memo'] = '"'.iconv('utf-8','gbk',$v['support_memo']).'"';
				$order_value['repay_memo'] = '"' . iconv('utf-8','gbk',$v['repay_memo']). '"' ;
				$content .= implode(",", $order_value) . "\n";
			}
			
			//
			header("Content-Disposition: attachment; filename=order_list.csv");
	    	echo $content ;
		}
		else
		{
			if($page==1)
			$this->error(L("NO_RESULT"));
		}	
		
	}
	
	public function export_csvs($page = 1)
	{
		$pagesize = 10;
		set_time_limit(0);
		$limit = (($page - 1)*intval($pagesize)).",".(intval($pagesize));
		//	$limit=((0).",".(10));
		//echo $limit;exit;
		//$where = " 1=1 ";
		//定义条件
		if(trim($_REQUEST['deal_id'] != ''))
		{
			$where['deal_id'] = intval($_REQUEST['deal_id']);
		}
		if(trim($_REQUEST['user_name'])!='')
		{
			$where['user_name'] = array('like','%'.trim($_REQUEST['user_name']).'%');
		}
		if(intval($_REQUEST['is_refund'])==1)
		{
			$where['is_refund'] = 0;
		}
		
		if(intval($_REQUEST['is_refund'])==2)
		{
			$where['is_refund'] = 1;
		}
		if(intval($_REQUEST['order_status'])==1)
		{
			$where['order_status'] = 0;
		}
		
		if(intval($_REQUEST['order_status'])==2)
		{
			$where['order_status'] = 1;
		}
		if(intval($_REQUEST['order_status'])==3)
		{
			$where['order_status'] = 2;
		}
		
		if(intval($_REQUEST['order_status'])==4)
		{
			$where['order_status'] = 3;
		}
		if(trim($_REQUEST['deal_xianhuo_id'])!='')
		{
			$where['deal_xianhuo_id'] = intval($_REQUEST['deal_xianhuo_id']);
		}
		$list = M("DealXianhuoOrder")
		->where($where)
		->field(DB_PREFIX.'deal_xianhuo_order.*')
		->order('id desc')
		->limit($limit)->findAll();
	
		if($list)
		{
			register_shutdown_function(array(&$this, 'export_csvs'), $page+1);
				
			$order_value = array('id'=>'""' ,'dingdanhao'=>'""', 'deal_name'=>'""', 'user_name'=>'""','num'=>'""', 'total_price'=>'""','credit_pay'=>'""','online_pay'=>'""','pay_time'=>'""','pay_status'=>'""','repay_make'=>'""','is_refund'=>'""','repay_time'=>'""','create_time'=>'""','kuaidi_desc'=>'""','province'=>'""','zip'=>'""','consignee'=>'""','mobile'=>'""','support_memo'=>'""','repay_memo'=>'""');
			    	if($page == 1)
	    	{
		    	$content = iconv("utf-8","gbk","编号,订单号,项目名称,购买者,购买数量,应付总额,余额支付,在线支付,支付时间,支付状态,确认收货,退款,回报日期,下单日期,配送信息,收货地址,邮编,收货人,手机号,购买者备注,发货信息");	    		    	
		    	$content = $content . "\n";
	    	}
	
			foreach($list as $k=>$v)
			{

				if($v['order_status']==0)$v['pay_status']="未支付";
				if($v['order_status']==1)$v['pay_status']="过期支付";
				if($v['order_status']==2)$v['pay_status']="限额已满";
				if($v['order_status']==3)$v['pay_status']="已支付";
				$order_value['id'] = '"' . iconv('utf-8','gbk',$v['id']) . '"';
				$order_value['dingdanhao'] = '"' . iconv('utf-8','gbk','D'.$v['dingdanhao']) . '"';
				$order_value['deal_name'] = '"' . iconv('utf-8','gbk',$v['deal_name']) . '"';
				$order_value['user_name'] = '"' . iconv('utf-8','gbk',$v['user_name']) . '"';
				$order_value['num'] = '"' . iconv('utf-8','gbk',$v['num']) . '"';
				$order_value['total_price'] = '"' . iconv('utf-8','gbk',$v['total_price']) . '"';
				$order_value['credit_pay'] = '"' . iconv('utf-8','gbk',$v['credit_pay']) . '"';
				$order_value['online_pay'] = '"' . iconv('utf-8','gbk',$v['online_pay']) . '"';
				$order_value['pay_time'] ='"' . iconv('utf-8','gbk',to_date($v['pay_time'],'Y-m-d H:i:s')) . '"';
				$order_value['pay_status'] = '"' . iconv('utf-8','gbk',$v['pay_status']) . '"';
				$order_value['repay_make'] = $v['repay_make_time'] > 1?'"' . iconv('utf-8','gbk','是') . '"':'"' . iconv('utf-8','gbk','否') . '"';
				$order_value['is_refund'] = $v['is_refund'] > 0?'"' . iconv('utf-8','gbk','是') . '"':'"' . iconv('utf-8','gbk','否') . '"';
				$order_value['repay_time'] ='"' . iconv('utf-8','gbk',to_date($v['repay_time'],'Y-m-d H:i:s')) . '"';
				$order_value['create_time'] ='"' . iconv('utf-8','gbk',to_date($v['create_time'],'Y-m-d H:i:s')) . '"';
				$order_value['kuaidi_desc'] = '"' . iconv('utf-8','gbk',$v['kuaidi_desc']) . '"';
				$order_value['province'] = '"' . iconv('utf-8','gbk',$v['province']) . '"'. iconv('utf-8','gbk',$v['city']) . iconv('utf-8','gbk',$v['address']);
				$order_value['zip'] = '"' . iconv('utf-8','gbk',$v['zip']) . '"';
				$order_value['consignee'] = '"' . iconv('utf-8','gbk',$v['consignee']). '"' ;
				$order_value['mobile'] = '"' . iconv('utf-8','gbk',$v['mobile']) . '"';
				$order_value['support_memo'] = '"'.iconv('utf-8','gbk',$v['support_memo']).'"';
				$order_value['repay_memo'] = '"' . iconv('utf-8','gbk',$v['repay_memo']). '"' ;
				$content .= implode(",", $order_value) . "\n";
			}
			//var_dump('saas121as'.$content);
			//exit;	
			//
			header("Content-Disposition: attachment; filename=order_list.csv");
			echo $content ;
		}
		else
		{
			if($page==1)
				$this->error(L("NO_RESULT"));
		}
	
	}
	
	public function get_pay_list()
	{
		$deal_id=$_REQUEST['deal_id'];
		$deal_info=$GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal where id=$deal_id ");
		$this->assign("deal_info",$deal_info);
		$order_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal_order where repay_make_time=0 and repay_time>0 and deal_id=$deal_id  ");		
		foreach($order_list as $k=>$v){
				$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
				$repay_make_date=$v['repay_time']+$left_date*24*3600;
				if($repay_make_date<=get_gmtime()){
 					$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set repay_make_time =  ".get_gmtime()." where id = ".$v['id'] );
				}
 		}
		//列表过滤器，生成查询Map对象
		//$map = $this->_search ();
		//追加默认参数
		$map['deal_id']=intval($_REQUEST['deal_id']);
		if($this->get("default_map"))
		$map = array_merge($map,$this->get("default_map"));
		if(trim($_REQUEST['user_name'])!='')
		{
			$map['user_name'] = array('like','%'.trim($_REQUEST['user_name']).'%');
		}
		if(trim($_REQUEST['dingdanhao'])!='')
		{
			$map['dingdanhao'] = array('like','%'.trim($_REQUEST['dingdanhao']).'%');
		}
		if(intval($_REQUEST['is_refund'])==1)
		{
			$map['is_refund'] = 0;
		}
		
		if(intval($_REQUEST['is_refund'])==2)
		{
			$map['is_refund'] = 1;
		}
		if(intval($_REQUEST['order_status'])==1)
		{
			$map['order_status'] = 0;
		}
		
		if(intval($_REQUEST['order_status'])==2)
		{
			$map['order_status'] = 1;
		}
		if(intval($_REQUEST['order_status'])==3)
		{
			$map['order_status'] = 2;
		}
		
		if(intval($_REQUEST['order_status'])==4)
		{
			$map['order_status'] = 3;
		}
		if(trim($_REQUEST['deal_item_id'])!='')
		{
			$map['deal_item_id'] = intval($_REQUEST['deal_item_id']);
		}
		if (method_exists ( $this, '_filter' )) {
			$this->_filter ( $map );
		}
		$name=$this->getActionName();
		$model = D ($name);
		if (! empty ( $model )) {
			$this->_list ( $model, $map );
		}
		$this->display ();
		return;
	}

	public function get_goumai_list()
	{
		$deal_id=$_REQUEST['deal_id'];
		$deal_info=$GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal where id=$deal_id ");
		$this->assign("deal_info",$deal_info);
		$order_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal_xianhuo_order where repay_make_time=0 and repay_time>0 and deal_id=$deal_id  ");
		foreach($order_list as $k=>$v){
			$left_date=intval(app_conf("REPAY_MAKE"))?7:intval(app_conf("REPAY_MAKE"));
			$repay_make_date=$v['repay_time']+$left_date*24*3600;
			if($repay_make_date<=get_gmtime()){
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_xianhuo_order set repay_make_time =  ".get_gmtime()." where id = ".$v['id'] );
			}
		}
		//列表过滤器，生成查询Map对象
		//$map = $this->_search ("DealXianhuoOrder");
		//追加默认参数
		
		$map['deal_id']=intval($_REQUEST['deal_id']);
		if($this->get("default_map"))
		$map = array_merge($map,$this->get("default_map"));
		if(trim($_REQUEST['user_name'])!='')
		{
			$map['user_name'] = array('like','%'.trim($_REQUEST['user_name']).'%');
		}
		if(trim($_REQUEST['dingdanhao'])!='')
		{
			$map['dingdanhao'] = array('like','%'.trim($_REQUEST['dingdanhao']).'%');
		}
		if(intval($_REQUEST['is_refund'])==1)
		{
			$map['is_refund'] = 0;
		}
		
		if(intval($_REQUEST['is_refund'])==2)
		{
			$map['is_refund'] = 1;
		}
		if(intval($_REQUEST['order_status'])==1)
		{
			$map['order_status'] = 0;
		}
		
		if(intval($_REQUEST['order_status'])==2)
		{
			$map['order_status'] = 1;
		}
		if(intval($_REQUEST['order_status'])==3)
		{
			$map['order_status'] = 2;
		}
		
		if(intval($_REQUEST['order_status'])==4)
		{
			$map['order_status'] = 3;
		}
		if(trim($_REQUEST['deal_xianhuo_id'])!='')
		{
			$map['deal_xianhuo_id'] = intval($_REQUEST['deal_xianhuo_id']);
		}
		if (method_exists ( $this, '_filter' )) {
			$this->_filter ( $map );
		}
		$name=$this->getActionName();
		$model = D ("DealXianhuoOrder");
		if (! empty ( $model )) {
			$this->_list ( $model, $map );
		}
		$this->display ();
		return;
	}
	
}
?>