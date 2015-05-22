<?php
/** 股权详情列表页 */
class equity_deals
{
	public function index()
	{
		$key = intval ( $_REQUEST ['key'] );
		$cate_id = intval ( $_REQUEST ['cate_id'] );
		$state = intval ( $_REQUEST ['state'] );
		$page = intval ( $_REQUEST ['page'] );
		$page = $page == 0 ? 1 : $page;
		
		$page_size = $GLOBALS ['m_config'] ['page_size'];
		$limit = (($page - 1) * $page_size) . "," . $page_size;
		$condition = " type=1 and is_delete = 0 and is_effect = 1 ";
		if ($cate_id > 0)
		{
			$condition .= " and cate_id=" . $cate_id;
		}
		
		switch ($state)
		{
			// 筹资成功
			case 1 :
				$condition .= " and is_success=1  ";
				
				break;
			// 筹资失败
			case 2 :
				$condition .= " and end_time < " . NOW_TIME . " and end_time!=0  and is_success=0  ";
				
				break;
			// 融资中
			case 3 :
				$condition .= " and (end_time > " . NOW_TIME . " or end_time=0 ) and begin_time < " . NOW_TIME . " and is_success=0  ";
				break;
		}
		
		if ($key != "")
		{
			$kws_div = div_str ( $key );
			foreach ( $kws_div as $k => $item )
			{
				$kws [$k] = str_to_unicode_string ( $item );
			}
			$ukeyword = implode ( " ", $kws );
			$condition .= " and (match(name_match) against('" . $ukeyword . "'  IN BOOLEAN MODE) or match(tags_match) against('" . $ukeyword . "'  IN BOOLEAN MODE)  or name like '%" . $key . "%') ";
		}
		
		$deal_count = $GLOBALS ['db']->getOne ( "select count(*) from " . DB_PREFIX . "deal where " . $condition );
		$deal_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal where " . $condition . " order by sort asc limit " . $limit );
		foreach ( $deal_list as $k => $v )
		{
			$deal_list [$k] = formateType2DealInfo ( $deal_list [$k] );
		}
		$data = responseSuccessInfo ( "股权列表" );
		$data ['deal_list'] = $deal_list;
		$data ['deal_list'] = $deal_list;
		$data ['page'] = array (
				"page" => $page,
				"page_total" => ceil ( $deal_count / $page_size ) 
		);
		
		output ( $data );
	}
}

?>