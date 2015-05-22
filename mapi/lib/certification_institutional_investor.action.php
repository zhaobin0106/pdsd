<?php
/** 认证机构投资者 */
class certification_institutional_investor
{
	public function index()
	{
		$is_investor = 2; // 2表示机构投资者
		                  
		// 获取参数
		$email = strim ( $GLOBALS ['request'] ['email'] );
		$password = strim ( $GLOBALS ['request'] ['pwd'] );
		$identify_business_name = strim ( $GLOBALS ['request'] ['identify_business_name'] ); // 机构名称
		                                                                                     
		// 验证参数
		
		if ($identify_business_name == '')
		{
			$data = responseErrorInfo ( "identify_business_name机构名称不能为空" );
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
			
			// identify_business_licence 营业执照
			// identify_business_code 组织机构代码证
			// identify_business_tax 税务登记证
			
			if (isset ( $_FILES ['identify_business_licence'] ) || isset ( $_FILES ['identify_business_code'] ) || isset ( $_FILES ['identify_business_tax'] ))
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
			
			if (isset ( $_FILES ['identify_business_licence'] ))
			{
				$identify_business_licence_result = save_image_upload ( $_FILES, "identify_business_licence", "attachment/" . $dir, $whs = array (
						'thumb' => array (
								205,
								160,
								1,
								0 
						) 
				), 0, 1 );
				
				if (intval ( $identify_business_licence_result ['error'] ) != 0)
				{
					$data = responseErrorInfo ( $identify_business_licence_result ['message'] );
					output ( $data );
				} else
				{
					$identify_business_licence_url = $identify_business_licence_result ['identify_business_licence'] ['url'];
				}
			}
			
			if (isset ( $_FILES ['identify_business_code'] ))
			{
				$identify_business_code_result = save_image_upload ( $_FILES, "identify_business_code", "attachment/" . $dir, $whs = array (
						'thumb' => array (
								205,
								160,
								1,
								0 
						) 
				), 0, 1 );
				
				if (intval ( $identify_business_code_result ['error'] ) != 0)
				{
					$data = responseErrorInfo ( $identify_business_code_result ['message'] );
					output ( $data );
				} else
				{
					$identify_business_code_url = $identify_business_code_result ['identify_business_code'] ['url'];
				}
			}
			
			if (isset ( $_FILES ['identify_business_tax'] ))
			{
				$identify_business_tax_result = save_image_upload ( $_FILES, "identify_business_tax", "attachment/" . $dir, $whs = array (
						'thumb' => array (
								205,
								160,
								1,
								0 
						) 
				), 0, 1 );
				
				if (intval ( $identify_business_tax_result ['error'] ) != 0)
				{
					$data = responseErrorInfo ( $identify_business_tax_result ['message'] );
					output ( $data );
				} else
				{
					$identify_business_tax_url = $identify_business_tax_result ['identify_business_tax'] ['url'];
				}
			}
			
			$dbObject = array ();
			if ($investor_status == 2) // 当审核未通过时，回置为0
			{
				$dbObject ['investor_status'] = 0;
			}
			$dbObject ['is_investor'] = $is_investor;
			$dbObject ['identify_business_name'] = $identify_business_name;
			$dbObject ['identify_business_licence'] = $identify_business_licence_url;
			$dbObject ['identify_business_code'] = $identify_business_code_url;
			$dbObject ['identify_business_tax'] = $identify_business_tax_url;
			$GLOBALS ['db']->autoExecute ( DB_PREFIX . "user", $dbObject, 'UPDATE', 'id = ' . $user_id );
			
			$data = responseSuccessInfo ( "提交成功" );
			output ( $data );
		} else
		{
			$data = responseErrorInfo ( "该用户已经通过审核" );
			output ( $data );
		}
	}
}

?>