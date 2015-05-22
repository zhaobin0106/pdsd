<?php

// +----------------------------------------------------------------------
// | Fanwe 方维众筹支持的项目
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(88522820@qq.com)
// +----------------------------------------------------------------------
// require APP_ROOT_PATH.'app/Lib/uc.php';
class pay_cart
{
	public function index()
	{
		$root = array ();
		
		$email = strim ( $GLOBALS ['request'] ['email'] ); // 用户名或邮箱
		$pwd = strim ( $GLOBALS ['request'] ['pwd'] ); // 密码
		                                               // 检查用户,用户密码
		$user = user_check ( $email, $pwd );
		$user_id = intval ( $user ['id'] );
		if ($user_id > 0)
		{
			$root ['user_login_status'] = 1;
			$root ['response_code'] = 1;
			$user ['money_format'] = format_price ( $user ['money'] ); // 可用资金
			$root ['money_format'] = $user ['money_format'];
			$root ['money'] = $user ['money'];
			
			$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $user ['id'] ) );
			$root ['consignee_list'] = $consignee_list;
			
			$payment_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "payment where is_effect = 1 and online_pay = 2 order by sort asc " );
			
			foreach ( $payment_list as $k => $v )
			{
				$class_name = $v ['class_name'] . "_payment";
				require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
				$o = new $class_name ();
				unset ( $payment_list ['$k'] ['config'] );
			}
			
			$root ['payment_list'] = $payment_list;
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