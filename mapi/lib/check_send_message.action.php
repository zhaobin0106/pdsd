<?php
/** 检测能否发送私信 */
class check_send_message
{
	public function index()
	{
		$email = strim ( $_REQUEST ['email'] );
		$password = strim ( $_REQUEST ['pwd'] );
		$receiver_id = intval ( $_REQUEST ['receiver_id'] );
		
		$sender_id = getUserID ( $email, $password );
		
		if (! $this->verifyParams ( $sender_id, $receiver_id ))
		{
			return false;
		}
		
		$send_user_info = $GLOBALS ['db']->getRow ( "select * from " . DB_PREFIX . "user where id = " . $receiver_id . " and is_effect = 1" );
		if (! $send_user_info)
		{
			$data = responseErrorInfo ( "收信人不存在" );
			output ( $data );
		} else
		{
			$data = responseSuccessInfo ( "可以弹出私信框" );
			output ( $data );
		}
	}
	private function verifyParams($user_id, $receiver_id)
	{
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		if ($user_id == $receiver_id)
		{
			$data = responseErrorInfo ( "不能给自己发私信" );
			output ( $data );
		}
		return true;
	}
}

?>