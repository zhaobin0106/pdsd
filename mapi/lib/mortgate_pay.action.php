<?php
/** 充值诚意金 */
class mortgate_pay
{
	public function index()
	{
		$email = strim ( $GLOBALS ['request'] ['email'] );
		$password = strim ( $GLOBALS ['request'] ['pwd'] );
		
		$user = user_check ( $email, $password );
		$user_id = intval ( $user ['id'] );
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		
		$new_money = user_need_mortgate ();
		$has_money = $GLOBALS ['db']->getOne ( "select mortgage_money from " . DB_PREFIX . "user where id=" . $user_id );
		$money = $new_money - $has_money;
		if ($money <= 0)
		{
			$data = responseErrorInfo ( "您的诚意金已支付，无需再支付！" );
			output ( $data );
		}
		
		$payment_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "payment where is_effect = 1 and online_pay=2 order by sort asc " );
		
		foreach ( $payment_list as $k => $v )
		{
			$class_name = $v ['class_name'] . "_payment";
			require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
			$o = new $class_name ();
			$payment_list [$k] ['logo'] = get_abs_img_root ( $v ['logo'] );
			$payment_list [$k] ['config'] = '';
		}
		
		$data = responseSuccessInfo ( "需要支付诚意金" );
		$data ['money'] = $money;
		$data ['payment_list'] = $payment_list;
		output ( $data );
	}
}

?>