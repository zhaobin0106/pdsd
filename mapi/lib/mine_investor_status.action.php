<?php
/** 投资的项目 */
class mine_investor_status
{
	public function index()
	{
		// $type 0询价 1领投 2跟投
		// 获取参数
		$email = strim ( $GLOBALS ['request'] ['email'] );
		$password = strim ( $GLOBALS ['request'] ['pwd'] );
		$type = intval ( ($GLOBALS ['request'] ['type']) );
		$page = intval ( $GLOBALS ['request'] ['page'] );
		$page = $page == 0 ? 1 : $page;
		
		$user = user_check ( $email, $password );
		$user_id = intval ( $user ['id'] );
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		
		$page_size = $GLOBALS ['m_config'] ['page_size'];
		$limit = (($page - 1) * $page_size) . "," . $page_size;
		
		$investor_list = $GLOBALS ['db']->getAll ( "select invest.*,d.end_time,d.pay_end_time,d.begin_time,d.name as deal_name ,d.image as deal_image,d.id as deal_id" . " from  " . DB_PREFIX . "investment_list as invest left join " . DB_PREFIX . "deal as d on d.id=invest.deal_id where  invest.type=$type and invest.user_id=$user_id order by invest.id desc limit $limit " );
		$investor_list_num = $GLOBALS ['db']->getOne ( "select count(*) from  " . DB_PREFIX . "investment_list where  type=$type and user_id=$user_id  " );
		$now_time = NOW_TIME;
		if ($type == 0 || $type == 2 || $type == 1)
		{
			foreach ( $investor_list as $k => $v )
			{
				if ($type == 1)
				{
					if ($now_time > $v ['end_time'])
					{
						$investor_list [$k] ['status'] = 2;
						$GLOBALS ['db']->query ( "UPDATE  " . DB_PREFIX . "investment_list set status=2 where id= " . $v ['id'] );
					}
				}
				if ($v ['investor_money_status'] == 0 && $now_time > $v ['end_time'])
				{
					$investor_list [$k] ['investor_money_status'] = 2;
					$GLOBALS ['db']->query ( "UPDATE  " . DB_PREFIX . "investment_list set investor_money_status=2 where id= " . $v ['id'] );
				} elseif ($v ['investor_money_status'] == 1 && $now_time > $v ['pay_end_time'])
				{
					$investor_list [$k] ['investor_money_status'] = 4;
					deal_invest_break ( $v ['id'] );
				}
				
				$investor_list [$k] ['create_time'] = to_date ( $v ['create_time'] );
				$investor_list [$k] ['begin_time'] = to_date ( $v ['begin_time'] );
				$investor_list [$k] ['end_time'] = to_date ( $v ['end_time'] );
				$investor_list [$k] ['pay_end_time'] = to_date ( $v ['pay_end_time'] );
				$investor_list [$k] ['cates'] = formateCates ( unserialize ( $investor_list [$k] ['cates'] ) );
				$investor_list [$k] ['deal_image'] = get_abs_img_root ( $v ['deal_image'] );
			}
		}
		
		$data=responseSuccessInfo("个人中心投资的项目");
		$date ['investor_list'] = $investor_list;
		$date ['page'] = array (
				"page" => $page,
				"page_total" => ceil ( $investor_list_num / $page_size ),
				"page_size" => intval ( $page_size ) 
		);
		output ( $date );
	}
}

?>