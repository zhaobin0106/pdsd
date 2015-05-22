<?php
/** 未充值成功继续付款页面 */
class record_pay
{
	public function index()
	{
		$id = intval ( $_REQUEST ['notice_id'] );
		
		$payment_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment_notice where is_paid = 0 and id=" . $id );	
		if (! $payment_info)
		{
			$result = responseErrorInfo ( "notice_id参数错误" );
			output ( $result );
		}
		
		$payment_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "payment where online_pay=2 and is_effect=1 " );
		
		foreach ( $payment_list as $k => $v )
		{
			$class_name = $v ['class_name'] . "_payment";
			require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
			$o = new $class_name ();
		}
		
		$result = responseSuccessInfo ( "未充值成功继续付款页面" );
		$result ['payment_info'] = $payment_info;
		$result ['payment_list'] = $payment_list;
		output ( $result );
	}
}

?>