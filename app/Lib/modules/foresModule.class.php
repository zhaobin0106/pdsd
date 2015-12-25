<?php
// +----------------------------------------------------------------------
// | Fanwe 方维o2o商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------
require APP_ROOT_PATH.'app/Lib/shop_lip.php';
require APP_ROOT_PATH.'app/Lib/page.php';
class foresModule extends BaseModule
{
	public function index()
	{	
		if(strim($_REQUEST['type'])==1 && app_conf("INVEST_STATUS")==1)
		{
			showErr("股权众筹已经关闭");
		}
		if(app_conf("INVEST_STATUS")==2 && strim($_REQUEST['type'])==null)
		{
			showErr("产品众筹已经关闭");
		}
		
		$image_list = load_dynamic_cache("FORESIMAGE_LIST");
		if($image_list===false)
		{
			$image_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."index_image where type = 2 order by sort asc");
			set_dynamic_cache("FORES_IMAGE_LIST",$image_list);
		}
		$GLOBALS['tmpl']->assign("image_list",$image_list);
		$GLOBALS['tmpl']->assign("xdog",3);
         //links
        $g_links =get_link_by_id(14);
        
        $GLOBALS['tmpl']->assign("g_links",$g_links);
        $GLOBALS['tmpl']->assign("page_title","最新动态");
        
         $param = array();//参数集合
           
         //数据来源参数
		$r = strim($_REQUEST['r']);   //推荐类型
        $param['r'] = $r?$r:'';
		$GLOBALS['tmpl']->assign("p_r",$r);
                
		$id = intval($_REQUEST['id']);  //分类id
		$param['id'] = $id;
		$GLOBALS['tmpl']->assign("p_id",$id);
		
		$loc = strim($_REQUEST['loc']);  //地区
		$param['loc'] = $loc;
		$GLOBALS['tmpl']->assign("p_loc",$loc);
        
        $state = intval($_REQUEST['state']);  //状态
        $param['state'] = $state;
		$GLOBALS['tmpl']->assign("p_state",$state);
                
		$tag = strim($_REQUEST['tag']);  //标签
		$param['tag'] = $tag;
		$GLOBALS['tmpl']->assign("p_tag",$tag);
                
		$kw = strim($_REQUEST['k']);    //关键词
		$param['k'] = $kw;
		$GLOBALS['tmpl']->assign("p_k",$kw);
		        
        $type = intval($_REQUEST['type']);   //推荐类型
        $param['type'] = $type;
		$GLOBALS['tmpl']->assign("p_type",$type);  
        
       
		if(intval($_REQUEST['redirect'])==1)
		{
  			app_redirect(url("fores",$param));
		}
		 
 		$cate_list = load_dynamic_cache("INDEX_CATE_LIST");
		
		if(!$cate_list)
		{
			$cate_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."deal_cate where is_delete=0 order by sort asc");
			set_dynamic_cache("INDEX_CATE_LIST",$cate_list);
		}
		$cate_result = array();
		foreach($cate_list as $k=>$v){
			if($v['pid'] == 41){
				$temp_param = $param;
				$cate_result[$k+1]['id'] = $v['id'];
				$cate_result[$k+1]['name'] = $v['name'];
				$temp_param['id'] = $v['id'];
				$cate_result[$k+1]['url'] = url("fores",$temp_param);
			}
		}
		
		$GLOBALS['tmpl']->assign("cate_list",$cate_result);
		
		$pid = $id;
		//获取父类id
		
		if($cate_list){
			$pid = $this->get_child($cate_list,$pid);
		}
		/*子分类 start*/
		$cate_ids = array();
		$is_child = false;
		$temp_cate_ids = array();
		
		if($cate_list){
			$child_cate_result= array();
			foreach($cate_list as $k=>$v)
			{
				if($v['pid'] == $pid){
					if($v['id'] > 0){
						$temp_param = $param;
						$child_cate_result[$v['id']]['id'] = $v['id'];
						$child_cate_result[$v['id']]['name'] = $v['name'];
						$temp_param['id'] = $v['id'];
						$child_cate_result[$v['id']]['url'] = url("fores",$temp_param);
						 if($id==$v['id']){
						 	$is_child = true;
						 }
						
					}
				}
				if($v['pid'] == $pid || $pid==0){
					$temp_cate_ids[] = $v['id'];
				}
			}		
		}
		
		//假如选择了子类 那么使用子类ID  否则使用 父类和其子类
		if($is_child){
			$cate_ids[] = $id;
		}
		else{
			$cate_ids[] = $pid;
			$cate_ids = array_merge($cate_ids,$temp_cate_ids);
		}
 		$cate_ids=array_filter($cate_ids);
		$GLOBALS['tmpl']->assign("child_cate_list",$child_cate_result);
		$GLOBALS['tmpl']->assign("pid",$pid);
		
		/*子分类 end*/
       $city_list = load_dynamic_cache("INDEX_CITY_LIST"); 
        if(!$city_list)
		{
			$city_list = $GLOBALS['db']->getAll("select province from ".DB_PREFIX."fore group by province order by sort asc");
			set_dynamic_cache("INDEX_CITY_LIST",$city_list);
		}
		foreach($city_list as $k=>$v){
			$temp_param = $param;
			$temp_param['loc'] = $v['province'];
			$city_list[$k]['url'] = url("fores",$temp_param);
		}
        	
		$GLOBALS['tmpl']->assign("city_list",$city_list);
		//============region_conf============
		$area_list = $GLOBALS['db']->getAll("select rc.* from ".DB_PREFIX."region_conf as rc where rc.name in (select province from ".DB_PREFIX."deal) or  rc.name in (select city from ".DB_PREFIX."deal) or rc.is_hot=1 ");
		$area=array();
		$hot_area=array();
		foreach($area_list as $k=>$v){
			$temp_param['loc'] = $v['name'];
			$area[strtoupper($v['py'][0])][$v['name']]=array('url'=> url("fores",$temp_param),'name'=>$v['name']);
			if($v['is_hot']){
				$hot_area[]=array('url'=> url("fores",$temp_param),'name'=>$v['name']);
			}
 			
		}
		ksort($area);
 		$area_array=array();
		
	
 		$area_array=array_chunk(array_filter($area),4,true);
		$area_array_num=array();
 		foreach($area_array as $k=>$v){
			foreach($v as $k1=>$v1){
				$area_array_str[$k].=$k1;
			}
		}
		
 		$GLOBALS['tmpl']->assign("area_array",$area_array);
		$GLOBALS['tmpl']->assign("area_array_str",$area_array_str);
		$GLOBALS['tmpl']->assign("hot_area",array_filter($hot_area));
		
		//=================region_conf==============
		if($type==1){
			$state_list = array(
				1=>array("name"=>"筹资成功"),
				2=>array("name"=>"筹资失败"),
				3=>array("name"=>"融资中"),
			);
		}else{
			$state_list = array(
				1=>array("name"=>"筹资成功"),
				2=>array("name"=>"筹资失败"),
				3=>array("name"=>"筹资中"),
			);
		}
		
		
		foreach($state_list as $k=>$v){
			$temp_param = $param;
			$temp_param['state'] = $k;
			$state_list[$k]['url'] = url("fores",$temp_param);
		}
		$GLOBALS['tmpl']->assign("state_list",$state_list);

		$page_size = DEAL_PAGE_SIZE;
		$step_size = DEAL_STEP_SIZE;
		
		$step = intval($_REQUEST['step']);
		if($step==0)$step = 1;
		$page = intval($_REQUEST['p']);
		if($page==0)$page = 1;		
		$limit = (($page-1)*$page_size+($step-1)*$step_size).",".$step_size	;
		
		$GLOBALS['tmpl']->assign("current_page",$page);
		
		$condition = " d.is_delete = 0 and d.is_effect = 1 "; 
		if($r!="")
		{
			if($r=="new")
			{
				$condition.=" and ".NOW_TIME." - d.begin_time < ".(24*3600)." and ".NOW_TIME." - d.begin_time > 0 ";  //上线不超过一天
				$GLOBALS['tmpl']->assign("page_title","最新上线");
			}
			if($r=="rec")
			{
				$condition.=" and ".NOW_TIME." <= d.end_time AND ".NOW_TIME." >= d.begin_time and d.is_recommend = 1 ";
				$GLOBALS['tmpl']->assign("page_title","推荐项目");
			}
            if($r=="yure")
			{
				$condition.=" and ".NOW_TIME." - d.begin_time < ".(24*3600)." and ".NOW_TIME." - d.begin_time <  0 ";  //上线不超过一天
				$GLOBALS['tmpl']->assign("page_title","正在预热");
			}
			if($r=="nend")
			{
				$condition.=" and d.end_time - ".NOW_TIME." < ".(24*3600)." and d.end_time - ".NOW_TIME." > 0 ";  //当天就要结束
				$GLOBALS['tmpl']->assign("page_title","即将结束");
			}
			if($r=="classic")
			{
				$condition.=" and d.is_classic = 1 ";
				$GLOBALS['tmpl']->assign("page_title","经典项目");
				$GLOBALS['tmpl']->assign("is_classic",true);
			}
			if($r=="limit_price")
			{
				$condition.=" and max(d.limit_price) ";
				$GLOBALS['tmpl']->assign("page_title","最高目标金额");
			}
		}
		switch($state)
		{
			//筹资成功
			case 1 : 
				$condition.=" and d.is_success=1  "; 
				$GLOBALS['tmpl']->assign("page_title","筹资成功");
				break;
			//筹资失败
			case 2 : 
				$condition.=" and d.end_time < ".NOW_TIME." and d.end_time!=0  and d.is_success=0  "; 
				$GLOBALS['tmpl']->assign("page_title","筹资失败");
				break;
			//筹资中
			case 3 : 
				$condition.=" and (d.end_time > ".NOW_TIME." or d.end_time=0 ) and d.begin_time < ".NOW_TIME." and d.is_success=0  ";  
				$GLOBALS['tmpl']->assign("page_title","筹资中");
			break;
		}
		if(count($cate_ids)>0)
		{
			$condition.= " and d.cate_id in (".implode(",",$cate_ids).")";
			$GLOBALS['tmpl']->assign("page_title",$cate_result[$id]['name']);
                        
		}
		if($loc!="")
        {
            $condition.=" and (d.province = '".$loc."' or city = '".$loc."') ";
			$GLOBALS['tmpl']->assign("page_title",$loc);            
		}
		
		if($type!=="")
        {
        	$type=intval($type);
            $condition.=" and type=$type ";
			$GLOBALS['tmpl']->assign("page_title",$loc);            
		}
		
		if($tag!="")
		{
			$unicode_tag = str_to_unicode_string($tag);
			$condition.=" and match(d.tags_match) against('".$unicode_tag."'  IN BOOLEAN MODE) ";
			$GLOBALS['tmpl']->assign("page_title",$tag);
		}
		
		
		if($kw!="")
		{		
			$kws_div = div_str($kw);
			foreach($kws_div as $k=>$item)
			{
				
				$kws[$k] = str_to_unicode_string($item);
			}
			$ukeyword = implode(" ",$kws);
			$condition.=" and (match(d.name_match) against('".$ukeyword."'  IN BOOLEAN MODE) or match(d.tags_match) against('".$ukeyword."'  IN BOOLEAN MODE)  or d.name like '%".$kw."%') ";

			$GLOBALS['tmpl']->assign("page_title",$kw);
		}
		
		
		$result = get_fore_list($limit,$condition);
 		if($type==1){
 			$GLOBALS['tmpl']->assign("deal_list_invest",$result['list']);
		}else{
 			$GLOBALS['tmpl']->assign("fore_list",$result['list']);
		}
		
		$GLOBALS['tmpl']->assign("deal_count",$result['rs_count']);
		$page = new Page($result['rs_count'],$page_size);   //初始化分页对象 		
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);	
		 if($type==1){
			$GLOBALS['tmpl']->assign('deal_type','gq_type');
		}
		else{
			$GLOBALS['tmpl']->assign('deal_type','product_type');
		}	
 		if($GLOBALS['tmpl']->_var['page_title']==''){
 			$page_title='';
 			if($type==1){
 				foreach($GLOBALS['nav_list'] as $k=>$v){
 					if($v['u_module']=='fores'&&$v['u_action']=='index'&&$v['u_param']=='type=1'){
 						$page_title=$v['name'];
 					}
  				}
  				$page_title=$page_title?$page_title:'股权项目';
 			}else{
 				foreach($GLOBALS['nav_list'] as $k=>$v){
 					if($v['u_module']=='fores'&&$v['u_action']=='index'&&$v['u_param']==''){
 						$page_title=$v['name'];
 					}
 							
 				}
 				$page_title=$page_title?$page_title:'试吃';
 			}
 			$GLOBALS['tmpl']->assign("page_title",$page_title);
 		}
 		
		$GLOBALS['tmpl']->display("fores_index.html");
	}
	
	public function get_child($cate_list,$pid){
 			foreach($cate_list as $k=>$v)
			{
				if($v['id'] ==  $pid){
					if($v['pid'] > 0){
						//$pid =$this->get_child($cate_list,$v['pid']) ;
						//if($pid==$v['pid']){
							return $pid;
						//}
					}
					else{
						return $pid;
					}
				}
			}
	}

	
	
}
?>