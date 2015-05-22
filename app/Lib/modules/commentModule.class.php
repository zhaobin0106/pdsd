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
class commentModule extends BaseModule
{
	//评论列表
	public function index()
	{	
              //links
                $g_links =get_link_by_id(14);
                
                $GLOBALS['tmpl']->assign("g_links",$g_links);
		if(!$GLOBALS['user_info'])
		{
			app_redirect(url("user#login"));
		}
		
		$page_size = DEAL_COMMENT_PAGE_SIZE;
		$page = intval($_REQUEST['p']);
		if($page==0)$page = 1;		
		$limit = (($page-1)*$page_size).",".$page_size	;

		$sql = "select * from ".DB_PREFIX."deal_comment where reply_user_id = ".intval($GLOBALS['user_info']['id'])." or deal_user_id = ".intval($GLOBALS['user_info']['id'])." order by create_time desc limit ".$limit;
		$sql_count = "select count(*) from ".DB_PREFIX."deal_comment where reply_user_id = ".intval($GLOBALS['user_info']['id'])." or deal_user_id = ".intval($GLOBALS['user_info']['id']);
		
		$comment_list = $GLOBALS['db']->getAll($sql);
		foreach($comment_list as $k=>$v)
		{
			$comment_list[$k] = cache_deal_comment($comment_list[$k]);
		}
		$comment_count = $GLOBALS['db']->getOne($sql_count);
		
		
		$GLOBALS['tmpl']->assign("comment_list",$comment_list);

		$page = new Page($comment_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);	
				
		$GLOBALS['tmpl']->assign("page_title","文章列表");
		$GLOBALS['tmpl']->display("comment_index.html");
	}
	
	public function send()
	{	
                    //links
                $g_links =get_link_by_id(14);
                
                $GLOBALS['tmpl']->assign("g_links",$g_links);
		$GLOBALS['tmpl']->assign("page_title","最新动态");
		if(!$GLOBALS['user_info'])
		{
			app_redirect(url("user#login"));
		}
		$page_size = DEAL_COMMENT_PAGE_SIZE;
		$page = intval($_REQUEST['p']);
		if($page==0)$page = 1;		
		$limit = (($page-1)*$page_size).",".$page_size	;

		$sql = "select * from ".DB_PREFIX."deal_comment where user_id = ".intval($GLOBALS['user_info']['id'])." order by create_time desc limit ".$limit;
		$sql_count = "select count(*) from ".DB_PREFIX."deal_comment where user_id = ".intval($GLOBALS['user_info']['id']);
		
		$comment_list = $GLOBALS['db']->getAll($sql);
		$deal_list = array();
		foreach($comment_list as $k=>$v)
		{
			$comment_list[$k] = cache_deal_comment($comment_list[$k]);
		}
		$comment_count = $GLOBALS['db']->getOne($sql_count);
		
		
		$GLOBALS['tmpl']->assign("comment_list",$comment_list);

		$page = new Page($comment_count,$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);	
				
		
		$GLOBALS['tmpl']->display("comment_send.html");
	}
	
	
}
?>