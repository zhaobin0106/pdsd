<?php
/** 领投(首次、追加)投资金额 */
class investor_save_money
{
	public function index()
	{
		$email = strim ( $_REQUEST ['email'] );
		$password = strim ( $_REQUEST ['pwd'] );
		$deal_id = intval ( $_REQUEST ['deal_id'] ); // 股权众筹ID
		$money = doubleval ( $_REQUEST ['money'] ); // (首次、追加)投资金额
		$is_partner = intval ( $_REQUEST ['is_partner'] ); // 1表示愿意担任 2表示不愿意担任
		
		if (dealIdIsExist ( $deal_id, 1 ) != 1)
		{
			$data = responseErrorInfo ( "deal_id参数错误" );
			output ( $data );
		}
		if ($money <= 0)
		{
			$data = responseErrorInfo ( "请输入正确的目标金额" );
			output ( $data );
		}
		if ($is_partner <=0 || $is_partner > 2)
		{
			$data = responseErrorInfo ( "is_partner参数错误" );
			output ( $data );
		}
		$user_id = getUserID ( $email, $password );
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		
		$result = investor_save_money ( $user_id, $deal_id, $money, $is_partner, '' );
		$result ['response_code'] = 1;
		output ( $result );
	}
}

?>