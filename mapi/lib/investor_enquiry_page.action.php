<?php
/** 询价下一步判断 */
class investor_enquiry_page
{
	public function index()
	{
		// 获取参数
		$email = strim ( $_REQUEST ['email'] );
		$password = strim ( $_REQUEST ['pwd'] );
		$deal_id = intval ( $_REQUEST ['deal_id'] ); // 股权众筹ID
		$enquiry = intval ( $_REQUEST ['enquiry'] ); // 0不参与询价无条件接受项目最终估值 1询价
		
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
	
		if ($enquiry<0 || $enquiry >1)
		{
			$data = responseErrorInfo ( "enquiry参数错误" );
			output ( $data );
		}
		$result = investor_enquiry_page ( $user_id, $deal_id, $enquiry );
	
		$result ['response_code'] = 1;
		output ( $result );
	}
}

?>