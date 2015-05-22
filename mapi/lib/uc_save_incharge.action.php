<?php
// +----------------------------------------------------------------------
// | Fanwe 方维p2p借贷系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(88522820@qq.com)
// +----------------------------------------------------------------------
// require APP_ROOT_PATH.'app/Lib/uc.php';
class uc_save_incharge
{
	public function index()
	{
		$root = array ();
		
		$email = strim ( $GLOBALS ['request'] ['email'] ); // 用户名或邮箱
		$pwd = strim ( $GLOBALS ['request'] ['pwd'] ); // 密码
		$payment_id = intval ( $GLOBALS ['request'] ['payment'] );
		$money = floatval ( $GLOBALS ['request'] ['money'] );
		$is_mortgate = intval ( $GLOBALS ['request'] ['is_mortgate'] );
		// $bank_id =
		// addslashes(htmlspecialchars(trim($GLOBALS['request']['bank_id'])));
		$memo = addslashes ( htmlspecialchars ( trim ( $GLOBALS ['request'] ['memo'] ) ) );
		
		if ($payment_id == 0)
		{
			$root ['response_code'] = 0;
			$root ['show_err'] = '支付方式不能为空';
			output ( $root );
		}
		// 检查用户,用户密码
		$user = user_check ( $email, $pwd );
		$user_id = intval ( $user ['id'] );
		if ($user_id > 0)
		{
			$root ['response_code'] = 1;
			$root ['user_login_status'] = 1;
			
			$payment_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment where id = " . $payment_id );
			if (! $payment_info)
			{
				$root ['response_code'] = 0;
				$root ['show_err'] = "支付方式不存在";
				$root ['user_login_status'] = 0;
			} else
			{
				$payment_notice ['create_time'] = NOW_TIME;
				$payment_notice ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
				$payment_notice ['payment_id'] = $payment_id;
				$payment_notice ['money'] = $money;
				$payment_notice ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
				$payment_notice ['is_mortgate'] = $is_mortgate;
				do
				{
					$payment_notice ['notice_sn'] = to_date ( NOW_TIME, "Ymd" ) . rand ( 100, 999 );
					$GLOBALS ['db']->autoExecute ( DB_PREFIX . "payment_notice", $payment_notice, "INSERT", "", "SILENT" );
					$notice_id = $GLOBALS ['db']->insert_id ();
				} while ( $notice_id == 0 );
				require_once APP_ROOT_PATH . "system/payment/" . $payment_info ['class_name'] . "_payment.php";
				$payment_class = $payment_info ['class_name'] . "_payment";
				$payment_object = new $payment_class ();
				$pay = $payment_object->get_payment_code ( $notice_id );
				$root ['pay_code'] = $pay ['pay_code'];
				if ($pay ['pay_code'] == 'walipay')
				{
					$root ['pay_type'] = 1;
					$root ['pay_wap'] = $pay ['notify_url'];
				}
				
				if ($pay ['pay_code'] == 'wyeepay')
				{
					$root ['pay_type'] = 1;
					$root ['pay_wap'] = $pay ['notify_url'];
				}
			}
		} else
		{
			$root ['response_code'] = 0;
			$root ['show_err'] = "未登录";
			$root ['user_login_status'] = 0;
		}
		output ( $root );
	}
}
?>
