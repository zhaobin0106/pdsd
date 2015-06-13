<?php
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------
require APP_ROOT_PATH . 'app/Lib/shop_lip.php';
class cartModule extends BaseModule {
	// 购物车
	public function index() {
		// links
		$g_links = get_link_by_id ( 14 );
		
		$GLOBALS ['tmpl']->assign ( "g_links", $g_links );
		if (! $GLOBALS ['user_info']) {
			app_redirect ( url ( "user#login" ) );
		}
		// (普通众筹)支持之前需要用户绑定手机号
		if (! $GLOBALS ['user_info'] ['mobile']) {
			showErr ( "您未绑定手机,无法进行众筹", 0, url ( "settings#security", array (
					'method' => 'setting-mobile-box' 
			) ) );
			// app_redirect(url("user#user_bind_mobile",array("cid"=>intval($_REQUEST['id']))));
			// app_redirect(url("settings#security",array('method'=>'setting-mobile-box')));
		}
		
		$id = intval ( $_REQUEST ['id'] );
		$type = intval ( $_REQUEST ['type'] );
		$lixing = $_REQUEST ['lixing'];
		if ($type != 2) {
			if ($lixing != 'fore') {
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item where id = " . $id );
				if (! $deal_item) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					app_redirect ( url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['deal_id'] );
				
				if (! $deal_info) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$deal_info1 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_item where deal_id = " . $deal_item ['deal_id'] );
				foreach ( $deal_info1 as $k => $v ) {
					// 统计所有真实+虚拟（钱）
					$deal_info1 ['total_virtual_price'] += intval ( $v ['price'] * $v ['virtual_person'] + $v ['support_amount'] );
				}
				$deal_info ['support_amount'] = $deal_info1 ['total_virtual_price'];
				$deal_item ['price_format'] = number_price_format ( $deal_item ['price'] );
				$deal_item ['delivery_fee_format'] = number_price_format ( $deal_item ['delivery_fee'] );
				$deal_info ['percent'] = round ( $deal_info ['support_amount'] / $deal_info ['limit_price'] * 100 );
				$deal_info ['remain_days'] = ceil ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
				
				$GLOBALS ['tmpl']->assign ( "deal_item", $deal_item );
				$GLOBALS ['tmpl']->assign ( "deal_info", $deal_info );
				
				if ($deal_info ['seo_title'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_title", $deal_info ['seo_title'] );
				if ($deal_info ['seo_keyword'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_keyword", $deal_info ['seo_keyword'] );
				if ($deal_info ['seo_description'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_description", $deal_info ['seo_description'] );
				$GLOBALS ['tmpl']->assign ( "page_title", $deal_info ['name'] );
				
				$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
				if ($consignee_list)
					$GLOBALS ['tmpl']->assign ( "consignee_list", $consignee_list );
				else {
					$region_lv2 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "region_conf where region_level = 2 order by py asc" ); // 二级地址
					$GLOBALS ['tmpl']->assign ( "region_lv2", $region_lv2 );
				}
				
				$shouhuolist = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_item_shouhuo where is_show = 1 and deal_item_id =" . $id . " order by sort desc" );
				$GLOBALS ['tmpl']->assign ( "shouhuolist", $shouhuolist );
				$GLOBALS ['tmpl']->assign ( "type", $type );
				$GLOBALS ['tmpl']->assign ( "lixing", $lixing );
				
				$GLOBALS ['tmpl']->display ( "cart_index.html" );
			} else {
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item where id = " . $id );
				if (! $deal_item) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					app_redirect ( url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['fore_id'] );
				
				if (! $deal_info) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ) );
				}
				$deal_info1 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_item where deal_id = " . $deal_item ['fore_id'] );
				foreach ( $deal_info1 as $k => $v ) {
					// 统计所有真实+虚拟（钱）
					$deal_info1 ['total_virtual_price'] += intval ( $v ['price'] * $v ['virtual_person'] + $v ['support_amount'] );
				}
				$deal_info ['support_amount'] = $deal_info1 ['total_virtual_price'];
				$deal_item ['price_format'] = number_price_format ( $deal_item ['price'] );
				$deal_item ['delivery_fee_format'] = number_price_format ( $deal_item ['delivery_fee'] );
				$deal_info ['percent'] = round ( $deal_info ['support_amount'] / $deal_info ['limit_price'] * 100 );
				$deal_info ['remain_days'] = ceil ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
				
				$GLOBALS ['tmpl']->assign ( "deal_item", $deal_item );
				$GLOBALS ['tmpl']->assign ( "deal_info", $deal_info );
				
				if ($deal_info ['seo_title'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_title", $deal_info ['seo_title'] );
				if ($deal_info ['seo_keyword'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_keyword", $deal_info ['seo_keyword'] );
				if ($deal_info ['seo_description'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_description", $deal_info ['seo_description'] );
				$GLOBALS ['tmpl']->assign ( "page_title", $deal_info ['name'] );
				
				$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
				if ($consignee_list)
					$GLOBALS ['tmpl']->assign ( "consignee_list", $consignee_list );
				else {
					$region_lv2 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "region_conf where region_level = 2 order by py asc" ); // 二级地址
					$GLOBALS ['tmpl']->assign ( "region_lv2", $region_lv2 );
				}
				
				$shouhuolist = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "fore_item_shouhuo where is_show = 1 and fore_item_id =" . $id . " order by sort desc" );
				$GLOBALS ['tmpl']->assign ( "shouhuolist", $shouhuolist );
				$GLOBALS ['tmpl']->assign ( "type", $type );
				$GLOBALS ['tmpl']->assign ( "lixing", $lixing );
				
				$GLOBALS ['tmpl']->display ( "cart_index.html" );
			}
		} else {
			$deal_xianhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo where id = " . $id );
			if (! $deal_xianhuo) {
				app_redirect ( url ( "index" ) );
			} elseif ($deal_xianhuo ['support_count'] >= $deal_xianhuo ['limit_user'] && $deal_xianhuo ['limit_user'] != 0) {
				app_redirect ( url ( "deal#show", array (
						"id" => $deal_xianhuo ['deal_id'] 
				) ) );
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_xianhuo ['deal_id'] );
			
			if (! $deal_info) {
				app_redirect ( url ( "index" ) );
			}
			
			$deal_info1 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_xianhuo where deal_id = " . $deal_xianhuo ['deal_id'] );
			foreach ( $deal_info1 as $k => $v ) {
				// 统计所有真实+虚拟（钱）
				$deal_info1 ['total_virtual_price'] += intval ( $v ['price'] * $v ['virtual_person'] + $v ['support_amount'] );
			}
			$deal_info ['support_amount'] = $deal_info1 ['total_virtual_price'];
			$deal_xianhuo ['price_format'] = number_price_format ( $deal_xianhuo ['price'] );
			
			$GLOBALS ['tmpl']->assign ( "deal_xianhuo", $deal_xianhuo );
			$GLOBALS ['tmpl']->assign ( "deal_info", $deal_info );
			
			if ($deal_info ['seo_title'] != "")
				$GLOBALS ['tmpl']->assign ( "seo_title", $deal_info ['seo_title'] );
			if ($deal_info ['seo_keyword'] != "")
				$GLOBALS ['tmpl']->assign ( "seo_keyword", $deal_info ['seo_keyword'] );
			if ($deal_info ['seo_description'] != "")
				$GLOBALS ['tmpl']->assign ( "seo_description", $deal_info ['seo_description'] );
			$GLOBALS ['tmpl']->assign ( "page_title", $deal_info ['name'] );
			
			$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
			if ($consignee_list)
				$GLOBALS ['tmpl']->assign ( "consignee_list", $consignee_list );
			else {
				$region_lv2 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "region_conf where region_level = 2 order by py asc" ); // 二级地址
				$GLOBALS ['tmpl']->assign ( "region_lv2", $region_lv2 );
			}
			
			$shouhuolist = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where is_show = 1 and deal_xianhuo_id =" . $id . " order by sort desc" );
			$GLOBALS ['tmpl']->assign ( "shouhuolist", $shouhuolist );
			$GLOBALS ['tmpl']->assign ( "type", $type );
			$GLOBALS ['tmpl']->assign ( "lixing", $lixing );
			
			$GLOBALS ['tmpl']->display ( "cart_index.html" );
		}
	}
	public function get_kuaidi() {
		$id = $_GET ['id'];
		$type = $_GET ['type'];
		$lixing = $_GET ['lixing'];
		
		if ($type != 2) {
			if ($lixing != 'fore') {
				$shouhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item_shouhuo where id =" . $id );
			} else {
				$shouhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item_shouhuo where id =" . $id );
			}
		} else {
			$shouhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where id =" . $id );
		}
		ajax_return ( $shouhuo );
	}
	public function check() {
		$ajax = intval ( $_REQUEST ['ajax'] );
		
		if (! $GLOBALS ['user_info']) {
			showErr ( "", $ajax, url ( "user#login" ) );
		}
		if (! $_REQUEST['kuaidi_id']){
			showErr ( "请选择配送方式", $ajax );
		}
		$order_type = intval ( $_REQUEST ['order_type'] );
		$lixing = $_REQUEST ['lixing'];
		if ($order_type != 2) {
			if ($lixing == 'fore') {
				
				$id = intval ( $_REQUEST ['id'] );
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item where id = " . $id );
				if (! $deal_item) {
					showErr ( "", $ajax, url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					showErr ( "", $ajax, url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['fore_id'] );
				if (! $deal_info) {
					showErr ( "", $ajax, url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					showErr ( "", $ajax, url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ) );
				}
				$kuaidi_id = intval ( $_REQUEST ['kuaidi'] );
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item_shouhuo where id = " . $kuaidi_id );
				if ($kuaidi_info ['is_kuaidi'] == 1) {
					$consignee_id = intval ( $_REQUEST ['consignee_id'] );
					if ($consignee_id == 0) {
						$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
						if ($consignee_list) {
							showErr ( "请选择收货地址", $ajax );
						} else {
							$consignee = strim ( $_REQUEST ['consignee'] );
							$province = strim ( $_REQUEST ['province'] );
							$city = strim ( $_REQUEST ['city'] );
							$address = strim ( $_REQUEST ['address'] );
							$zip = strim ( $_REQUEST ['zip'] );
							$mobile = strim ( $_REQUEST ['mobile'] );
							if ($consignee == "") {
								showErr ( "请填写收货人姓名", $ajax, "" );
							}
							if ($province == "") {
								showErr ( "请选择省份", $ajax, "" );
							}
							if ($city == "") {
								showErr ( "请选择城市", $ajax, "" );
							}
							if ($address == "") {
								showErr ( "请填写详细地址", $ajax, "" );
							}
							if (! check_postcode ( $zip )) {
								showErr ( "请填写正确的邮编", $ajax, "" );
							}
							if ($mobile == "") {
								showErr ( "请填写收货人手机号码", $ajax, "" );
							}
							if (! check_mobile ( $mobile )) {
								showErr ( "请填写正确的手机号码", $ajax, "" );
							}
							
							$data = array ();
							$data ['consignee'] = $consignee;
							$data ['province'] = $province;
							$data ['city'] = $city;
							$data ['address'] = $address;
							$data ['zip'] = $zip;
							$data ['mobile'] = $mobile;
							$data ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
							$GLOBALS ['db']->autoExecute ( DB_PREFIX . "user_consignee", $data );
							$consignee_id = $GLOBALS ['db']->insert_id ();
						}
					}
				}
				
				if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
					showErr ( "请选择收货地址", $ajax, "" );
				} else {
					$memo = strim ( $_REQUEST ['memo'] );
					if ($memo != "" && $memo != "在此填写关于回报内容的具体选择或者任何你想告诉项目发起人的话")
						es_session::set ( "cart_memo_" . intval ( $id ), $memo );
					
					if ($kuaidi_info ['is_kuaidi'] == 0)
						showSuccess ( "", $ajax, url ( "cart#pay", array (
								"id" => $id,
								"kuaidi" => $kuaidi_id,
								"order_type" => $order_type,
								"lixing" => $lixing 
						) ) );
					else
						showSuccess ( "", $ajax, url ( "cart#pay", array (
								"id" => $id,
								"kuaidi" => $kuaidi_id,
								"did" => $consignee_id,
								"order_type" => $order_type,
								"lixing" => $lixing 
						) ) );
				}
			} else {
				$id = intval ( $_REQUEST ['id'] );
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item where id = " . $id );
				if (! $deal_item) {
					showErr ( "", $ajax, url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					showErr ( "", $ajax, url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['deal_id'] );
				if (! $deal_info) {
					showErr ( "", $ajax, url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					showErr ( "", $ajax, url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$kuaidi_id = intval ( $_REQUEST ['kuaidi'] );
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item_shouhuo where id = " . $kuaidi_id );
				if ($kuaidi_info ['is_kuaidi'] == 1) {
					$consignee_id = intval ( $_REQUEST ['consignee_id'] );
					if ($consignee_id == 0) {
						$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
						if ($consignee_list) {
							showErr ( "请选择收货地址", $ajax );
						} else {
							$consignee = strim ( $_REQUEST ['consignee'] );
							$province = strim ( $_REQUEST ['province'] );
							$city = strim ( $_REQUEST ['city'] );
							$address = strim ( $_REQUEST ['address'] );
							$zip = strim ( $_REQUEST ['zip'] );
							$mobile = strim ( $_REQUEST ['mobile'] );
							if ($consignee == "") {
								showErr ( "请填写收货人姓名", $ajax, "" );
							}
							if ($province == "") {
								showErr ( "请选择省份", $ajax, "" );
							}
							if ($city == "") {
								showErr ( "请选择城市", $ajax, "" );
							}
							if ($address == "") {
								showErr ( "请填写详细地址", $ajax, "" );
							}
							if (! check_postcode ( $zip )) {
								showErr ( "请填写正确的邮编", $ajax, "" );
							}
							if ($mobile == "") {
								showErr ( "请填写收货人手机号码", $ajax, "" );
							}
							if (! check_mobile ( $mobile )) {
								showErr ( "请填写正确的手机号码", $ajax, "" );
							}
							
							$data = array ();
							$data ['consignee'] = $consignee;
							$data ['province'] = $province;
							$data ['city'] = $city;
							$data ['address'] = $address;
							$data ['zip'] = $zip;
							$data ['mobile'] = $mobile;
							$data ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
							$GLOBALS ['db']->autoExecute ( DB_PREFIX . "user_consignee", $data );
							$consignee_id = $GLOBALS ['db']->insert_id ();
						}
					}
				}
				
				if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
					showErr ( "请选择收货地址", $ajax, "" );
				} else {
					$memo = strim ( $_REQUEST ['memo'] );
					if ($memo != "" && $memo != "在此填写关于回报内容的具体选择或者任何你想告诉项目发起人的话")
						es_session::set ( "cart_memo_" . intval ( $id ), $memo );
					
					if ($kuaidi_info ['is_kuaidi'] == 0)
						showSuccess ( "", $ajax, url ( "cart#pay", array (
								"id" => $id,
								"kuaidi" => $kuaidi_id,
								"order_type" => $order_type,
								"lixing" => $lixing 
						) ) );
					else
						showSuccess ( "", $ajax, url ( "cart#pay", array (
								"id" => $id,
								"kuaidi" => $kuaidi_id,
								"did" => $consignee_id,
								"order_type" => $order_type,
								"lixing" => $lixing 
						) ) );
				}
			}
		} else {
			$id = intval ( $_REQUEST ['id'] );
			$deal_xianhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo where id = " . $id );
			if (! $deal_xianhuo) {
				showErr ( "", $ajax, url ( "index" ) );
			} elseif ($deal_xianhuo ['support_count'] >= $deal_xianhuo ['limit_user'] && $deal_xianhuo ['limit_user'] != 0) {
				showErr ( "", $ajax, url ( "deal#show", array (
						"id" => $deal_xianhuo ['deal_id'] 
				) ) );
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where id = " . $deal_xianhuo ['deal_id'] );
			if (! $deal_info) {
				showErr ( "", $ajax, url ( "index" ) );
			}
			
			$kuaidi_id = intval ( $_REQUEST ['kuaidi'] );
			$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where id = " . $kuaidi_id );
			if ($kuaidi_info ['is_kuaidi'] == 1) {
				$consignee_id = intval ( $_REQUEST ['consignee_id'] );
				if ($consignee_id == 0) {
					$consignee_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user_consignee where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
					if ($consignee_list) {
						showErr ( "请选择收货地址", $ajax );
					} else {
						$consignee = strim ( $_REQUEST ['consignee'] );
						$province = strim ( $_REQUEST ['province'] );
						$city = strim ( $_REQUEST ['city'] );
						$address = strim ( $_REQUEST ['address'] );
						$zip = strim ( $_REQUEST ['zip'] );
						$mobile = strim ( $_REQUEST ['mobile'] );
						if ($consignee == "") {
							showErr ( "请填写收货人姓名", $ajax, "" );
						}
						if ($province == "") {
							showErr ( "请选择省份", $ajax, "" );
						}
						if ($city == "") {
							showErr ( "请选择城市", $ajax, "" );
						}
						if ($address == "") {
							showErr ( "请填写详细地址", $ajax, "" );
						}
						if (! check_postcode ( $zip )) {
							showErr ( "请填写正确的邮编", $ajax, "" );
						}
						if ($mobile == "") {
							showErr ( "请填写收货人手机号码", $ajax, "" );
						}
						if (! check_mobile ( $mobile )) {
							showErr ( "请填写正确的手机号码", $ajax, "" );
						}
						
						$data = array ();
						$data ['consignee'] = $consignee;
						$data ['province'] = $province;
						$data ['city'] = $city;
						$data ['address'] = $address;
						$data ['zip'] = $zip;
						$data ['mobile'] = $mobile;
						$data ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
						$GLOBALS ['db']->autoExecute ( DB_PREFIX . "user_consignee", $data );
						$consignee_id = $GLOBALS ['db']->insert_id ();
					}
				}
			}
			if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
				showErr ( "请选择收货地址", $ajax, "" );
			} else {
				$memo = strim ( $_REQUEST ['memo'] );
				
				if ($memo != "" && $memo != "在此填写关于回报内容的具体选择或者任何你想告诉项目发起人的话")
					es_session::set ( "cart_memo_" . intval ( $id ), $memo );
				
				if ($kuaidi_info ['is_kuaidi'] == 0)
					showSuccess ( "", $ajax, url ( "cart#pay", array (
							"id" => $id,
							"kuaidi" => $kuaidi_id,
							"order_type" => $order_type,
							"lixing" => $lixing 
					) ) );
				else
					
					showSuccess ( "", $ajax, url ( "cart#pay", array (
							"id" => $id,
							"kuaidi" => $kuaidi_id,
							"did" => $consignee_id,
							"order_type" => $order_type,
							"lixing" => $lixing 
					) ) );
			}
		}
	}
	public function pay() {
		if (! $GLOBALS ['user_info']) {
			app_redirect ( url ( "user#login" ) );
		}
		$order_type = intval ( $_REQUEST ['order_type'] );
		$lixing = $_REQUEST ['lixing'];
		if ($order_type != 2) {
			if ($lixing == 'fore') {
				$id = intval ( $_REQUEST ['id'] );
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item where id = " . $id );
				if (! $deal_item) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					app_redirect ( url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['fore_id'] );
				if (! $deal_info) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ) );
				}
				$kuaidi_id = intval ( $_REQUEST ['kuaidi'] );
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item_shouhuo where id = " . $kuaidi_id );
				$deal_item ['price_format'] = number_price_format ( $deal_item ['price'] );
				$deal_item ['delivery_fee_format'] = number_price_format ( $kuaidi_info ['kuaidi_jiage'] );
				$deal_item ['total_price'] = $deal_item ['price'] + $kuaidi_info ['kuaidi_jiage'];
				$deal_item ['total_price_format'] = number_price_format ( $deal_item ['total_price'] );
				$deal_info ['percent'] = round ( $deal_info ['support_amount'] / $deal_info ['limit_price'] * 100 );
				$deal_info ['remain_days'] = ceil ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
				
				$GLOBALS ['tmpl']->assign ( "deal_item", $deal_item );
				$GLOBALS ['tmpl']->assign ( "deal_info", $deal_info );
				$GLOBALS ['tmpl']->assign ( "kuaidi_info", $kuaidi_info );
				
				if ($deal_info ['seo_title'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_title", $deal_info ['seo_title'] );
				if ($deal_info ['seo_keyword'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_keyword", $deal_info ['seo_keyword'] );
				if ($deal_info ['seo_description'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_description", $deal_info ['seo_description'] );
				$GLOBALS ['tmpl']->assign ( "page_title", $deal_info ['name'] );
				
				$memo = es_session::get ( "cart_memo_" . $id );
				$consignee_id = intval ( $_REQUEST ['did'] );
				$GLOBALS ['tmpl']->assign ( "memo", $memo );
				$GLOBALS ['tmpl']->assign ( "consignee_id", $consignee_id );
				
				$payment_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "payment where is_effect = 1 and online_pay=1  order by sort asc " );
				$payment_html = "";
				foreach ( $payment_list as $k => $v ) {
					$class_name = $v ['class_name'] . "_payment";
					require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
					$o = new $class_name ();
					$payment_html .= "<div>" . $o->get_display_code () . "<div class='blank'></div></div>";
				}
				$GLOBALS ['tmpl']->assign ( "payment_html", $payment_html );
			} else {
				$id = intval ( $_REQUEST ['id'] );
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item where id = " . $id );
				if (! $deal_item) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					app_redirect ( url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['deal_id'] );
				if (! $deal_info) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$kuaidi_id = intval ( $_REQUEST ['kuaidi'] );
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item_shouhuo where id = " . $kuaidi_id );
				$deal_item ['price_format'] = number_price_format ( $deal_item ['price'] );
				$deal_item ['delivery_fee_format'] = number_price_format ( $kuaidi_info ['kuaidi_price'] );
				$deal_item ['total_price'] = $deal_item ['price'] + $kuaidi_info ['kuaidi_price'];
				$deal_item ['total_price_format'] = number_price_format ( $deal_item ['total_price'] );
				$deal_info ['percent'] = round ( $deal_info ['support_amount'] / $deal_info ['limit_price'] * 100 );
				$deal_info ['remain_days'] = ceil ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
				
				$GLOBALS ['tmpl']->assign ( "deal_item", $deal_item );
				$GLOBALS ['tmpl']->assign ( "deal_info", $deal_info );
				$GLOBALS ['tmpl']->assign ( "kuaidi_info", $kuaidi_info );
				
				if ($deal_info ['seo_title'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_title", $deal_info ['seo_title'] );
				if ($deal_info ['seo_keyword'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_keyword", $deal_info ['seo_keyword'] );
				if ($deal_info ['seo_description'] != "")
					$GLOBALS ['tmpl']->assign ( "seo_description", $deal_info ['seo_description'] );
				$GLOBALS ['tmpl']->assign ( "page_title", $deal_info ['name'] );
				
				$memo = es_session::get ( "cart_memo_" . $id );
				$consignee_id = intval ( $_REQUEST ['did'] );
				$GLOBALS ['tmpl']->assign ( "memo", $memo );
				$GLOBALS ['tmpl']->assign ( "consignee_id", $consignee_id );
				
				$payment_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "payment where is_effect = 1 and online_pay=1  order by sort asc " );
				$payment_html = "";
				foreach ( $payment_list as $k => $v ) {
					$class_name = $v ['class_name'] . "_payment";
					require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
					$o = new $class_name ();
					$payment_html .= "<div>" . $o->get_display_code () . "<div class='blank'></div></div>";
				}
				$GLOBALS ['tmpl']->assign ( "payment_html", $payment_html );
			}
		} else {
			
			$id = intval ( $_REQUEST ['id'] );
			$deal_xianhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo where id = " . $id );
			if (! $deal_xianhuo) {
				app_redirect ( url ( "index" ) );
			} elseif ($deal_xianhuo ['support_count'] >= $deal_xianhuo ['limit_user'] && $deal_xianhuo ['limit_user'] != 0) {
				app_redirect ( url ( "deal#show", array (
						"id" => $deal_xianhuo ['deal_id'] 
				) ) );
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where id = " . $deal_xianhuo ['deal_id'] );
			if (! $deal_info) {
				app_redirect ( url ( "index" ) );
			}
			
			$kuaidi_id = intval ( $_REQUEST ['kuaidi'] );
			$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where id = " . $kuaidi_id );
			$deal_xianhuo ['price_format'] = number_price_format ( $deal_xianhuo ['price'] );
			$deal_xianhuo ['delivery_fee_format'] = number_price_format ( $kuaidi_info ['kuaidi_pjiage'] );
			$deal_xianhuo ['total_price'] = $deal_xianhuo ['price'] + $kuaidi_info ['kuaidi_jiage'];
			$deal_xianhuo ['total_price_format'] = number_price_format ( $deal_xianhuo ['total_price'] );
			$deal_info ['percent'] = round ( $deal_info ['support_amount'] / $deal_info ['limit_price'] * 100 );
			$deal_info ['remain_days'] = ceil ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
			
			$GLOBALS ['tmpl']->assign ( "deal_xianhuo", $deal_xianhuo );
			$GLOBALS ['tmpl']->assign ( "deal_info", $deal_info );
			$GLOBALS ['tmpl']->assign ( "kuaidi_info", $kuaidi_info );
			
			if ($deal_info ['seo_title'] != "")
				$GLOBALS ['tmpl']->assign ( "seo_title", $deal_info ['seo_title'] );
			if ($deal_info ['seo_keyword'] != "")
				$GLOBALS ['tmpl']->assign ( "seo_keyword", $deal_info ['seo_keyword'] );
			if ($deal_info ['seo_description'] != "")
				$GLOBALS ['tmpl']->assign ( "seo_description", $deal_info ['seo_description'] );
			$GLOBALS ['tmpl']->assign ( "page_title", $deal_info ['name'] );
			
			$memo = es_session::get ( "cart_memo_" . $id );
			$consignee_id = intval ( $_REQUEST ['did'] );
			$GLOBALS ['tmpl']->assign ( "memo", $memo );
			$GLOBALS ['tmpl']->assign ( "consignee_id", $consignee_id );
			
			$payment_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "payment where is_effect = 1 and online_pay=1  order by sort asc " );
			$payment_html = "";
			foreach ( $payment_list as $k => $v ) {
				$class_name = $v ['class_name'] . "_payment";
				require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
				$o = new $class_name ();
				$payment_html .= "<div>" . $o->get_display_code () . "<div class='blank'></div></div>";
			}
			$GLOBALS ['tmpl']->assign ( "payment_html", $payment_html );
		}
		$GLOBALS ['tmpl']->assign ( "order_type", $order_type );
		$GLOBALS ['tmpl']->assign ( "lixing", $lixing );
		
		$GLOBALS ['tmpl']->display ( "cart_pay.html" );
	}
	public function go_pay() {
		if (! $GLOBALS ['user_info']) {
			app_redirect ( url ( "user#login" ) );
		}
		$order_type = intval ( $_REQUEST ['order_type'] );
		$lixing = $_REQUEST ['lixing'];
		if ($order_type != 2) {
			if ($lixing == 'fore') {
				
				$id = intval ( $_REQUEST ['id'] );
				$consignee_id = intval ( $_REQUEST ['consignee_id'] );
				$credit = doubleval ( $_REQUEST ['credit'] );
				$kuaidi_id = intval ( $_REQUEST ['kuaidi_id'] );
				
				$memo = strim ( $_REQUEST ['memo'] );
				$payment_id = intval ( $_REQUEST ['payment'] );
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item where id = " . $id );
				if (! $deal_item) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					app_redirect ( url ( "fore#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['fore_id'] );
				if (! $deal_info) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url ( "fore#show", array (
							"id" => $deal_item ['fore_id'] 
					) ) );
				}
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "fore_item_shouhuo where id = " . $kuaidi_id );
				
				if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
					showErr ( "请选择配送方式", 0, get_gopreview () );
				}
				$order_info ['fore_id'] = $deal_info ['id'];
				$order_info ['fore_item_id'] = $deal_item ['id'];
				$order_info ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
				$order_info ['user_name'] = $GLOBALS ['user_info'] ['user_name'];
				$order_info ['total_price'] = $deal_item ['price'] + $kuaidi_info ['kuaidi_jiage'];
				$order_info ['delivery_fee'] = $deal_item ['delivery_fee'];
				$order_info ['deal_price'] = $deal_item ['price'];
				$order_info ['support_memo'] = $memo;
				$order_info ['payment_id'] = $payment_id;
				$order_info ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
				$order_info ['kuaidi_id'] = $kuaidi_info ['id'];
				$order_info ['kuaidi_name'] = $kuaidi_info ['kuaidi_name'];
				$order_info ['kuaidi_desc'] = $kuaidi_info ['kuaidi_desc'];
				$order_info ['is_kuaidi'] = $kuaidi_info ['is_kuaidi'];
				$order_info ['kuaidi_jiage'] = $kuaidi_info ['kuaidi_jiage'];
				$order_info ['dingdanhao'] = to_date ( NOW_TIME, "YmdHis" ) . rand ( 1000, 9999 );
				
				$max_credit = $order_info ['total_price'] < $GLOBALS ['user_info'] ['money'] ? $order_info ['total_price'] : $GLOBALS ['user_info'] ['money'];
				if ($max_credit < 0) {
					$max_credit = 0;
				}
				$credit = $credit > $max_credit ? $max_credit : $credit;
				
				$order_info ['credit_pay'] = 0;
				$order_info ['online_pay'] = 0;
				$order_info ['deal_name'] = $deal_info ['name'];
				$order_info ['order_status'] = 0;
				$order_info ['create_time'] = NOW_TIME;
				if ($consignee_id > 0) {
					$consignee_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "user_consignee where id = " . $consignee_id . " and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
					if (! $consignee_info && $kuaidi_info ['is_kuaidi'] == 1) {
						showErr ( "请选择配送方式", 0, get_gopreview () );
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
					if ($credit > 0) {
						
						require_once APP_ROOT_PATH . "system/libs/user.php";
						$re = modify_account ( array (
								"money" => "-" . $credit 
						), intval ( $GLOBALS ['user_info'] ['id'] ), "报名" . $deal_info ['name'] . "支付" );
						if ($re) {
							$GLOBALS ['db']->query ( "update  " . DB_PREFIX . "fore_item_order set credit_pay=" . $credit . " where id=" . $order_id );
						}
					}
					$result = pay_fore_order ( $order_id );
					if ($result ['status'] == 0) {
						$money = $result ['money'];
						$payment_notice ['create_time'] = NOW_TIME;
						$payment_notice ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
						$payment_notice ['payment_id'] = $payment_id;
						$payment_notice ['money'] = $money;
						$payment_notice ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
						$payment_notice ['order_id'] = $order_id;
						$payment_notice ['memo'] = $memo;
						$payment_notice ['fore_id'] = $deal_info ['id'];
						$payment_notice ['fore_item_id'] = $deal_item ['id'];
						$payment_notice ['deal_name'] = $deal_info ['name'];
						
						do {
							$payment_notice ['notice_sn'] = to_date ( NOW_TIME, "Ymd" ) . rand ( 100, 999 );
							$GLOBALS ['db']->autoExecute ( DB_PREFIX . "payment_notice", $payment_notice, "INSERT", "", "SILENT" );
							$notice_id = $GLOBALS ['db']->insert_id ();
						} while ( $notice_id == 0 );
						
						app_redirect ( url ( "cart#jump", array (
								"id" => $notice_id 
						) ) );
					} elseif ($result ['status'] == 1 || $result ['status'] == 2) {
						app_redirect ( url ( "account#credit" ) );
					} else {
						app_redirect ( url ( "account" ) );
					}
				} else {
					showErr ( "下单失败", 0, get_gopreview () );
				}
			} else {
				$id = intval ( $_REQUEST ['id'] );
				$consignee_id = intval ( $_REQUEST ['consignee_id'] );
				$credit = doubleval ( $_REQUEST ['credit'] );
				$kuaidi_id = intval ( $_REQUEST ['kuaidi_id'] );
				
				$memo = strim ( $_REQUEST ['memo'] );
				$payment_id = intval ( $_REQUEST ['payment'] );
				$deal_item = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item where id = " . $id );
				if (! $deal_item) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_item ['support_count'] >= $deal_item ['limit_user'] && $deal_item ['limit_user'] != 0) {
					app_redirect ( url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where is_delete = 0 and is_effect = 1 and id = " . $deal_item ['deal_id'] );
				if (! $deal_info) {
					app_redirect ( url ( "index" ) );
				} elseif ($deal_info ['begin_time'] > NOW_TIME || ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] != 0)) {
					app_redirect ( url ( "deal#show", array (
							"id" => $deal_item ['deal_id'] 
					) ) );
				}
				$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_item_shouhuo where id = " . $kuaidi_id );
				
				if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
					showErr ( "请选择配送方式", 0, get_gopreview () );
				}
				$order_info ['deal_id'] = $deal_info ['id'];
				$order_info ['deal_item_id'] = $deal_item ['id'];
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
				$order_info ['kuaidi_price'] = $kuaidi_info ['kuaidi_price'];
				$order_info ['dingdanhao'] = to_date ( NOW_TIME, "YmdHis" ) . rand ( 1000, 9999 );
				
				$max_credit = $order_info ['total_price'] < $GLOBALS ['user_info'] ['money'] ? $order_info ['total_price'] : $GLOBALS ['user_info'] ['money'];
				if ($max_credit < 0) {
					$max_credit = 0;
				}
				$credit = $credit > $max_credit ? $max_credit : $credit;
				
				$order_info ['credit_pay'] = 0;
				$order_info ['online_pay'] = 0;
				$order_info ['deal_name'] = $deal_info ['name'];
				$order_info ['order_status'] = 0;
				$order_info ['create_time'] = NOW_TIME;
				if ($consignee_id > 0) {
					$consignee_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "user_consignee where id = " . $consignee_id . " and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
					if (! $consignee_info && $kuaidi_info ['is_kuaidi'] == 1) {
						showErr ( "请选择配送方式", 0, get_gopreview () );
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
				
				$order_id = $GLOBALS ['db']->insert_id ();
				if ($order_id > 0) {
					if ($credit > 0) {
						
						require_once APP_ROOT_PATH . "system/libs/user.php";
						$re = modify_account ( array (
								"money" => "-" . $credit 
						), intval ( $GLOBALS ['user_info'] ['id'] ), "支持" . $deal_info ['name'] . "项目支付" );
						if ($re) {
							$GLOBALS ['db']->query ( "update  " . DB_PREFIX . "deal_order set credit_pay=" . $credit . " where id=" . $order_id );
						}
					}
					$result = pay_order ( $order_id );
					if ($result ['status'] == 0) {
						$money = $result ['money'];
						$payment_notice ['create_time'] = NOW_TIME;
						$payment_notice ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
						$payment_notice ['payment_id'] = $payment_id;
						$payment_notice ['money'] = $money;
						$payment_notice ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
						$payment_notice ['order_id'] = $order_id;
						$payment_notice ['memo'] = $memo;
						$payment_notice ['deal_id'] = $deal_info ['id'];
						$payment_notice ['deal_item_id'] = $deal_item ['id'];
						$payment_notice ['deal_name'] = $deal_info ['name'];
						
						do {
							$payment_notice ['notice_sn'] = to_date ( NOW_TIME, "Ymd" ) . rand ( 100, 999 );
							$GLOBALS ['db']->autoExecute ( DB_PREFIX . "payment_notice", $payment_notice, "INSERT", "", "SILENT" );
							$notice_id = $GLOBALS ['db']->insert_id ();
						} while ( $notice_id == 0 );
						
						app_redirect ( url ( "cart#jump", array (
								"id" => $notice_id 
						) ) );
					} elseif ($result ['status'] == 1 || $result ['status'] == 2) {
						app_redirect ( url ( "account#credit" ) );
					} else {
						app_redirect ( url ( "account" ) );
					}
				} else {
					showErr ( "下单失败", 0, get_gopreview () );
				}
			}
		} else {
			$id = intval ( $_REQUEST ['id'] );
			$consignee_id = intval ( $_REQUEST ['consignee_id'] );
			$credit = doubleval ( $_REQUEST ['credit'] );
			$kuaidi_id = intval ( $_REQUEST ['kuaidi_id'] );
			
			$memo = strim ( $_REQUEST ['memo'] );
			$payment_id = intval ( $_REQUEST ['payment'] );
			$deal_xianhuo = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo where id = " . $id );
			if (! $deal_xianhuo) {
				app_redirect ( url ( "index" ) );
			} elseif ($deal_xianhuo ['support_count'] >= $deal_xianhuo ['limit_user'] && $deal_xianhuo ['limit_user'] != 0) {
				app_redirect ( url ( "deal#show", array (
						"id" => $deal_item ['deal_id'] 
				) ) );
			}
			$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where id = " . $deal_xianhuo ['deal_id'] );
			if (! $deal_info) {
				app_redirect ( url ( "index" ) );
			}
			
			$kuaidi_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal_xianhuo_shouhuo where id = " . $kuaidi_id );
			
			if (intval ( $consignee_id ) == 0 && $kuaidi_info ['is_kuaidi'] == 1) {
				showErr ( "请选择配送方式", 0, get_gopreview () );
			}
			$order_info ['deal_id'] = $deal_info ['id'];
			$order_info ['deal_xianhuo_id'] = $deal_xianhuo ['id'];
			$order_info ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
			$order_info ['user_name'] = $GLOBALS ['user_info'] ['user_name'];
			$order_info ['total_price'] = $deal_xianhuo ['price'] + $kuaidi_info ['kuaidi_jiage'];
			$order_info ['delivery_fee'] = $deal_item ['delivery_fee'];
			$order_info ['deal_price'] = $deal_xianhuo ['price'];
			$order_info ['support_memo'] = $memo;
			$order_info ['payment_id'] = $payment_id;
			$order_info ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
			$order_info ['kuaidi_id'] = $kuaidi_info ['id'];
			$order_info ['kuaidi_name'] = $kuaidi_info ['kuaidi_name'];
			$order_info ['kuaidi_desc'] = $kuaidi_info ['kuaidi_desc'];
			$order_info ['is_kuaidi'] = $kuaidi_info ['is_kuaidi'];
			$order_info ['kuaidi_jiage'] = $kuaidi_info ['kuaidi_jiage'];
			$order_info ['dingdanhao'] = to_date ( NOW_TIME, "YmdHis" ) . rand ( 1000, 9999 );
			
			$max_credit = $order_info ['total_price'] < $GLOBALS ['user_info'] ['money'] ? $order_info ['total_price'] : $GLOBALS ['user_info'] ['money'];
			if ($max_credit < 0) {
				$max_credit = 0;
			}
			$credit = $credit > $max_credit ? $max_credit : $credit;
			
			$order_info ['credit_pay'] = 0;
			$order_info ['online_pay'] = 0;
			$order_info ['deal_name'] = $deal_info ['name'];
			$order_info ['order_status'] = 0;
			$order_info ['create_time'] = NOW_TIME;
			if ($consignee_id > 0) {
				$consignee_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "user_consignee where id = " . $consignee_id . " and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
				if (! $consignee_info && $kuaidi_info ['is_kuaidi'] == 1) {
					showErr ( "请选择配送方式", 0, get_gopreview () );
				}
				$order_info ['consignee'] = $consignee_info ['consignee'];
				$order_info ['zip'] = $consignee_info ['zip'];
				$order_info ['address'] = $consignee_info ['address'];
				$order_info ['province'] = $consignee_info ['province'];
				$order_info ['city'] = $consignee_info ['city'];
				$order_info ['mobile'] = $consignee_info ['mobile'];
			}
			$order_info ['is_success'] = $deal_info ['is_success'];
			$GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_xianhuo_order", $order_info );
			
			$order_id = $GLOBALS ['db']->insert_id ();
			if ($order_id > 0) {
				if ($credit > 0) {
					
					require_once APP_ROOT_PATH . "system/libs/user.php";
					$re = modify_account ( array (
							"money" => "-" . $credit 
					), intval ( $GLOBALS ['user_info'] ['id'] ), "购买" . $deal_info ['name'] . "支付" );
					if ($re) {
						$GLOBALS ['db']->query ( "update  " . DB_PREFIX . "deal_xianhuo_order set credit_pay=" . $credit . " where id=" . $order_id );
					}
				}
				$result = pay_xianhuo_order ( $order_id );
				if ($result ['status'] == 0) {
					$money = $result ['money'];
					$payment_notice ['create_time'] = NOW_TIME;
					$payment_notice ['user_id'] = intval ( $GLOBALS ['user_info'] ['id'] );
					$payment_notice ['payment_id'] = $payment_id;
					$payment_notice ['money'] = $money;
					$payment_notice ['bank_id'] = strim ( $_REQUEST ['bank_id'] );
					$payment_notice ['order_id'] = $order_id;
					$payment_notice ['memo'] = $memo;
					$payment_notice ['deal_id'] = $deal_info ['id'];
					$payment_notice ['deal_xianhuo_id'] = $deal_xianhuo ['id'];
					$payment_notice ['deal_name'] = $deal_info ['name'];
					
					do {
						$payment_notice ['notice_sn'] = to_date ( NOW_TIME, "Ymd" ) . rand ( 100, 999 );
						$GLOBALS ['db']->autoExecute ( DB_PREFIX . "payment_notice", $payment_notice, "INSERT", "", "SILENT" );
						$notice_id = $GLOBALS ['db']->insert_id ();
					} while ( $notice_id == 0 );
					
					app_redirect ( url ( "cart#jump", array (
							"id" => $notice_id 
					) ) );
				} elseif ($result ['status'] == 1 || $result ['status'] == 2) {
					app_redirect ( url ( "account#credit" ) );
				} else {
					app_redirect ( url ( "account#xianhuo" ) );
				}
			} else {
				showErr ( "下单失败", 0, get_gopreview () );
			}
		}
	}
	public function jump() {
		if (! $GLOBALS ['user_info'])
			app_redirect ( url ( "user#login" ) );
		
		$notice_id = intval ( $_REQUEST ['id'] );
		$notice_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment_notice where id = " . $notice_id . " and is_paid = 0 and user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
		if (! $notice_info) {
			app_redirect ( url ( "index" ) );
		}
		$payment_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "payment where id = " . $notice_info ['payment_id'] );
		$class_name = $payment_info ['class_name'] . "_payment";
		require_once APP_ROOT_PATH . "system/payment/" . $class_name . ".php";
		$o = new $class_name ();
		
		header ( "Content-Type:text/html; charset=utf-8" );
		echo $o->get_payment_code ( $notice_id );
	}
}
?>