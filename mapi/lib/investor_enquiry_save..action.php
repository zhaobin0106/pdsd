<?php
/** 跟投询价表单信息保存 */
class investor_enquiry_save
{
	public function index()
	{
		$email = strim ( $_REQUEST ['email'] );
		$password = strim ( $_REQUEST ['pwd'] );
		$deal_id = intval ( $_REQUEST ['deal_id'] ); // 股权众筹ID
		$money = doubleval ( $_REQUEST ['money'] ); // (首次、追加)投资金额
		$is_partner = intval ( $_REQUEST ['is_partner'] ); // 必须传1，表示愿意担任
		$stock_value = doubleval ( $_REQUEST ['stock_value'] ); // 估值
		$investment_reason = strim ( $_REQUEST ['investment_reason'] ); // 原因
		$funding_to_help = strim ( $_REQUEST ['funding_to_help'] ); //
		
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
		$user_id = getUserID ( $email, $password );
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		
		$result = investor_enquiry_save ( $user_id, $deal_id, $stock_value, $money, $investment_reason, $funding_to_help, $is_partner );
		$result ['response_code'] = 1;
		output ( $result );
	}
}

?>