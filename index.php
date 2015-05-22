<?php 
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------

require './system/common.php';
require './app/Lib/App.class.php';

if($_REQUEST['is_pc']==1)
	es_cookie::set("is_pc","1",24*3600*30);
 
if (isMobile() && !isset($_REQUEST['is_pc']) && es_cookie::get("is_pc")!=1&&is_dir(APP_ROOT_PATH."wap")){
	app_redirect(APP_ROOT."/wap/index.php");
}else{
 	//实例化一个网站应用实例
	$AppWeb = new App();
}
//实例化一个网站应用实例
 

?>