<?php
class indexModule{
	public function index()
	{		
		$root = array();
		$root['response_code'] = 1;

		$root['kf_phone'] = $GLOBALS['m_config']['kf_phone'];//客服电话
		$root['kf_email'] = $GLOBALS['m_config']['kf_email'];//客服邮箱
		
 		//关于我们(填文章ID)
		$root['about_info'] = intval($GLOBALS['m_config']['about_info']);
		$root['version'] = VERSION; //接口版本号int
		$root['page_size'] = PAGE_SIZE;//默认分页大小
		$root['program_title'] = $GLOBALS['m_config']['program_title'];
		$root['site_domain'] = str_replace("/mapi", "", SITE_DOMAIN.APP_ROOT);//站点域名;
		$root['site_domain'] = str_replace("http://", "", $root['site_domain']);//站点域名;
		$root['site_domain'] = str_replace("https://", "", $root['site_domain']);//站点域名;
		
		/*虚拟的累计项目总个数，支持总人数，项目支持总金额*/ 
	 	$virtual_effect = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal where is_effect = 1 and is_delete=0");
	 	$virtual_person =  $GLOBALS['db']->getOne("select sum((support_count+virtual_person)) from ".DB_PREFIX."deal_item");
	 	$virtual_money =  $GLOBALS['db']->getOne("select sum((support_count+virtual_person)*price) from ".DB_PREFIX."deal_item");

	 	$root['virtual_effect'] = $virtual_effect;//项目总个数
		$root['virtual_person'] = $virtual_person;//累计支持人
		$root['virtual_money'] =number_format($virtual_money,2);//筹资总金额
	
	    /*虚拟的累计项目总个数，支持总人数，项目支持总金额 结束*/
	    /*首页广告*/
	    $adv_num=intval($GLOBALS['m_config']['adv_num'])?$GLOBALS['m_config']['adv_num']:5;
		$index_list = $GLOBALS['db']->getAll(" select * from ".DB_PREFIX."m_adv where status = 1 order by sort asc limit 0,$adv_num");
		$adv_list = array();
		foreach($index_list as $k=>$v)
		{
			if($v['page'] == 'top'){
				if ($v['img'] != '')
						$v['img'] = get_abs_img_root_wap(get_spec_image($v['img'],640,240,1));	
				if($v['type']==1){
					$v['url']=url_wap("article#index",array("id"=>$v['data']));
				}elseif($v['type']==2){
					$v['url']=$v['data'];
				}
				$adv_list[] = $v;	
			}
		}
 		$GLOBALS['tmpl']->assign('adv_list',$adv_list);
		
		/*项目显示以及权限控制*/
		//===============首页项目列表START===================
		$page_size =  $GLOBALS['m_config']['page_size'];
		$page = intval($_REQUEST['p']);

		$limit="";
		$index_pro_num=$GLOBALS['m_config']['index_pro_num'];
		if($index_pro_num>0){
			$limit="  0,$index_pro_num";
		}
		$limit = " 0,3";
		$GLOBALS['tmpl']->assign("current_page",$page);
 		//权限控制
 		$now_time = get_gmtime();
		$deal_result=get_deal_list($limit,$condition);
		$fore_result=get_fore_list($limit,$condition);
 		$deal_list = $deal_result['list'];
		$deal_count =  $deal_result['rs_count'];
		$fore_list = $fore_result['list'];
		$fore_count =  $fore_result['rs_count'];
		//获取当前项目列表下的所有子项目
 		$GLOBALS['tmpl']->assign("deal_count",$deal_count);
		$GLOBALS['tmpl']->assign("deal_list",$deal_list);
		$GLOBALS['tmpl']->assign("fore_count",$fore_count);
		$GLOBALS['tmpl']->assign("fore_list",$fore_list);
		$GLOBALS['tmpl']->assign("now_time",$now_time);
		
  		$GLOBALS['tmpl']->display("index.html");
	}
}

?>