<?php
// +----------------------------------------------------------------------
// | easethink 易想团购商城系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.easethink.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(88522820@qq.com)
// +----------------------------------------------------------------------
require APP_ROOT_PATH.'app/Lib/shop_lip.php';
require APP_ROOT_PATH.'app/Lib/page.php';
class articleModule extends BaseModule
{
	//文章详情
	public function index()
	{	
		 //友情链接
                $g_links =get_link_by_id(14);
         $GLOBALS['tmpl']->assign("g_links",$g_links);
         $GLOBALS['tmpl']->caching = true;
         
        //输出文章
		$id = intval($_REQUEST['id']);
		$article = $GLOBALS['db']->getRow("select a.*,ac.type_id from ".DB_PREFIX."article as a left join ".DB_PREFIX."article_cate as ac on ac.id=a.cate_id where a.id=$id");
		$cate_id=$article['cate_id'];
		
		$artilce_cate = load_auto_cache("article_cates"); 
		$artilce_cate_new=array();
		foreach($artilce_cate as $k=>$v)
		{
			if($v['type_id']==$article['type_id']&&$v['id']!=$cate_id&&$v['num']>0){
				$artilce_cate_new[$k]['cate_id']=$v['id'];
 				$artilce_cate_new[$k]['titles']=$v['title'];
 				$artilce_cate_new[$k]['url']=url('article_cate',array('id'=>$v['id']));
			}
 			
		}
 
		$GLOBALS['tmpl']->assign("other_cate",$artilce_cate_new); 
		//文章详细页面最新更新(控制最新的10条)
		$temp_article_list=$GLOBALS['db']->getAllCached("SELECT a.*,c.type_id from ".DB_PREFIX."article a LEFT JOIN ".DB_PREFIX."article_cate c on a.cate_id=c.id where 1=1 and a.is_delete=0 and a.is_effect=1 and c.type_id=".$article['type_id']." and a.cate_id=$cate_id and a.id!=$id  order by update_time desc limit 0,5");
		
		$article_list=array();
		foreach ($temp_article_list as $k=>$v){
			//最新更新
 				$article_list[$k]['cate_title']=$v['title'];
				if($v['rel_url']=="")
					$article_list[$k]['url']=url('article',array('id'=>$v['id']));
				else
					$article_list[$k]['url']=$v['rel_url'];
 		}
		unset($temp_article_list);
		$GLOBALS['tmpl']->assign('deal_type','article_type');
		//文章头部导航
		$nav_top=set_nav_top($GLOBALS['module'],$GLOBALS['action'],$id);
		$GLOBALS['tmpl']->assign('nav_top',$nav_top);
		
		$GLOBALS['tmpl']->assign("page_title",$article['seo_title']);
		$GLOBALS['tmpl']->assign("page_seo_keyword",$article['seo_keyword']);
		$GLOBALS['tmpl']->assign("page_seo_description",$article['seo_description']);
		$GLOBALS['tmpl']->assign("article",$article); 
		$GLOBALS['tmpl']->assign("article_list",$article_list);
		$GLOBALS['tmpl']->display("article_index.html");
	}
}
?>