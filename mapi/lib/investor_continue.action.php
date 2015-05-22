<?php
 /** 跟投按钮判断 */
class investor_continue
{
	public function index()
	{
		$email = strim ( $GLOBALS ['request'] ['email'] );
		$password = strim ( $GLOBALS ['request'] ['pwd'] );
		$deal_id = intval ( $GLOBALS ['request'] ['deal_id'] ); // 股权众筹ID
		
		if (dealIdIsExist ( $deal_id, 1 ) != 1)
		{
			$data = responseErrorInfo ( "deal_id参数错误" );
			output ( $data );
		}
		
		$user_id = getUserID ( $email, $password );
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		
		$result=investor_continue($user_id,$user_id,'app');
		output($result);
	}
}

?>