<?php
// +----------------------------------------------------------------------
// | Fanwe 方维众筹商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------

//用于队列的发送
require './system/common.php';
require './app/Lib/common.php';
es_session::close();
set_time_limit(0);
if($_REQUEST['act']=='notify_msg_list')
{
	$deal_id = intval($GLOBALS['db']->getOne("select deal_id from ".DB_PREFIX."deal_notify order by create_time asc limit 1"));
	if($deal_id>0)
	{
		$deal_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal where id = ".$deal_id);
		//一次性生成50条
		$deal_notify_items = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."user_deal_notify where deal_id = ".$deal_id." order by create_time asc limit 50");
		$ids = array(0);
		foreach($deal_notify_items as $k=>$v)
		{
			$ids[] = $v['id'];
		}
		$GLOBALS['db']->query("delete from ".DB_PREFIX."user_deal_notify where id in (".implode(",",$ids).")");
		if($GLOBALS['db']->affected_rows()==count($deal_notify_items))
		{
			$deal_count = intval($GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."user_deal_notify where deal_id = ".$deal_id));
			if($deal_count==0)
			$GLOBALS['db']->query("delete from ".DB_PREFIX."deal_notify where deal_id = ".$deal_id);
			//开始发送通知
			foreach ($deal_notify_items as $k=>$v)
			{
				send_notify($v['user_id'],$deal_info['name']." 在 ".to_date($deal_info['success_time'])." 成功筹到 ".format_price($deal_info['limit_price']),"deal#show","id=".$deal_info['id']);
			}
		}
		header("Content-Type:text/html; charset=utf-8");
		echo 1;
	}
	else
	{
		header("Content-Type:text/html; charset=utf-8");
		echo 0;
	}
}

if($_REQUEST['act']=='deal_msg_list')
{
	//业务队列的群发
	$GLOBALS['db']->query("update ".DB_PREFIX."conf set `value` = 1 where name = 'DEAL_MSG_LOCK' and `value` = 0");
	$rs = $GLOBALS['db']->affected_rows();
	if($rs)
	{
		$msg_item = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_msg_list where is_send = 0 order by id asc limit 1");

		if($msg_item)
		{
			//优先改变发送状态,不论有没有发送成功
			$GLOBALS['db']->query("update ".DB_PREFIX."deal_msg_list set is_send = 1,send_time='".get_gmtime()."' where id =".intval($msg_item['id']));
			if($msg_item['send_type']==0)
			{
				//短信
				require_once APP_ROOT_PATH."system/utils/es_sms.php";
				$sms = new sms_sender();
				$result = $sms->sendSms($msg_item['dest'],$msg_item['content']);
				//发送结束，更新当前消息状态
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_msg_list set is_success = ".intval($result['status']).",result='".$result['msg']."' where id =".intval($msg_item['id']));
			}

			if($msg_item['send_type']==1)
			{
				//邮件
				require_once APP_ROOT_PATH."system/utils/es_mail.php";
				$mail = new mail_sender();

				$mail->AddAddress($msg_item['dest']);
				$mail->IsHTML($msg_item['is_html']); 				  // 设置邮件格式为 HTML
				$mail->Subject = $msg_item['title'];   // 标题
				$mail->Body = $msg_item['content'];  // 内容

				$is_success = $mail->Send();
				$result = $mail->ErrorInfo;

				//发送结束，更新当前消息状态
				$GLOBALS['db']->query("update ".DB_PREFIX."deal_msg_list set is_success = ".intval($is_success).",result='".$result."' where id =".intval($msg_item['id']));
			}
		}
		header("Content-Type:text/html; charset=utf-8");
		echo intval($GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal_msg_list where is_send = 0"));
		$GLOBALS['db']->query("update ".DB_PREFIX."conf set `value` = 0 where name = 'DEAL_MSG_LOCK'");
	}
	else
	{
		header("Content-Type:text/html; charset=utf-8");
		echo 0;
	}
}




if($_REQUEST['act']=='promote_msg_list')
{
	//推广队列的群发
	$GLOBALS['db']->query("update ".DB_PREFIX."conf set `value` = 1 where name = 'PROMOTE_MSG_LOCK' and `value` = 0");
	$rs = $GLOBALS['db']->affected_rows();
	if($rs)
	{
		$promote_msg = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."promote_msg where send_status <> 2 and send_time <= ".get_gmtime()." order by id asc limit 1");

		if($promote_msg)
		{
			$last_id = intval($GLOBALS['db']->getOne("select value from ".DB_PREFIX."conf where name = 'PROMOTE_MSG_PAGE'"));

			//开始更新为发送中
			$GLOBALS['db']->query("update ".DB_PREFIX."promote_msg set send_status = 1 where id = ".intval($promote_msg['id'])." and send_status <> 2");
			switch(intval($promote_msg['send_type']))
			{
				case 0: //会员组

					if($promote_msg['type']==0)
					{
						//短信
						$sql = "select u.id,u.ex_contact from ".DB_PREFIX."user as u where u.ex_contact <> '' ";
						$sql.=" and u.id > ".$last_id." order by u.id asc";
						$res = $GLOBALS['db']->getRow($sql);
						$dest = $res['ex_contact'];
						$last_id = $res['id'];
					}

					if($promote_msg['type']==1)
					{
						//邮件
						$sql = "select u.id,u.email from ".DB_PREFIX."user as u where u.email <> '' ";
						$sql.=" and u.id > ".$last_id." order by u.id asc";
						$res = $GLOBALS['db']->getRow($sql);
						$dest = $res['email'];
						$last_id = $res['id'];
					}
					break;
				case 1: //订阅
					$city_id = intval($promote_msg['send_type_id']);

					$ids_util = new ChildIds("deal_city");
					$ids = $ids_util->getChildIds($city_id);
					$ids[] = $city_id;
					$ids_str = implode(",",$ids);

					if($promote_msg['type']==0)
					{
						//短信
						$sql = "select id,mobile from ".DB_PREFIX."mobile_list where mobile <> '' and is_effect = 1 ";
						if($city_id>0)
						{
							$sql.=" and city_id in(".$ids_str.") ";
						}
						$sql.=" and id > ".$last_id." order by id asc";

						$res = $GLOBALS['db']->getRow($sql);
						$dest = $res['ex_contact'];
						$last_id = $res['id'];
					}

					if($promote_msg['type']==1)
					{
						//邮件
						$sql = "select id,mail_address from ".DB_PREFIX."mail_list where mail_address <> '' and is_effect = 1 ";
						if($city_id>0)
						{
							$sql.=" and city_id in(".$ids_str.") ";
						}
						$sql.=" and id > ".$last_id." order by id asc";
						$res = $GLOBALS['db']->getRow($sql);
						$dest = $res['mail_address'];
						$last_id = $res['id'];
					}

					break;
				case 2: //自定义
					$send_define_data = trim($promote_msg['send_define_data']); //自定义的内容
					$dest_array = preg_split("/[ ,]/i",$send_define_data);

					foreach($dest_array as $k=>$v)
					{
						$rs = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."promote_msg_list where msg_id = ".intval($promote_msg['id'])." and dest = '".$v."'");
						if($rs==0)
						{
							$dest = $v;
							break;
						}
					}
					$last_id = 0;
					break;
			}

			if($dest)
			{
				//开始创建一个新的发送队列
				$msg_data['dest'] = $dest;
				$msg_data['send_type'] = $promote_msg['type'];
				$msg_data['content'] = addslashes($promote_msg['content']);
				$msg_data['title'] = $promote_msg['title'];
				$msg_data['send_time'] = 0;
				$msg_data['is_send'] = 0;
				$msg_data['create_time'] = get_gmtime();
				$msg_data['user_id'] = 0;
				$msg_data['is_html'] = $promote_msg['is_html'];
				$msg_data['msg_id'] = $promote_msg['id'];
				$GLOBALS['db']->autoExecute(DB_PREFIX."promote_msg_list",$msg_data); //插入
				if($id = $GLOBALS['db']->insert_id())
				{
					$msg_item = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."promote_msg_list where id = ".$id);

					if($msg_item)
					{
						//优先改变发送状态,不论有没有发送成功
						$GLOBALS['db']->query("update ".DB_PREFIX."promote_msg_list set is_send = 1,send_time='".get_gmtime()."' where id =".intval($msg_item['id']));

						if($msg_item['send_type']==0)
						{
							//短信
							require_once APP_ROOT_PATH."system/utils/es_sms.php";
							$sms = new sms_sender();
							$result = $sms->sendSms($msg_item['dest'],$msg_item['content']);
							//发送结束，更新当前消息状态
							$GLOBALS['db']->query("update ".DB_PREFIX."promote_msg_list set is_success = ".intval($result['status']).",result='".$result['msg']."' where id =".intval($msg_item['id']));
						}

						if($msg_item['send_type']==1)
						{
							//邮件
							require_once APP_ROOT_PATH."system/utils/es_mail.php";
							$mail = new mail_sender();

							$mail->AddAddress($msg_item['dest']);
							$mail->IsHTML($msg_item['is_html']); 				  // 设置邮件格式为 HTML
							$mail->Subject = $msg_item['title'];   // 标题
							//发送推广邮件时加上退订的内容
							if($msg_item['is_html'])
								$msg_item['content'] .= "<br />".sprintf(app_conf("UNSUBSCRIBE_MAIL_TIP"),app_conf("SHOP_TITLE"),"<a href='".get_domain().APP_ROOT."/tuan.php?ctl=subscribe&act=unsubscribe&code=".base64_encode($msg_item['dest'])."'>".$GLOBALS['lang']['CANCEN_EMAIL']."</a>");
							else
								$msg_item['content'] .= " \n ".sprintf(app_conf("UNSUBSCRIBE_MAIL_TIP"),app_conf("SHOP_TITLE"),$GLOBALS['lang']['CANCEN_EMAIL'].get_domain().APP_ROOT."/tuan.php?ctl=subscribe&act=unsubscribe&code=".base64_encode($msg_item['dest']));

							$mail->Body = $msg_item['content'];  // 内容

							$is_success = $mail->Send();
							$result = $mail->ErrorInfo;

							//发送结束，更新当前消息状态
							$GLOBALS['db']->query("update ".DB_PREFIX."promote_msg_list set is_success = ".intval($is_success).",result='".$result."' where id =".intval($msg_item['id']));
						}
					}
				}
				$GLOBALS['db']->query("update ".DB_PREFIX."conf set value = ".intval($last_id)." where name='PROMOTE_MSG_PAGE'");
			}
			else //当没有目标可以发送时。完成发送
			{
				$GLOBALS['db']->query("update ".DB_PREFIX."promote_msg set send_status = 2 where id = ".intval($promote_msg['id']));
				$GLOBALS['db']->query("update ".DB_PREFIX."conf set value = 0 where name='PROMOTE_MSG_PAGE'");
			}
		}
		header("Content-Type:text/html; charset=utf-8");
		echo intval($GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."promote_msg where send_status <> 2 and send_time <=".get_gmtime()));
		$GLOBALS['db']->query("update ".DB_PREFIX."conf set `value` = 0 where name = 'PROMOTE_MSG_LOCK'");
	}
	else
	{
		header("Content-Type:text/html; charset=utf-8");
		echo 0;
	}
}
?>