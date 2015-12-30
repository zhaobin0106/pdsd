<?php

// +----------------------------------------------------------------------
// | Fanwe 方维众筹支持的项目
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(88522820@qq.com)
// +----------------------------------------------------------------------
// require APP_ROOT_PATH.'app/Lib/uc.php';
class go_pay
{
	public function index()
	{
		$root = array ();
		
		$email = strim ( $GLOBALS ['request'] ['email'] ); // 用户名或邮箱
		$pwd = strim ( $GLOBALS ['request'] ['pwd'] ); // 密码
		$credit = doubleval ( $GLOBALS ['request'] ['credit'] );
		$consignee_id = intval ( $_REQUEST ['consignee_id'] );
		$id = intval ( $_REQUEST ['id'] );
		$memo = strim ( $_REQUEST ['memo'] );
		$payment_id = intval ( $_REQUEST ['payment'] );
		
		// 检查用户,用户密码
		$user = user_check ( $email, $pwd );
		$user_id = intval ( $user ['id'] );
		if ($user_id > 0)
		{
			$root ['user_login_status'] = 1;
			$order_info ['payment_id'] = 0;
			$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item where id = " . $id );
			if (! $deal_item)
			{
				$root ['addr'] = get_domain () . APP_ROOT;
				// app_redirect(url("index"));
			} elseif (($deal_item ['support_count'] + $deal_item ['virtual_person']) >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0)
			{
				$root ['addr'] = url ( "deal#show", array (
						"id" => $deal_item ['deal_id'] 
				) );
				// app_redirect(url("deal#show",array("id"=>$deal_item['deal_id'])));
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['deal_id'] );
			if (! $deal_info)
			{
				$root ['addr'] = get_domain () . APP_ROOT;
				// app_redirect(url("index"));
			} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0))
			{
				$root ['addr'] = url_mapi ( "deal#show", array (
						"id" => $deal_item ['deal_id'] 
				) );
				// app_redirect(url("deal#show",array("id"=>$deal_item['deal_id'])));
			}
			
			if (intval ( $consignee_id ) == 0 && $deal_item ['is_delivery'] == 1)
			{
				$root ['info'] = "请选择配送方式";
				// showErr("请选择配送方式",0,get_gopreview());
			}
			
			$order_info ['deal_id'] = $deal_info ['id'];
			$order_info ['deal_item_id'] = $deal_item ['id'];
			$order_info ['user_id'] = intval ( $user ['id'] );
			$order_info ['user_name'] = $user ['user_name'];
			$order_info ['total_price'] = $deal_item ['price'] + $deal_item ['delivery_fee'];
			$order_info ['delivery_fee'] = $deal_item ['delivery_fee'];
			$order_info ['deal_price'] = $deal_item ['price'];
			$order_info ['support_memo'] = $memo;
			$order_info ['payment_id'] = $payment_id;
			// $order_info['bank_id'] = strim($_REQUEST['bank_id']);
			
			$max_credit = $order_info ['total_price'] < $user ['money'] ? $order_info ['total_price'] : $user ['money'];
			if ($max_credit < 0)
			{
				$max_credit = 0;
			}
			$credit = $credit > $max_credit ? $max_credit : $credit;
			
			$order_info ['credit_pay'] = 0;
			$order_info ['online_pay'] = 0;
			$order_info ['deal_name'] = $deal_info ['name'];
			$order_info ['order_status'] = 0;
			$order_info ['create_time'] = NOW_TIME;
			
			if ($consignee_id > 0)
			{
				$consignee_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "user_consignee where id = " . $consignee_id . " and user_id = " . intval ( $user ['id'] ) );
				if (! $consignee_info && $deal_item ['is_delivery'] == 1)
				{
					$root ['info'] = "请选择配送方式";
					// showErr("请选择配送方式",0,get_gopreview());
				}
				$order_info ['consignee'] = $consignee_info ['consignee'];
				$order_info ['zip'] = $consignee_info ['zip'];
				$order_info ['address'] = $consignee_info ['address'];
				$order_info ['province'] = $consignee_info ['province'];
				$order_info ['city'] = $consignee_info ['city'];
				$order_info ['mobile'] = $consignee_info ['mobile'];
			}
			$order_info ['is_success'] = $deal_info ['is_success'];
			$GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_order", $order_info );
			$root ['order_info'] = $order_info;
			$order_id = $GLOBALS ['db']->insert_id ();
			if ($order_id > 0)
			{
				if ($credit > 0)
				{
					require_once APP_ROOT_PATH . "system/libs/user.php";
					$re = modify_account ( array (
							"money" => "-" . $credit 
					), intval ( $user ['id'] ),  $deal_info ['name'] . "支付" );
					if ($re)
					{
						$GLOBALS ['db']->query ( "update  " . DB_PREFIX . "deal_order set credit_pay=" . $credit . " where id=" . $order_id );
					} else
					{
						$data ['info'] = "发生异常";
						output ( $data );
					}
				}
				
				$root ['response_code'] = 1;
				$root ['info'] = "下单成功";
				$root ['user_login_status'] = 1;
				$root ['order_id'] = $order_id;
				$root ['response_code'] = 1;
			} else
			{
				$root ['info'] = "下单失败";
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