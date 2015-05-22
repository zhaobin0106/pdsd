<?php
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------

require APP_ROOT_PATH.'app/Lib/shop_lip.php';
class helpModule extends BaseModule
{
	public function index()
	{	
                //links
                $g_links =get_link_by_id(14);
                
                $GLOBALS['tmpl']->assign("g_links",$g_links);
		$act = strim($_REQUEST['act']);
		$GLOBALS['tmpl']->caching = true;
		$cache_id  = md5(MODULE_NAME.ACTION_NAME.$act);		
		if (!$GLOBALS['tmpl']->is_cached('help_index.html', $cache_id))
		{
			$help_item = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."help where type = '".$act."' or id = ".intval($act));
			if($help_item)
			{			
				$GLOBALS['tmpl']->assign("help_item",$help_item);
				$GLOBALS['tmpl']->assign("page_title",$help_item['title']);
			}
			else
			{
				app_redirect(url("index"));
			}
		}
		$GLOBALS['tmpl']->display("help_index.html",$cache_id);
	}

	
	
}
?>