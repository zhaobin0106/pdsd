<?php
/** 初始化筛选列表 */
class init_filter_list
{
	public function index()
	{
		$article_cates_list = $this->getArticleCatesList ();
		$state_list = $this->getStateList ();
		$equity_state_list = $this->getEquityStateList ();
		$cate_list = $this->getCateList ();
		
		$data = responseSuccessInfo ( "初始化筛选列表" );
		$data ['article_cates_list'] = $article_cates_list;
		$data ['state_list'] = $state_list;
		$data ['equity_state_list'] = $equity_state_list;
		$data ['cate_list'] = $cate_list;
		output ( $data );
	}
	// wap文章分类栏
	public function getArticleCatesList()
	{
		$article_cates_list = $GLOBALS ['db']->getAllCached ( "select ac.id,ac.title from " . DB_PREFIX . "article_cate ac where ac.is_effect=1 and ac.is_delete=0 and ac.type_id=0 order by ac.id asc" );
		$cates_list = array ();
		foreach ( $article_cates_list as $k => $v )
		{
			$cates_list [$k] ['title'] = $v ['title'];
			$cates_list [$k] ['id'] = $v ['id'];
		}
		return $cates_list;
	}
	// 普通众筹状态
	public function getStateList()
	{
		$state_list = array (
				0 => array (
						"name" => "所有项目" 
				),
				1 => array (
						"name" => "筹资成功" 
				),
				2 => array (
						"name" => "筹资失败" 
				),
				3 => array (
						"name" => "筹资中" 
				) 
		);
		return $state_list;
	}
	// 股权众筹状态
	public function getEquityStateList()
	{
		$equity_list = array (
				0 => array (
						"name" => "所有项目",
						"state" => "0" 
				),
				1 => array (
						"name" => "筹资成功",
						"state" => "1" 
				),
				2 => array (
						"name" => "筹资失败",
						"state" => "2" 
				),
				3 => array (
						
						"name" => "融资中",
						"state" => "3" 
				)
				 
		);
		return $equity_list;
	}
	// 众筹分类列表
	public function getCateList()
	{
		$cate_list = load_dynamic_cache ( "INDEX_CATE_LIST" );
		if (! $cate_list)
		{
			$cate_list = $GLOBALS ['db']->getAll ( "select * from " . DB_PREFIX . "deal_cate order by sort asc" );
			set_dynamic_cache ( "INDEX_CATE_LIST", $cate_list );
		}
		$cate_new_list = array ();
		$cate_new_list [0] ['id'] = '0';
		$cate_new_list [0] ['name'] = "全部";
		foreach ( $cate_list as $k => $v )
		{
			$cate_new_list [$k + 1] ['id'] = $v ['id'];
			$cate_new_list [$k + 1] ['name'] = $v ['name'];
		}
		return $cate_new_list;
	}
}

?>