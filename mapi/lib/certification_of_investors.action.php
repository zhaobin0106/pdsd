<?php
/** 认证个人投资者 */
class certification_of_investors
{
	public function index()
	{
		$is_investor = 1; // 1表示个人投资者
		                  
		// 获取参数
		$email = strim ( $GLOBALS ['request'] ['email'] );
		$password = strim ( $GLOBALS ['request'] ['pwd'] );
		$ex_real_name = strim ( $GLOBALS ['request'] ['ex_real_name'] ); // 真实姓名
		$identify_number = strim ( $GLOBALS ['request'] ['identify_number'] ); // 身份证号码
		                                                                       
		// 验证参数
		if ($ex_real_name == '')
		{
			$data = responseErrorInfo ( "ex_real_name不能为空" );
			output ( $data );
		}
		if ($identify_number == '')
		{
			$data = responseErrorInfo ( "identify_number不能为空" );
			output ( $data );
		}
		$user = user_check ( $email, $password );
		$user_id = intval ( $user ['id'] );
		if ($user_id <= 0)
		{
			$data = responseNoLoginParams ();
			output ( $data );
		}
		
		$investor_status = intval ( $user ['investor_status'] );
		$identify_positive_image = $user ['identify_positive_image'];
		$identify_business_licence = $user ['identify_business_licence'];
		
		if ($investor_status != 1) // 1 表示通过审核
		{
			if ($investor_status == 0)
			{
				if ($identify_positive_image != '')
				{
					$data = responseErrorInfo ( "个人投资者资料正在审核" );
					output ( $data );
				}
				if ($identify_business_licence != '')
				{
					$data = responseErrorInfo ( "机构投资者资料正在审核" );
					output ( $data );
				}
			}
			
			// identify_positive_image身份证正面
			// identify_nagative_image身份证反面
			if (isset ( $_FILES ['identify_positive_image'] ) || isset ( $_FILES ['identify_nagative_image'] ))
			{
				// 开始上传
				// 上传处理
				// 创建attachment目录
				if (! is_dir ( APP_ROOT_PATH . "public/attachment" ))
				{
					@mkdir ( APP_ROOT_PATH . "public/attachment" );
					@chmod ( APP_ROOT_PATH . "public/attachment", 0777 );
				}
				
				$dir = to_date ( get_gmtime (), "Ym" );
				if (! is_dir ( APP_ROOT_PATH . "public/attachment/" . $dir ))
				{
					@mkdir ( APP_ROOT_PATH . "public/attachment/" . $dir );
					@chmod ( APP_ROOT_PATH . "public/attachment/" . $dir, 0777 );
				}
				
				$dir = $dir . "/" . to_date ( get_gmtime (), "d" );
				if (! is_dir ( APP_ROOT_PATH . "public/attachment/" . $dir ))
				{
					@mkdir ( APP_ROOT_PATH . "public/attachment/" . $dir );
					@chmod ( APP_ROOT_PATH . "public/attachment/" . $dir, 0777 );
				}
				
				$dir = $dir . "/" . to_date ( get_gmtime (), "H" );
				
				if (! is_dir ( APP_ROOT_PATH . "public/attachment/" . $dir ))
				{
					@mkdir ( APP_ROOT_PATH . "public/attachment/" . $dir );
					@chmod ( APP_ROOT_PATH . "public/attachment/" . $dir, 0777 );
				}
			} else
			{
				$data = responseErrorInfo ( "图片未上传" );
				output ( $data );
			}
			
			if (isset ( $_FILES ['identify_positive_image'] ))
			{
				
				$identify_positive_image_result = save_image_upload ( $_FILES, "identify_positive_image", "attachment/" . $dir, $whs = array (
						'thumb' => array (
								205,
								160,
								1,
								0 
						) 
				), 0, 1 );
				
				if (intval ( $identify_positive_image_result ['error'] ) != 0)
				{
					$data = responseErrorInfo ( $identify_positive_image_result ['message'] );
					output ( $data );
				} else
				{
					$identify_positive_image_url = $identify_positive_image_result ['identify_positive_image'] ['url'];
				}
			}
			
			if (isset ( $_FILES ['identify_nagative_image'] ))
			{
				$identify_nagative_image_result = save_image_upload ( $_FILES, "identify_nagative_image", "attachment/" . $dir, $whs = array (
						'thumb' => array (
								205,
								160,
								1,
								0 
						) 
				), 0, 1 );
				
				if (intval ( $identify_nagative_image_result ['error'] ) != 0)
				{
					$data = responseErrorInfo ( $identify_nagative_image_result ['message'] );
					output ( $data );
				} else
				{
					$identify_nagative_image_url = $identify_nagative_image_result ['identify_nagative_image'] ['url'];
				}
			}
			
			$dbObject = array ();
			if ($investor_status == 2) // 当审核未通过时，回置为0
			{
				$dbObject ['investor_status'] = 0;
			}
			$dbObject ['is_investor'] = $is_investor;
			$dbObject ['identify_name'] = $ex_real_name;
			$dbObject ['identify_number'] = $identify_number;
			$dbObject ['identify_positive_image'] = $identify_positive_image_url;
			$dbObject ['identify_nagative_image'] = $identify_nagative_image_url;
			$GLOBALS ['db']->autoExecute ( DB_PREFIX . "user", $dbObject, 'UPDATE', 'id = ' . $user_id );
			
			$data = responseSuccessInfo ( "提交成功" );
			output ( $data );
		} else
		{
			$data = responseErrorInfo ( "该用户认证个人投资者资料已经通过审核" );
			output ( $data );
		}
	}
}
// 查询集合
// $sql = "select *,id as uid from " . DB_PREFIX . "user where (user_name='" .
// $username_email . "' or email = '" . $username_email . "' or mobile = '" .
// $username_email . "') ";
// $user_info = $GLOBALS ['db']->getRow ( $sql );
// 更新
// $data = array ();
// $data ['ex_real_name'] = $ex_real_name;
// $data ['identify_number'] = $identify_number;
// $GLOBALS ['db']->autoExecute ( DB_PREFIX . "user", $data, 'UPDATE', 'id = ' .
// $user_id );

// 插入
// $data = array ();
// $data ['ex_real_name'] = $ex_real_name;
// $data ['identify_number'] = $identify_number;
// $GLOBALS ['db']->autoExecute ( DB_PREFIX . "user", $data );
// $id = $GLOBALS ['db']->insert_id ();

?>