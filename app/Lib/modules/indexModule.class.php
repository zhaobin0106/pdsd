<?php
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------
require APP_ROOT_PATH.'app/Lib/shop_lip.php';
require APP_ROOT_PATH.'app/Lib/page.php';
class indexModule extends BaseModule
{
	public function index()
	{
  		get_mortgate();
         $GLOBALS['tmpl']->caching = true;
        $cache_id = md5(MODULE_NAME . ACTION_NAME);
		$image_list = load_dynamic_cache("INDEX_IMAGE_LIST");
		if($image_list===false)
		{
			$image_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."index_image order by sort asc");
			set_dynamic_cache("INDEX_IMAGE_LIST",$image_list);
		}
		$GLOBALS['tmpl']->assign("image_list",$image_list); 		
		$cate_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal_cate where is_delete=0 order by sort asc");
		$cate_result= array();
		foreach($cate_list as $k=>$v)
		{
			$cate_result[$v['id']] = $v;
		}
	 
		$GLOBALS['tmpl']->assign("cate_list",$cate_result);
		send_deal_success_1();
		send_deal_fail_1();
		
		//===============首页项目列表START===================
		$page_size = 8;
	 
		$limit =  "0,8";
		
		$GLOBALS['tmpl']->assign("current_page",1);
 		$deal_result = get_deal_list($limit,'type=0');
		$GLOBALS['tmpl']->assign("deal_list",$deal_result['list']);
		$fore_result = get_fore_list($limit,'type=0');
		$GLOBALS['tmpl']->assign("fore_list",$fore_result['list']);
 		$deal_invest_result = get_deal_list($limit,'type=1');
		$GLOBALS['tmpl']->assign("deal_list_invest",$deal_invest_result['list']);
		//===============首页项目列表END===================
		
        //links
         $g_links =get_link_by_id();
                
    	/*虚拟的累计项目总个数，支持总人数，项目支持总金额*/
         if(app_conf("INVEST_STATUS")==0)
         {
         	$condition = " and 1=1 ";
         }
         elseif (app_conf("INVEST_STATUS")==1)
         {
         	$condition = " and type=0 ";
         }
         elseif (app_conf("INVEST_STATUS")==2)
         {
         	$condition = " and type=1 ";
         }
 	 	$virtual_effect = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal where is_effect = 1 and is_delete=0 $condition");
 	 	$virtual_person =  $GLOBALS['db']->getOne("select sum((support_count+virtual_num)) from ".DB_PREFIX."deal where is_effect = 1 and is_delete=0 $condition");
	 	$virtual_money =  $GLOBALS['db']->getOne("select sum(support_amount+virtual_price) from ".DB_PREFIX."deal where is_effect = 1 and is_delete=0 $condition");

	 	
		$GLOBALS['tmpl']->assign("virtual_effect",$virtual_effect);//项目总个数
		$GLOBALS['tmpl']->assign("virtual_person",$virtual_person);//累计支持人
		$GLOBALS['tmpl']->assign("virtual_money",number_format($virtual_money,2));//筹资总金额
	    /*虚拟的累计项目总个数，支持总人数，项目支持总金额 结束*/
		
		//首页TAB选项卡
		if(app_conf("INVEST_STATUS")==0)
		{
			$condition = " d.is_delete = 0 and d.is_effect = 1 ";
		}
		elseif (app_conf("INVEST_STATUS")==1)
		{
			$condition = " d.is_delete = 0 and d.is_effect = 1 and d.type=0 ";
		}
		elseif (app_conf("INVEST_STATUS")==2)
		{
			$condition = " d.is_delete = 0 and d.is_effect = 1 and d.type=1 ";
		}
	
		if($GLOBALS['user_info']['user_level']!=0){
			$level=$GLOBALS['db']->getOne("SELECT level from ".DB_PREFIX."user_level where id=".$GLOBALS['user_info']['user_level']);
			$condition .=" AND (d.user_level ='' or d.user_level=0 or d.user_level <=$level)   ";
		}
		else{
			$condition.=" AND (d.user_level =0 or d.user_level =1 or d.user_level ='') AND d.is_recommend='1'";
		}
		
		//最后发起的项目，如果被设置为推荐，被选项卡显示
 		 
		$deal_cate_array=$GLOBALS['db']->getAll("select d.* from (select * from ".DB_PREFIX."deal order by sort asc)  as d left join ".DB_PREFIX."deal_cate as dc on dc.id=d.cate_id    where $condition group by d.cate_id order by dc.sort asc ");
		$deal_cate=array();
		$now_time=NOW_TIME;
		foreach ($deal_cate_array as $k=>$v){
			if($v['id']>0){
				$v['cate_name']=$cate_result[$v['cate_id']]['name'];
				$v['percent'] = round($v['support_amount']/$v['limit_price']*100);
				$v['num_days'] = ceil(($v['end_time'] - $v['begin_time'])/(24*3600));
				
				$v['remain_days'] = ceil(($v['end_time'] - $now_time)/(24*3600));
				if($v['begin_time'] > $now_time){
					$v['left_days'] = intval(($now_time - $v['create_time']) / 24 / 3600);
				}
				$v['num_days'] = ceil(($v['end_time'] - $v['begin_time'])/(24*3600));
				$deal_ids[] =  $v['id'];
				
				$deal_cate[$v['id']]=$v;
				
				
			}
			 
		}
	 
		//将获取到的虚拟人数和虚拟价格拿到项目列表里面进行统计
		foreach($deal_cate as $k=>$v)
		{
			if($v['type']==1){
				$deal_cate[$k]['virtual_person']=$deal_cate[$k]['invote_num'];
				$deal_cate[$k]['support_count'] =$deal_cate[$k]['invote_num'];
				$deal_cate[$k]['support_amount'] =$deal_cate[$k]['invote_money'];
				$deal_cate[$k]['percent'] = round(($deal_cate[$k]['support_amount'])/$v['limit_price']*100);
			}else{
				$deal_cate[$k]['virtual_person']=$deal_cate[$k]['virtual_num'];
				$deal_cate[$k]['support_count'] =$deal_cate[$k]['virtual_num']+$deal_cate[$k]['support_count'];
				$deal_cate[$k]['support_amount'] =$deal_cate[$k]['virtual_price']+$deal_cate[$k]['support_amount'];
				$deal_cate[$k]['percent'] = round(($deal_cate[$k]['support_amount'])/$v['limit_price']*100);
 			}
  		}
  		
		$GLOBALS['tmpl']->assign("deal_cate",$deal_cate);
        $GLOBALS['tmpl']->assign("g_links",$g_links);
        
 		$GLOBALS['tmpl']->display("index.html");
	}		
}
?>