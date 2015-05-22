<?php
/**
 * 股权项目详情页面
 */
require '../system/utils/weixin.php';
class equity_deal_detail
{
	public function index()
	{
		$id = intval ( $GLOBALS ['request'] ['id'] );
		$email = strim ( $GLOBALS ['request'] ['email'] );
		$pwd = strim ( $GLOBALS ['request'] ['pwd'] );
		
		if (! dealIdIsExist ( $id, 1 ))
		{
			$result = responseErrorInfo ( "deal_id参数错误" );
			output ( $result );
		}
		
		$user = user_check ( $email, $pwd );
		$user_id = intval ( $user ['id'] );
		
		get_mortgate (); // 不知道为什么要冻结
		
		$deal_info = formateDealInfo ( $id, $user_id );
		$leader_info = getLeaderInfo ( $id );
		
		$deal_new_info = $this->getNewDeal_info ( $deal_info );
		// $stock_info = $this->getStockAndUnStock ( $deal_info );
		// $history_info = $this->getHistoryInfo ( $deal_info );
		// $plan_info = $this->getPlanInfo ( $deal_info );
		
		$result = responseSuccessInfo ( "项目详情" );
		$result ["deal_info"] = $deal_new_info;
		$result ['leader_info'] = $leader_info;
		// $result ['stock_info'] = $stock_info;
		
		// $result ['history_info'] = $history_info;
		// $result ['plan_info'] = $plan_info;
		
		if ($user_id > 0)
		{
			$is_focus = $GLOBALS ['db']->getOne ( "select  count(*) from " . DB_PREFIX . "deal_focus_log where deal_id = " . $id . " and user_id = " . $user_id );
			$result ['is_focus'] = $is_focus;
		}
		
		$result ['business_url'] = $this->replace_mapi ( url_wap ( "deal#business", array (
				"id" => $id 
		) ) );
		$result ['teams_url'] = $this->replace_mapi ( url_wap ( "deal#teams", array (
				"id" => $id 
		) ) );
		$result ['history_url'] = $this->replace_mapi ( url_wap ( "deal#history", array (
				"id" => $id 
		) ) );
		$result ['plans_url'] = $this->replace_mapi ( url_wap ( "deal#plans", array (
				"id" => $id 
		) ) );
		$url = $this->replace_mapi ( url_wap ( "deal#show", array (
				"id" => $id 
		) ) );
		$result ['normal_url'] = $url;
		if ($GLOBALS ['m_config'] ['wx_appid'] != '' && $GLOBALS ['m_config'] ['wx_secrit'] != '')
		{
			$weixin_1 = new weixin ( $GLOBALS ['m_config'] ['wx_appid'], $GLOBALS ['m_config'] ['wx_secrit'], $url );
			$wx_url = $weixin_1->scope_get_code ();
			$result ['share_url'] = $wx_url;
		}
		output ( $result );
	}
	private function replace_mapi($item)
	{
		return get_domain () . str_replace ( "/mapi", "", $item );
	}
	private function getNewDeal_info($deal_info)
	{
		$deal_new_info = array ();
		
		$deal_new_info ['business_descripe'] = $deal_info ['business_descripe'];
		$deal_new_info ['transfer_share'] = $deal_info ['transfer_share'];
		$deal_new_info ['business_name'] = $deal_info ['business_name'];
		$deal_new_info ['business_address'] = $deal_info ['business_address'];
		$deal_new_info ['business_create_time'] = to_date ( $deal_info ['business_create_time'], 'Y-m-d' );
		$deal_new_info ['business_employee_num'] = $deal_info ['business_employee_num'];
		$deal_new_info ['has_another_project'] = $deal_info ['has_another_project'];
		$deal_new_info ['province'] = $deal_info ['province'];
		$deal_new_info ['city'] = $deal_info ['city'];
		$deal_new_info ['tags'] = $deal_info ['tags'];
		// 项目阶段 0表示未启动 1表示在开发中 2产品已上市或上线，3已经有收入，4已经盈利
		$deal_new_info ['project_step'] = $deal_info ['project_step'];
		
		$deal_new_info ['id'] = $deal_info ['id'];
		$deal_new_info ['name'] = $deal_info ['name'];
		$deal_new_info ['user_name'] = $deal_info ['user_name'];
		$deal_new_info ['user_id'] = $deal_info ['user_id'];
		$deal_new_info ['invote_money'] = doubleval ( $deal_info ['invote_money'] );
		$deal_new_info ['invote_money_formate'] = ($deal_info ['invote_money'] / 10000) . '万';
		$deal_new_info ['gen_num'] = $deal_info ['gen_num'];
		$deal_new_info ['xun_num'] = $deal_info ['xun_num'];
		$deal_new_info ['limit_price'] = $deal_info ['limit_price'];
		$deal_new_info ['limit_price_format'] = ($deal_info ['limit_price'] / 10000) . '万';
		$deal_new_info ['comment_count'] = $deal_info ['comment_count'];
		$deal_new_info ['end_time'] = to_date ( $deal_info ['end_time'] );
		$deal_new_info ['business_pay_type'] = $deal_info ['business_pay_type'];
		$deal_new_info ['source_vedio'] = $deal_info ['source_vedio'];
		$deal_new_info ['vedio'] = $deal_info ['vedio'];
		$deal_new_info ['image'] = get_abs_img_root ( $deal_info ['image'] );
		$deal_new_info ['type'] = $deal_info ['type'];
		$deal_new_info ['remain_days'] = floor ( ($deal_info ['end_time'] - NOW_TIME) / (24 * 3600) );
		$deal_new_info ['person'] = $deal_info ['invote_num'];
		$deal_new_info ['percent'] = round ( ($deal_info ['invote_money'] / $deal_info ['limit_price']) * 100 );
		
		$cate = $GLOBALS ['db']->getOne ( "select name from " . DB_PREFIX . "deal_cate where id =" . $deal_info ['cate_id'] );
		$deal_new_info ['cate'] = $cate;
		
		// equity_status 0即将开始 1已成功 2筹资失败 3 长期项目 4 融资中
		if ($deal_info ['begin_time'] > NOW_TIME)
		{
			$equity_status = 0; // 即将开始
			$equity_status_expression = '即将开始';
		} elseif ($deal_info ['end_time'] < NOW_TIME && $deal_info ['end_time'] > 0)
		{
			if ($deal_info ['percent'] >= 100)
			{
				$equity_status = 1; // 已成功
				$equity_status_expression = '已成功';
			} else
			{
				$equity_status = 2; // 筹资失败
				$equity_status_expression = '筹资失败';
			}
		} else
		{
			if ($deal_info ['percent'] >= 100)
			{
				$equity_status = 1; // 已成功
				$equity_status_expression = '已成功';
			} elseif ($deal_info ['end_time'] == 0)
			{
				$equity_status = 3; // 长期项目
				$equity_status_expression = '长期项目';
			} else
			{
				$equity_status_expression = '融资中';
				$equity_status = 4; // 融资中
			}
		}
		$deal_new_info ['equity_status_expression'] = $equity_status_expression;
		$deal_new_info ['equity_status'] = $equity_status;
		
		return $deal_new_info;
	}
	
	// 编辑及管理团队
	private function getStockAndUnStock($deal_info)
	{
		$stockInfo = array ();
		
		$stock_list = unserialize ( $deal_info ['stock'] );
		$stock_num = count ( $stock_list );
		if ($stock_num == 0)
		{
			$stock_num ++;
		}
		
		$unstock_list = unserialize ( $deal_info ['unstock'] );
		if (! $unstock_list || ! is_array ( $unstock_list ))
		{
			$unstock_num = 1;
			$is_unstock = 0;
		} else
		{
			$unstock_num = count ( $unstock_list );
			if ($unstock_num == 0)
			{
				$is_unstock = 0;
				$unstock_num ++;
			} else
			{
				$is_unstock = 1;
			}
		}
		
		$stockInfo ['stock_list'] = $stock_list;
		$stockInfo ['stock_num'] = $stock_num;
		$stockInfo ['is_unstock'] = $is_unstock;
		$stockInfo ['unstock_num '] = $unstock_num;
		$stockInfo ['unstock_list'] = $unstock_list;
		
		return $stockInfo;
	}
	// 项目历史执行资料
	private function getHistoryInfo($deal_info)
	{
		$historyInfo = array ();
		
		$history_list = unserialize ( $deal_info ['history'] );
		
		$history_num = count ( $history_list );
		
		$total_history_income = 0;
		$total_history_out = 0;
		$total_history = 0;
		foreach ( $history_list as $key => $v )
		{
			$total_history_income += intval ( $v ["info"] ["item_income"] );
			$total_history_out += intval ( $v ["info"] ["item_out"] );
			$total_history = $total_history_income - $total_history_out;
		}
		
		$historyInfo ['history_num'] = $history_num;
		$historyInfo ['history_list'] = $history_list;
		$historyInfo ['total_history_income'] = $total_history_income;
		$historyInfo ['total_history_out'] = $total_history_out;
		$historyInfo ['total_history'] = $total_history;
		
		return $historyInfo;
	}
	
	// 未来三年内计划
	private function getPlanInfo($deal_info)
	{
		$plan_info = array ();
		$plan_list = unserialize ( $deal_info ['plan'] );
		$plan_num = count ( $plan_list );
		
		$total_plan_income = 0;
		$total_plan_out = 0;
		$total_plan = 0;
		foreach ( $plan_list as $key => $v )
		{
			$total_plan_income += intval ( $v ["info"] ["item_income"] );
			$total_plan_out += intval ( $v ["info"] ["item_out"] );
			$total_plan = $total_plan_income - $total_plan_out;
		}
		
		$plan_info ['plan_num'] = $plan_num;
		$plan_info ['plan_list'] = $plan_list;
		$plan_info ['total_plan_income'] = $total_plan_income;
		$plan_info ['total_plan_out'] = $total_plan_out;
		$plan_info ['total_plan'] = $total_plan;
		return $plan_info;
	}
	
	// $strHtml = "<meta name=\"viewport\" content=\"width=device-width,
	// initial-scale=1.0, maximum-scale=2.0,
	// user-scalable=0,minimum-scale=0.5\">
	// <h3
	// style=\"height:40px;line-height:40px;background:#0099ff;color:#fff;font-size:18px;\">目标用户或客户群体定位</h3>"
	// . "<br/><div style=\"width:100%\">" . $deal_info ['description_2'] .
	// "</div>";
	// $deal_new_info ['strHtml'] = $strHtml;
	// $strHtml_1 = "<meta name=\"viewport\" content=\"width=device-width,
	// initial-scale=1.0, maximum-scale=2.0,
	// user-scalable=0,minimum-scale=0.5\">" .
	// "<br/><div style=\"width:100%\">";
	// $description_2 = "<h3
	// style=\"height:40px;line-height:40px;background:#0099ff;color:#fff;font-size:18px;\">目标用户或客户群体定位</h3>"
	// . "<br/><div style=\"width:100%\">" . $deal_info ['description_2'] .
	// "</div>";
	// $description_3 = "<h3
	// style=\"height:40px;line-height:40px;background:#0099ff;color:#fff;font-size:18px;\">目标用户或客户群体目前困扰或需求定位</h3>"
	// . "<br/><div style=\"width:100%\">" . $deal_info ['description_3'] .
	// "</div>";
	// $description_4 = "<h3
	// style=\"height:40px;line-height:40px;background:#0099ff;color:#fff;font-size:18px;\">满足目标用户或客户需求的产品或服务模式说明</h3>"
	// . "<br/><div style=\"width:100%\">" . $deal_info ['description_4'] .
	// "</div>";
	// $description_5 = "<h3
	// style=\"height:40px;line-height:40px;background:#0099ff;color:#fff;font-size:18px;\">项目赢利模式说明</h3>"
	// . "<br/><div style=\"width:100%\">" . $deal_info ['description_5'] .
	// "</div>";
	// $description_6 = "<h3
	// style=\"height:40px;line-height:40px;background:#0099ff;color:#fff;font-size:18px;\">市场主要同行或竞争对手概述</h3>"
	// . "<br/><div style=\"width:100%\">" . $deal_info ['description_6'] .
	// "</div>";
	// $description_7 = "<h3
	// style=\"height:40px;line-height:40px;background:#0099ff;color:#fff;font-size:18px;\">项目主要核心竞争力说明</h3>"
	// . "<br/><div style=\"width:100%\">" . $deal_info ['description_7'] .
	// "</div>";
	// $deal_new_info ['business_description'] = $strHtml_1 . $description_2 .
	// $description_3 . $description_4 . $description_5 . $description_6 .
	// $description_7;
}

?>