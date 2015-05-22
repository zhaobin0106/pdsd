<?php
class invester_list
{
	public function index()
	{
		// 0 普通用户 1 投资人 2机构投资人 5全部
		$is_investor = intval ( $GLOBALS ['request'] ['is_investor'] );
		
		if ($is_investor > 2 && $is_investor >= 0)
		{
			$condition .= " and is_investor = " . $is_investor;
		}
		
		
		
	
		
		$param = array (); // 参数集合
		
		$loc = strim ( $_REQUEST ['loc'] ); // 地区
		$param ['loc'] = $loc;
		$GLOBALS ['tmpl']->assign ( "p_loc", $loc );
		
		$city = strim ( $_REQUEST ['city'] ); // 地区
		$param ['city'] = $city;
		$GLOBALS ['tmpl']->assign ( "p_city", $city );
		
		if (intval ( $_REQUEST ['redirect'] ) == 1)
		{
			$param = array ();
			
			if ($loc != "")
			{
				$param = array_merge ( $param, array (
						"loc" => $loc 
				) );
			}
			if ($city != "")
			{
				$param = array_merge ( $param, array (
						"city" => $city 
				) );
			}
		}
		$city_list = load_dynamic_cache ( "INDEX_CITY_LIST" );
		if (! $city_list)
		{
			$city_list = $GLOBALS ['db']->getAll ( "select province from " . DB_PREFIX . "user group by province order by create_time desc" );
			set_dynamic_cache ( "INDEX_CITY_LIST", $city_list );
		}
		foreach ( $city_list as $k => $v )
		{
			$temp_param = $param;
			unset ( $temp_param ['city'] );
			$temp_param ['loc'] = $v ['province'];
			$city_list [$k] ['url'] = url ( "investor#invester_list", $temp_param );
		}
		$GLOBALS ['tmpl']->assign ( "city_list", $city_list );
		
		$next_pid = 0;
		$region_lv2 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "region_conf where region_level = 2 order by py asc" ); // 二级地址
		foreach ( $region_lv2 as $k => $v )
		{
			$temp_param = $param;
			unset ( $temp_param ['city'] );
			$temp_param ['loc'] = $v ['name'];
			
			$region_lv2 [$k] ['url'] = url ( "investor#invester_list", $temp_param );
			
			if ($loc == $v ['name'])
			{
				$next_pid = $v ['id'];
			}
		}
		$GLOBALS ['tmpl']->assign ( "region_lv2", $region_lv2 );
		if ($next_pid > 0)
		{
			$region_lv3 = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "region_conf where region_level = 3 and `pid`='" . $next_pid . "' order by py asc" ); // 二级地址
			foreach ( $region_lv3 as $k => $v )
			{
				$temp_param = $param;
				$temp_param ['city'] = $v ['name'];
				$region_lv3 [$k] ['url'] = url ( "investor#invester_list", $temp_param );
			}
			$GLOBALS ['tmpl']->assign ( "region_lv3", $region_lv3 );
		}
		
		$page_size = DEAL_PAGE_SIZE;
		$step_size = DEAL_STEP_SIZE;
		
		$step = intval ( $_REQUEST ['step'] );
		if ($step == 0)
			$step = 1;
		$page = intval ( $_REQUEST ['p'] );
		if ($page == 0)
			$page = 1;
		$limit = (($page - 1) * $page_size + ($step - 1) * $step_size) . "," . $step_size;
		
		$GLOBALS ['tmpl']->assign ( "current_page", $page );
		
		$condition = "is_effect = 1 ";
		
		if ($loc != "")
		{
			$condition .= " and (province = '" . $loc . "') ";
			$GLOBALS ['tmpl']->assign ( "page_title", $loc );
		}
		if ($city != "")
		{
			$condition .= " and (province = '" . $loc . "' and city = '" . $city . "') ";
			$GLOBALS ['tmpl']->assign ( "page_title", $city );
		}
		/* 投资人列表 */
		$invester_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user where " . $condition . " order by create_time desc limit " . $limit );
		foreach ( $invester_list as $k => $v )
		{
			$invester_list [$k] ['image'] = get_user_avatar ( $v ["id"], "middle" ); // 用户头像
		}
		$invester_count = $GLOBALS ['db']->getOne ( "select count(*) from " . DB_PREFIX . "user where " . $condition );
		
		$GLOBALS ['tmpl']->assign ( "invester_count", $invester_count );
		
		require APP_ROOT_PATH . 'app/Lib/page.php';
		$page = new Page ( $invester_count, $page_size ); // 初始化分页对象
		$p = $page->show ();
		$GLOBALS ['tmpl']->assign ( 'pages', $p );
		$GLOBALS ['tmpl']->assign ( "invester_list", $invester_list );
		
		/* 投资人推荐 */
		$new_invester = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "user where investor_status = 1 and is_effect = 1 and (is_investor = 1 or is_investor = 2) order by create_time desc " );
		foreach ( $new_invester as $kk => $vv )
		{
			$new_invester [$kk] ['image'] = get_user_avatar ( $vv ["id"], "middle" ); // 用户头像
		}
		// print_r($invester_list);exit;
		$GLOBALS ['tmpl']->assign ( "new_invester", $new_invester );
		$GLOBALS ['tmpl']->display ( "invester_list.html" );
	}
}

?>