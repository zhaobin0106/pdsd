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
class homeModule extends BaseModule
{
	public function index()
	{		
                //links
                $g_links =get_link_by_id(14);
                
                $GLOBALS['tmpl']->assign("g_links",$g_links);
		$id = intval($_REQUEST['id']);
		
		$home_user_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user where id = ".$id." and is_effect = 1");
		if(!$home_user_info)
		{
			app_redirect(url("index"));	
		}
		
		$home_user_info['weibo_list'] = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."user_weibo where user_id = ".$home_user_info['id']);
		$GLOBALS['tmpl']->assign("home_user_info",$home_user_info);
		
		$page_size = DEAL_PAGE_SIZE;
		$step_size = DEAL_STEP_SIZE;
		
		$step = intval($_REQUEST['step']);
		if($step==0)$step = 1;
		$page = intval($_REQUEST['p']);
		if($page==0)$page = 1;		
		$limit = (($page-1)*$page_size+($step-1)*$step_size).",".$step_size	;
		
		$GLOBALS['tmpl']->assign("current_page",$page);
		
		$condition = " is_delete = 0 and is_effect = 1 and user_id = ".intval($home_user_info['id'])." "; 
		
		if(app_conf("INVEST_STATUS")==0)
		{
			$condition.=" and 1=1 ";
		}
		elseif (app_conf("INVEST_STATUS")==1)
		{
			$condition.=" and type=0 ";
		}
		elseif(app_conf("INVEST_STATUS")==2)
		{
			$condition.=" and type=1 ";
		}
		
		$GLOBALS['tmpl']->assign('deal_type','home');
		$deal_count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal where ".$condition);
		/*（home模块）准备虚拟数据 start*/
			$deal_list = array();
			if($deal_count > 0){
				$now_time = get_gmtime();
				$deal_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal where ".$condition." order by sort desc limit ".$limit);
				$deal_ids = array();
				foreach($deal_list as $k=>$v)
				{
					$deal_list[$k]['remain_days'] = floor(($v['end_time'] - NOW_TIME)/(24*3600));
					if($v['begin_time'] > $now_time){
						$deal_list[$k]['left_days'] = intval(($now_time - $v['create_time']) / 24 / 3600);
					}
					$deal_ids[] =  $v['id'];
				}
				//获取当前项目列表下的所有子项目
				$temp_virtual_person_list = $GLOBALS['db']->getAll("select deal_id,virtual_person,price from ".DB_PREFIX."deal_item where deal_id in(".implode(",",$deal_ids).") ");
				$virtual_person_list  = array();
				//重新组装一个以项目ID为KEY的 统计所有的虚拟人数和虚拟价格
				foreach($temp_virtual_person_list as $k=>$v){
					$virtual_person_list[$v['deal_id']]['total_virtual_person'] += $v['virtual_person'];
					$virtual_person_list[$v['deal_id']]['total_virtual_price'] += $v['price'] * $v['virtual_person'];
				}
				unset($temp_virtual_person_list);
				//将获取到的虚拟人数和虚拟价格拿到项目列表里面进行统计
				foreach($deal_list as $k=>$v)
				{
					if($v['type']==1)
					{
						$deal_list[$k]['virtual_person']=$deal_list[$k]['invote_num'];
						$deal_list[$k]['support_count'] =$deal_list[$k]['invote_num'];
						$deal_list[$k]['support_amount'] =$deal_list[$k]['invote_money'];
						$deal_list[$k]['percent'] = round(($deal_list[$k]['support_amount'])/$v['limit_price']*100);
						$deal_list[$k]['limit_price_w']=round(($deal_list[$k]['limit_price'])/10000);
						$deal_list[$k]['invote_mini_money_w']=round(($deal_list[$k]['invote_mini_money'])/10000);
					}else
					{
						$deal_list[$k]['virtual_person']=$virtual_person_list[$v['id']]['total_virtual_person'];
						$deal_list[$k]['percent'] = round(($v['support_amount']+$virtual_person_list[$v['id']]['total_virtual_price'])/$v['limit_price']*100);
						$deal_list[$k]['support_count'] += $deal_list[$k]['virtual_person'];
						$deal_list[$k]['support_amount'] += $virtual_person_list[$v['id']]['total_virtual_price'];
					}
					
				}
			}
		/*（home模块）准备虚拟数据 end*/
		//var_dump($deal_list);
// 		$deal_invest_result = get_deal_list($limit,'type=1');
// 		$deal_list['list']=$deal_invest_result['list'];
		$GLOBALS['tmpl']->assign("deal_list",$deal_list);
		$GLOBALS['tmpl']->assign("deal_count",$deal_count);
		$page = new Page($deal_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);		
		if($home_user_info['user_level'] == 14){
		$GLOBALS['tmpl']->display("home_index.html");
		}else{
		app_redirect(url("home#support&id=".$id));									
		}
	}
	
	
	public function support()
	{	
                    //links
                $g_links =get_link_by_id(14);
                
                $GLOBALS['tmpl']->assign("g_links",$g_links);
		$GLOBALS['tmpl']->assign("page_title","");

		$id = intval($_REQUEST['id']);
		
		$home_user_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user where id = ".$id." and is_effect = 1");
		if(!$home_user_info)
		{
			app_redirect(url("index"));	
		}
		
		$home_user_info['weibo_list'] = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."user_weibo where user_id = ".$home_user_info['id']);
		$GLOBALS['tmpl']->assign("home_user_info",$home_user_info);
		
		$page_size = DEAL_PAGE_SIZE;
		$step_size = DEAL_STEP_SIZE;
		
		$step = intval($_REQUEST['step']);
		if($step==0)$step = 1;
		$page = intval($_REQUEST['p']);
		if($page==0)$page = 1;		
		$limit = (($page-1)*$page_size+($step-1)*$step_size).",".$step_size	;
		
		$GLOBALS['tmpl']->assign("current_page",$page);
		
		if(app_conf("INVEST_STATUS")==0)
		{
			$condition=" 1=1 ";
		}
		elseif (app_conf("INVEST_STATUS")==1)
		{
			$condition=" d.type=0 ";
		}
		elseif(app_conf("INVEST_STATUS")==2)
		{
			$condition=" d.type=1 ";
		}
		
		$sql = "select distinct(dsl.deal_id) as did,d.* from ".DB_PREFIX."deal as d left join ".DB_PREFIX."deal_support_log as dsl on d.id = dsl.deal_id ".
			   " where $condition and dsl.user_id = ".$home_user_info['id']." order by dsl.create_time desc limit ".$limit;
	
		$sql_count = "select count(distinct(d.id)) from ".DB_PREFIX."deal as d left join ".DB_PREFIX."deal_support_log as dsl on d.id = dsl.deal_id ".
			   " where $condition and dsl.user_id = ".$home_user_info['id'];
		//得到当前页面项目信息
	
		$deal_count = $GLOBALS['db']->getOne($sql_count);
		/*（home模块）准备虚拟数据 start*/
			$deal_list = array();
			if($deal_count > 0){
				$now_time = get_gmtime();
				$deal_list = $GLOBALS['db']->getAll($sql);
				
				$deal_ids = array();
				foreach($deal_list as $k=>$v)
				{
					$deal_list[$k]['remain_days'] = floor(($v['end_time'] - NOW_TIME)/(24*3600));
					if($v['begin_time'] > $now_time){
						$deal_list[$k]['left_days'] = intval(($now_time - $v['create_time']) / 24 / 3600);
					}
					$deal_ids[] =  $v['id'];
				}
				//获取当前项目列表下的所有子项目
				$temp_virtual_person_list = $GLOBALS['db']->getAll("select deal_id,virtual_person,price from ".DB_PREFIX."deal_item where deal_id in(".implode(",",$deal_ids).") ");
				$virtual_person_list  = array();
				//重新组装一个以项目ID为KEY的 统计所有的虚拟人数和虚拟价格
				foreach($temp_virtual_person_list as $k=>$v){
					$virtual_person_list[$v['deal_id']]['total_virtual_person'] += $v['virtual_person'];
					$virtual_person_list[$v['deal_id']]['total_virtual_price'] += $v['price'] * $v['virtual_person'];
				}
				unset($temp_virtual_person_list);
				//将获取到的虚拟人数和虚拟价格拿到项目列表里面进行统计
				foreach($deal_list as $k=>$v)
				{
					if($v['type']==1)
					{
						$deal_list[$k]['virtual_person']=$deal_list[$k]['invote_num'];
						$deal_list[$k]['support_count'] =$deal_list[$k]['invote_num'];
						$deal_list[$k]['support_amount'] =$deal_list[$k]['invote_money'];
						$deal_list[$k]['percent'] = round(($deal_list[$k]['support_amount'])/$v['limit_price']*100);
						$deal_list[$k]['limit_price_w']=round(($deal_list[$k]['limit_price'])/10000);
						$deal_list[$k]['invote_mini_money_w']=round(($deal_list[$k]['invote_mini_money'])/10000);
					}
					else
					{
						$deal_list[$k]['virtual_person']=$virtual_person_list[$v['id']]['total_virtual_person'];
						$deal_list[$k]['percent'] = round(($v['support_amount']+$virtual_person_list[$v['id']]['total_virtual_price'])/$v['limit_price']*100);
						$deal_list[$k]['support_count'] += $deal_list[$k]['virtual_person'];
						$deal_list[$k]['support_amount'] += $virtual_person_list[$v['id']]['total_virtual_price'];
					}
				}
			}
		/*（home模块）准备虚拟数据 end*/
		$GLOBALS['tmpl']->assign("deal_list",$deal_list);
		$GLOBALS['tmpl']->assign("deal_count",$deal_count);
		$page = new Page($deal_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);		
		
		$GLOBALS['tmpl']->display("home_support.html");
	}
	

	
	
}
?>