<?php
require '../system/utils/weixin.php';
class deal_detail
{
	public function index()
	{
		$root = array ();
		$id = intval ( $_REQUEST ['id'] );
		$email = strim ( $GLOBALS ['request'] ['email'] ); // 用户名或邮箱
		$pwd = strim ( $GLOBALS ['request'] ['pwd'] ); // 密码 // 检查用户,用户密码
		
		$user = user_check ( $email, $pwd );
		$user_level = intval ( $user ['user_level'] );
		$user_id = intval ( $user ['id'] );
		
		if ($user_id > 0)
		{
			$is_focus = $GLOBALS ['db']->getOne ( "select  count(*) from " . DB_PREFIX . "deal_focus_log where deal_id = " . $id . " and user_id = " . $user_id );
			$root ['is_focus'] = $is_focus;
		}
		
		// 权限控制
		$condition = " is_delete = 0 and id = $id";
		if ($user_level != 0)
		{
			$condition .= " AND (user_level <=" . $user_level . ") ";
		} else
		{
			$condition .= " AND (user_level =0 or user_level =1 or user_level ='') ";
		}
		
		$deal_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "deal where " . $condition );
		
		// 获取当前项目列表下的所有子项目
		$temp_virtual_person_list = $GLOBALS ['db']->getAll ( "select deal_id,virtual_person,price from " . DB_PREFIX . "deal_item where deal_id =" . $deal_info ['id'] );
		
		$virtual_person_list = array ();
		// 重新组装一个以项目ID为KEY的 统计所有的虚拟人数和虚拟价格
		foreach ( $temp_virtual_person_list as $k => $v )
		{
			$virtual_person_list [$v ['deal_id']] ['total_virtual_person'] += $v ['virtual_person'];
			$virtual_person_list [$v ['deal_id']] ['total_virtual_price'] += $v ['price'] * $v ['virtual_person'];
		}
		
		$deal_info = $this->formateDealInfo ( $deal_info, $virtual_person_list );
		
		$root ['deal_list'] = $deal_info;
		$root ['share_url'] = get_domain () . str_replace ( "/mapi", "", url_wap( "deal#show", array (
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
		output ( $root );
	}
	private function formateDealInfo($deal_info, $virtual_person_list)
	{
		$now_time = get_gmtime ();
		$deal_info_type1 = array ();
		$deal_info_type1 ['id'] = $deal_info ['id'];
		$deal_info_type1 ['type'] = $deal_info ['type'];
		$deal_info_type1 ['name'] = $deal_info ['name'];
		$deal_info_type1 ['image'] = get_abs_img_root ( $deal_info ['image'] );
		$deal_info_type1 ['num_days'] = ceil ( ($deal_info ['end_time'] - $deal_info ['begin_time']) / (24 * 3600) );
		$deal_info_type1 ['end_time'] = to_date ( $deal_info ['end_time'], 'Y-m-d' );
		$deal_info_type1 ['begin_time'] = to_date ( $deal_info ['begin_time'], 'Y-m-d' );
		$deal_info_type1 ['create_time'] = to_date ( $deal_info ['create_time'], 'Y-m-d' );
		$deal_info_type1 ['content'] = $deal_info ['description'];
		$deal_info_type1 ['percent'] = round ( (($deal_info ['support_amount'] + $deal_info ['virtual_price']) / $deal_info ['limit_price']) * 100 );
		$deal_info_type1 ['limit_price'] = $deal_info ['limit_price'];
		$deal_info_type1 ['support_amount'] = $deal_info ['support_amount'];
		$deal_info_type1 ['person'] = $deal_info ['support_count'] + $deal_info ['virtual_num'];
		$deal_info_type1 ['total_virtual_price'] = number_price_format ( $deal_info ['support_amount'] + $deal_info ['virtual_price'] );
		$deal_info_type1 ['focus_count'] = $deal_info ['focus_count'];
		$deal_info_type1 ['support_count'] = $deal_info ['support_count'];
        $deal_info_type1 ['source_vedio']=$deal_info ['source_vedio'];
		
		$deal_info_type1 ['vedio'] = '<div style="text-align: center;"><iframe width=100% height=300px src="' . $deal_info ['source_vedio'] . '" frameborder=0 allowfullscreen></iframe></div>';
		if ($deal_info ['source_vedio'] == '')
		{
			$deal_info_type1 ['vedio'] = null;
		}
		// $deal_list['status']值0表示即将开始；1表示已成功；2表示筹资失败；3表示筹资中；4表示长期项目
		
		if ($deal_info ['begin_time'] > $now_time)
		{
			$deal_info_type1 ['status'] = '0';
		} elseif ($deal_info ['end_time'] < $now_time && $deal_info ['end_time'] > 0)
		{
			if ($deal_info ['percent'] >= 100)
			{
				$deal_info_type1 ['status'] = '1';
			} else
			{
				if ($deal_info ['percent'] >= 0)
				{
					$deal_info_type1 ['status'] = '2';
				}
			}
		} else
		{
			if ($deal_info ['end_time'] > 0)
			{
				if ($deal_info ['percent'] >= 100)
				{
					$deal_info_type1 ['status'] = '1';
				} else
					$deal_info_type1 ['status'] = '3';
			} else
				$deal_info_type1 ['status'] = '4';
		}
		if ($deal_info ['end_time'] > 0 && $deal_info ['end_time'] > $now_time)
		{
			$deal_info_type1 ['remain_days'] = ceil ( ($deal_info ['end_time'] - $now_time) / (24 * 3600) );
		} elseif ($deal_info ['end_time'] > 0 && $deal_info ['end_time'] <= $now_time)
		{
			$deal_info_type1 ['remain_days'] = 0;
		}
		
		if ($deal_info ['begin_time'] > $now_time)
		{
			$deal_info_type1 ['left_days'] = intval ( ($deal_info ['begin_time'] - $now_time) / 24 / 3600 );
		} else
		{
			$deal_info_type1 ['left_days'] = 0;
		}
		$pattern = "/<img([^>]*)\/>/i";
		$replacement = "<img width=100% $1 />";
		$deal_info_type1 ['description'] = preg_replace ( $pattern, $replacement, get_abs_img_root ( $deal_info ['description'] ) );
		
		return $deal_info_type1;
	}
}

?>
