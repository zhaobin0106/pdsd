<?php
class login
{
	public function index()
	{
		$email = strim ( $GLOBALS ['request'] ['email'] ); // 用户名或邮箱
		$pwd = strim ( $GLOBALS ['request'] ['pwd'] ); // 密码
		
		$result = user_login ( $email, $pwd );
		if ($result ['status'])
		{
			$user_data = $GLOBALS ['user_info']; // $result['user'];
			$root ['response_code'] = 1;
			$root ['user_login_status'] = 1; // 用户登陆状态：1:成功登陆;0：未成功登陆
			$root ['info'] = "用户登陆成功";
			$root ['id'] = $user_data ['id'];
			$root ['user_name'] = $user_data ['user_name'];
			$root ['money'] = $user_data ['money'];
			$root ['money_format'] = format_price ( $user_data ['money'] ); // 用户金额
			$root ['mobile'] = $user_data ['mobile'];
			
			$result ['intro'] = $user_data ['intro'];
			$root ['email'] = $user_data ['email'];
			$root ['province'] = $user_data ['province'];
			$root ['city'] = $user_data ['city'];
			$root ['sex'] = $user_data ['sex'];
			$root ['image'] = get_user_avatar_root ( $user_data ['id'], "middle" );
			$root ['user_avatar'] = get_abs_img_root ( get_muser_avatar ( $user_data ['id'], "big" ) );
			$weibo_list = $GLOBALS ['db']->getOne ( "select weibo_url from " . DB_PREFIX . "user_weibo where user_id = " . intval ( $GLOBALS ['user_info'] ['id'] ) );
			$root ['weibo_list'] = $weibo_list;
			$user ['create_time_format'] = to_date ( $user_data ['create_time'], 'Y-m-d' ); // 注册时间
			$root ['create_time_format'] = $user ['create_time_format'];
			
			$root ['investor_status'] = intval ( $user ['investor_status'] );
			$root ['identify_positive_image'] = $user ['identify_positive_image'];
			$root ['identify_business_licence'] = $user ['identify_business_licence'];
		} else
		{
			if ($result ['data'] == ACCOUNT_NO_EXIST_ERROR)
			{
				$err = "会员不存在";
			}
			if ($result ['data'] == ACCOUNT_PASSWORD_ERROR)
			{
				$err = "密码错误";
			}
			if ($result ['data'] == ACCOUNT_NO_VERIFY_ERROR)
			{
				$err = "会员未通过验证";
			}
			$root ['response_code'] = 0;
			$root ['info'] = $err;
			$root ['id'] = 0;
			$root ['user_name'] = $email;
			$root ['user_email'] = $email;
		}
		
		$root ['act'] = "login";
		output ( $root );
	}
}
?>