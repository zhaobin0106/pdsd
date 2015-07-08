<?php
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------

class PaymentNoticeAction extends CommonAction{
	public function index()
	{
		//列表过滤器，生成查询Map对象
		$map = $this->_search ();
		//追加默认参数
		if($this->get("default_map"))
		$map = array_merge($map,$this->get("default_map"));
		if($_REQUEST['deal_id']>0)
		{
			$map['deal_id'] = intval($_REQUEST['deal_id']);
		}
		if($_REQUEST['deal_name'] != ''){
			$map['deal_name'] = array('like','%'.trim($_REQUEST['deal_name']).'%');
		}
		if($_REQUEST['user_name'] != ''){
			$user_id = M("User")->where("user_name= '".$_REQUEST['user_name']."'")->getField("id");
			$map['user_id'] = intval($user_id);
		}
		if($_REQUEST['payment_id']!= NULL){
			$map['payment_id']=intval($_REQUEST['payment_id']);
		}
		if($_REQUEST['payment_id']=='NULL'){
			unset($map['payment_id']);
		}

		
		if (method_exists ( $this, '_filter' )) {
			$this->_filter ( $map );
		}
		$payment = M("Payment")->findAll();
		$this->assign('payment',$payment);
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
				$list = M(MODULE_NAME)->where ( $condition )->delete();		
				
				foreach($rel_data as $data)
				{
					$info[] = "[单号:".$data['notice_sn']."]";						
				}
				if($info) $info = implode(",",$info);
				
				if ($list!==false) {
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
	

}
?>