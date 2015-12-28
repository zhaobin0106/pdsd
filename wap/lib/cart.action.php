<?php
class cartModule {
	public function index() {
		if (! $GLOBALS ['user_info']) {
			app_redirect ( url_wap ( "user#login" ) );
		}
		// (普通众筹)支持之前需要用户绑定手机号
/* 		if (! $GLOBALS ['user_info'] ['mobile']) {
			app_redirect ( url_wap ( "user#user_bind_mobile", array (
					"cid" => intval ( $_REQUEST ['id'] ) 
			) ) );
		} */
		$GLOBALS ['tmpl']->assign ( "user_info", $GLOBALS ['user_info'] );
		
		$id = intval ( $_REQUEST ['id'] );
		$type = intval ( $_REQUEST ['type'] );
		$lixing = intval ( $_REQUEST ['lixing'] );
		if ($lixing == 2) {
			
			$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item where id = " . $id );
			if (! $deal_item) {
				app_redirect ( url_wap ( "index" ) );
			} elseif (($deal_item ['support_count'] + $deal_item ['virtual_person']) >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
				app_redirect ( url_wap ( "fore#show", array (
						"id" => $deal_item ['fore_id'] 
				) ) );
			}
			$count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."fore_item_order where  fore_id = " . $deal_item ['fore_id']." and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ));
			if($count >= $deal_item['enroll']){
				showErr ( "已达到报名上限", 0 ,url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ));
									
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['fore_id'] );
			$deal_info = cache_fore_extra ( $deal_info );
			init_fore_page_wap ( $deal_info );
			
			if (! $deal_info) {
				app_redirect ( url_wap ( "index" ) );
			}
			
			if ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
				app_redirect ( url_wap ( "fore#show", array (
						"id" => $deal_item ['fore_id'] 
				) ) );
			}
			$deal_item ['consigee_url'] = url_wap ( "settings#add_consignee" );
			
			$deal_item ['price_format'] = number_price_format ( $deal_item ['price'] );
			$deal_item ['delivery_fee_format'] = number_price_format ( $deal_item ['delivery_fee'] );
			$deal_item ['total_price'] = $deal_item ['price'];
			$deal_item ['total_price_format'] = number_price_format ( $deal_item ['total_price'] );
			$deal_info ['percent'] = round ( $deal_info ['support_amount'] / $deal_info ['limit_price'] * 100 );
			$deal_info ['remain_days'] = ceil ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
			
			$GLOBALS ['tmpl']->assign ( "deal_item", $deal_item );
			
			$shouhuolist = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "fore_item_shouhuo where is_show = 1 and fore_item_id =" . $id . " order by sort desc" );
			
			$GLOBALS ['tmpl']->assign ( "shouhuolist", $shouhuolist );
			
			$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
			if ($consignee_list)
				$GLOBALS ['tmpl']->assign ( "consignee_list", $consignee_list );
			else {
				$region_lv2 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "region_conf where region_level = 2 order by py asc" ); // 二级地址
				$GLOBALS ['tmpl']->assign ( "region_lv2", $region_lv2 );
			}
			
			$payment_list = get_payment_list ( "wap" );
			
			$GLOBALS ['tmpl']->assign ( "payment_list", $payment_list );
			$GLOBALS ['tmpl']->assign ( "type", $type );
			$GLOBALS ['tmpl']->assign ( "lixing", $lixing );
			
			$GLOBALS ['tmpl']->display ( "cart_index.html" );
		} else {
			if ($type == 2) {
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo where id = " . $id );
			} else {
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item where id = " . $id );
			}
			if (! $deal_item) {
				app_redirect ( url_wap ( "index" ) );
			} elseif (($deal_item ['support_count'] + $deal_item ['virtual_person']) >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
				app_redirect ( url_wap ( "deal#show", array (
						"id" => $deal_item ['deal_id'] 
				) ) );
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['deal_id'] );
			$deal_info = cache_deal_extra ( $deal_info );
			init_deal_page_wap ( $deal_info );
			
			if (! $deal_info) {
				app_redirect ( url_wap ( "index" ) );
			} elseif ($type != 2) {
				if ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url_wap ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
			}
			$deal_item ['consigee_url'] = url_wap ( "settings#add_consignee" );
			
			$deal_item ['price_format'] = number_price_format ( $deal_item ['price'] );
			$deal_item ['delivery_fee_format'] = number_price_format ( $deal_item ['delivery_fee'] );
			$deal_item ['total_price'] = $deal_item ['price'];
			$deal_item ['total_price_format'] = number_price_format ( $deal_item ['total_price'] );
			$deal_info ['percent'] = round ( $deal_info ['support_amount'] / $deal_info ['limit_price'] * 100 );
			$deal_info ['remain_days'] = ceil ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
			
			$GLOBALS ['tmpl']->assign ( "deal_item", $deal_item );
			if ($type == 2) {
				$shouhuolist = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where is_show = 1 and deal_xianhuo_id =" . $id . " order by sort desc" );
			} else {
				$shouhuolist = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_item_shouhuo where is_show = 1 and deal_item_id =" . $id . " order by sort desc" );
			}
			$GLOBALS ['tmpl']->assign ( "shouhuolist", $shouhuolist );
			
			$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
			if ($consignee_list)
				$GLOBALS ['tmpl']->assign ( "consignee_list", $consignee_list );
			else {
				$region_lv2 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "region_conf where region_level = 2 order by py asc" ); // 二级地址
				$GLOBALS ['tmpl']->assign ( "region_lv2", $region_lv2 );
			}
			
			$payment_list = get_payment_list ( "wap" );
			
			$GLOBALS ['tmpl']->assign ( "payment_list", $payment_list );
			$GLOBALS ['tmpl']->assign ( "type", $type );
			$GLOBALS ['tmpl']->display ( "cart_index.html" );
		}
	}
	public function get_kuaidi() {
		$id = intval ( $_REQUEST ['id'] );
		$shouhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item_shouhuo where id =" . $id );
		ajax_return ( $shouhuo );
	}
	public function get_kuai_di() {
		$id = intval ( $_REQUEST ['id'] );
		$type = intval ( ($_REQUEST ['type']) );
		if ($type == 2) {
			$shouhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where id =" . $id );
		} else {
			$shouhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item_shouhuo where id =" . $id );
		}
		ajax_return ( $shouhuo );
	}
	public function go_pay() {
		if (! $GLOBALS ['user_info']) {
			app_redirect ( url_wap ( "user#login" ) );
		}
		
		$id = intval ( $_REQUEST ['id'] );
		$consignee_id = intval ( $_REQUEST ['consignee_id'] );
		$credit = doubleval ( $_REQUEST ['credit'] );
		$kuaidi_id = intval ( $_REQUEST ['kuaidi_id'] );
		$type = intval ( $_REQUEST ['type'] );
		
		$memo = strim ( $_REQUEST ['memo'] );
		$payment_id = intval ( $_REQUEST ['payment'] );
		$lixing = intval ( $_REQUEST ['lixing'] );
		$payment_id = intval ( $_REQUEST ['payment'] );
		if (! $_REQUEST ['kuaidi_id']) {
			showErr ( "请选择配送方式", 0, get_gopreview_wap () );
		}
		if ($lixing == 2) {
			
			$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item where id = " . $id );
			
			if (! $deal_item) {
				app_redirect ( url_wap ( "index" ) );
			} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
				app_redirect ( url_wap ( "fore#show", array (
						"id" => $deal_item ['fore_id'] 
				) ) );
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['fore_id'] );
			if (! $deal_info) {
				app_redirect ( url_wap ( "index" ) );
			}
			if ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
				app_redirect ( url_wap ( "fore#show", array (
						"id" => $deal_item ['fore_id'] 
				) ) );
			}
			
			$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item_shouhuo where id = " . $kuaidi_id );
			$kuaidi_info ['kuaidi_price'] = $kuaidi_info ['kuaidi_jiage'];
			if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
				showErr ( "请选择收货地址", 0, get_gopreview_wap () );
			}
			
			$order_info ['fore_id'] = $deal_info ['id'];
			
			$order_info ['fore_item_id'] = $deal_item ['id'];
			$order_info ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
			$order_info ['user_name'] = $GLOBALS ['user_info'] ['user_name'];
			$order_info ['total_price'] = $deal_item ['price'] + $kuaidi_info ['kuaidi_price'];
			$order_info ['delivery_fee'] = $deal_item ['delivery_fee'];
			$order_info ['deal_price'] = $deal_item ['price'];
			$order_info ['support_memo'] = $memo;
			$order_info ['payment_id'] = $payment_id;
			$order_info ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
			$order_info ['kuaidi_id'] = $kuaidi_info ['id'];
			$order_info ['kuaidi_name'] = $kuaidi_info ['kuaidi_name'];
			$order_info ['kuaidi_desc'] = $kuaidi_info ['kuaidi_desc'];
			$order_info ['is_kuaidi'] = $kuaidi_info ['is_kuaidi'];
			$order_info ['dingdanhao'] = to_date ( NOW_TIME, "YmdHis" ) . rand ( 1000, 9999 );
			
			$order_info ['kuaidi_jiage'] = $kuaidi_info ['kuaidi_price'];
			
			$max_credit = $order_info ['total_price'] < $GLOBALS ['user_info'] ['money'] ? $order_info ['total_price'] : $GLOBALS ['user_info'] ['money'];
			$credit = $credit > $max_credit ? $max_credit : $credit;
			
			$order_info ['credit_pay'] = $credit;
			$order_info ['online_pay'] = 0;
			$order_info ['deal_name'] = $deal_info ['name'];
			$order_info ['order_status'] = 0;
			$order_info ['create_time'] = NOW_TIME;
			if ($consignee_id > 0 && $kuaidi_info ['is_kuaidi'] == 1) {
				$consignee_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "user_consignee where id = " . $consignee_id . " and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
				if (! $consignee_info && $kuaidi_info ['is_kuaidi'] == 1) {
					showErr ( "请选择收货地址", 0, get_gopreview_wap () );
				}
				$order_info ['consignee'] = $consignee_info ['consignee'];
				$order_info ['zip'] = $consignee_info ['zip'];
				$order_info ['address'] = $consignee_info ['address'];
				$order_info ['province'] = $consignee_info ['province'];
				$order_info ['city'] = $consignee_info ['city'];
				$order_info ['mobile'] = $consignee_info ['mobile'];
			}
			$order_info ['is_success'] = $deal_info ['is_success'];
			$GLOBALS ['db']->autoExecute ( DB_PREFIX . "fore_item_order", $order_info );
			
			$order_id = $GLOBALS ['db']->insert_id ();
			if ($order_id > 0) {
				if ($order_info ['credit_pay'] > 0) {
					require_once APP_ROOT_PATH . "system/libs/user.php";
					modify_account ( array (
							"money" => "-" . $order_info ['credit_pay'] 
					), intval ( $GLOBALS ['user_info'] ['id'] ), "报名" . $order_info ['deal_name'] . "支付" );
				}
				
				$result = pay_fore_order ( $order_id );
				
				if ($result ['status'] == 0) {
					$money = $result ['money'];
					$payment_notice ['create_time'] = NOW_TIME;
					$payment_notice ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
					$payment_notice ['payment_id'] = $order_info ['payment_id'];
					$payment_notice ['money'] = $money;
					$payment_notice ['order_id'] = $order_id;
					$payment_notice ['memo'] = $order_info ['memo'];
					$payment_notice ['fore_id'] = $order_info ['fore_id'];
					
					$payment_notice ['fore_item_id'] = $order_info ['fore_item_id'];
					
					$payment_notice ['deal_name'] = $order_info ['deal_name'];
					
					do {
						$payment_notice ['notice_sn'] = to_date ( NOW_TIME, "YmdHis" ) . rand ( 100, 999 );
						$GLOBALS ['db']->autoExecute ( DB_PREFIX . "payment_notice", $payment_notice, "INSERT", "", "SILENT" );
						$notice_id = $GLOBALS ['db']->insert_id ();
					} while ( $notice_id == 0 );
					
					app_redirect ( url_wap ( "cart#jump", array (
							"id" => $notice_id 
					) ) );
				} elseif ($result ['status'] == 1) {
					$data ['pay_status'] = 0;
					$data ['pay_info'] = '订单过期.';
					$data ['show_pay_btn'] = 0;
					$GLOBALS ['tmpl']->assign ( 'data', $data );
					$GLOBALS ['tmpl']->assign ( 'type', 'shichi' );
					$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
				} elseif ($result ['status'] == 2) {
					$data ['pay_status'] = 0;
					$data ['pay_info'] = '订单无库存.';
					$data ['show_pay_btn'] = 0;
					$GLOBALS ['tmpl']->assign ( 'data', $data );
					$GLOBALS ['tmpl']->assign ( 'type', 'shichi' );
						
					$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
				} else {
					$data ['pay_status'] = 1;
					$data ['pay_info'] = '订单支付成功.';
					$data ['show_pay_btn'] = 0;
					$GLOBALS ['tmpl']->assign ( 'data', $data );
					$GLOBALS ['tmpl']->assign ( 'type', 'shichi' );
						
					$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
				}
				
				// app_redirect(url_wap("cart#pay_order",array("order_id"=>$order_id)));
			} else {
				showErr ( "下单失败", 0, get_gopreview_wap () );
			}
		} else {
			if ($type == 2) {
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo where id = " . $id );
			} else {
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item where id = " . $id );
			}
			if (! $deal_item) {
				app_redirect ( url_wap ( "index" ) );
			} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
				app_redirect ( url_wap ( "deal#show", array (
						"id" => $deal_item ['deal_id'] 
				) ) );
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['deal_id'] );
			if (! $deal_info) {
				app_redirect ( url_wap ( "index" ) );
			} elseif ($type != 2) {
				if ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url_wap ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
			}
			if ($type == 2) {
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where id = " . $kuaidi_id );
				$kuaidi_info ['kuaidi_price'] = $kuaidi_info ['kuaidi_jiage'];
			} else {
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item_shouhuo where id = " . $kuaidi_id );
			}
			if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
				showErr ( "请选择配送方式", 0, get_gopreview_wap () );
			}
			
			$order_info ['deal_id'] = $deal_info ['id'];
			if ($type == 2) {
				$order_info ['deal_xianhuo_id'] = $deal_item ['id'];
			} else {
				$order_info ['deal_item_id'] = $deal_item ['id'];
			}
			$order_info ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
			$order_info ['user_name'] = $GLOBALS ['user_info'] ['user_name'];
			$order_info ['total_price'] = $deal_item ['price'] + $kuaidi_info ['kuaidi_price'];
			$order_info ['delivery_fee'] = $deal_item ['delivery_fee'];
			$order_info ['deal_price'] = $deal_item ['price'];
			$order_info ['support_memo'] = $memo;
			$order_info ['payment_id'] = $payment_id;
			$order_info ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
			$order_info ['kuaidi_id'] = $kuaidi_info ['id'];
			$order_info ['kuaidi_name'] = $kuaidi_info ['kuaidi_name'];
			$order_info ['kuaidi_desc'] = $kuaidi_info ['kuaidi_desc'];
			$order_info ['is_kuaidi'] = $kuaidi_info ['is_kuaidi'];
			$order_info ['dingdanhao'] = to_date ( NOW_TIME, "YmdHis" ) . rand ( 1000, 9999 );
			
			if ($type == 2) {
				$order_info ['kuaidi_jiage'] = $kuaidi_info ['kuaidi_price'];
			} else {
				$order_info ['kuaidi_price'] = $kuaidi_info ['kuaidi_price'];
			}
			
			$max_credit = $order_info ['total_price'] < $GLOBALS ['user_info'] ['money'] ? $order_info ['total_price'] : $GLOBALS ['user_info'] ['money'];
			$credit = $credit > $max_credit ? $max_credit : $credit;
			
			$order_info ['credit_pay'] = $credit;
			$order_info ['online_pay'] = 0;
			$order_info ['deal_name'] = $deal_info ['name'];
			$order_info ['order_status'] = 0;
			$order_info ['create_time'] = NOW_TIME;
			if ($consignee_id > 0 && $kuaidi_info ['is_kuaidi'] == 1) {
				$consignee_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "user_consignee where id = " . $consignee_id . " and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
				if (! $consignee_info && $kuaidi_info ['is_kuaidi'] == 1) {
					showErr ( "请选择配送方式", 0, get_gopreview_wap () );
				}
				$order_info ['consignee'] = $consignee_info ['consignee'];
				$order_info ['zip'] = $consignee_info ['zip'];
				$order_info ['address'] = $consignee_info ['address'];
				$order_info ['province'] = $consignee_info ['province'];
				$order_info ['city'] = $consignee_info ['city'];
				$order_info ['mobile'] = $consignee_info ['mobile'];
			}
			$order_info ['is_success'] = $deal_info ['is_success'];
			if ($type == 2) {
				$GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_xianhuo_order", $order_info );
			} else {
				$GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_order", $order_info );
			}
			$order_id = $GLOBALS ['db']->insert_id ();
			if ($order_id > 0) {
				if ($order_info ['credit_pay'] > 0) {
					require_once APP_ROOT_PATH . "system/libs/user.php";
					if ($type == 2) {
						modify_account ( array (
								"money" => "-" . $order_info ['credit_pay'] 
						), intval ( $GLOBALS ['user_info'] ['id'] ), "购买" . $order_info ['deal_name'] . "商品支付" );
					} else {
						modify_account ( array (
								"money" => "-" . $order_info ['credit_pay'] 
						), intval ( $GLOBALS ['user_info'] ['id'] ), "支持" . $order_info ['deal_name'] . "项目支付" );
					}
				}
				if ($type == 2) {
					$result = pay_xianhuo_order ( $order_id );
				} else {
					$result = pay_order ( $order_id );
				}
				if ($result ['status'] == 0) {
					$money = $result ['money'];
					$payment_notice ['create_time'] = NOW_TIME;
					$payment_notice ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
					$payment_notice ['payment_id'] = $order_info ['payment_id'];
					$payment_notice ['money'] = $money;
					$payment_notice ['order_id'] = $order_id;
					$payment_notice ['memo'] = $order_info ['memo'];
					$payment_notice ['deal_id'] = $order_info ['deal_id'];
					if ($type == 2) {
						$payment_notice ['deal_xianhuo_id'] = $order_info ['deal_xianhuo_id'];
					} else {
						$payment_notice ['deal_item_id'] = $order_info ['deal_item_id'];
					}
					$payment_notice ['deal_name'] = $order_info ['deal_name'];
					
					do {
						$payment_notice ['notice_sn'] = to_date ( NOW_TIME, "YmdHis" ) . rand ( 100, 999 );
						$GLOBALS ['db']->autoExecute ( DB_PREFIX . "payment_notice", $payment_notice, "INSERT", "", "SILENT" );
						$notice_id = $GLOBALS ['db']->insert_id ();
					} while ( $notice_id == 0 );
					
					app_redirect ( url_wap ( "cart#jump", array (
							"id" => $notice_id 
					) ) );
				} elseif ($result ['status'] == 1) {
					$data ['pay_status'] = 0;
					$data ['pay_info'] = '订单过期.';
					$data ['show_pay_btn'] = 0;
					$GLOBALS ['tmpl']->assign ( 'data', $data );
					if ($type == 2) {
					$GLOBALS ['tmpl']->assign ( 'type', 'xianhuo' );
					}else{
						$GLOBALS ['tmpl']->assign ( 'type', '' );
						
					}
						
					$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
				} elseif ($result ['status'] == 2) {
					$data ['pay_status'] = 0;
					$data ['pay_info'] = '订单无库存.';
					$data ['show_pay_btn'] = 0;
					$GLOBALS ['tmpl']->assign ( 'data', $data );
					
									if ($type == 2) {
					$GLOBALS ['tmpl']->assign ( 'type', 'xianhuo' );
					}else{
						$GLOBALS ['tmpl']->assign ( 'type', '' );
						
					}											
					$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
				} else {
					$data ['pay_status'] = 1;
					$data ['pay_info'] = '订单支付成功.';
					$data ['show_pay_btn'] = 0;
					$GLOBALS ['tmpl']->assign ( 'data', $data );
									if ($type == 2) {
					$GLOBALS ['tmpl']->assign ( 'type', 'xianhuo' );
					}else{
						$GLOBALS ['tmpl']->assign ( 'type', '' );
						
					}											
					$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
				}
				
				// app_redirect(url_wap("cart#pay_order",array("order_id"=>$order_id)));
			} else {
				showErr ( "下单失败", 0, get_gopreview_wap () );
			}
		}
	}
	public function jump() {
		$notice_id = intval ( $_REQUEST ['id'] );
		$notice_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment_notice where id = " . $notice_id . "   and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
		if ($notice_info ['is_paid'] == 1) {
			$data ['pay_status'] = 1;
			$data ['pay_info'] = '已支付.';
			$data ['show_pay_btn'] = 0;
			$GLOBALS ['tmpl']->assign ( 'data', $data );
			$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
		} else {
			$payment_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment where id = " . $notice_info ['payment_id'] );
			$class_name = $payment_info ['class_name'] . "_payment";
			require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
			$o = new $class_name ();
			$pay = $o->get_payment_code ( $notice_id );
			app_redirect ( $pay ['notify_url'] );
		}
	}
	public function wx_jspay() {
		$notice_id = intval ( $_REQUEST ['id'] );
		// $GLOBALS['user_info']['id']=333;
		$notice_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment_notice where id = " . $notice_id . "   and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
		
		if ($notice_info ['is_paid'] == 1) {
			$data ['pay_status'] = 1;
			$data ['pay_info'] = '已支付.';
			$data ['show_pay_btn'] = 0;
			$data ['deal_id'] = $notice_info ['deal_id'];
			$GLOBALS ['tmpl']->assign ( 'data', $data );
			$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
		} else {
			$payment_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment where id = " . $notice_info ['payment_id'] );
			$class_name = $payment_info ['class_name'] . "_payment";
			
			require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
			$o = new $class_name ();
			
			$pay = $o->get_payment_code ( $notice_id );
			// echo $pay['parameters'];
			$GLOBALS ['tmpl']->assign ( 'jsApiParameters', $pay ['parameters'] );
			$notice_info ['pay_status'] = 0;
			$notice_info ['pay_info'] = '未支付.';
			$notice_info ['show_pay_btn'] = 1;
			$notice_info ['deal_id'] = $notice_info ['deal_id'];
			$GLOBALS ['tmpl']->assign ( 'data', $notice_info );
			
			$GLOBALS ['tmpl']->display ( 'pay_wx_jspay.html' );
		}
	}
	public function pay_result() {
		$notice_id = intval ( $_REQUEST ['id'] );
		if (! $notice_id) {
			$data ['pay_status'] = 1;
			$data ['pay_info'] = '支付失败.';
			$data ['show_pay_btn'] = 0;
		} else {
			$notice_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment_notice where id = " . $notice_id . "   and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
			if ($notice_info ['is_paid'] == 1) {
				$data ['pay_status'] = 1;
				$data ['pay_info'] = '支付成功.';
				$data ['show_pay_btn'] = 0;
			} else {
				$data ['pay_status'] = 1;
				$data ['pay_info'] = '支付失败.';
				$data ['show_pay_btn'] = 0;
			}
		}
		$GLOBALS ['tmpl']->assign ( 'data', $data );
		$GLOBALS ['tmpl']->display ( 'pay_order_index.html' );
	}
}

?>