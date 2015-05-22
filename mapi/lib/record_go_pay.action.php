<?php
/** 充值记录未支付则继续支付使用 */
class record_go_pay
{
	public function index()
	{
		$id = intval ( $_REQUEST ['notice_id'] );
		$payment_id = intval ( $_REQUEST ['payment'] );
		
		// 参数验证区
		
		if ($id <= 0)
		{
			$result = responseErrorInfo ( "notice_id参数错误" );
			output ( $result );
		}
		$payment_info = getPayMentInfo ( $payment_id );
		if (! $payment_info)
		{
			$result = responseErrorInfo ( "payment无效支付方式" );
			output ( $result );
		}
		$is_paid = $GLOBALS ['db']->getOne ( "select is_paid from " . DB_PREFIX . "payment_notice where and id=" . $id );
		if ($is_paid == 1)
		{
			$result = responseErrorInfo ( "已支付成功无需再支付" );
			output ( $result );
		}
		
		$GLOBALS ['db']->query ( "update " . DB_PREFIX . "payment_notice set payment_id=$payment_id where id=$id " );
		
		require_once APP_ROOT_PATH . "system/payment/" . $payment_info ['class_name'] . "_payment.php";
 		$payment_class = $payment_info ['class_name'] . "_payment";
		$payment_object = new $payment_class ();
		$pay = $payment_object->get_payment_code ($id);
		 
		$result = responseSuccessInfo ( "充值未完成继续充值使用" );
		$result ['pay_code'] = $pay ['pay_code'];
		$result ['pay_type'] = 1;
		if ($pay ['pay_code'] == 'walipay')
		{
			$result ['pay_wap'] = $pay ['notify_url'];
		}
		
		if ($pay ['pay_code'] == 'wyeepay')
		{
			$result ['pay_wap'] = $pay ['notify_url'];
		}
		output ( $result );
	}
}

?>