<?php
class userModule{
	 
	public function login()
	{
 		if($GLOBALS['user_info']){
			app_redirect(url_wap("settings#index"));
		}
		
		$GLOBALS['tmpl']->caching = true;
		$cache_id  = md5(MODULE_NAME.ACTION_NAME);		
		if (!$GLOBALS['tmpl']->is_cached('user_login.html', $cache_id))
		{		
			$GLOBALS['tmpl']->assign("page_title","会员登录");
		}
		 
		$GLOBALS['tmpl']->display("user_login.html",$cache_id);
	}
	
	public function do_login()
	{		
		if(!$_POST)
		{
 			app_redirect(APP_ROOT."/");
		}
		foreach($_POST as $k=>$v)
		{
			$_POST[$k] = strim($v);
		}
		$ajax = intval($_REQUEST['ajax']);
		
		require_once APP_ROOT_PATH."system/libs/user.php";
		if(check_ipop_limit(get_client_ip(),"user_dologin",5))
		$result = do_login_user($_POST['email'],$_POST['user_pwd']);
		else
		showErr("提交太快",$ajax,url_wap("user#login"));		
		if($result['status'])
		{	
 			$s_user_info = es_session::get("user_info");
			if(intval($_POST['auto_login'])==1)
			{
				//自动登录，保存cookie
				$user_data = $s_user_info;
				es_cookie::set("email",$user_data['email'],3600*24*30);			
				es_cookie::set("user_pwd",md5($user_data['user_pwd']."_EASE_COOKIE"),3600*24*30);
				
			}
			if($ajax==0&&trim(app_conf("INTEGRATE_CODE"))=='')
			{
				$redirect = $_SERVER['HTTP_REFERER']?$_SERVER['HTTP_REFERER']:url_wap("index");
				app_redirect($redirect);
			}
			else
			{			
				$jump_url = get_gopreview();				
				if($ajax==1)
				{
					$return['status'] = 1;
					$return['info'] = "登录成功";
					$return['data'] = $result['msg'];
					$return['jump'] = $jump_url;					
					ajax_return($return);
				}
				else
				{
					$GLOBALS['tmpl']->assign('integrate_result',$result['msg']);					
					showSuccess("登录成功",$ajax,$jump_url);
				}
			}
		}
		else
		{
 			if($result['data'] == ACCOUNT_NO_EXIST_ERROR)
			{
				$err = "会员不存在";
			}
			if($result['data'] == ACCOUNT_PASSWORD_ERROR)
			{
				$err = "密码错误";
			}
                        if($result['data'] == ACCOUNT_NO_VERIFY_ERROR)
			{
				$err = "用户未通过验证";
				if(app_conf("MAIL_ON")==1&&$ajax==0)
				{				
					$GLOBALS['tmpl']->assign("page_title",$err);
					$GLOBALS['tmpl']->assign("user_info",$result['user']);
					$GLOBALS['tmpl']->display("verify_user.html");
					exit;
				}
				
			}
			showErr($err,$ajax);
		}
	}
	public function register()
	{
                 //links
        if($GLOBALS['user_info']){
			app_redirect(url_wap("settings#index"));
		}
 		$GLOBALS['tmpl']->caching = true;
		$cache_id  = md5(MODULE_NAME.ACTION_NAME);		
		if (!$GLOBALS['tmpl']->is_cached('user_register.html', $cache_id))
		{		
			$GLOBALS['tmpl']->assign("page_title","会员注册");
		}
		$GLOBALS['tmpl']->display("user_register.html",$cache_id);
	}
	public function do_register()
		{
			$email = strim($_REQUEST['email']);
			require_once APP_ROOT_PATH."system/libs/user.php";
			$_REQUEST['confirm_user_pwd']= strim($_REQUEST['user_pwd']);
			$return = $this->register_check_all();
			 
 			if($return['status']==0)
			{
				ajax_return($return);
			}		
			$user_data = $_POST;
			foreach($_POST as $k=>$v)
			{
				$user_data[$k] = strim($v);
			}	
            //开启邮箱验证
            if(app_conf("USER_VERIFY")==0||app_conf("USER_VERIFY")==2){
                 $user_data['is_effect'] = 1;
            }else{
            	$user_data['is_effect'] = 0;
            }
 		
			$res = save_user($user_data);
		
	
			if($res['status'] == 1)
			{
				if(!check_ipop_limit(get_client_ip(),"user_do_register",5))
				showErr("提交太快",1);	
				
				$user_id = intval($res['data']);
				$user_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user where id = ".$user_id);
				if($user_info['is_effect']==1)
				{
					//在此自动登录
					//send_register_success(0,$user_data);
					$result = do_login_user($user_data['user_name'],$user_data['user_pwd']);
				//	ajax_return(array("status"=>1,"jump"=>get_gopreview()));
					ajax_return(array("status"=>1,"data"=>$result['msg'],"jump"=>get_gopreview()));
				}
				else
				{
                    if(app_conf("USER_VERIFY")==1){
                        ajax_return(array("status"=>1,"jump"=>url_wap("user#mail_check",array('uid'=>$user_id))));
                    }else if(app_conf("USER_VERIFY")==3){
                    	ajax_return(array("status"=>0,"info"=>"请等待管理员审核"));
                    }
						
				}                     
			}
			else
			{
				$error = $res['data'];	
				if($error['field_name']=="user_name")
				{
					$data[] = array("type"=>"form_success","field"=>"email","info"=>"");	
					$field_name = "会员帐号";
				}
				if($error['field_name']=="email")
				{
					$data[] = array("type"=>"form_success","field"=>"user_name","info"=>"");
					$field_name = "电子邮箱";
				}
				if($error['field_name']=="mobile")
				{
					$data[] = array("type"=>"form_success","field"=>"mobile","info"=>"");
					$field_name = "手机号码";
				}
				if($error['field_name']=="verify_code")
				{
					$data[] = array("type"=>"form_success","field"=>"verify_code","info"=>"");
					$field_name = "验证码";
				}
			
				if($error['error']==EMPTY_ERROR)
				{
					$error_info = "不能为空";
					$type = "form_tip";
				}
				if($error['error']==FORMAT_ERROR)
				{
					$error_info = "错误";
					$type="form_error";
				}
				if($error['error']==EXIST_ERROR)
				{
					$error_info = "已存在";
					$type="form_error";
				}
				
				//$data[] = array("type"=>$type,"field"=>$error['field_name'],"info"=>$field_name.$error_info);	
				ajax_return(array("status"=>0,"data"=>$field_name.$error_info,"info"=>""));			
				
			}
	}
	
	public function loginout(){
		$ajax = intval($_REQUEST['ajax']);
		require_once APP_ROOT_PATH."system/libs/user.php";
		$result = loginout_user();
		if($result['status'])
		{
			es_cookie::delete("email");
			es_cookie::delete("user_pwd");
			es_cookie::delete("hide_user_notify");
			if($ajax==1)
			{
				$return['status'] = 1;
				$return['info'] = "登出成功";
				$return['data'] = $result['msg'];
				$return['jump'] = get_gopreview_wap();					
				ajax_return($return);
			}
			else
			{
				$GLOBALS['tmpl']->assign('integrate_result',$result['msg']);
				if(trim(app_conf("INTEGRATE_CODE"))=='')
				{
					app_redirect(get_gopreview_wap());
				}
				else
				showSuccess("登出成功",0,get_gopreview_wap());
			}
		}
		else
		{
			if($ajax==1)
			{
				$return['status'] = 1;
				$return['info'] = "登出成功";
				$return['jump'] = get_gopreview_wap();					
				ajax_return($return);
			}
			else
			app_redirect(get_gopreview_wap());		
		}
	}
	
	
	
	
	private function register_check_all()
	{
		
		if(app_conf("USER_VERIFY")!=2){
 			$user_name = strim($_REQUEST['user_name']);
			$email = strim($_REQUEST['email']);
			
			//	$mobile = strim($_REQUEST['mobile']);
			$user_pwd = strim($_REQUEST['user_pwd']);
			$confirm_user_pwd = strim($_REQUEST['confirm_user_pwd']);
			$data = array();
			require_once APP_ROOT_PATH."system/libs/user.php";
			
			$user_name_result = check_user("user_name",$user_name);
			$return = array('status'=>1,"info"=>"");
			if($user_name_result['status']==0)
			{
				if($user_name_result['data']['error']==EMPTY_ERROR)
				{
					$error = "不能为空";
					$type = "form_tip";
				}
				if($user_name_result['data']['error']==FORMAT_ERROR)
				{
					$error = "格式有误";
					$type="form_error";
				}
				if($user_name_result['data']['error']==EXIST_ERROR)
				{
					$error = "已存在";
					$type="form_error";
				}
				$return = array('status'=>0,"info"=>"会员帐号".$error);
				return $return;
 				//$data[] = array("type"=>$type,"field"=>"user_name","info"=>"会员帐号".$error);
			}
			 
			
			$email_result = check_user("email",$email);
			if($email_result['status']==0)
			{
				if($email_result['data']['error']==EMPTY_ERROR)
				{
					$error = "不能为空";
					$type = "form_tip";
				}
				if($email_result['data']['error']==FORMAT_ERROR)
				{
					$error = "格式有误";
					$type="form_error";
				}
				if($email_result['data']['error']==EXIST_ERROR)
				{
					$error = "已存在";
					$type="form_error";
				}
				$return = array('status'=>0,"info"=>"电子邮箱".$error);
				return $return;
 				//$data[] = array("type"=>$type,"field"=>"email","info"=>"电子邮箱".$error);
			}
			 
			
			if($user_pwd=="")
			{
				$user_pwd_result['status'] = 0;
 				$return = array('status'=>0,"info"=>"请输入会员密码");
 				return $return;
 			}
			elseif(strlen($user_pwd)<4)
			{
				$user_pwd_result['status'] = 0;
 				$return = array('status'=>0,"info"=>"密码不得小于四位");
 				return $return;
 				
			}
			 
			
			if($user_pwd!=$confirm_user_pwd)
			{
				$return = array('status'=>0,"info"=>"确认密码失败");
				return $return;
 			}
			 
		 
			return $return;
		}
		if(app_conf("USER_VERIFY")==2){
 			$user_name = strim($_REQUEST['user_name']);
			$email = strim($_REQUEST['email']);
			
			$mobile = strim($_REQUEST['mobile']);
			$verify_coder=strim($_REQUEST['verify_coder']);
			
			$user_pwd = strim($_REQUEST['user_pwd']);
			$confirm_user_pwd = strim($_REQUEST['confirm_user_pwd']);
			$data = array();
			require_once APP_ROOT_PATH."system/libs/user.php";
			
			$return = array('status'=>1,"info"=>"");
			$user_name_result = check_user("user_name",$user_name);
		
 			if($user_name_result['status']==0)
			{
				if($user_name_result['data']['error']==EMPTY_ERROR)
				{
					$error = "不能为空";
					$type = "form_tip";
				}
				if($user_name_result['data']['error']==FORMAT_ERROR)
				{
					$error = "格式有误";
					$type="form_error";
				}
				if($user_name_result['data']['error']==EXIST_ERROR)
				{
					$error = "已存在";
					$type="form_error";
				}
 				$return = array('status'=>0,"info"=>"会员帐号".$error);
				return $return;
			}
		 
			

			$mobile_result = check_user("mobile",$mobile);
				
			if($mobile_result['status']==0)
			{
				if($mobile_result['data']['error']==EMPTY_ERROR)
				{
					$error = "不能为空";
					$type = "form_tip";
				}
				if($mobile_result['data']['error']==FORMAT_ERROR)
				{
					$error = "格式有误";
					$type="form_error";
				}
				if($mobile_result['data']['error']==EXIST_ERROR)
				{
					$error = "已存在";
					$type="form_error";
				}
 				$return = array('status'=>0,"info"=>"手机号码".$error);
				return $return;
			}
			 
			//=================================================这里面的要验证改y
			$verify_coder_result = check_user("verify_coder",$verify_coder);
			if($verify_coder_result['status']==0)
			{
				if($verify_coder_result['data']['error']==EMPTY_ERROR)
				{
					$error = "不能为空";
					$type = "form_tip";
				}
				if($verify_coder_result['data']['error']==FORMAT_ERROR)
				{
					$error = "格式错误";
					$type = "form_tip";
				}
				if($verify_coder_result['data']['error']==EXIST_ERROR)
				{
					$error = "错误";
					$type="form_error";
				}
 				$return = array('status'=>0,"info"=>"验证码".$error);
				return $return;
			}
 				
			if($user_pwd=="")
			{
 				$return = array('status'=>0,"info"=>"请输入会员密码");
				return $return;
			}
			elseif(strlen($user_pwd)<4)
			{
 				$return = array('status'=>0,"info"=>"密码不得小于四位");
				return $return;
			}
			 
 			return $return;
		}
	}
	
	//检查验证码是否正确
	function check_verify_code()
	{
 		$settings_mobile_code=strim($_REQUEST['code']);
  		$mobile=strim($_REQUEST['mobile']);
		//判断验证码是否正确=============================
 		if($GLOBALS['db']->getOne("SELECT count(*) FROM ".DB_PREFIX."mobile_verify_code WHERE mobile=".$mobile." AND verify_code='".$settings_mobile_code."'")==0){
			$data['status'] = 0;
			$data['info'] = "手机验证码出错";
			ajax_return($data);
		}else{
			$data['status'] = 1;
			$data['info'] = "验证码正确";
			ajax_return($data);
		}
	}
	
	public function getpassword()
	{
		$GLOBALS['tmpl']->caching = true;
		$cache_id  = md5(MODULE_NAME.ACTION_NAME);
		if (!$GLOBALS['tmpl']->is_cached('user_getpassword.html', $cache_id))
		{
			$GLOBALS['tmpl']->assign("page_title","邮件取回密码");
		}
		$GLOBALS['tmpl']->display("user_getpassword.html",$cache_id);
	}
	
	public function wx_register(){
		if($GLOBALS['user_info']){
			app_redirect(url_wap("index#index"));
		}
		 
		$GLOBALS['tmpl']->assign('wx_info',$GLOBALS['wx_info']);
		$GLOBALS['tmpl']->display("user_wx_register.html");
	}
	
	public function wx_do_register()
	{
		$user_info=array();
		$user_info['mobile'] = strim($_REQUEST['mobile']);
 		$user_info['verify_coder']=strim($_REQUEST['code']);
		$user_info['wx_openid']=strim($_REQUEST['wx_openid']);
		$user_info['user_name']=strim($_REQUEST['user_name']);
		$user_info['province']=strim($_REQUEST['province']);
		$user_info['email']=strim($_REQUEST['email']);
		$user_info['city']=strim($_REQUEST['city']);
		$user_info['sex']=strim($_REQUEST['sex']);
		if(!$user_info['mobile'])
		{
			$data['status'] = 0;
			$data['info'] = "手机号码为空";
			ajax_return($data);
		}
		
	
		if($user_info['verify_coder']==""){
			$data['status'] = 0;
			$data['info'] = "手机验证码为空";
			ajax_return($data);
		}
		//判断验证码是否正确=============================
		if($GLOBALS['db']->getOne("SELECT count(*) FROM ".DB_PREFIX."mobile_verify_code WHERE mobile=".$user_info['mobile']." AND verify_code='".$user_info['verify_coder']."'")==0){
 			$data['status'] = 0;
			$data['info'] = "手机验证码错误";
			ajax_return($data);
		}
		$user=get_user_has('mobile',$user_info['mobile']);
		require_once APP_ROOT_PATH."system/libs/user.php";
		if($user){
			$GLOBALS['db']->query("update ".DB_PREFIX."user set wx_openid='".$user_info['wx_openid']."' where id=".$user['id']);
 			$user_id = $user['id'];	
 		}else{
 			if(!$user_info['email'])
			{
				$data['status'] = 0;
				$data['info'] = "邮箱为空";
				ajax_return($data);
			}
			if(!check_email($user_info['email'])){
				$data['status'] = 0;
				$data['info'] = "邮箱格式错误";
				ajax_return($data);
			}
			$has_email=get_user_has('email',$user_info['email']);
			if($has_email){
				$data['status'] = 0;
				$data['info'] = "邮箱已存在，请重新填写";
				ajax_return($data);
			}
			$has_user_name=get_user_has('user_name',$user_info['user_name']);
			if($has_user_name){
				$user_info['user_name']=$user_info['user_name'].rand(10000,99999);
			}
			
 			
 			if($user_info['sex']==0){
 				$user_info['sex']=-1;
 			}elseif($user_info['sex']==1){
 				$user_info['sex']=1;
 			}else{
 				$user_info['sex']=0;
 			}
 			//开启邮箱验证
            if(app_conf("USER_VERIFY")==0||app_conf("USER_VERIFY")==2){
                 $user_info['is_effect'] = 1;
            }else{
            	$user_info['is_effect'] = 0;
            }
 			
 			$user_info['create_time'] = get_gmtime();
			$user_info['update_time'] = get_gmtime();
			//新建用户 使用验证码作为密码
			$user_info['user_pwd']=$user_info['verify_coder'];
			//$GLOBALS['db']->autoExecute(DB_PREFIX."user",$user_info,"INSERT");
 			$res = save_user($user_info);
 			 
			$user_id = intval($res['data']);	
 		}
 		 
  			$user_info_new = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user where id = ".$user_id);
 			if($user_info_new['is_effect']==1)
			{
 				$result = do_login_user($user_info_new['mobile'],$user_info_new['user_pwd']);
  				ajax_return(array("status"=>1,"info"=>$result['msg'],"jump"=>url_wap("index")));
			}
			else
			{
                if(app_conf("USER_VERIFY")==1){
                    ajax_return(array("status"=>1,"jump"=>url_wap("user#mail_check",array('uid'=>$user_id))));
                }else if(app_conf("USER_VERIFY")==3){
                	ajax_return(array("status"=>0,"info"=>"请等待管理员审核"));
                }
					
			}                     
 	}
	
	//手机验证修改密码=====================================================================================
	public function phone_update_password()
	{
		$mobile = strim($_REQUEST['mobile']);
		$user_pwd = strim($_REQUEST['user_pwd']);
		$confirm_user_pwd=strim($_POST['confirm_user_pwd']);
		$settings_mobile_code1=strim($_POST['code']);
	
		if(!$mobile)
		{
			$data['status'] = 0;
			$data['info'] = "手机号码为空";
			ajax_return($data);
		}
	
		if($settings_mobile_code1==""){
			$data['status'] = 0;
			$data['info'] = "手机验证码为空";
			ajax_return($data);
		}
	
		if($user_pwd==""){
			$data['status'] = 0;
			$data['info'] = "密码为空";
			ajax_return($data);
		}
	
		if($user_pwd!==$confirm_user_pwd){
			$data['status'] = 0;
			$data['info'] = "两次密码不一致";
			ajax_return($data);
		}
	
		//判断验证码是否正确=============================
		if($GLOBALS['db']->getOne("SELECT count(*) FROM ".DB_PREFIX."mobile_verify_code WHERE mobile=".$mobile." AND verify_code='".$settings_mobile_code1."'")==0){
	
			$data['status'] = 0;
			$data['info'] = "手机验证码错误";
			ajax_return($data);
		}
	
	
		if($user_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user where mobile =".$mobile))
		{
				
			$GLOBALS['db']->query("UPDATE ".DB_PREFIX."user SET user_pwd='".md5($user_pwd.$user_info['code'])."' where mobile=".$mobile);
			$result = 1;  //初始为1
			$data['status'] = 1;
			$data['info'] = "密码修改成功";
			ajax_return($data);//密码修改成功
		}
		else{
			$data['status'] = 0;
			$data['info'] = "没有该手机账户";
			ajax_return($data);//密码修改成功
		}
	}
	
	//判断邮箱类型及跳转到user_register_email.html界面
	function mail_check()
	{
	
		$GLOBALS['tmpl']->assign("g_links",$g_links);
		if(app_conf("MAIL_ON")==1)
		{
			$user_id = (int)$_REQUEST['uid'];
			//发邮件
			send_wap_user_verify_mail($user_id);
			$user_email = $GLOBALS['db']->getOne("select email from ".DB_PREFIX."user where id =".$user_id);
			//开始关于跳转地址的解析
			$domain = explode("@",$user_email);
			$domain = $domain[1];
			$gocheck_url = '';
			switch($domain)
			{
				case '163.com':
					$gocheck_url = 'http://mail.163.com';
					break;
				case '126.com':
					$gocheck_url = 'http://www.126.com';
					break;
				case 'sina.com':
					$gocheck_url = 'http://mail.sina.com';
					break;
				case 'sina.com.cn':
					$gocheck_url = 'http://mail.sina.com.cn';
					break;
				case 'sina.cn':
					$gocheck_url = 'http://mail.sina.cn';
					break;
				case 'qq.com':
					$gocheck_url = 'http://mail.qq.com';
					break;
				case 'foxmail.com':
					$gocheck_url = 'http://mail.foxmail.com';
					break;
				case 'gmail.com':
					$gocheck_url = 'http://www.gmail.com';
					break;
				case 'yahoo.com':
					$gocheck_url = 'http://mail.yahoo.com';
					break;
				case 'yahoo.com.cn':
					$gocheck_url = 'http://mail.cn.yahoo.com';
					break;
				case 'hotmail.com':
					$gocheck_url = 'http://www.hotmail.com';
					break;
				default:
					$gocheck_url = "";
					break;
			}
	
			$GLOBALS['tmpl']->assign("page_title",$GLOBALS['lang']['REGISTER_MAIL_SEND_SUCCESS']);
	
			$GLOBALS['tmpl']->assign("user_email",$user_email);
	
			$GLOBALS['tmpl']->assign("gocheck_url",$gocheck_url);
			//end
			$GLOBALS['tmpl']->display("user_register_email.html");
		}
	
	}
	
	public function verify()
	{
		$id = intval($_REQUEST['id']);
		$user_info  = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user where id = ".$id);
		if(!$user_info)
		{
			showErr("没有该会员");
		}
		$verify = addslashes(trim($_REQUEST['code']));
		if($user_info['verify']!=''&&$user_info['verify'] == $verify)
		{
			//成功
//			send_register_success(0,$user_info);
			es_session::set("user_info",$user_info);
			$GLOBALS['db']->query("update ".DB_PREFIX."user set login_ip = '".get_client_ip()."',login_time= ".get_gmtime().",verify = '',is_effect = 1 where id =".$user_info['id']);
			$GLOBALS['db']->query("update ".DB_PREFIX."mail_list set is_effect = 1 where mail_address ='".$user_info['email']."'");
			showSuccess("验证成功",0,get_gopreview_wap());
		}
	
		elseif($user_info['verify']=='')
		{
			showErr("已验证过",0,get_gopreview_wap());
	
		}
		else
		{
			showErr("验证失败",0,get_gopreview_wap());
		}
	}
	
	public function investor_result($from='wap'){
		if(!$GLOBALS['user_info']){
			if($from=='web'){
				app_redirect(url("user#login"));
			}elseif ($from=='wap'){
				app_redirect(url_wap("user#login"));
			}
		}
		if($GLOBALS['user_info']['investor_status']==1){
			$GLOBALS['tmpl']->assign("investor_status",$GLOBALS['user_info']['investor_status']);
			$GLOBALS['tmpl']->assign("is_investor",$GLOBALS['user_info']['is_investor']);
		}
		$GLOBALS['tmpl']->display("investor_success.html");
	}

	//投资认证申请信息入库(个人)
	public function investor_save_data($from='wap'){
		if(!$GLOBALS['user_info']){
			if($from=='web'){
				app_redirect(url("user#login"));
			}elseif($from=='wap'){
				app_redirect(url_wap("user#login"));
			}
		}
		if(!check_ipop_limit(get_client_ip(),"user_investor_result",5))
			showErr("提交太快",1);
		$id=intval($_REQUEST ['id']);
		$ajax = intval($_POST['ajax']);
		$identify_name=strim($_POST['identify_name']);
		$identify_number=strim($_POST['identify_number']);
		$image1['url']=replace_public(strim($_POST['idcard_zheng_u']));
		$image2['url']=replace_public(strim($_POST['idcard_fang_u']));
		$data=investor_save($id,$ajax='',$identify_name,$identify_number,$image1['url'],$image2['url']);
		ajax_return($data);
		return false;
	}
	
	//投资认证申请信息入库(机构)
	public function investor_agency_save_data($from='wap'){
		if(!$GLOBALS['user_info']){
			if($from=='web'){
				app_redirect(url("user#login"));
			}elseif ($from=='wap'){
				app_redirect(url_wap("user#login"));
			}
		}
		if(!check_ipop_limit(get_client_ip(),"user_investor_result",5))
			showErr("提交太快",1);
		$id=intval($_REQUEST ['id']);
		$ajax = intval($_POST['ajax']);
		$identify_business_name=strim($_POST['identify_business_name']);
		$identify_business_licence=es_session::get("identify_business_licence");
		$identify_business_code=es_session::get("identify_business_code");
		$identify_business_tax=es_session::get("identify_business_tax");
		$image1['url']=replace_public(strim($_POST['identify_business_licence_u']));
		$image2['url']=replace_public(strim($_POST['identify_business_code_u']));
		$image3['url']=replace_public(strim($_POST['identify_business_tax_u']));
		$data=investor_agency_save($id,$ajax='',$identify_business_name,$identify_business_licence,$identify_business_code,$identify_business_tax,$image1['url'],$image2['url'],$image3['url']);
		ajax_return($data);
		return false;
	}
	
	//(投资者认证)更新用户手机号码
	public function investor_save_mobile(){
		$id=$GLOBALS['user_info']['id'];
		$mobile=strim($_POST['mobile']);
		if((es_cookie::get(md5("mobile_is_bind".$id)))!=1)
		{
			$verify_coder=strim($_POST['verify_coder']);
			if($GLOBALS['db']->getOne("SELECT count(*) FROM ".DB_PREFIX."mobile_verify_code WHERE mobile=".$mobile." AND verify_code='".$verify_coder."'")==0){
				$data['status'] = 0;
				$data['info'] = "手机验证码出错!";
				ajax_return($data);
				return false;
			}
		}
		$is_investor=strim($_POST['is_investor']);
		if($mobile==null){
			$data['status'] = 0;
			$data['info'] = "手机号码不能为空！";
			ajax_return($data);
			return false;
		}
		if($GLOBALS['db']->getOne("SELECT count(*) FROM ".DB_PREFIX."user WHERE id!=".$id." AND mobile=".$mobile)>0){
			$data['status'] = 0;
			$data['info'] = "手机号码已经被使用！";
			ajax_return($data);
			return false;
		}
		if($GLOBALS['db']->query("UPDATE ".DB_PREFIX."user SET mobile=".$mobile." WHERE id = ".$id)&&$GLOBALS['db']->query("UPDATE ".DB_PREFIX."user SET is_investor=".$is_investor." WHERE id = ".$id)){
			//绑定过回退不用再次发送短信
			es_cookie::set(md5("mobile_is_bind".$id),1);
			$data['status'] = 1;
			ajax_return($data);
		}
	
		return false;
	}
	
	//（普通众筹）支持前用户是否绑定了手机号码
	public function user_bind_mobile(){
		$cid=strim($_REQUEST['cid']);
		$GLOBALS['tmpl']->assign("cid",$cid);
		$GLOBALS['tmpl']->display("inc/user_bind_mobile.html");
	}
	
	//更新用户手机号码
	public function save_mobile(){
		$mobile=strim($_POST['mobile']);
		$cid=strim($_POST['cid']);
		$verify_coder=strim($_POST['verify_coder']);
		if($mobile==null){
			$data['status'] = 0;
			$data['info'] = "手机号码不能为空！";
			ajax_return($data);
			return false;
		}
		if($GLOBALS['db']->getOne("SELECT count(*) FROM ".DB_PREFIX."mobile_verify_code WHERE mobile=".$mobile." AND verify_code='".$verify_coder."'")==0){
			$data['status'] = 0;
			$data['info'] = "手机验证码出错";
			ajax_return($data);
			return false;
		}
		$id=$GLOBALS['user_info']['id'];
		if($GLOBALS['db']->query("UPDATE ".DB_PREFIX."user SET mobile=".$mobile." WHERE id = ".$id)){
			//绑定过回退不用再次发送短信
			es_cookie::set(md5("mobile_is_bind".$GLOBALS['user_info']['id']),1);
			$data['status'] = 1;
			ajax_return($data);
		}
		return false;
	}
}
?>