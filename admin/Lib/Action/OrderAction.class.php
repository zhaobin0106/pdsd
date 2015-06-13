<?php
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------

class OrderAction extends CommonAction{
	public function index()
	{
		//列表过滤器，生成查询Map对象
		$map = $this->_search ();
		//追加默认参数
		if($this->get("default_map"))
		$map = array_merge($map,$this->get("default_map"));
		if(trim($_REQUEST['dingdanhao'])!='')
		{
			$map['dingdanhao'] = array('like','%'.trim($_REQUEST['dingdanhao']));
		}
		$map['is_refund'] = "is_rufund = 0";
		
		if (method_exists ( $this, '_filter' )) {
			$this->_filter ( $map );
		}
		$type=trim($_REQUEST['type']);
		
		if(trim($_REQUEST['type'] == 1)){
			$model = D ('DealOrder');
		}elseif(trim($_REQUEST['type'] == 2)){
			$model = D ('ForeItemOrder');			
		}elseif(trim($_REQUEST['type'] == 3)){
			$model = D ('DealXianhuoOrder');			
		}else{
		$name=$this->getActionName();
		$model = D ($name);
		}
		if (! empty ( $model )) {
			$this->_userlist ( $model, $map ,$type);
		}
		$this->display ();
		return;
	}
	public function mb_sure(){
		$ajax = intval($_REQUEST['ajax']);
		$id = $_REQUEST ['id'];
		$info = $_REQUEST['info'];
		$this->assign('id',$id);
		$this->assign('info',$info);
		$this->display('usermessage');
	}
	public function save_memo(){
		$order_id = intval ( $_REQUEST ['id'] );
		$info=$_REQUEST['info'];
		$this->assign("jumpUrl",u(MODULE_NAME."/index",array("type"=>$info)));
		
		if($info== 1){
			$order_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_order where id = " . $order_id . " and order_status = 3 and is_refund = 0" );		
		}elseif($info == 2){
			$order_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item_order where id = " . $order_id . " and order_status = 3 and is_refund = 0" );
					
		}elseif($info == 3){
			$order_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo_order where id = " . $order_id . " and order_status = 3 and is_refund = 0" );
				
		}
		if (! $order_info) {
			$this->error( "无权为该订单设置回报");
		}

		
		$order_info ['repay_time'] = NOW_TIME;
		$order_info ['repay_memo'] = strim ( $_REQUEST ['repay_memo'] );
		
		if ($order_info ['repay_memo'] == "") {
			$order_info['repay_memo'] = "确认已领取";
		}
		if($info['type'] == 1){
		$GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_order", $order_info, "UPDATE", "id=" . $order_info ['id'] );
		}elseif($info['type'] == 2){
		$GLOBALS ['db']->autoExecute ( DB_PREFIX . "fore_item_order", $order_info, "UPDATE", "id=" . $order_info ['id'] );
		}elseif($info['type'] == 3){
		$GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_xianhuo_order", $order_info, "UPDATE", "id=" . $order_info ['id'] );
											
		}
		
		send_notify ( $order_info ['user_id'], "您报名的项目" . $order_info ['deal_name'] . "回报已发放", "account#view_shichi_order", "id=" . $order_info ['id'] );
		$this->success ('确认成功');
	}
	public function delete() {
		//彻底删除指定记录
		$ajax = intval($_REQUEST['ajax']);
		$id = $_REQUEST ['id'];
		if (isset ( $id )) {
				$condition = array ('id' => array ('in', explode ( ',', $id ) ) );			
				$rel_data = M(MODULE_NAME)->where($condition)->count();				
				$list = M(MODULE_NAME)->where ( $condition )->delete();		

				
				
				if ($list!==false) {
					foreach($rel_data as $k=>$v)
					{
						if($v['log_id']==0)
						{
							$GLOBALS['db']->query("update ".DB_PREFIX."fore set comment_count = comment_count - 1 where id = ".$v['fore_id']);
						}
					}
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
	
	public function set_effect()
	{
		$id = intval($_REQUEST['id']);
		$ajax = intval($_REQUEST['ajax']);
		$info = M(MODULE_NAME)->where("id=".$id)->getField("name");
		$c_is_effect = M(MODULE_NAME)->where("id=".$id)->getField("status");  //当前状态
		$n_is_effect = $c_is_effect == 0 ? 1 : 0; //需设置的状态
		M(MODULE_NAME)->where("id=".$id)->setField("status",$n_is_effect);	
		save_log($info.l("SET_EFFECT_".$n_is_effect),1);
		rm_auto_cache("cache_nav_list");
		$this->ajaxReturn($n_is_effect,l("SET_EFFECT_".$n_is_effect),1)	;	
	}

}
?>