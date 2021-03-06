<?php
//底部文章
class new_hepls_auto_cache extends auto_cache{
	public function load($param)
	{
		$key = $this->build_key(__CLASS__,$param);
		$GLOBALS['fcache']->set_dir(APP_ROOT_PATH."public/runtime/data/".__CLASS__."/");
		$new_hepls = $GLOBALS['fcache']->get($key);
		if($new_hepls === false)
		{
			
			$new_hepls = load_auto_cache('article_cates');
			$article_array=$GLOBALS['db']->getAll("select * from ".DB_PREFIX."article where is_effect=1 order by sort desc ");
			foreach($new_hepls as $k=>$v){
				if($v['type_id'] == 1&&$v['num']>0){
					foreach($article_array as $article_k=>$article_v){
						if($article_v['cate_id']==$v['id']){
							if($article_v['rel_url']==""){
								$article_v['url']=url('article',array('id'=>$article_v['id']));
 							}else{
								$article_v['url']=$article_v['rel_url'];
							}
							$new_hepls[$k]['article'][]=$article_v;
						}
					}
				}
				else{
					unset($new_hepls[$k]);
				}
			}
 			$new_hepls=array_filter($new_hepls);
			$GLOBALS['fcache']->set_dir(APP_ROOT_PATH."public/runtime/data/".__CLASS__."/");
			$GLOBALS['fcache']->set($key,$new_hepls);
		}
		return $new_hepls;
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