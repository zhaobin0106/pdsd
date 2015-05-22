<?php
/** 跟投(首次、追加)投资金额 */
class investor_enquirymoney_save
{
	public function index()
	{
		$email = strim ( $_REQUEST ['email'] );
		$password = strim ( $_REQUEST ['pwd'] );
		$deal_id = intval ( $_REQUEST ['deal_id'] ); // 股权众筹ID
		$money = doubleval ( $_REQUEST['money'] ); // 跟投(首次、追加)投资金额
		$is_partner = intval ($_REQUEST ['is_partner'] ); // 1表示愿意担任 2表示不愿意担任
		
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
		if($is_partner<=0||$is_partner>2){
			$data = responseErrorInfo ( "is_partner参数错误" );
			output ( $data );
		}
		$user_id = getUserID ( $email, $password );
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		
		$result = investor_enquiry_money_save ( $user_id, $deal_id, $is_partner, $money );
		$result['response_code']=1;
		output($result);
	}
}

?>