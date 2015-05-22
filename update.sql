1.52;

ALTER TABLE `fanwe_user`
ADD COLUMN `identify_name`  varchar(255) NOT NULL COMMENT '身份证名称' ,
ADD COLUMN `identify_number`  varchar(255) NOT NULL COMMENT '身份证号码'  ,
ADD COLUMN `identify_positive_image`  varchar(255) NOT NULL COMMENT '身份证正面' ,
ADD COLUMN `identify_nagative_image`  varchar(255) NOT NULL COMMENT '身份证反面'  ;

ALTER TABLE `fanwe_user`
ADD COLUMN `identify_business_licence`  varchar(255) NOT NULL COMMENT '营业执照' ,
ADD COLUMN `identify_business_code`  varchar(255) NOT NULL COMMENT '组织机构代码证' ,
ADD COLUMN `identify_business_tax`  varchar(255) NOT NULL COMMENT '税务登记证' ,
ADD COLUMN `identify_business_name`  varchar(255) NOT NULL COMMENT '机构名称' ;

ALTER TABLE `fanwe_user`
ADD COLUMN `is_investor`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '判断是否为投资者，默认0表示非投资者，1表示投资者,2 表示机构投资者' ,
ADD COLUMN `mortgage_money`  int(11) NOT NULL COMMENT '诚意金' ;

ALTER TABLE `fanwe_user`
ADD COLUMN `investor_status`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '投资认证是否通过 0 表示审核申请中，1表示通过审核 ,2表示审核未通过'  ,
ADD COLUMN `investor_status_send`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '审核结果通知用户，0表示未发送，1表示已发送' ;




CREATE TABLE `fanwe_investment_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(11) NOT NULL DEFAULT '0' COMMENT '投资的类型 0 表示 询价，1表示领投，2表示跟投,3表示追加的金额',
  `money` int(11) NOT NULL COMMENT '投资的金额',
  `stock_value` int(11) NOT NULL DEFAULT '0' COMMENT '估指',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0表示 不同意，1表示同意',
  `introduce` text NOT NULL COMMENT '领投人的个人简介',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `deal_id` int(11) NOT NULL COMMENT '股权众筹ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资列表';



ALTER TABLE `fanwe_deal`
ADD COLUMN `type`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 表示普通众筹，1表示股权众筹' ;

CREATE TABLE `fanwe_deal_info_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL COMMENT '项目ID',
  `type` tinyint(1) NOT NULL COMMENT '类型 0 非股权团队 1 股权团队 2 项目历史 3 计划  4 项目附件',
  `name_list` text NOT NULL,
  `descrip_list` text NOT NULL,
  `pay_list` text NOT NULL COMMENT '支出列表',
  `income_list` text NOT NULL COMMENT '收入列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `fanwe_deal`
ADD COLUMN `description_2`  text NOT NULL COMMENT '目标用户或客户群体定位'  ,
ADD COLUMN `description_3`  text NOT NULL COMMENT '目标用户或客户群体目前困扰或需求定位'  ,
ADD COLUMN `description_4`  text NOT NULL COMMENT '满足目标用户或客户需求的产品或服务模式说明'  ,
ADD COLUMN `description_5`  text NOT NULL COMMENT '项目赢利模式说明' ,
ADD COLUMN `description_6`  text NOT NULL COMMENT '市场主要同行或竞争对手概述'  ,
ADD COLUMN `description_7`  text NOT NULL COMMENT '项目主要核心竞争力说明' ;


============================
INSERT INTO `fanwe_msg_template` VALUES ('5', 'TPL_MAIL_INVESTOR_STATUS', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 {$user.send_time_ms} 进行{$user.is_investor_name}申请，{if $user.investor_status eq 1}很高兴您审核通过,点击以下链接，即可进行下一步操作{else}很遗憾您的申请未通过,点击以下链接，即可重新申请{/if}：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.verify_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.verify_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n 				<div style=\"line-height:80px;height:80px;\"></div>\r\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');
INSERT INTO `fanwe_msg_template` VALUES ('6', 'TPL_SMS_INVESTOR_STATUS', '{$user.user_name}您好，{if $user.investor_status eq 1}恭喜您{else}很遗憾{/if},您申请的{$user.is_investor_name}{$user.investor_status_name}', '0', '0');


ALTER TABLE `fanwe_deal`
ADD COLUMN `investor_authority`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '0表示只有投资人可以，1表所有人都可以看' AFTER `description_7`,
ADD COLUMN `project_step`  tinyint(1) NOT NULL COMMENT '项目阶段 0表示未启动 1表示在开发中 2产品已上市或上线，3已经有收入，4已经盈利' AFTER `investor_authority`,
ADD COLUMN `business_create_time`  int(11) NOT NULL COMMENT '企业成立时间' AFTER `project_step`,
ADD COLUMN `business_employee_num`  int(11) NOT NULL COMMENT '企业员工数量' AFTER `business_create_time`,
ADD COLUMN `business_is_exist`  tinyint(1) NOT NULL COMMENT '公司是否成立' AFTER `business_employee_num`,
ADD COLUMN `has_another_project`  tinyint(1) NOT NULL COMMENT '是否有其他项目 0表示么有  1表示有' AFTER `business_is_exist`,
ADD COLUMN `business_name`  varchar(255) NOT NULL COMMENT '公司名称' AFTER `has_another_project`,
ADD COLUMN `business_address`  varchar(255) NOT NULL COMMENT '办公地址' AFTER `business_name`,
ADD COLUMN `business_stock_type`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '入股方式  0直接入股原公司 1 创建新公司入股' AFTER `business_address`,
ADD COLUMN `business_pay_type`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '付款方式 0表示一次性付款' AFTER `business_stock_type`,
ADD COLUMN `business_descripe`  text NOT NULL COMMENT '企业简介' AFTER `business_pay_type`;


ALTER TABLE `fanwe_deal`
ADD COLUMN `stock`  text NOT NULL COMMENT '股东信息' AFTER `description_7`,
ADD COLUMN `history`  text NOT NULL COMMENT '三年信息' AFTER `stock`,
ADD COLUMN `plan`  text NOT NULL COMMENT '三年计划' AFTER `history`,
ADD COLUMN `attach`  text NOT NULL COMMENT '附件信息' AFTER `plan`;

ALTER TABLE `fanwe_deal`
ADD COLUMN `unstock`  text NOT NULL COMMENT '非股东成员' AFTER `stock`;

ALTER TABLE `fanwe_deal`
ADD COLUMN `pay_end_time`  int(11) NOT NULL COMMENT '支付结算时间' AFTER `business_descripe`;

ALTER TABLE `fanwe_investment_list`
MODIFY COLUMN `status`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态 0表示 未来审核，1表示同意，2表示不同意' AFTER `stock_value`;

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `cates`  text NOT NULL COMMENT '分类信息' ;

ALTER TABLE `fanwe_payment_notice`
ADD COLUMN `is_mortgate`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是诚意金 0表示否 1表示 是 2表示诚意金已经冻结（从余额中取出）' ;

ALTER TABLE `fanwe_user`
ADD COLUMN `break_num`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '毁约次数';

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `create_time`  int(11) NOT NULL COMMENT '创建时间';

ALTER TABLE `fanwe_investment_list`
 ADD COLUMN `investment_reason`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '投资请求';

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `funding_to_help`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资金帮助';

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `investor_money_status`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '投资金额0 表示未审核 1表示审核通过 2表示审核拒绝 3表示已支付投资成功 4表示未按时间支付，违约';

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `order_id`  int(11) NOT NULL COMMENT '订单号' AFTER `investor_money_status`;

ALTER TABLE `fanwe_deal_order`
ADD COLUMN `type`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '订单类型 0表示普通众筹 1表示股权众筹' AFTER `num`;

ALTER TABLE `fanwe_deal`
ADD COLUMN `investor_edit`  int(1) NOT NULL COMMENT '0表示显示下一步按钮，1表示显示不错和返回按钮' ;

ALTER TABLE `fanwe_user_log`
ADD COLUMN `type`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '类型 0表示普通的 1表示 加入诚意金 2表示违约扣除诚意金' ;

CREATE TABLE `fanwe_mortgate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `notice_id` int(11) NOT NULL COMMENT '0 表示为余额支付 大于0表示在线支付',
  `money` int(11) NOT NULL COMMENT '诚意金 金额',
  `status` tinyint(1) NOT NULL COMMENT '状态 1表示诚意金支付 2表示扣除诚意金 3表示诚意金解冻到余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='诚意金列表';

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `is_partner`  tinyint(11) NOT NULL COMMENT '0表示无状态 1表示愿意承担企业合伙人 2表示不愿意承担企业合伙人';


INSERT INTO `fanwe_role_module` VALUES ('137', 'UserInvestor', '投资人申请管理', '1', '0');

INSERT INTO `fanwe_role_node` VALUES ('6867', 'index', '投资申请列表', '1', '0', '69', '137');


=================================
ALTER TABLE `fanwe_deal`
ADD COLUMN `mine_stock`    decimal(10,2) NULL COMMENT '投资人占有的股份' AFTER `investor_edit`;

ALTER TABLE `fanwe_deal`
ADD COLUMN `transfer_share`  decimal(10,2) NOT NULL;

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `leader_moban`  text NOT NULL COMMENT '尽职调查和条款清单模板' AFTER `is_partner`,
ADD COLUMN `leader_help`  text NOT NULL COMMENT '他为创业者还能提供的其它帮助' AFTER `leader_moban`,
ADD COLUMN `leader_for_team`  text NOT NULL COMMENT '对创业团队评价' AFTER `leader_help`,
ADD COLUMN `leader_for_project`  text NOT NULL COMMENT '对创业项目评价' AFTER `leader_for_team`;

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `detailed_information`  text NOT NULL COMMENT '详细资料';

========================================
ALTER TABLE `fanwe_deal`
ADD COLUMN `virtual_num`  int(11) NOT NULL COMMENT '虚拟人数',
ADD COLUMN `virtual_price`  double(20,4) NOT NULL COMMENT '虚拟金额';

ALTER TABLE `fanwe_deal`
ADD COLUMN `gen_num`  int(11) NOT NULL COMMENT '跟投人数' ,
ADD COLUMN `xun_num`  int(11) NOT NULL COMMENT '询价人数' ,
ADD COLUMN `invote_money`  double(20,4) NOT NULL COMMENT '预购金额'  ;

ALTER TABLE `fanwe_deal`
ADD COLUMN `invote_num`  int(11) NOT NULL COMMENT '投资人数';

=========================================
CREATE TABLE `fanwe_recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memo` text NOT NULL COMMENT '推荐理由',
  `deal_id` int(11) NOT NULL COMMENT '项目编号',
  `user_id` int(11) NOT NULL COMMENT '推送给哪个会员',
  `recommend_user_id` int(11) NOT NULL COMMENT '推送人ID',
  `create_time` int(11) NOT NULL COMMENT '推荐时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `fanwe_investment_list`
ADD COLUMN `send_type`  tinyint(1) NOT NULL DEFAULT '发送信息' COMMENT '0 表示未发送 1发送成功' AFTER `leader_for_project`;

ALTER TABLE `fanwe_recommend`
ADD COLUMN `deal_type`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '项目类型 0表示普通项目 1表示股权项目';

ALTER TABLE `fanwe_recommend`
ADD COLUMN `deal_name`  varchar(255) NOT NULL COMMENT '项目名称';

ALTER TABLE `fanwe_recommend`
ADD COLUMN `deal_image`  varchar(255) NOT NULL COMMENT '推荐项目图片';

INSERT INTO `fanwe_help` VALUES ('7', '撰写指南', '', 'write_guide', '', '1', '1');

=======================================================
ALTER TABLE `fanwe_user`
ADD COLUMN `wx_openid`  varchar(255) NOT NULL COMMENT '微信openid' AFTER `break_num`;

INSERT INTO `fanwe_msg_template` VALUES ('25', 'TPL_MAIL_INVESTOR_PAY_STATUS', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}您好，您的投资申请已通过，请在{$user.pay_end_time}前进行支付{$user.money}元</p>\r\n				\r\n  				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');
INSERT INTO `fanwe_msg_template` VALUES ('26', 'TPL_SMS_INVESTOR_PAY_STATUS', '{$user.user_name}您好，您的投资申请已通过，请在{$user.pay_end_time}前进行支付{$user.money}元', '0', '0');

INSERT INTO `fanwe_conf` VALUES ('266', 'MORTGAGE_MONEY', '0.01', '6', '0', '', '1', '1', '1');
INSERT INTO `fanwe_conf` VALUES ('267', 'ENQUIER_NUM', '6', '6', '0', '', '1', '1', '2');
INSERT INTO `fanwe_conf` VALUES ('268', 'INVEST_PAY_SEND_STATUS', '1', '6', '1', '0,1,2', '1', '1', '3');

INSERT INTO `fanwe_m_config` VALUES ('36', 'wx_appid', '微信APPID', '', '0', '36');
INSERT INTO `fanwe_m_config` VALUES ('37', 'wx_secrit', '微信SECRIT', '', '0', '37');

============================================================

ALTER TABLE `fanwe_investment_list`
MODIFY COLUMN `money`  double(20,2) NOT NULL COMMENT '投资的金额' AFTER `type`,
MODIFY COLUMN `stock_value`  double(20,2) NOT NULL DEFAULT 0 COMMENT '估指' AFTER `money`;
==============================================================================================

ALTER TABLE `fanwe_user`
MODIFY COLUMN `mortgage_money`  double(20,2) NOT NULL COMMENT '用户诚意金';

ALTER TABLE `fanwe_payment_notice`
ADD COLUMN `paid_send`  tinyint(1) NOT NULL COMMENT '支付成功后是否发送' AFTER `is_mortgate`;

INSERT INTO `fanwe_conf` VALUES ('269', 'INVEST_STATUS_SEND_STATUS', '1', '6', '1', '0,1,2', '1', '1', '4');
INSERT INTO `fanwe_conf` VALUES ('270', 'INVEST_PAID_SEND_STATUS', '1', '6', '1', '0,1,2', '1', '1', '5');

INSERT INTO `fanwe_msg_template` VALUES ('27', 'TPL_SMS_INVESTOR_PAID_STATUS', '恭喜您，已经支付{$user.paid_money}元,支付单号为{$user.notice_sn}', '0', '0');
INSERT INTO `fanwe_msg_template` VALUES ('28', 'TPL_MAIL_INVESTOR_PAID_STATUS', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}您好，恭喜您，已经支付{$user.paid_money}元,支付单号为{$user.notice_sn}</p>\r\n				\r\n  				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');


ALTER TABLE `fanwe_deal`
MODIFY COLUMN `limit_price`  decimal(20,2) NOT NULL COMMENT '项目金额' AFTER `is_effect`,
MODIFY COLUMN `support_amount`  decimal(20,2) NOT NULL COMMENT '支持总金额，需大等于limit_price(不含运费)' AFTER `log_count`,
MODIFY COLUMN `pay_amount`  decimal(20,2) NOT NULL COMMENT '可发放金额，抽完佣金的可领金额（含运费，运费不抽佣金）\r\n即support_amount*佣金比率+delivery_fee_amount' AFTER `support_amount`,
MODIFY COLUMN `delivery_fee_amount`  decimal(20,2) NOT NULL COMMENT '交付费用金额' AFTER `pay_amount`,
MODIFY COLUMN `pay_radio`  decimal(20,2) NOT NULL AFTER `is_has_send_success`,
MODIFY COLUMN `virtual_price`  decimal(20,2) NOT NULL COMMENT '虚拟金额' AFTER `virtual_num`,
MODIFY COLUMN `invote_money`  decimal(20,2) NOT NULL COMMENT '预购金额' AFTER `xun_num`;


ALTER TABLE `fanwe_deal_item`
MODIFY COLUMN `price`  decimal(20,2) NOT NULL COMMENT '金额' AFTER `deal_id`,
MODIFY COLUMN `support_amount`  decimal(20,2) NOT NULL COMMENT '支持量' AFTER `support_count`,
MODIFY COLUMN `delivery_fee`  decimal(20,2) NOT NULL COMMENT '支付金额' AFTER `is_delivery`;

ALTER TABLE `fanwe_deal_order`
MODIFY COLUMN `total_price`  decimal(20,2) NOT NULL COMMENT '总价' AFTER `pay_time`,
MODIFY COLUMN `delivery_fee`  decimal(20,2) NOT NULL COMMENT '运费' AFTER `total_price`,
MODIFY COLUMN `deal_price`  decimal(20,2) NOT NULL COMMENT '项目费用' AFTER `delivery_fee`,
MODIFY COLUMN `credit_pay`  decimal(20,2) NOT NULL COMMENT '信贷付款' AFTER `bank_id`,
MODIFY COLUMN `online_pay`  decimal(20,2) NOT NULL COMMENT '在线付款' AFTER `credit_pay`;

ALTER TABLE `fanwe_deal_support_log`
MODIFY COLUMN `price`  decimal(20,2) NOT NULL COMMENT '金额' AFTER `create_time`;

ALTER TABLE `fanwe_investment_list`
MODIFY COLUMN `money`  decimal(20,2) NOT NULL COMMENT '投资的金额' AFTER `type`,
MODIFY COLUMN `stock_value`  decimal(20,2) NOT NULL DEFAULT 0.0000 COMMENT '估指' AFTER `money`;


ALTER TABLE `fanwe_payment`
MODIFY COLUMN `total_amount`  decimal(20,2) NOT NULL COMMENT '总金额' AFTER `description`;


ALTER TABLE `fanwe_payment_notice`
MODIFY COLUMN `money`  decimal(20,2) NOT NULL COMMENT '金额' AFTER `memo`;

ALTER TABLE `fanwe_user`
MODIFY COLUMN `money`  decimal(20,2) NOT NULL COMMENT '金额' AFTER `email`,
MODIFY COLUMN `mortgage_money`  decimal(20,2) NOT NULL COMMENT '诚意金' AFTER `is_investor`;

ALTER TABLE `fanwe_user`
ADD COLUMN `investor_send_info`  varchar(255) NOT NULL COMMENT '审核信息' AFTER `wx_openid`;

ALTER TABLE `fanwe_deal`
ADD COLUMN `invote_mini_money`  decimal(10,2) NOT NULL COMMENT '最低支付金额' AFTER `invote_num`;

ALTER TABLE `fanwe_deal`
ADD COLUMN `refuse_reason`  text NULL COMMENT '拒绝理由' AFTER `invote_mini_money`;

INSERT INTO `fanwe_conf` VALUES ('271', 'INVEST_STATUS', '0', '6', '1', '0,1', '1', '1', '0');

UPDATE `fanwe_conf` set `value` = '1.52' where name = 'DB_VERSION'; 