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
		$is_partner = intval ( $_REQUEST ['is_partner'] ); // 1表示愿意担任 2表示不愿意担任
		$stock_value = doubleval ( $_REQUEST ['stock_value'] ); // 项目估值
		$investment_reason = strim ( $_REQUEST ['investment_reason'] ); // 投资理由
		$funding_to_help = strim ( $_REQUEST ['funding_to_help'] ); // 我能为创业者提供非资金帮助
		
		$user_id = getUserID ( $email, $password );
		
		if ($this->verifyParams ( $deal_id, $money, $is_partner, $investment_reason, $user_id ))
		{
			$result = investor_enquiry_save ( $user_id, $deal_id, $stock_value, $money, $investment_reason, $funding_to_help, $is_partner );
			$result ['response_code'] = 1;
			output ( $result );
		}
	}
	
	private function verifyParams($deal_id, $money, $is_partner, $investment_reason, $user_id)
	{
		if (dealIdIsExist ( $deal_id, 1 ) != 1)
		{
			$data = responseErrorInfo ( "deal_id参数错误" );
			output ( $data );
		} elseif ($money <= 0)
		{
			$data = responseErrorInfo ( "请输入正确的目标金额" );
			output ( $data );
		} elseif ($is_partner <= 0 || $is_partner > 2)
		{
			$data = responseErrorInfo ( "is_partner参数错误" );
			output ( $data );
		} elseif ($investment_reason == '')
		{
			$data = responseErrorInfo ( "请输入投资理由" );
			output ( $data );
		} elseif ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		} else
		{
			return true;
		}
	}
}

?>