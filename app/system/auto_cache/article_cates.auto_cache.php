<?php
//底部文章
class article_cates_auto_cache extends auto_cache{
	public function load($param)
	{
		$key = $this->build_key(__CLASS__,$param);
		$GLOBALS['fcache']->set_dir(APP_ROOT_PATH."public/runtime/data/".__CLASS__."/");
		$article_cates = $GLOBALS['fcache']->get($key);
		if($article_cates === false)
		{
			
			$article_cates = $GLOBALS['db']->getAll("select ac.*,fa.num from ".DB_PREFIX."article_cate as ac left join (SELECT count(*) as num,cate_id from ".DB_PREFIX."article GROUP BY cate_id) as fa on fa.cate_id=ac.id  where ac.is_effect=1 and  ac.is_delete=0  order by sort asc");
			foreach($article_cates as $k=>$v){
				$article_cates[$k]['num']=intval($v['num']);
				$article_cates[$k]['url']=url('article',array('id'=>$v['id']));
			}
			$GLOBALS['fcache']->set_dir(APP_ROOT_PATH."public/runtime/data/".__CLASS__."/");
			$GLOBALS['fcache']->set($key,$article_cates);
		}
		return $article_cates;
	}
	public function rm($param)
	{
		$key = $this->build_key(__CLASS__,$param);
		$GLOBALS['fcache']->set_dir(APP_ROOT_PATH."public/runtime/data/".__CLASS__."/");
		$GLOBALS['fcache']->rm($key);
	}
	public function clear_all()
	{
		$GLOBALS['fcache']->set_dir(APP_ROOT_PATH."public/runtime/data/".__CLASS__."/");
		$GLOBALS['fcache']->clear();
	}
}
?>