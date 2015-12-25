/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50508
Source Host           : localhost:3306
Source Database       : zc_153

Target Server Type    : MYSQL
Target Server Version : 50508
File Encoding         : 65001

Date: 2015-02-26 16:24:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `%DB_PREFIX%admin`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%admin`;
CREATE TABLE `%DB_PREFIX%admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adm_name` varchar(255) NOT NULL,
  `adm_password` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `role_id` int(11) NOT NULL,
  `login_time` int(11) NOT NULL,
  `login_ip` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_adm_name` (`adm_name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='//管理员';

-- ----------------------------
-- Records of fanwe_admin
-- ----------------------------
INSERT INTO `%DB_PREFIX%admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1', '0', '4', '1352225405', '127.0.0.1');

-- ----------------------------
-- Table structure for `%DB_PREFIX%adv`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%adv`;
CREATE TABLE `%DB_PREFIX%adv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tmpl` varchar(255) NOT NULL,
  `adv_id` varchar(255) NOT NULL,
  `code` text NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_table` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tmpl` (`tmpl`),
  KEY `adv_id` (`adv_id`),
  KEY `rel_id` (`rel_id`),
  KEY `rel_table` (`rel_table`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='//广告位';

-- ----------------------------
-- Records of fanwe_adv
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%api_login`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%api_login`;
CREATE TABLE `%DB_PREFIX%api_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `config` text NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `bicon` varchar(255) NOT NULL,
  `is_weibo` tinyint(1) NOT NULL,
  `dispname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='// 登录接口';

-- ----------------------------
-- Records of fanwe_api_login
-- ----------------------------
INSERT INTO `%DB_PREFIX%api_login` VALUES ('13', '新浪api登录接口', 'a:3:{s:7:\"app_key\";s:0:\"\";s:10:\"app_secret\";s:0:\"\";s:7:\"app_url\";s:0:\"\";}', 'Sina', './public/attachment/201210/13/17/50792e5bbc901.gif', './public/attachment/201210/13/16/5079277a72c9d.gif', '1', '新浪微博');
INSERT INTO `%DB_PREFIX%api_login` VALUES ('14', '腾讯微博登录插件', 'a:3:{s:7:\"app_key\";s:0:\"\";s:10:\"app_secret\";s:0:\"\";s:7:\"app_url\";s:0:\"\";}', 'Tencent', './public/attachment/201211/06/11/509882825c183.png', './public/attachment/201211/06/11/50988287b1890.png', '1', '腾讯微博');

-- ----------------------------
-- Table structure for `%DB_PREFIX%article`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%article`;
CREATE TABLE `%DB_PREFIX%article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT ' 文章内容',
  `cate_id` int(11) NOT NULL COMMENT '文章分类ID',
  `create_time` int(11) NOT NULL COMMENT '发表时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `add_admin_id` int(11) NOT NULL COMMENT '发布人(管理员ID)',
  `is_effect` tinyint(4) NOT NULL COMMENT '有效性标识',
  `rel_url` varchar(255) NOT NULL COMMENT '自动跳转的外链',
  `update_admin_id` int(11) NOT NULL COMMENT '更新人(管理员ID)',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除标识',
  `click_count` int(11) NOT NULL COMMENT '点击数',
  `sort` int(11) NOT NULL COMMENT '排序 由大到小',
  `seo_title` text NOT NULL COMMENT '自定义seo页面标题',
  `seo_keyword` text NOT NULL COMMENT '自定义seo页面keyword',
  `seo_description` text NOT NULL COMMENT '自定义seo页面标述',
  `uname` varchar(255) NOT NULL,
  `sub_title` varchar(255) NOT NULL,
  `brief` text NOT NULL,
  `is_week` tinyint(1) NOT NULL,
  `is_hot` tinyint(1) NOT NULL,
  `icon` varchar(255) NOT NULL COMMENT '展示图表',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `create_time` (`create_time`),
  KEY `update_time` (`update_time`),
  KEY `click_count` (`click_count`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='//文章列表';

-- ----------------------------
-- Records of fanwe_article
-- ----------------------------
INSERT INTO `%DB_PREFIX%article` VALUES ('68', '关于我们', '关于方维众筹 <br />\r\n<br />\r\n<p>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。 <br />\r\n</p>\r\n<p><br />\r\n</p>\r\n众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。<br />\r\n<br />', '22', '1413251192', '1413251224', '0', '1', '', '0', '0', '0', '1', '众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。', '方维系统 众筹网站 方维众筹', '众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('69', '联系方式', '<img src=\"http://www.fanwe.com/app/Tpl/new/coupon/images/index_end_4.gif\" />						<dl style=\"width:400px;\" class=\"f_1\"><div class=\"_link_1\"><p class=\"shouqian\"><span><img src=\"http://www.fanwe.com/app/Tpl/new/coupon/images/index_end_1.gif\" /></span>&nbsp;&nbsp;<span>福州市台江区八一七中路群升国际E区</span></p>\r\n						<p class=\"lianxi_1\"><span><img src=\"http://www.fanwe.com/app/Tpl/new/coupon/images/index_end_2.gif\" /></span>&nbsp;&nbsp;<span>售前咨询（09:00-18:00）</span> 400-600-5505 0591-88600697</p>\r\n<p class=\"lianxi_1\">QQ:800005515&nbsp; <br />\r\n</p>\r\n</div>\r\n</dl>', '22', '1413251436', '1413486559', '0', '1', '', '0', '0', '0', '2', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('72', '常见问题', '', '24', '1413338371', '1413588178', '0', '1', 'http://t2.fanwe.net:107/zc_svn/index.php?ctl=faq', '0', '0', '0', '5', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('77', '项目规范', '<b>项目规范</b><br />\r\n<br />\r\n本众筹系统是中国最专业的众筹系统服务提供商，帮您在一天内快速搭建众筹平台。<br />\r\n<br />\r\n系统咨询热线： <br />\r\n<br />\r\n以下是众筹网站发布项目的基本要求，不合要求的项目，将会被拒绝或删除。如果你有疑问，可以通过邮件或电话联系我们。 <br />\r\n<br />\r\n<br />\r\n附注：某些规范会随着时间而更新或者调整，会导致一些旧项目并不能完全符合最新规范。<br />\r\n<br />\r\n项目发布团队资格：<br />\r\n&nbsp;&nbsp;&nbsp; （团队中必须有至少一名成员满足以下条件）<br />\r\n&nbsp;&nbsp;&nbsp; 18周岁以上;<br />\r\n&nbsp;&nbsp;&nbsp; 中华人民共和国公民;<br />\r\n&nbsp;&nbsp;&nbsp; 拥有能够在中国地区接收人民币汇款的银行卡或者支付宝、财付通账户;<br />\r\n&nbsp;&nbsp;&nbsp; 提供必要的身份认证和资质认证，根据项目内容，有可能包括但不限于：身份证，护照，学历证明等;<br />\r\n&nbsp;&nbsp;&nbsp; 其他跟项目发布、执行需求、渠道销售相关的必须条件。<br />\r\n项目发布：<br />\r\n&nbsp;&nbsp;&nbsp; 根据相关法律法规，项目发布申请提交后，须经过众筹网站工作人员审核后才能发布;<br />\r\n&nbsp;&nbsp;&nbsp; 根据项目的内容，众筹网站会要求项目发布团队提供相关材料，证明项目的可行性，以及项目发布团队的执行能力;<br />\r\n&nbsp;&nbsp;&nbsp; 众筹网站对提交上线审核的项目是否拥有上线资格具有最终决定权;<br />\r\n&nbsp;&nbsp;&nbsp; 项目在众筹网站上线预售期间，不能在中国大陆其他相似平台（包括但不限于众筹网站、电商网站、及其他形式网店等）同时发布。一经发现将立即下线处 理，其项目上线期间所获得的金额将被立即退回给预订用户在众筹网站上的账户中。<br />\r\n<br />\r\n项目内容规范（不符合以下内容规范的项目将被退回）：<br />\r\n<br />\r\n&nbsp;&nbsp;&nbsp; 1. 只允许尚未正式对外发布的项目在众筹网站上线。项目在众筹网站上线之前，不能在中国大陆其他相似平台（包括但不限于众筹网站、电商网站、及其 他形式网店等）或媒体发布。<br />\r\n&nbsp;&nbsp;&nbsp; 2. 项目必须为智能项目。智能项目的定义为：设备必须可采集数据、联网联动，并提供自动化的服务。单纯有设计感的非智能项目暂时无法通过审核。<br />\r\n&nbsp;&nbsp;&nbsp; 3. 项目发布方必须在项目上线前提供无bug的实物试产样机，由众筹网站工作人员进行盲测确保没有问题才能正式上线。<br />\r\n&nbsp;&nbsp;&nbsp; 4. 项目内容介绍框架必须包含“项目介绍”、“团队介绍”、“研发进展”等重要板块。<br />\r\n&nbsp;&nbsp;&nbsp; 5. 项目软硬件设计必须完整、合理、具有可行性；有完整的计划和执行能力，且图片、视频不能借用或盗用非自行拍摄的内容。<br />\r\n&nbsp;&nbsp;&nbsp; 6. 项目发布团队必须有明确的生产计划及售后服务计划，尚不确定是否会量产的项目不符合首次发布的标准皆不能上线。<br />\r\n&nbsp;&nbsp;&nbsp; 7. 提交申请的项目必须能符合如下分类：医疗健康、家居生活、出行定位、影音娱乐、科技外设。<br />\r\n&nbsp;&nbsp;&nbsp; 8. 以下类别的项目或内容将不被允许在此发布或作为给预订用户的附加回报：<br />\r\n<br />\r\n&nbsp;&nbsp;&nbsp; 烟、酒相关<br />\r\n&nbsp;&nbsp;&nbsp; 洗浴、美容或化妆项目相关<br />\r\n&nbsp;&nbsp;&nbsp; 毒品、类似毒品的物质、吸毒用具、烟等相关<br />\r\n&nbsp;&nbsp;&nbsp; 枪支、武器和刀具相关<br />\r\n&nbsp;&nbsp;&nbsp; 营养补充剂相关<br />\r\n&nbsp;&nbsp;&nbsp; 色情、保健、性用品内容相关<br />\r\n&nbsp;&nbsp;&nbsp; 房地产相关<br />\r\n&nbsp;&nbsp;&nbsp; 饮食类相关<br />\r\n&nbsp;&nbsp;&nbsp; 财政奖励(所有权、利润份额、还款贷款等)<br />\r\n&nbsp;&nbsp;&nbsp; 多级直销和传销类相关<br />\r\n&nbsp;&nbsp;&nbsp; 令人反感的内容(仇恨言论、不适当内容等)<br />\r\n&nbsp;&nbsp;&nbsp; 支持或反对政治党派的项目<br />\r\n&nbsp;&nbsp;&nbsp; 推广或美化暴力行为的项目<br />\r\n&nbsp;&nbsp;&nbsp; 对奖、彩票和抽奖活动相关<br />\r\n&nbsp;&nbsp;&nbsp; 股权、债券、分红、利息等形式的附加回报<br />\r\n&nbsp;&nbsp;&nbsp; 与首发项目无关的附加回报<br />\r\n&nbsp;&nbsp;&nbsp; 以其他无可行、不合理的承诺作为附加回报<br />\r\n举报及推荐标准：<br />\r\n<br />\r\n&nbsp;&nbsp;&nbsp; 举报：不符合《项目内容规范》<br />\r\n&nbsp;&nbsp;&nbsp; 合格：符合《项目内容规范》<br />\r\n&nbsp;&nbsp;&nbsp; 推荐：合格并且满足下列标准中的任意1-3项（含3项），视为推荐<br />\r\n&nbsp;&nbsp;&nbsp; 强烈推荐：合格并且满足下列标准中的任意3项以上，视为强烈推荐<br />\r\n&nbsp;&nbsp;&nbsp; 1. 项目定位清晰，功能逻辑性强、完整且条理清晰、团队对研发和生产有完整的计划和管控能力，有相关的图片和视频（图片、视频不能借用或盗用非 本人/公司拍摄的）<br />\r\n&nbsp;&nbsp;&nbsp; 2. 项目符合时下趋势、有热点，具备可传播性<br />\r\n&nbsp;&nbsp;&nbsp; 3. 项目本身有创意、创新；非山寨、抄袭、跟风；市面上无同类相似项目<br />\r\n&nbsp;&nbsp;&nbsp; 4. 项目设计感好，有品质，符合大众审美喜好的要求<br />\r\n&nbsp;&nbsp;&nbsp; 5. 项目发布团队有一定的推广渠道、媒体资源、或在公众平台上有一定的影响力<br />\r\n&nbsp;&nbsp;&nbsp; 6. 项目发布团队的话题运营能力出众，与粉丝互动积极正面，能调动起网友的兴趣和参与感<br />\r\n<br />', '24', '1413588165', '1413588165', '0', '1', '', '0', '0', '0', '9', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('74', '【活动报名】10.21第一期天使合投SHOW热辣登场！', '<p>本协会精心策划“天使合投SHOW”，期待您的光临！</p>\r\n<p><strong>活动时间：</strong><span style=\"color:#ff0000;\">2014年10月21日（下周二） 14:00-17:30</span></p>\r\n<p><strong>活动地点：</strong>科技园科技大厦B座1层</p>\r\n<strong>协办及支持单位：</strong><p><strong>参与投资机构：</strong></p>\r\n<p><strong>活动人数：</strong>50-60人</p>\r\n<p>&nbsp;</p>\r\n<p><strong><span style=\"background-color:#ffff00;\">分享嘉宾及主题</span></strong></p>\r\n<p><img src=\"./public/attachment/201410/17/16/5440d8025b024.jpg\" alt=\"\" border=\"0\" /></p>\r\n<br />\r\n<p><strong><span style=\"background-color:#ffff00;\">活动流程：</span></strong></p>\r\n<p>14:00 活动开始</p>\r\n<br />\r\n<p>&nbsp;</p>\r\n<p><strong><span style=\"background-color:#ffff00;\">报名方法：</span></strong></p>\r\n<p>邮件： 请注明姓名、机构、职务</p>\r\n<p>电话：方维服务 400-600-5505 请注明姓名、机构、职务</p>', '25', '1413506986', '1413506986', '0', '1', '', '0', '0', '0', '6', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('75', '使用条款', '使用条款<br />\r\n接受条款<br />\r\n<br />\r\n本站所提供的服务包含众筹网体验和使用、众筹网互联网消息传递服务以及众筹网提供的与众筹网有关的任何其他特色功能、内容或应用程序(合称\"众筹网服务\")。<br />\r\n<br />\r\n无论用户是以\"访客\"(表示用户只是浏览众筹网)还是\"成员\"(表示用户已在众筹网注册并登录)的身份使用众筹网服务，均表示该用户同意遵守本使用协议。<br />\r\n<br />\r\n如 果用户自愿成为众筹网成员并与其他成员交流(包括通过众筹网直接联系或通过众筹网各种服务而连接到的成员)，以及使用众筹网及其各种附加服务，请 务必认真阅读本协议并在注册过程中表明同意接受本协议。本协议的内容包含众筹网关于接受众筹网服务和在众筹网上发布内容的规定、用户使用众筹网服务所享有 的权利、承担的义务和对使用众筹网服务所受的限制、以及众筹网的隐私条款。<br />\r\n<br />\r\n如果用户选择使用某些众筹网服务，可能会收到要求其下载软件或内容的通知，和或要求用户同意附加条款和条件的通知。除非用户选择使用的众筹网服务相关的附加条款和条件另有规定，附加的条款和条件都应被包含于本协议中。<br />\r\n<br />\r\n有权随时修改本协议文本中的任何条款。一旦众筹网对本协议进行修改, 众筹网将会以公告形式发布通知。任何该等修改自发布之日起生效。如果用户在该等修改发布后继续使用众筹网服务，则表示该用户同意遵守对本协议所作出的该等 修改。因此，请用户务必定期查阅本协议，以确保了解所有关于本协议的最新修改。如果用户不同意众筹网对本协议进行的修改，请用户离开众筹网并立即停止使用 众筹网服务。同时，用户还应当删除个人档案并注销成员资格。<br />\r\n<br />\r\n遵守法律<br />\r\n<br />\r\n当使用众筹网服务时，用户同意遵守中华人民共和国 (下称\"中国\")的相关法律法规，包括但不限于《中华人民共和国宪法》、《中华人民共和国合同 法》、《中华人民共和国电信条例》、《互联网信息服务管理办法》、《互联网电子公告服务管理规定》、《中华人民共和国保守国家秘密法》、《全国人民代表大 会常务委员会关于维护互联网安全的决定》、《中华人民共和国计算机信息系统安全保护条例》、《计算机信息网络国际联网安全保护管理办法》、《中华人民共和 国著作权法》及其实施条例、《互联网著作权行政保护办法》等。用户只有在同意遵守所有相关法律法规和本协议时，才有权使用众筹网服务(无论用户是否有意访 问或使用此服务)。请用户仔细阅读本协议并将其妥善保存。<br />\r\n<br />\r\n用户帐号、密码及安全<br />\r\n<br />\r\n用户应提供及时、详尽、准确的个人资 料，并不断及时更新注册时提供的个人资料，保持其详尽、准确。所有用户输入的资料将引用为注册资料。众筹网不对因用户提交的注册信息不真实或未及时准确变 更信息而引起的问题、争议及其后果承担责任。 用户不应将其帐号、密码转让、出借或告知他人，供他人使用。如用户发现帐号遭他人非法使用，应立即通知众筹网。因黑客行为或用户的保管疏忽导致帐号、密码 遭他人非法使用的，众筹网不承担任何责任。<br />\r\n<br />\r\n隐私权政策<br />\r\n<br />\r\n用户提供的注册信息及众筹网保留的用户所有资料将受到中国相关法律法规和众筹网《隐私权政策》的规范。《隐私权政策》构成本协议不可分割的一部分。<br />\r\n<br />\r\n上传内容<br />\r\n<br />\r\n用 户通过任何众筹网提供的服务上传、张贴、发送(通过电子邮件或任何其它方式传送)的文本、文件、图像、照片、视频、声音、音乐、其他创作作品或任 何其他材料(以下简称\"内容\"，包括用户个人的或个人创作的照片、声音、视频等)，无论系公开还是私下传播，均由用户和内容提供者承担责任，众筹网不对该 等内容的正确性、完整性或品质作出任何保证。用户在使用众筹网服务时，可能会接触到令人不快、不适当或令人厌恶之内容，用户需在接受服务前自行做出判断。 在任何情况下，众筹网均不为任何内容负责(包括但不限于任何内容的错误、遗漏、不准确或不真实)，亦不对通过众筹网服务上传、张贴、发送(通过电子邮件或 任何其它方式传送)的内容衍生的任何损失或损害负责。众筹网在管理过程中发现或接到举报并进行初步调查后，有权依法停止任何前述内容的传播并采取进一步行 动，包括但不限于暂停某些用户使用众筹网的全部或部分服务，保存有关记录，并向有关机关报告。<br />\r\n<br />\r\n用户行为<br />\r\n<br />\r\n用户在使用众筹网服务时，必须遵守中华人民共和国相关法律法规的规定，用户保证不会利用众筹网服务进行任何违法或不正当的活动，包括但不限于下列行为：<br />\r\n<br />\r\n&nbsp;&nbsp;&nbsp; 上传、展示、张贴或以其它方式传播含有下列内容之一的信息：<br />\r\n&nbsp;&nbsp;&nbsp; 反对宪法及其他法律的基本原则的;<br />\r\n&nbsp;&nbsp;&nbsp; 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的;<br />\r\n&nbsp;&nbsp;&nbsp; 损害国家荣誉和利益的;<br />\r\n&nbsp;&nbsp;&nbsp; 煽动民族仇恨、民族歧视、破坏民族团结的;<br />\r\n&nbsp;&nbsp;&nbsp; 破坏国家宗教政策，宣扬邪教和封建迷信的;<br />\r\n&nbsp;&nbsp;&nbsp; 散布谣言，扰乱社会秩序，破坏社会稳定的;<br />\r\n&nbsp;&nbsp;&nbsp; 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的;<br />\r\n&nbsp;&nbsp;&nbsp; 侮辱或者诽谤他人，侵害他人合法权利的;<br />\r\n&nbsp;&nbsp;&nbsp; 含有虚假、有害、胁迫、侵害他人隐私、骚扰、中伤、粗俗、猥亵、或其它道德上令人反感的内容;<br />\r\n&nbsp;&nbsp;&nbsp; 含有中国法律、法规、规章、条例以及任何具有法律效力的规范所限制或禁止的其它内容的;<br />\r\n&nbsp;&nbsp;&nbsp; 不得为任何非法目的而使用网络服务系统;<br />\r\n&nbsp;&nbsp;&nbsp; 用户同时保证不会利用众筹网服务从事以下活动：<br />\r\n&nbsp;&nbsp;&nbsp; 未经允许，进入计算机信息网络或者使用计算机信息网络资源的;<br />\r\n&nbsp;&nbsp;&nbsp; 未经允许，对计算机信息网络功能进行删除、修改或者增加的;<br />\r\n&nbsp;&nbsp;&nbsp; 未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的;故意制作、传播计算机病毒等破坏性程序的;<br />\r\n&nbsp;&nbsp;&nbsp; 其他危害计算机信息网络安全的行为。<br />\r\n<br />\r\n如用户在使用网络服务时违反任何上述规定，众筹网或经其授权者有权要求该用户改正或直接采取一切必要措施(包括但不限于更改、删除相关内容、暂停或终止相关用户使用众筹网服务)以减轻和消除该用户不当行为造成的影响。<br />\r\n<br />\r\n用户不得对众筹网服务的任何部分或全部以及通过众筹网取得的任何形式的信息，进行复制、拷贝、出售、转售或用于任何其它商业目的。<br />\r\n<br />\r\n用户须对自己在使用众筹网服务过程中的行为承担法律责任。用户承担法律责任的形式包括但不限于：停止侵害行为，向受到侵害者公开赔礼道歉，恢复受到 侵害者的名誉，对受到侵害者进行赔偿。如果众筹网网站因某用户的非法或不当行为受到行政处罚或承担了任何形式的侵权损害赔偿责任，该用户应向众筹网进行赔 偿(不低于众筹网向第三方赔偿的金额)并通过全国性的媒体向众筹网公开赔礼道歉。<br />\r\n<br />\r\n知识产权和其他合法权益(包括但不限于名誉权、商誉等)<br />\r\n<br />\r\n并不对用户发布到众筹网服务中的文本、文件、图像、照片、视频、声音、音乐、其他创作作品或任何其他材料(前文称为\"内容\")拥有任何所有 权。在用户将内容发布到众筹网服务中后，用户将继续对内容享有权利，并且有权选择恰当的方式使用该等内容。如果用户在众筹网服务中或通过众筹网服务展示或 发表任何内容，即表明该用户就此授予众筹网一个有限的许可以使众筹网能够合法使用、修改、复制、传播和出版此类内容。<br />\r\n<br />\r\n用户同意其已在服务所发布的内容，授予众筹网可以免费的、永久有效的、不可撤销的、非独家的、可转授权的、在全球范围内对所发布内容进行使 用、复制、修改、改写、改编、发行、翻译、创造衍生性著作的权利，及/或可以将前述部分或全部内容加以传播、表演、展示，及/或可以将前述部分或全部内容 放入任何现在已知和未来开发出的以任何形式、媒体或科技承载的著作当中。<br />\r\n<br />\r\n用户声明并保证：用户对其在众筹网服务中或通过众筹网服务发布 的内容拥有合法权利;用户在众筹网服务中或通过众筹网服务发布的内容不侵犯任何人的肖 像权、隐私权、著作权、商标权、专利权、及其它合同权利。如因用户在众筹网服务中或通过众筹网服务发布的内容而需向其他任何人支付许可费或其它费用，全部 由该用户承担。<br />\r\n<br />\r\n众筹网服务中包含众筹网提供的内容，包含用户和其他众筹网许可方的内容(下称\"众筹网的内容\")。众筹网的内容受《中华 人民共和国著作权法》、《中 华人民共和国商标法》、《中华人民共和国专利法》、《中华人民共和国反不正当竞争法》和其他相关法律法规的保护，众筹网拥有并保持对众筹网的内容和众筹网 服务的所有权利。<br />\r\n<br />\r\n国际使用之特别警告<br />\r\n<br />\r\n用户已了解国际互联网的无国界性，同意遵守所有关于网上行为、内容的法律法规。用户特别同意遵守有关从中国或用户所在国家或地区输出信息所可能涉及、适用的全部法律法规。<br />\r\n<br />\r\n项目筹款<br />\r\n<br />\r\n是一个让用户(即“项目发起人”)通过提供回报向支持者筹集资金的平台。您作为项目发起人，社会大众可以与您订立合同，在众筹网创建筹款项 目。您作为支持者，可以接受项目发起人和您之间的回报和契约，以赞助项目发起人的筹款项目。众筹网并不是支持者和项目发起人中的任何一方。所有交易仅存在 于用户和用户之间。<br />\r\n<br />\r\n通过众筹网支持项目，您须同意并遵守以下协议，包括如下条款：<br />\r\n<br />\r\n&nbsp;&nbsp;&nbsp; 支持者同意接受在其承诺支持某项目时提供付款授权信息 。<br />\r\n&nbsp;&nbsp;&nbsp; 支持者同意众筹网及其合作伙伴授权或保留收费的权利。<br />\r\n&nbsp;&nbsp;&nbsp; 回报预期的完成日期并非约定实现的期限，它仅为项目发起人希望实现的日期。<br />\r\n&nbsp;&nbsp;&nbsp; 为建立良好的信用和名声，项目发起人会尽力依照预期完成日期实现项目。<br />\r\n&nbsp;&nbsp;&nbsp; 对于所有项目，众筹网将提供所有支持者的用户名称和联系方式给于项目发起人。项目成功时，众筹网将额外提供支持者的姓名、联系方式和邮寄地址等信息给于项目发起人。<br />\r\n&nbsp;&nbsp;&nbsp; 项目发起人可以在项目成功后直接向支持者要求额外信息。为了顺利获得回报，支持者须同意在合理期限内提供给项目发起人相关信息。<br />\r\n&nbsp;&nbsp;&nbsp; 如活动难以进行或无法满足回报需求时，项目发起人可应支持者的请求而退款 。<br />\r\n&nbsp;&nbsp;&nbsp; 项目发起人须满足项目成功后支持者的回报需求，或在无法实现的情况下退款。<br />\r\n&nbsp;&nbsp;&nbsp; 众筹网保留随时以任何理由取消项目的权利。<br />\r\n&nbsp;&nbsp;&nbsp; 众筹网有权随时以任何理由拒绝、取消、中断、删除或暂停该项目。众筹网不因该行为承担任何赔偿。众筹网的政策并非评论此类行为的理由。<br />\r\n&nbsp;&nbsp;&nbsp; 在项目成功和获得款项之间可能存在延迟。<br />\r\n<br />\r\n不承担任何相关回报或使用服务产生的损失或亏损。众筹网无义务介入任何用户之间的纠纷，或用户与其他第三方就服务使用方面产生的纠纷。包括但 不限于货物及服务的交付，其他条款、条件、保证或与网站活动相关联的有关陈述。众筹网不负责监督项目的实现与严格执行。您可授权众筹网、其工作人员、职 员、代理人及对损失索赔权的继任者所有已知或未知、公开或秘密的解决争议的方法和服务。<br />\r\n<br />\r\n费用和付款<br />\r\n<br />\r\n加入众筹网免费，但是我们对于某些服务是收取费用的。当您使用某项服务时，您将有机会看到您需要支付费用的项目，费用的变化在我们在网站上为您公开后生效。您负责支付使用该服务产生的所有费用和税款。<br />\r\n<br />\r\n向支持者筹集的资金通过第三方支付平台支付，众筹网对第三方支付平台的支付性能不承担责任。<br />\r\n<br />\r\n赔偿<br />\r\n<br />\r\n由 于用户通过众筹网服务上传、张贴、发送或传播的内容，或因用户与本服务连线，或因用户违反本使用协议，或因用户侵害他人任何权利而导致任何第三人 向众筹网提出赔偿请求，该用户同意赔偿众筹网及其股东、子公司、关联企业、代理人、品牌共有人或其它合作伙伴相应的赔偿金额(包括众筹网支付的律师费 等)，以使众筹网的利益免受损害。<br />\r\n<br />\r\n关于使用及储存的一般措施<br />\r\n<br />\r\n用户承认众筹网有权制定关于服务使用的一般措施及限制，包括 但不限于众筹网服务将保留用户的电子邮件信息、用户所张贴内容或其它上载内容的最长保留 期间、用户一个帐号可收发信息的最大数量、用户帐号当中可收发的单个信息的大小、众筹网服务器为用户分配的最大磁盘空间，以及一定期间内用户使用众筹网服 务的次数上限(及每次使用时间之上限)。通过众筹网服务存储或传送的任何信息、通讯资料和其它任何内容，如被删除或未予储存，用户同意众筹网毋须承担任何 责任。用户亦同意，超过一年未使用的帐号，众筹网有权关闭。众筹网有权依其自行判断和决定，随时变更相关一般措施及限制。<br />\r\n<br />\r\n服务的修改<br />\r\n<br />\r\n用 户了解并同意，无论通知与否，众筹网有权于任何时间暂时或永久修改或终止部分或全部众筹网服务，对此，众筹网对用户和任何第三人均无需承担任何责 任。用户同意，所有上传、张贴、发送到众筹网的内容，众筹网均无保存义务，用户应自行备份。众筹网不对任何内容丢失以及用户因此而遭受的相关损失承担责 任。<br />\r\n<br />\r\n终止服务<br />\r\n<br />\r\n用户同意众筹网可单方面判断并决定，如果用户违反本使用协议或用户长时间未能使用其帐号，众筹网可以终止该 用户的密码、帐号或某些服务的使用，并可 将该用户在众筹网服务中留存的任何内容加以移除或删除。众筹网亦可基于自身考虑，在通知或未通知之情形下，随时对该用户终止部分或全部服务。用户了解并同 意依本使用协议，无需进行事先通知，众筹网可在发现任何不适宜内容时，立即关闭或删除该用户的帐号及其帐号中所有相关信息及文件，并暂时或永久禁止该用户 继续使用前述文件或帐号。<br />\r\n<br />\r\n与广告商进行的交易<br />\r\n<br />\r\n用户通过众筹网服务与广告商进行任何形式的通讯或商业往来，或参与促销活 动(包括相关商品或服务的付款及交付)，以及达成的其它任何条款、条件、保 证或声明，完全是用户与广告商之间的行为。除有关法律法规明文规定要求众筹网承担责任外，用户因前述任何交易、沟通等而遭受的任何性质的损失或损害，均不予负责。<br />\r\n<br />\r\n链接<br />\r\n<br />\r\n用户了解并同意，对于众筹网服务或第三人提供的其它网站或资源的链接是否可以利用，众筹网不予负 责；存在或源于此类网站或资源的任何内容、广告、产 品或其它资料，众筹网亦不保证或负责。因使用或信赖任何此类网站或资源发布的或经由此类网站或资源获得的任何商品、服务、信息，如对用户造成任何损害，不负任何直接或间接责任。<br />\r\n<br />\r\n禁止商业行为<br />\r\n<br />\r\n用户同意不对众筹网服务的任何部分或全部以及用户通过众筹网的服务取得的任何物品、服务、信息等，进行复制、拷贝、出售、转售或用于任何其它商业目的。<br />\r\n<br />\r\n众筹网的专属权利<br />\r\n<br />\r\n用 户了解并同意，众筹网服务及其所使用的相关软件(以下简称\"服务软件\")含有受到相关知识产权及其它法律保护的专有保密资料。用户同时了解并同 意，经由众筹网服务或广告商向用户呈现的赞助广告或信息所包含之内容，亦可能受到著作权、商标、专利等相关法律的保护。未经众筹网或广告商书面授权，用户 不得修改、出售、传播部分或全部服务内容或软件，或加以制作衍生服务或软件。众筹网仅授予用户个人非专属的使用权，用户不得(也不得允许任何第三人)复 制、修改、创作衍生著作，或通过进行还原工程、反向组译及其它方式破译原代码。用户也不得以转让、许可、设定任何担保或其它方式移转服务和软件的任何权 利。用户同意只能通过由众筹网所提供的界面而非任何其它方式使用众筹网服务。<br />\r\n<br />\r\n担保与保证<br />\r\n<br />\r\n众筹网使用协议的任何规定均不 会免除因众筹网造成用户人身伤害或因故意造成用户财产损失而应承担的任何责任。 用户使用众筹网服务的风险由用户个人承担。众筹网对服务不提供任何明示或默示的担保或保证，包括但不限于商业适售性、特定目的的适用性及未侵害他人权利等 的担保或保证。<br />\r\n<br />\r\n众筹网亦不保证以下事项：<br />\r\n<br />\r\n&nbsp;&nbsp;&nbsp; 服务将符合用户的要求；<br />\r\n&nbsp;&nbsp;&nbsp; 服务将不受干扰、及时提供、安全可靠或不会出错；<br />\r\n&nbsp;&nbsp;&nbsp; 使用服务取得的结果正确可靠；<br />\r\n&nbsp;&nbsp;&nbsp; 用户经由众筹网服务购买或取得的任何产品、服务、资讯或其它信息将符合用户的期望，且软件中任何错误都将得到更正。<br />\r\n&nbsp;&nbsp;&nbsp; 用户应自行决定使用众筹网服务下载或取得任何资料且自负风险，因任何资料的下载而导致的用户电脑系统损坏或数据流失等后果，由用户自行承担。<br />\r\n&nbsp;&nbsp;&nbsp; 用户经由众筹网服务获知的任何建议或信息(无论书面或口头形式)，除非使用协议有明确规定，将不构成众筹网对用户的任何保证。<br />\r\n<br />\r\n责任限制<br />\r\n<br />\r\n用户明确了解并同意，基于以下原因而造成的任何损失，众筹网均不承担任何直接、间接、附带、特别、衍生性或惩罚性赔偿责任(即使众筹网事先已被告知用户或第三方可能会产生相关损失)：<br />\r\n<br />\r\n&nbsp;&nbsp;&nbsp; 众筹网服务的使用或无法使用；<br />\r\n&nbsp;&nbsp;&nbsp; 通过众筹网服务购买、兑换、交换取得的任何商品、数据、服务、信息，或缔结交易而发生的成本；<br />\r\n&nbsp;&nbsp;&nbsp; 用户的传输或数据遭到未获授权的存取或变造；<br />\r\n&nbsp;&nbsp;&nbsp; 任何第三方在众筹网服务中所作的声明或行为；<br />\r\n&nbsp;&nbsp;&nbsp; 与众筹网服务相关的其它事宜，但本使用协议有明确规定的除外。<br />\r\n<br />\r\n一般性条款<br />\r\n<br />\r\n本使用协议构成用户与众筹网之间的正式协议，并用于规范用户的使用行为。在用户使用众筹网服务、使用第三方提供的内容或软件时，在遵守本协议的基础上，亦应遵守与该等服务、内容、软件有关附加条款及条件。<br />\r\n<br />\r\n本使用协议及用户与众筹网之间的关系，均受到中华人民共和国法律管辖。<br />\r\n<br />\r\n用户与众筹网就服务本身、本使用协议或其它有关事项发生的争议，应通过友好协商解决。协商不成的，应向相关机构提起诉讼。<br />\r\n<br />\r\n众筹网未行使或执行本使用协议设定、赋予的任何权利，不构成对该等权利的放弃。<br />\r\n<br />\r\n本使用协议中的任何条款因与中华人民共和国法律相抵触而无效，并不影响其它条款的效力。<br />\r\n<br />\r\n本使用协议的标题仅供方便阅读而设，如与协议内容存在矛盾，以协议内容为准。<br />\r\n<br />\r\n举报<br />\r\n<br />\r\n如用户发现任何违反本服务条款的情事，请及时通知众筹网。<br />\r\n<br />', '21', '1413586458', '1413586458', '0', '1', '', '0', '0', '0', '7', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('76', '【媒体报道】众筹平台助“印象”打造专业川菜连锁品牌', '三顾茅庐，方识茅庐真印象!目前已经拥有直营店的平台，10月18号将与平台投资人见面。<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img alt=\"\" src=\"http://www.renrentou.com/s/upload/editor/2014/10images/141016102309036310fuv8e.jpg\" style=\"height:427px;width:651px;\" /></p>\r\n<p><br />\r\n　　融资计划</p>\r\n<p><br />\r\n　众筹平台的建立，将进一步提高本服务水平</p>\r\n<p><br />\r\n　　项目特色</p>\r\n<p><br />\r\n　项目特色信息</p>\r\n<p><br />\r\n　　项目背景</p>\r\n<p>　跨济南、济区域，并保持良好增长势头。广大爱好美食的投资朋友们，这样好的赚钱投资机会你想拥有吗?赶紧关注众筹平台吧。<br />\r\n　　</p>\r\n<p><br />\r\n　　市场优势</p>\r\n<p><br />\r\n　　拥有多年品牌积淀，就餐环境良好好，价格符合大众消费，是商场餐饮业市场中目前仅有的大众定位的川菜连锁品牌。另外，印象中央厨房的可复制性研发，品牌发展及品质保证，开业即火爆，市场潜力巨大。目前，印象已跨济南、济区域，并保持良好增长势头。广大爱好美食的投资朋友们，这样好的赚钱投资机会你想拥有吗?赶紧关注众筹平台吧。</p>', '26', '1413586791', '1413586791', '0', '1', '', '0', '0', '0', '8', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('78', '版权申明', '该系统知识产权归我方所有，<span style=\"mso-spacerun:\'yes\';font-family:\'宋体\';\">未经书面许可，不得以任何形式公布“软件产品”的源码，并不得复制、传播、出售、出租、出借等。</span><!--[if gte mso 9]><xml><w :LatentStyles deflockedstate=\"false\" defunhidewhenused=\"true\" defsemihidden=\"true\" defqformat=\"false\" defpriority=\"99\" latentstylecount=\"156\"><w :LsdException locked=\"false\" priority=\"99\" name=\"Normal\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 1\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 4\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 5\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 6\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 7\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 8\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"heading 9\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 1\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 4\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 5\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 6\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 7\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 8\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index 9\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 1\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 4\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 5\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 6\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 7\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 8\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toc 9\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Normal Indent\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"footnote text\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"annotation text\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"header\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"footer\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"index heading\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"caption\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"table of figures\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"envelope address\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"envelope return\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"footnote reference\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"annotation reference\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"line number\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"page number\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"endnote reference\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"endnote text\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"table of authorities\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"macro\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"toa heading\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Bullet\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Number\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List 4\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List 5\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Bullet 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Bullet 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Bullet 4\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Bullet 5\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Number 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Number 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Number 4\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Number 5\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Title\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Closing\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Signature\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Default Paragraph Font\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text Indent\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Continue\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Continue 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Continue 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Continue 4\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"List Continue 5\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Message Header\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Subtitle\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Salutation\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Date\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text First Indent\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text First Indent 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Note Heading\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text Indent 2\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Body Text Indent 3\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Block Text\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Hyperlink\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"FollowedHyperlink\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Strong\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Emphasis\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Document Map\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Plain Text\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"E-mail Signature\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Normal (Web)\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Acronym\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Address\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Cite\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Code\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Definition\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Keyboard\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Preformatted\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Sample\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Typewriter\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"HTML Variable\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Normal Table\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"annotation subject\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"No List\"></w :LsdException><w :LsdException locked=\"false\" priority=\"99\" name=\"Balloon Text\"></w :LsdException></w :LatentStyles></xml><![endif]-->', '21', '1413588553', '1413588553', '0', '1', '', '0', '0', '0', '10', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('79', '会员注册', '', '28', '1413588976', '1413588976', '0', '1', 'user-register', '0', '0', '0', '11', '', '', '', '', '', '', '1', '1', '');
INSERT INTO `%DB_PREFIX%article` VALUES ('80', '发起项目', '', '28', '1413589126', '1417975607', '0', '1', '/zc_svn/project', '0', '0', '0', '12', '', '', '', '', '', '', '1', '1', './public/attachment/201412/08/10/548507b508df3.jpg');

-- ----------------------------
-- Table structure for `%DB_PREFIX%article_cate`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%article_cate`;
CREATE TABLE `%DB_PREFIX%article_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '分类名称',
  `brief` varchar(255) NOT NULL COMMENT '分类简介(备用字段)',
  `pid` int(11) NOT NULL COMMENT '父ID，程序分类可分二级',
  `is_effect` tinyint(4) NOT NULL COMMENT '有效性标识',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除标识',
  `type_id` tinyint(1) NOT NULL COMMENT '型 0:普通文章（可通前台分类列表查找到） 1.帮助文章（用于前台页面底部的站点帮助） 2.公告文章（用于前台页面公告模块的调用） 3.系统文章（自定义的一些文章，需要前台自定义一些入口链接到该文章） 所属该分类的所有文章类型与分类一致',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `type_id` (`type_id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='//文章分类';

-- ----------------------------
-- Records of fanwe_article_cate
-- ----------------------------
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('21', '站点申明', '', '0', '1', '0', '1', '10');
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('22', '关于我们', '', '0', '1', '0', '1', '0');
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('23', '众筹简介', '众筹简介', '0', '1', '1', '0', '3');
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('24', '新手帮助', '', '0', '1', '0', '1', '1');
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('25', '活动报名', '', '0', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('26', '媒体报道', '', '0', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('27', '合作方式', '', '0', '1', '0', '1', '7');
INSERT INTO `%DB_PREFIX%article_cate` VALUES ('28', '我有项目', '', '0', '1', '0', '1', '8');

-- ----------------------------
-- Table structure for `%DB_PREFIX%auto_cache`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%auto_cache`;
CREATE TABLE `%DB_PREFIX%auto_cache` (
  `cache_key` varchar(100) NOT NULL,
  `cache_type` varchar(100) NOT NULL,
  `cache_data` text NOT NULL,
  `cache_time` int(11) NOT NULL,
  PRIMARY KEY (`cache_key`,`cache_type`),
  KEY `cache_type` (`cache_type`),
  KEY `cache_key` (`cache_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='//自动缓存';

-- ----------------------------
-- Records of fanwe_auto_cache
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%bank`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%bank`;
CREATE TABLE `%DB_PREFIX%bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '银行名称',
  `is_rec` tinyint(1) NOT NULL COMMENT '是否推荐',
  `day` int(11) NOT NULL COMMENT '处理时间',
  `sort` int(11) NOT NULL COMMENT '银行排序',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fanwe_bank
-- ----------------------------
INSERT INTO `%DB_PREFIX%bank` VALUES ('1', '中国工商银行', '1', '3', '0', './public/bank/1.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('2', '中国农业银行', '1', '3', '0', './public/bank/2.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('3', '中国建设银行', '1', '3', '0', './public/bank/3.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('4', '招商银行', '1', '3', '0', './public/bank/4.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('5', '中国光大银行', '1', '3', '0', './public/bank/5.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('6', '中国邮政储蓄银行', '1', '3', '0', './public/bank/6.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('7', '兴业银行', '1', '3', '0', './public/bank/7.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('8', '中国银行', '0', '3', '0', './public/bank/8.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('9', '交通银行', '0', '3', '3', './public/bank/9.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('10', '中信银行', '0', '3', '0', './public/bank/10.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('11', '华夏银行', '0', '3', '0', './public/bank/11.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('12', '上海浦东发展银行', '0', '3', '1', './public/bank/12.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('13', '城市信用社', '0', '3', '0', './public/bank/13.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('14', '恒丰银行', '0', '3', '0', './public/bank/14.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('15', '广东发展银行', '0', '3', '0', './public/bank/15.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('16', '深圳发展银行', '0', '3', '2', './public/bank/16.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('17', '中国民生银行', '0', '3', '0', './public/bank/17.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('18', '中国农业发展银行', '0', '3', '0', './public/bank/18.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('19', '农村商业银行', '0', '3', '0', './public/bank/19.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('20', '农村信用社', '0', '3', '0', './public/bank/20.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('21', '城市商业银行', '0', '3', '0', './public/bank/21.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('22', '农村合作银行', '0', '3', '0', './public/bank/22.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('23', '浙商银行', '0', '3', '0', './public/bank/23.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('24', '上海农商银行', '0', '3', '0', './public/bank/24.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('25', '中国进出口银行', '0', '3', '0', './public/bank/25.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('26', '渤海银行', '0', '3', '0', './public/bank/26.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('27', '国家开发银行', '0', '3', '0', './public/bank/27.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('28', '村镇银行', '0', '3', '0', './public/bank/28.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('29', '徽商银行股份有限公司', '0', '3', '0', './public/bank/29.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('30', '南洋商业银行', '0', '3', '0', './public/bank/30.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('31', '韩亚银行', '0', '3', '0', './public/bank/31.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('32', '花旗银行', '0', '3', '0', './public/bank/32.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('33', '渣打银行', '0', '3', '0', './public/bank/33.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('34', '华一银行', '0', '3', '0', './public/bank/34.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('35', '东亚银行', '1', '3', '0', './public/bank/35.jpg');
INSERT INTO `%DB_PREFIX%bank` VALUES ('36', '苏格兰皇家银行', '1', '1', '26', './public/bank/36.jpg');

-- ----------------------------
-- Table structure for `%DB_PREFIX%conf`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%conf`;
CREATE TABLE `%DB_PREFIX%conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `group_id` int(11) NOT NULL,
  `input_type` tinyint(1) NOT NULL COMMENT '配置输入的类型 0:文本输入 1:下拉框输入 2:图片上传 3:编辑器',
  `value_scope` text NOT NULL COMMENT '取值范围',
  `is_effect` tinyint(1) NOT NULL,
  `is_conf` tinyint(1) NOT NULL COMMENT '是否可配置 0: 可配置  1:不可配置',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=273 DEFAULT CHARSET=utf8 COMMENT='// 配置';

-- ----------------------------
-- Records of fanwe_conf
-- ----------------------------
INSERT INTO `%DB_PREFIX%conf` VALUES ('1', 'DEFAULT_ADMIN', 'admin', '1', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('2', 'URL_MODEL', '0', '1', '1', '0,1', '1', '1', '3');
INSERT INTO `%DB_PREFIX%conf` VALUES ('3', 'AUTH_KEY', 'fanwe', '1', '0', '', '1', '1', '4');
INSERT INTO `%DB_PREFIX%conf` VALUES ('4', 'TIME_ZONE', '8', '1', '1', '0,8', '1', '1', '1');
INSERT INTO `%DB_PREFIX%conf` VALUES ('5', 'ADMIN_LOG', '1', '1', '1', '0,1', '0', '1', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('6', 'DB_VERSION', '1.53', '0', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('7', 'DB_VOL_MAXSIZE', '8000000', '1', '0', '', '1', '1', '11');
INSERT INTO `%DB_PREFIX%conf` VALUES ('8', 'WATER_MARK', './public/attachment/201011/4cdde85a27105.gif', '2', '2', '', '1', '1', '48');
INSERT INTO `%DB_PREFIX%conf` VALUES ('10', 'BIG_WIDTH', '500', '2', '0', '', '0', '0', '49');
INSERT INTO `%DB_PREFIX%conf` VALUES ('11', 'BIG_HEIGHT', '500', '2', '0', '', '0', '0', '50');
INSERT INTO `%DB_PREFIX%conf` VALUES ('12', 'SMALL_WIDTH', '200', '2', '0', '', '0', '0', '51');
INSERT INTO `%DB_PREFIX%conf` VALUES ('13', 'SMALL_HEIGHT', '200', '2', '0', '', '0', '0', '52');
INSERT INTO `%DB_PREFIX%conf` VALUES ('14', 'WATER_ALPHA', '75', '2', '0', '', '1', '1', '53');
INSERT INTO `%DB_PREFIX%conf` VALUES ('15', 'WATER_POSITION', '4', '2', '1', '1,2,3,4,5', '1', '1', '54');
INSERT INTO `%DB_PREFIX%conf` VALUES ('16', 'MAX_IMAGE_SIZE', '3000000', '2', '0', '', '1', '1', '55');
INSERT INTO `%DB_PREFIX%conf` VALUES ('17', 'ALLOW_IMAGE_EXT', 'jpg,gif,png', '2', '0', '', '1', '1', '56');
INSERT INTO `%DB_PREFIX%conf` VALUES ('18', 'BG_COLOR', '#ffffff', '2', '0', '', '0', '0', '57');
INSERT INTO `%DB_PREFIX%conf` VALUES ('19', 'IS_WATER_MARK', '1', '2', '1', '0,1', '1', '1', '58');
INSERT INTO `%DB_PREFIX%conf` VALUES ('20', 'TEMPLATE', 'fanwe_1', '1', '0', '', '1', '1', '17');
INSERT INTO `%DB_PREFIX%conf` VALUES ('21', 'SITE_LOGO', './public/attachment/201210/12/11/5077943312beb.jpg', '1', '2', '', '1', '1', '19');
INSERT INTO `%DB_PREFIX%conf` VALUES ('173', 'SEO_TITLE', '预购一个梦想', '1', '0', '', '1', '1', '20');
INSERT INTO `%DB_PREFIX%conf` VALUES ('25', 'REPLY_ADDRESS', 'info@fanwe.com', '3', '0', '', '1', '1', '77');
INSERT INTO `%DB_PREFIX%conf` VALUES ('24', 'SMS_ON', '0', '5', '1', '0,1', '1', '1', '78');
INSERT INTO `%DB_PREFIX%conf` VALUES ('26', 'PUBLIC_DOMAIN_ROOT', '', '2', '0', '', '1', '1', '59');
INSERT INTO `%DB_PREFIX%conf` VALUES ('27', 'APP_MSG_SENDER_OPEN', '0', '1', '1', '0,1', '1', '1', '9');
INSERT INTO `%DB_PREFIX%conf` VALUES ('28', 'ADMIN_MSG_SENDER_OPEN', '0', '1', '1', '0,1', '1', '1', '10');
INSERT INTO `%DB_PREFIX%conf` VALUES ('29', 'GZIP_ON', '0', '1', '1', '0,1', '1', '1', '2');
INSERT INTO `%DB_PREFIX%conf` VALUES ('42', 'SITE_NAME', '方维众筹', '1', '0', '', '1', '1', '1');
INSERT INTO `%DB_PREFIX%conf` VALUES ('30', 'CACHE_ON', '1', '1', '1', '0,1', '1', '1', '7');
INSERT INTO `%DB_PREFIX%conf` VALUES ('31', 'EXPIRED_TIME', '0', '1', '0', '', '1', '1', '5');
INSERT INTO `%DB_PREFIX%conf` VALUES ('32', 'TMPL_DOMAIN_ROOT', '', '2', '0', '0', '0', '0', '62');
INSERT INTO `%DB_PREFIX%conf` VALUES ('33', 'CACHE_TYPE', 'File', '1', '1', 'File,Xcache,Memcached', '1', '1', '7');
INSERT INTO `%DB_PREFIX%conf` VALUES ('34', 'MEMCACHE_HOST', '127.0.0.1:11211', '1', '0', '', '1', '1', '8');
INSERT INTO `%DB_PREFIX%conf` VALUES ('35', 'IMAGE_USERNAME', 'admin', '2', '0', '', '1', '1', '60');
INSERT INTO `%DB_PREFIX%conf` VALUES ('36', 'IMAGE_PASSWORD', 'admin', '2', '4', '', '1', '1', '61');
INSERT INTO `%DB_PREFIX%conf` VALUES ('37', 'DEAL_MSG_LOCK', '0', '0', '0', '', '0', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('38', 'SEND_SPAN', '2', '1', '0', '', '1', '1', '85');
INSERT INTO `%DB_PREFIX%conf` VALUES ('39', 'TMPL_CACHE_ON', '1', '1', '1', '0,1', '1', '1', '6');
INSERT INTO `%DB_PREFIX%conf` VALUES ('40', 'DOMAIN_ROOT', '', '1', '0', '', '1', '0', '10');
INSERT INTO `%DB_PREFIX%conf` VALUES ('41', 'COOKIE_PATH', '/', '1', '0', '', '1', '1', '10');
INSERT INTO `%DB_PREFIX%conf` VALUES ('43', 'INTEGRATE_CFG', '', '0', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('44', 'INTEGRATE_CODE', '', '0', '0', '', '1', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('172', 'PAY_RADIO', '0.1', '3', '0', '', '1', '1', '10');
INSERT INTO `%DB_PREFIX%conf` VALUES ('176', 'SITE_LICENSE', '方维众筹 - fanwe.com 版权所有', '1', '0', '', '1', '1', '22');
INSERT INTO `%DB_PREFIX%conf` VALUES ('174', 'SEO_KEYWORD', 'SEO关键词', '1', '0', '', '1', '1', '21');
INSERT INTO `%DB_PREFIX%conf` VALUES ('175', 'SEO_DESCRIPTION', 'SEO描述', '1', '0', '', '1', '1', '22');
INSERT INTO `%DB_PREFIX%conf` VALUES ('177', 'PROMOTE_MSG_LOCK', '0', '0', '0', '', '0', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('178', 'PROMOTE_MSG_PAGE', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('179', 'STATE_CDOE', '', '1', '0', '', '1', '1', '23');
INSERT INTO `%DB_PREFIX%conf` VALUES ('180', 'USER_VERIFY', '0', '4', '1', '0,1,2,3', '1', '1', '63');
INSERT INTO `%DB_PREFIX%conf` VALUES ('181', 'INVITE_REFERRALS', '20', '4', '0', '', '1', '1', '67');
INSERT INTO `%DB_PREFIX%conf` VALUES ('182', 'INVITE_REFERRALS_TYPE', '0', '4', '1', '0,1', '1', '1', '68');
INSERT INTO `%DB_PREFIX%conf` VALUES ('183', 'USER_MESSAGE_AUTO_EFFECT', '1', '4', '1', '0,1', '1', '1', '64');
INSERT INTO `%DB_PREFIX%conf` VALUES ('184', 'REFERRAL_LIMIT', '1', '4', '0', '', '1', '1', '69');
INSERT INTO `%DB_PREFIX%conf` VALUES ('185', 'REFERRAL_IP_LIMI', '0', '4', '1', '0,1', '1', '1', '71');
INSERT INTO `%DB_PREFIX%conf` VALUES ('186', 'REFERRALS_DELAY', '1', '4', '0', '', '1', '1', '70');
INSERT INTO `%DB_PREFIX%conf` VALUES ('187', 'MOBILE_MUST', '0', '4', '1', '0,1', '1', '1', '66');
INSERT INTO `%DB_PREFIX%conf` VALUES ('190', 'MAIL_SEND_PAYMENT', '0', '5', '1', '0,1', '1', '1', '75');
INSERT INTO `%DB_PREFIX%conf` VALUES ('191', 'REPLY_ADDRESS', 'info@fanwe.com', '5', '0', '', '1', '1', '77');
INSERT INTO `%DB_PREFIX%conf` VALUES ('192', 'MAIL_SEND_DELIVERY', '0', '5', '1', '0,1', '1', '1', '76');
INSERT INTO `%DB_PREFIX%conf` VALUES ('193', 'MAIL_ON', '0', '5', '1', '0,1', '1', '1', '72');
INSERT INTO `%DB_PREFIX%conf` VALUES ('262', 'NETWORK_FOR_RECORD', '闽ICP备10206706号-7', '1', '0', '', '1', '1', '201');
INSERT INTO `%DB_PREFIX%conf` VALUES ('263', 'QR_CODE', './public/images/qrcode/qcode.jpg', '1', '2', '', '1', '1', '202');
INSERT INTO `%DB_PREFIX%conf` VALUES ('264', 'REPAY_MAKE', '7', '1', '0', '', '1', '1', '264');
INSERT INTO `%DB_PREFIX%conf` VALUES ('265', 'SQL_CHECK', '0', '1', '1', '0,1', '1', '1', '265');
INSERT INTO `%DB_PREFIX%conf` VALUES ('266', 'MORTGAGE_MONEY', '0.01', '6', '0', '', '1', '1', '1');
INSERT INTO `%DB_PREFIX%conf` VALUES ('267', 'ENQUIER_NUM', '6', '6', '0', '', '1', '1', '2');
INSERT INTO `%DB_PREFIX%conf` VALUES ('268', 'INVEST_PAY_SEND_STATUS', '1', '6', '1', '0,1,2', '1', '1', '3');
INSERT INTO `%DB_PREFIX%conf` VALUES ('269', 'INVEST_STATUS_SEND_STATUS', '1', '6', '1', '0,1,2', '1', '1', '4');
INSERT INTO `%DB_PREFIX%conf` VALUES ('270', 'INVEST_PAID_SEND_STATUS', '1', '6', '1', '0,1,2', '1', '1', '5');
INSERT INTO `%DB_PREFIX%conf` VALUES ('271', 'INVEST_STATUS', '1', '6', '1', '0,1,2', '1', '1', '0');
INSERT INTO `%DB_PREFIX%conf` VALUES ('272', 'AVERAGE_USER_STATUS', '0', '6', '1', '0,1', '1', '1', '6');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal`;
CREATE TABLE `%DB_PREFIX%deal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_match` text NOT NULL,
  `name_match_row` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `source_vedio` varchar(255) NOT NULL,
  `vedio` varchar(255) NOT NULL,
  `deal_days` int(11) NOT NULL COMMENT '上线天数，仅提供管理员审核参考',
  `begin_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `limit_price` decimal(20,2) NOT NULL COMMENT '项目金额',
  `brief` text NOT NULL,
  `description` text NOT NULL,
  `comment_count` int(11) NOT NULL,
  `support_count` int(11) NOT NULL COMMENT '支持人数',
  `focus_count` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `log_count` int(11) NOT NULL,
  `support_amount` decimal(20,2) NOT NULL COMMENT '支持总金额，需大等于limit_price(不含运费)',
  `pay_amount` decimal(20,2) NOT NULL COMMENT '可发放金额，抽完佣金的可领金额（含运费，运费不抽佣金）\r\n即support_amount*佣金比率+delivery_fee_amount',
  `delivery_fee_amount` decimal(20,2) NOT NULL COMMENT '交付费用金额',
  `create_time` int(11) NOT NULL,
  `seo_title` text NOT NULL,
  `seo_keyword` text NOT NULL,
  `seo_description` text NOT NULL,
  `tags` text NOT NULL,
  `tags_match` text NOT NULL,
  `tags_match_row` text NOT NULL,
  `success_time` int(11) NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `cate_id` int(11) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `is_recommend` tinyint(1) NOT NULL COMMENT '推荐项目',
  `is_classic` tinyint(1) NOT NULL COMMENT '经典项目',
  `is_delete` tinyint(1) NOT NULL,
  `deal_extra_cache` text NOT NULL,
  `is_edit` tinyint(1) NOT NULL,
  `description_1` text NOT NULL,
  `is_support_print` int(11) NOT NULL,
  `user_level` int(11) NOT NULL,
  `is_has_send_success` tinyint(1) NOT NULL,
  `pay_radio` decimal(20,2) NOT NULL,
  `adv_image` varchar(255) NOT NULL COMMENT '广告图片',
  `status` tinyint(1) NOT NULL,
  `deal_background_image` varchar(255) NOT NULL COMMENT '项目背景图片',
  `deal_backgroundColor_image` varchar(255) NOT NULL COMMENT '项目底色图片',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示普通众筹，1表示股权众筹',
  `description_2` text NOT NULL COMMENT '目标用户或客户群体定位',
  `description_3` text NOT NULL COMMENT '目标用户或客户群体目前困扰或需求定位',
  `description_4` text NOT NULL COMMENT '满足目标用户或客户需求的产品或服务模式说明',
  `description_5` text NOT NULL COMMENT '项目赢利模式说明',
  `description_6` text NOT NULL COMMENT '市场主要同行或竞争对手概述',
  `description_7` text NOT NULL COMMENT '项目主要核心竞争力说明',
  `stock` text NOT NULL COMMENT '股东信息',
  `unstock` text NOT NULL COMMENT '非股东成员',
  `history` text NOT NULL COMMENT '三年信息',
  `plan` text NOT NULL COMMENT '三年计划',
  `attach` text NOT NULL COMMENT '附件信息',
  `investor_authority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示只有投资人可以，1表所有人都可以看',
  `project_step` tinyint(1) NOT NULL COMMENT '项目阶段 0表示未启动 1表示在开发中 2产品已上市或上线，3已经有收入，4已经盈利',
  `business_create_time` int(11) NOT NULL COMMENT '企业成立时间',
  `business_employee_num` int(11) NOT NULL COMMENT '企业员工数量',
  `business_is_exist` tinyint(1) NOT NULL COMMENT '公司是否成立',
  `has_another_project` tinyint(1) NOT NULL COMMENT '是否有其他项目 0表示么有  1表示有',
  `business_name` varchar(255) NOT NULL COMMENT '公司名称',
  `business_address` varchar(255) NOT NULL COMMENT '办公地址',
  `business_stock_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '入股方式  0直接入股原公司 1 创建新公司入股',
  `business_pay_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '付款方式 0表示一次性付款',
  `business_descripe` text NOT NULL COMMENT '企业简介',
  `pay_end_time` int(11) NOT NULL COMMENT '支付结算时间',
  `investor_edit` int(1) NOT NULL COMMENT '0表示显示下一步按钮，1表示显示不错和返回按钮',
  `mine_stock` decimal(10,2) DEFAULT NULL COMMENT '投资人占有的股份',
  `transfer_share` decimal(10,2) NOT NULL,
  `virtual_num` int(11) NOT NULL COMMENT '虚拟人数',
  `virtual_price` decimal(20,2) NOT NULL COMMENT '虚拟金额',
  `gen_num` int(11) NOT NULL COMMENT '跟投人数',
  `xun_num` int(11) NOT NULL COMMENT '询价人数',
  `invote_money` decimal(20,2) NOT NULL COMMENT '预购金额',
  `invote_num` int(11) NOT NULL COMMENT '投资人数',
  `invote_mini_money` decimal(10,2) NOT NULL COMMENT '最低支付金额',
  `refuse_reason` text COMMENT '拒绝理由',
  `audit_data` text NOT NULL COMMENT '发起人资料',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热门',
  PRIMARY KEY (`id`),
  KEY `begin_time` (`begin_time`),
  KEY `end_time` (`end_time`),
  KEY `is_effect` (`is_effect`),
  KEY `limit_price` (`limit_price`),
  KEY `comment_count` (`comment_count`),
  KEY `support_count` (`support_count`),
  KEY `focus_count` (`focus_count`),
  KEY `view_count` (`view_count`),
  KEY `log_count` (`log_count`),
  KEY `support_amount` (`support_amount`),
  KEY `create_time` (`create_time`),
  KEY `is_success` (`is_success`),
  KEY `cate_id` (`cate_id`),
  KEY `sort` (`sort`),
  KEY `is_recommend` (`is_recommend`),
  KEY `is_classic` (`is_classic`),
  KEY `is_delete` (`is_delete`),
  FULLTEXT KEY `tags_match` (`tags_match`),
  FULLTEXT KEY `name_match` (`name_match`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='//项目信息';

-- ----------------------------
-- Records of fanwe_deal
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal` VALUES ('55', '原创DIY桌面游戏《功夫》《黄金密码》期待您的支持', 'ux21151ux22827,ux26700ux38754,ux26399ux24453,ux23494ux30721,ux40644ux37329,ux25903ux25345,ux21407ux21019,ux28216ux25103,ux68ux73ux89,ux21407ux21019ux68ux73ux89ux26700ux38754ux28216ux25103ux12298ux21151ux22827ux12299ux12298ux40644ux37329ux23494ux30721ux12299ux26399ux24453ux24744ux30340ux25903ux25345,ux21407ux21019ux68ux73ux89ux26700ux38754ux28216ux25103ux12298ux21151ux22827ux12299ux12298ux40644ux37329ux23494ux30721ux12299ux26399ux24453ux24744ux30340ux25903ux25345,ux21407ux21019ux68ux73ux89ux26700ux38754ux28216ux25103ux12298ux21151ux22827ux12299ux12298ux40644ux37329ux23494ux30721ux12299ux26399ux24453ux24744ux30340ux25903ux25345', '功夫,桌面,期待,密码,黄金,支持,原创,游戏,DIY,原创DIY桌面游戏《功夫》《黄金密码》期待您的支持,原创DIY桌面游戏《功夫》《黄金密码》期待您的支持,原创DIY桌面游戏《功夫》《黄金密码》期待您的支持', './public/attachment/201211/07/10/021e2f6812298468cfab78cbd07b90ee85.jpg', '', '', '15', '1351710606', '1383765012', '1', '3000.00', '这次给大家带来的是我们自己原创的两个桌面游戏《功夫》和《黄金密码》，由于我们并非专业的桌游制作公司，希望大家能够喜欢并支持我们！', '这次给大家带来的是我们自己原创的两个桌面游戏《功夫》和《黄金密码》，由于我们并非专业的桌游制作公司，所以在游戏的美术、包装、宣传等方面都会存在一些不足。但本次带来的两个作品都是我们利用几乎所有的业余时间尽心尽力制作出来的，希望大家能够喜欢并支持我们！<p><br />\r\n</p>\r\n<h3>我想要做什么</h3>\r\n<p>&nbsp; 桌面游戏是一种健康的休闲方式，你不用整天面对电脑的辐射，同时也让你可以不再过度沉迷于虚拟的网络世界中。因为桌面游戏方式的特殊性，能使你更加注重加强与人面对面的交流，提高自己的语言和沟通能力，还可以在现实生活中用这种轻松愉快的休闲方式结交更多的朋友。</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;我们就是这样一群喜爱桌游，同时喜欢设计桌游的年轻人，我们并非专业的桌游制作团队，我们只是凭着对桌游的爱好开始了对桌游设计的探索。我们希望通过努力，将桌游的快乐带给更多喜欢轻松休闲、热爱生活的朋友。但是，我们的资金及能力有限，需要得到大家的帮助与支持，才能实现这样的梦想。也希望您在支持我们的同时收获一份快乐和惊喜！</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;我们这次将原创的桌面游戏《功夫》和《黄金密码》一起放到这里，希望得到大家的支持！&nbsp;&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><br />\r\n<img src=\"./public/attachment/201211/07/16/da4f6f7e11b249dcf71bf5e9c6a86d8a83o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n</p>\r\n<p>游戏人数：2-4人</p>\r\n<p>适合年龄：8+</p>\r\n<p>游戏时间：10-30分钟</p>\r\n<p>游戏类型：手牌管理</p>\r\n<p>游戏背景：你在游戏中扮演一名武者，灵活运用你掌握的功夫（手牌）和装备（装备牌）对抗其他的武者并最终打败他们。</p>\r\n<p>游戏目标：扣除敌方所有人物的体力为胜。</p>\r\n游戏配件：69张动作牌（手牌）、6张道具牌、2张血量牌（需自行制作）<p><br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/7a404c90f81ca1368ff0f5b24e26a5d781o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n</p>\r\n<p>游戏过程：游戏的每个回合分两个阶段，第一阶段为热身阶段，获得热身阶段胜利的玩家成为第二阶段（攻击阶段）的主导者，由他决定第二阶段如何进行。</p>\r\n<p>&nbsp;&nbsp;&nbsp;《功夫》用卡牌较好的模拟再现了格斗中的一些乐趣，比如热身阶段的猜招、攻击阶段一招一式的过招，同时结合手牌管理的一些特点，打出组合招式及连招，配合你获得的道具，最终战胜对手。在游戏过程中，当你取得一定的优势时，也不能掉以轻心，形式可能会因为你的任何一个破绽而发生逆转，这与格斗、搏击的情况十分相似。所以如何保持良好的心态，灵活的运用手牌才是这个游戏制胜的关键所在。（具体规则见最下方及本项目动态）</p>\r\n<p><br />\r\n</p>\r\n<p><br />\r\n</p>\r\n<p>游戏人数：3-4人</p>\r\n<p>适合年龄：8+</p>\r\n<p>游戏时间：20-40分钟</p>\r\n<p>游戏类型：逻辑推理、谜题设计</p>\r\n<p>游戏背景：二战时期，德军将一批黄金铸成金条，分别保存在3个金库里，并派重兵把守。为了得到这批黄金，美军重金收买了一个德军守卫为内奸，内奸成功获取了金库的密码破解方法，并将密码破解方法以暗号的形式告知了美军特工。但是，与此同时德军也发现了暗号，并且金库的守卫非常森严，解开金库密码的时间只有1分钟……玩家在这个游戏中分别扮演德军、德军内奸、美军特工。如何设计出德军看不懂，美军特工又能在1分钟内解出的暗号密码。就看你的表现啦！</p>\r\n<p>游戏目标：根据身份的不同，任务也不同。德军需解开密码保住金库，特工需设置密码阻止德军解密，美军需解开密码同时选择金库获得黄金。</p>\r\n<p>游戏配件：10张密码牌、12张空箱牌、24张黄金牌、沙漏1个、草稿纸和笔（自备）</p>\r\n<p>游戏过程：每人分别扮演一次特工、德军、美军，完成后计算每人所获得的黄金数量，黄金最多的玩家获胜。</p>\r\n<p><br />\r\n<br />\r\n</p>\r\n<p></p>', '0', '1', '0', '3', '1', '15.00', '18.50', '5.00', '1352229030', '', '', '', '功夫 桌面 期待 密码 黄金 支持 原创 游戏 DIY', 'ux21151ux22827,ux26700ux38754,ux26399ux24453,ux23494ux30721,ux40644ux37329,ux25903ux25345,ux21407ux21019,ux28216ux25103,ux68ux73ux89', '功夫,桌面,期待,密码,黄金,支持,原创,游戏,DIY', '0', '0', '8', '福建', '福州', '17', '0', 'fanwe', '1', '1', '0', '', '0', '', '0', '0', '0', '0.00', '', '0', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '', '0', '0', null, '0.00', '0', '0.00', '0', '0', '0.00', '0', '0.00', null, '', '0');
INSERT INTO `%DB_PREFIX%deal` VALUES ('56', '拥有自己的咖啡馆', 'ux21654ux21857ux39302,ux25317ux26377,ux33258ux24049,ux25317ux26377ux33258ux24049ux30340ux21654ux21857ux39302', '咖啡馆,拥有,自己,拥有自己的咖啡馆', './public/attachment/201211/07/11/40e44eb97b0ca5aed5148e59c2cc8dcb95.jpg', '', '', '30', '1351711495', '1384975499', '1', '5000.00', '每个人心目中都有一个属于自己的咖啡馆,我们也是.但我们想要的咖啡馆，又不仅仅是咖啡馆', '<h3>关于我</h3>\r\n<p>每个人心目中都有一个属于自己的咖啡馆<br />\r\n我们也是<br />\r\n但我们想要的咖啡馆，又不仅仅是咖啡馆<br />\r\n这里除了售卖咖啡和甜点，还有旅行的梦想<br />\r\n我们想要一个“窝”，一个无论在出发前还是归来后随时开放的地方<br />\r\n梦想着有一天<br />\r\n我们可以带着咖啡的香气出发<br />\r\n又满载着旅行的收获回到充满咖啡香气的小“窝”</p>\r\n<h3>我想要做什么</h3>\r\n<p>以图文并茂的方式简洁生动地说明你的项目，让大家一目了然，这会决定是否将你的项目描述继续看下去。建议不超过300字。<br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/0482ef5836f6745af0f59ff40d40805765o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\r\n</p>\r\n<h3>为什么我需要你的支持</h3>\r\n<p>这是加分项。说说你的项目不同寻常的特色、资金用途、以及大家支持你的理由。这会让更多人能够支持你，不超过200个汉字。<br />\r\n<br />\r\n</p>\r\n<h3>我的承诺与回报</h3>\r\n让大家感到你对待项目的认真程度，鞭策你将项目执行最终成功。同时向大家展示一下你为支持者准备的回报，来吸引更多人支持你。<br />\r\n<br />\r\n<img src=\"./public/attachment/201211/07/16/2ae4c7149cfd31f12d91453713322f9076o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />', '0', '11', '1', '4', '1', '5500.00', '4950.00', '0.00', '1352229954', '', '', '', '咖啡馆 拥有 自己', 'ux21654ux21857ux39302,ux25317ux26377,ux33258ux24049', '咖啡馆,拥有,自己', '1352230293', '1', '1', '北京', '东城区', '18', '0', 'fzmatthew', '1', '1', '0', '', '0', '', '0', '0', '0', '0.00', '', '0', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '', '0', '0', null, '0.00', '0', '0.00', '0', '0', '0.00', '0', '0.00', null, '', '0');
INSERT INTO `%DB_PREFIX%deal` VALUES ('57', '短片电影《Blind Love》', 'ux30701ux29255,ux30005ux24433,ux66ux108ux105ux110ux100,ux76ux111ux118ux101,ux30701ux29255ux30005ux24433ux12298ux66ux108ux105ux110ux100ux76ux111ux118ux101ux12299', '短片,电影,Blind,Love,短片电影《Blind Love》', './public/attachment/201211/07/11/0c067c4522bba51595c324028be7070d11.jpg', 'http://player.youku.com/player.php/sid/XMzgyNjMzNDA4/v.swf', 'http://v.youku.com/v_show/id_XMzgyNjMzNDA4.html', '30', '1349034009', '1383766813', '1', '3000.00', '我叫武秋辰， 美国圣地亚哥大学影视专业硕士毕业。这是我在毕业后的第一部独立电影作品，讲述了一个关于盲人画家的唯美爱情故事。', '<p>我叫武秋辰， 美国圣地亚哥大学影视专业硕士毕业。这是我在毕业后的第一部独立电影作品，讲述了一个关于盲人画家的唯美爱情故事。</p>\r\n <p>这是一个需要爱与被爱的世界，然而在我们面对这纷繁复杂多变的世界时，我们如何过滤掉那迷乱双眼的尘沙找到真爱？我们在爱中得救，在爱中迷失。我们过度相信我们用双眼所见的，却忘记听从内心最真的感受！<br />\r\n<br />\r\n</p>\r\n<p>我们一路奔跑、一路追逐，生活的洪流把我们涌向未来不确定的方向，我们有着一双能望穿苍穹的眼睛，却不断的迷失在路途中。如果有一天我们的双眼失去光明……<br />\r\n<br />\r\n</p>\r\n<p>真爱是否还遥远？<br />\r\n<br />\r\n</p>\r\n<p>导演武秋辰将用电影语言为我们讲述一位盲人画家的爱情故事，如同她所写道的：“我们视觉正常的人很容易被表象所迷惑，而我们的触觉，听觉和嗅觉却非常的精准，给我们带来更丰富的感知。”当我们不仅凭双眼去认识这个世界的时候，也许答案就在那里！<br />\r\n<br />\r\n</p>\r\n<p>为了使影片更富深入性、更具专业性，导演请来了好莱坞的职业演员，就连剧中的盲人画像也由美国著名画家OlyaLusina特为此片创作。<br />\r\n<br />\r\n</p>\r\n<p>该片不仅是一个远赴美国实现梦想的中国女孩的心血之作，同时也深刻展现了一个盲人心中的世界，从“他”的角度为因爱迷失的人们找到了一个诗意的出口。<br />\r\n<br />\r\n</p>\r\n<p>在这里，真诚地感谢您的关注！关注武秋辰和她的《BlindLove》！<br />\r\n<br />\r\n</p>\r\n<h3>自我介绍<br />\r\n</h3>\r\n<p>我是一个在美国学电影做电影的中国女孩。在美国圣地亚哥大学电影系求学的过程中，我学会了编剧，导演，拍摄和剪辑，参与了几十部电影的创作。“盲爱”是我在硕士毕业后自编自导的第一部独立电影作品。</p>\r\n<p><br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/148cb883cbb170735c331125a96c11e162o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n</p>\r\n<p><br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/875016977d65ee2cc679ab0cfd7a7f6620o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\r\n<br />\r\n</p>', '0', '0', '0', '3', '1', '0.00', '0.00', '0.00', '1352230821', '', '', '', '短片 电影 Blind Love', 'ux30701ux29255,ux30005ux24433,ux66ux108ux105ux110ux100,ux76ux111ux118ux101', '短片,电影,Blind,Love', '0', '0', '3', '福建', '福州', '17', '0', 'fanwe', '1', '1', '0', '', '0', '', '0', '0', '0', '0.00', '', '0', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '', '0', '0', null, '0.00', '0', '0.00', '0', '0', '0.00', '0', '0.00', null, '', '0');
INSERT INTO `%DB_PREFIX%deal` VALUES ('58', '流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！', 'ux21654ux21857ux39302,ux37325ux24314,ux20844ux30410,ux27969ux28010,ux21147ux37327,ux38656ux35201,ux22825ux20351,ux22823ux23478,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281', '咖啡馆,重建,公益,流浪,力量,需要,天使,大家,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！', './public/attachment/201211/07/11/438813e6d75cb84c6b0df8ffbad7aa8c31.jpg', 'http://www.tudou.com/v/153527563/v.swf', 'http://www.tudou.com/listplay/i67lCgQt5nQ/i9toRdup3ok.html', '50', '1352145022', '1385668225', '1', '3000.00', '爱天使成立的猫天使驿站三年多收养救助了两百余只的流浪猫并为它们找到了一个个温暖的家。', '<p>爱天使成立的猫天使驿站三年多收养救助了两百余只的流浪猫并为它们找到了一个个温暖的家。爱天使是一种爱，更是一种生活！坚持个人信念的我一直努力活出这个世上不一般的价值人生。那就是不追求自己能拥有什么而在能为自己以外的生命带去什么。。。爱天使在今年因合同到期而到了转折点，重建是艰辛的却也坚信必将更加强大。</p>\r\n <h3>【关于我】——将救助流浪猫视为自己的事业！</h3>\r\n<p>首先做个自我介绍：</p>\r\n<p>我叫李文婷，英文名ANGELLI。</p>\r\n<p>是一名爱猫如命的“狂热分子”，</p>\r\n<p>作为流浪猫的代理麻麻已收养救助过两百余只猫咪；</p>\r\n<p>00年在大学校园宿舍开始拨号上网的网络生活，</p>\r\n<p>担任系学生会副主席及宣传部长等，</p>\r\n<p>参与系女篮队、校诗朗诵比赛、主持系选举活动，<br />\r\n</p>\r\n<p>组织带领系队作为一辩参加校辩论赛获得季军，</p>\r\n<p>毕业后于厦门海尔及三五互联等公司工作近六年。</p>\r\n<p>工作中一直表现突出主持公司千人晚会并荣获过部门最高荣誉奖。</p>\r\n<p>08年辞去部门经理一职后成为SOHO一族，</p>\r\n<p>经营LA爱天使韩国饰品成为淘宝卖家。</p>\r\n<p>于短短半年间毫无虚假的升为二钻一年后升至三钻，</p>\r\n<p>于09年6月20日在老爸大力的支持下经营爱天使咖啡馆，</p>\r\n<p>于2010年10月创办猫天使驿站正式收养救助流浪猫，</p>\r\n<p>先后接受了海峡导报厦门卫视等媒体及大学生的多次采访报道。<br />\r\n</p>\r\n<p>三年间收养救助了两百余只流浪猫并为它们找到了一个个温暖的家。</p>\r\n<p>与仔仔、全全、QQ、EE四只咪咪一起相伴爱天使救命流浪猫的生活。</p>\r\n<p>爱天使就是流浪猫们的家，是我将用余生为之奋斗的事业！</p>\r\n将“关爱弱小弱势生命，传递爱分享快乐”救助流浪猫视为毕生为之努力的事业。<br />\r\n<br />\r\n<img src=\"./public/attachment/201211/07/16/dda29128a6310c273da111f1f30296c172o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\r\n<br />\r\n<img src=\"./public/attachment/201211/07/16/c7650c3dd93e5585dbfad780ba3bbced31o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />', '1', '2', '1', '3', '1', '5000.00', '4500.00', '0.00', '1352231478', '', '', '', '咖啡馆 重建 公益 流浪 力量 需要 天使 大家', 'ux21654ux21857ux39302,ux37325ux24314,ux20844ux30410,ux27969ux28010,ux21147ux37327,ux38656ux35201,ux22825ux20351,ux22823ux23478', '咖啡馆,重建,公益,流浪,力量,需要,天使,大家', '1352231704', '1', '7', '福建', '福州', '17', '0', 'fanwe', '1', '1', '0', '', '0', '', '0', '0', '0', '0.00', '', '0', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '', '0', '0', null, '0.00', '0', '0.00', '0', '0', '0.00', '0', '0.00', null, '', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_cate`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_cate`;
CREATE TABLE `%DB_PREFIX%deal_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='// 项目分类';

-- ----------------------------
-- Records of fanwe_deal_cate
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('1', '设计', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('2', '科技', '2', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('3', '影视', '3', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('4', '摄影', '4', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('5', '音乐', '5', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('6', '出版', '6', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('7', '活动', '7', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('8', '游戏', '8', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('9', '旅行', '9', '0', '0');
INSERT INTO `%DB_PREFIX%deal_cate` VALUES ('10', '其他', '10', '0', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_comment`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_comment`;
CREATE TABLE `%DB_PREFIX%deal_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL COMMENT '回复的评论ID',
  `deal_user_id` int(11) NOT NULL COMMENT '项目发起人的ID',
  `reply_user_id` int(11) NOT NULL COMMENT '回复的评论的评论人ID',
  `deal_user_name` varchar(255) NOT NULL,
  `reply_user_name` varchar(255) NOT NULL,
  `deal_info_cache` text NOT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '状态0 表示隐藏 ，1 表示 显示',
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`),
  KEY `log_id` (`log_id`),
  KEY `pid` (`pid`),
  KEY `deal_user_id` (`deal_user_id`),
  KEY `reply_user_id` (`reply_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=176 DEFAULT CHARSET=utf8 COMMENT='// 项目评论';

-- ----------------------------
-- Records of fanwe_deal_comment
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_comment` VALUES ('170', '55', '加油哦！', '18', '1352229601', '26', 'fzmatthew', '0', '17', '0', 'fanwe', '', '', '0');
INSERT INTO `%DB_PREFIX%deal_comment` VALUES ('171', '56', '感谢支持！！', '18', '1352230363', '27', 'fzmatthew', '0', '18', '0', 'fzmatthew', '', '', '0');
INSERT INTO `%DB_PREFIX%deal_comment` VALUES ('172', '57', '好好加油！', '18', '1352230882', '28', 'fzmatthew', '0', '17', '0', 'fanwe', '', '', '0');
INSERT INTO `%DB_PREFIX%deal_comment` VALUES ('173', '57', '回复 fzmatthew:一定会的。', '17', '1352230924', '28', 'fanwe', '172', '17', '18', 'fanwe', 'fzmatthew', '', '0');
INSERT INTO `%DB_PREFIX%deal_comment` VALUES ('174', '58', '感谢', '17', '1352231585', '29', 'fanwe', '0', '17', '0', 'fanwe', '', '', '0');
INSERT INTO `%DB_PREFIX%deal_comment` VALUES ('175', '58', '感谢大家的支持', '17', '1352231787', '0', 'fanwe', '0', '17', '0', 'fanwe', '', '', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_faq`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_faq`;
CREATE TABLE `%DB_PREFIX%deal_faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='//项目常见问题解答';

-- ----------------------------
-- Records of fanwe_deal_faq
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_faq` VALUES ('98', '56', '我们的咖啡馆在哪里？', '目前暂定的店址，是在延安西路、重庆北路附近。', '1');
INSERT INTO `%DB_PREFIX%deal_faq` VALUES ('99', '56', '我们的咖啡馆大概有多大？', '目前定的店址面积约在200平米以内，有上下两层，底楼较小，二层是整个一层。', '2');
INSERT INTO `%DB_PREFIX%deal_faq` VALUES ('100', '56', '咖啡馆筹备的进度是？', '由于各种的原因，在寻找店址的过程中，先先后后放弃了很多地方，目前找的店址，在办证、面积、交通等方面都较理想。所以基本确定了地方，正在积极办理营业执照及设计各方面的工作，同时也在现有资金的基础上，募集更多的资金及支持。目前店面的装修免租期约在2个月内，所以离正式开业还需要一些时日。', '3');
INSERT INTO `%DB_PREFIX%deal_faq` VALUES ('96', '58', '流浪猫与爱天使咖啡是什么关系呢？', '爱天使就是收养救助流浪猫的咖啡馆。因为救助需要资金与空间，这个资金的最好来源一定是要有一个有收益的项目来支撑而非单纯靠募捐方式，否则容易造成依赖与被动，当然其实也因自己个性好强。 在繁殖季爱天使最多一天能收到3-6只的流浪猫，三年间独自一人艰难维持并收养救助两百多只流浪猫，所需空间资金精力全部由我个人维持。', '1');
INSERT INTO `%DB_PREFIX%deal_faq` VALUES ('97', '58', '新店确定了吗？装修顺利吗？在哪里呢？', '新店终于在几经各方协商后于前日确定于文化艺术中心广场正中间（五一文化广场中间文化宫左边，图书馆对面，大润发楼上正中间）的玻璃房。昨天开始了紧张的重新设计装修中。关于搬店的过程几经周折的磨难苦不堪言。因为新店面积比老店小了，而东西只能先搬过去，而里面要装修所以大柜子都没办法先放进去。里面也已堆满了东西，装修师傅找了五个都不愿意接，因为太多东西很影响装修。东西要一直搬来搬去，现在全部是灰，之后又是一大堆的卫生清洁整理工作，已有很多东西因此受到损坏了。。。新店是转过来了付了一大笔转让费未想因为要重装再装修又要投入两万多的改装费，这笔当时完全忘记预算在内了。。。 不过现在顺利的进入装修重新开业在即。谢谢大家的关注支持！我会让爱天使尽快走回正轨。', '2');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_focus_log`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_focus_log`;
CREATE TABLE `%DB_PREFIX%deal_focus_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='// 项目焦点';

-- ----------------------------
-- Records of fanwe_deal_focus_log
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_focus_log` VALUES ('32', '58', '18', '1352231518');
INSERT INTO `%DB_PREFIX%deal_focus_log` VALUES ('33', '56', '17', '1352232247');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_info_list`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_info_list`;
CREATE TABLE `%DB_PREFIX%deal_info_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL COMMENT '项目ID',
  `type` tinyint(1) NOT NULL COMMENT '类型 0 非股权团队 1 股权团队 2 项目历史 3 计划  4 项目附件',
  `name_list` text NOT NULL,
  `descrip_list` text NOT NULL,
  `pay_list` text NOT NULL COMMENT '支出列表',
  `income_list` text NOT NULL COMMENT '收入列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fanwe_deal_info_list
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_item`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_item`;
CREATE TABLE `%DB_PREFIX%deal_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `price` decimal(20,2) NOT NULL COMMENT '金额',
  `support_count` int(11) NOT NULL,
  `support_amount` decimal(20,2) NOT NULL COMMENT '支持量',
  `description` text NOT NULL,
  `is_delivery` tinyint(1) NOT NULL,
  `delivery_fee` decimal(20,2) NOT NULL COMMENT '支付金额',
  `is_limit_user` tinyint(1) NOT NULL COMMENT '是否限',
  `limit_user` int(11) NOT NULL COMMENT '限额数量',
  `repaid_day` int(11) NOT NULL COMMENT '项目成功后的回报时间',
  `virtual_person` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `price` (`price`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='// 项目回报';

-- ----------------------------
-- Records of fanwe_deal_item
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('17', '55', '10.00', '0', '0.00', '我们将以平信的方式寄出2款桌游的首发纪念牌，随机赠送部分游戏牌（至少5张）并在游戏说明书中致谢', '1', '0.00', '0', '0', '60', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('18', '55', '15.00', '1', '15.00', '我们将回报《黄金密码》1套，赠送首发纪念牌并在游戏说明书中致谢。（邮费另计）', '1', '5.00', '0', '0', '60', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('19', '55', '30.00', '0', '0.00', '我们将回报《黄金密码》、《功夫》各1套，赠送首发纪念牌并在游戏说明书中致谢。（邮费另计）', '1', '5.00', '0', '0', '60', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('20', '55', '50.00', '0', '0.00', '我们将回报《黄金密码》、《功夫》各2套，赠送首发纪念牌并在游戏说明书中致谢。（邮费另计）', '1', '5.00', '0', '0', '60', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('21', '55', '500.00', '0', '0.00', '我们将回报《黄金密码》40套，赠送首发纪念牌并在游戏说明书中致谢，同时还将在首发纪念牌上印上您的姓名或公司名称致谢！（限额2名）。（国内包邮）', '1', '0.00', '0', '0', '60', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('22', '56', '50.00', '0', '0.00', '你将收到小组成员，在旅行中为你寄出的一张祝福明信片\r\n你将成为我们开业PARTY的座上嘉宾\r\n所以，请留下你的联系方式（电话，地址及邮编）', '1', '0.00', '0', '0', '50', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('23', '56', '200.00', '0', '0.00', '你将获得咖啡馆开业后永久9折会员卡一张（会员卡可用于借阅书籍，并在生日当天获得免费饮料一杯）\r\n店内旅行纪念手信一份（价值在50元以内）\r\n成为开业PARTY的邀请来宾', '1', '0.00', '0', '0', '60', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('24', '56', '500.00', '11', '5500.00', '你将获得咖啡馆开业后永久9折会员卡一张（会员卡可用于借阅书籍，并在生日当天获得免费饮料一杯）\r\n一份店内招牌下午茶套餐的招待券\r\n免费参加店内组织的活动（各类分享会、试吃体验等等）\r\n成为开业PARTY的邀请来宾', '1', '0.00', '0', '0', '50', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('25', '57', '60.00', '0', '0.00', '电影签名海报和明信片。全国包邮。', '1', '0.00', '0', '0', '50', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('26', '57', '150.00', '0', '0.00', '电影DVD的拷贝一张，以及片尾特别感谢。全国包邮。', '1', '0.00', '0', '0', '55', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('27', '57', '600.00', '0', '0.00', '一个崭新的印有影片标志的8GB快闪储存器（flash drive), 电影DVD 拷贝，剧照，和特别回报（包括预告片DVD，拍摄花絮DVD）, 以及片尾特别感谢。（所有DVD均有中文字幕），全国包邮。', '1', '0.00', '1', '20', '50', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('28', '57', '1200.00', '0', '0.00', '电影签名海报和明信片， 一个崭新的印有影片标志的8GB快闪储存器（flash drive), 电影DVD 拷贝，剧照，和特别回报（包括预告片DVD，拍摄花絮DVD）, 以及片尾特别感谢。（所有DVD均有中文字幕）全国包邮。', '1', '0.00', '1', '5', '10', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('29', '57', '3000.00', '0', '0.00', '成为影片的联合制片人（associate producer), 8GB的快闪储存器（flash drive)， 电影DVD 拷贝，剧照，和特别回报（包括预告片DVD，拍摄花絮DVD）。（所有DVD均有中文字幕） 全国包邮。', '1', '0.00', '0', '0', '10', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('30', '58', '1000.00', '0', '0.00', '爱的礼物：精美工艺品及红酒。如果你希望得到一份爱的礼物与记念，请留言你的详细地址姓名电话，我将会于爱天使重建之后的三个月内为你寄一件精美的工艺品及价值399元的澳洲红宝龙红酒一瓶！你将成为爱天使的终生会员。。。', '1', '0.00', '0', '0', '50', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('31', '58', '2000.00', '1', '2000.00', '爱的礼物：精美工艺品红酒及晚餐。如果你希望得到一份爱的礼物与记念，请留言你的详细地址姓名电话，我将会于爱天使重建之后的三个月内为你寄一件精美的工艺品及澳洲红宝龙红酒一瓶及邀请你到爱天使享受晚餐！你将成为爱天使的终生会员。。。', '1', '0.00', '0', '0', '50', '0');
INSERT INTO `%DB_PREFIX%deal_item` VALUES ('32', '58', '3000.00', '1', '3000.00', '爱的礼物：精美工艺品及红酒及晚餐。如果你希望得到一份爱的礼物与记念，请留言你的详细地址姓名电话，我将会于爱天使重建之后的三个月内为你寄一件精美的工艺品及价值688元的澳洲康纳瓦拉红酒一瓶及邀请你到爱天使享受晚餐！你将成为爱天使的终生会员。。。', '1', '0.00', '0', '0', '50', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_item_image`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_item_image`;
CREATE TABLE `%DB_PREFIX%deal_item_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `deal_item_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `deal_item_id` (`deal_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='//项目回报图片';

-- ----------------------------
-- Records of fanwe_deal_item_image
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('40', '55', '18', './public/attachment/201211/07/10/1df0db265b86352e3886b9c62e8ef01b18.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('41', '55', '18', './public/attachment/201211/07/10/4a4a8bdca29b165b7bd5f510ce200c4385.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('42', '55', '18', './public/attachment/201211/07/10/c8223b4192fc39e4a3dce8a986eccf3994.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('43', '55', '19', './public/attachment/201211/07/10/a37a306a3bedaa664011115de251576034.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('44', '55', '20', './public/attachment/201211/07/10/cc12200a637c9db1dcf7354e592f220985.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('45', '55', '21', './public/attachment/201211/07/10/d65e7badd7098a0922db2b49c2fd8ef011.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('46', '56', '22', './public/attachment/201211/07/11/5d379d45a98db1816b027e85d59ca47c58.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('47', '56', '23', './public/attachment/201211/07/11/1ed8f029594ec5e809d95d8074fe3d2760.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('48', '56', '24', './public/attachment/201211/07/11/b08505b20319f493cbc03debd52eceb474.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('49', '56', '24', './public/attachment/201211/07/11/18b75305fe13c623363abb4ab995f6af34.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('50', '57', '25', './public/attachment/201211/07/11/7ecd287a12bff4289d305c0fb949889e29.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('51', '57', '26', './public/attachment/201211/07/11/d84152ab2d569c584c795018846cbb7233.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('52', '57', '27', './public/attachment/201211/07/11/bdefb72e944b41b60a751d50d0d84fe983.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('53', '57', '28', './public/attachment/201211/07/11/c0df234411b34427dedb121ab9bd577352.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('54', '57', '28', './public/attachment/201211/07/11/9c82e2a30f02513d0a197f3d4573794e76.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('55', '57', '29', './public/attachment/201211/07/11/326730647fde78562777b82f0a9e81a155.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('56', '58', '30', './public/attachment/201211/07/11/06bab2f2823bdd050ef8949162bf717729.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('57', '58', '31', './public/attachment/201211/07/11/c835e1fd43685e3106c4de641f70cf2b62.jpg');
INSERT INTO `%DB_PREFIX%deal_item_image` VALUES ('58', '58', '32', './public/attachment/201211/07/11/44036ee2e369e9c91be966a329cac70084.jpg');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_level`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_level`;
CREATE TABLE `%DB_PREFIX%deal_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '等级名',
  `level` int(11) DEFAULT NULL COMMENT '等级大小   大->小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='//项目等级';

-- ----------------------------
-- Records of fanwe_deal_level
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_log`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_log`;
CREATE TABLE `%DB_PREFIX%deal_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `deal_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `vedio` varchar(255) NOT NULL,
  `source_vedio` varchar(255) NOT NULL,
  `comment_data_cache` text NOT NULL,
  `deal_info_cache` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='//项目的动态，主要由发起人更新动态进度';

-- ----------------------------
-- Records of fanwe_deal_log
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_log` VALUES ('26', '功夫图文说明书1', '1352229555', '17', 'fanwe', '55', './public/attachment/201211/07/11/5d2a94ce2a3db73277fb04be463365a255.jpg', '', '', 'a:3:{s:13:\"comment_count\";s:1:\"1\";s:12:\"comment_list\";a:1:{i:0;a:13:{s:2:\"id\";s:3:\"170\";s:7:\"deal_id\";s:2:\"55\";s:7:\"content\";s:12:\"加油哦！\";s:7:\"user_id\";s:2:\"18\";s:11:\"create_time\";s:10:\"1352229601\";s:6:\"log_id\";s:2:\"26\";s:9:\"user_name\";s:9:\"fzmatthew\";s:3:\"pid\";s:1:\"0\";s:12:\"deal_user_id\";s:2:\"17\";s:13:\"reply_user_id\";s:1:\"0\";s:14:\"deal_user_name\";s:5:\"fanwe\";s:15:\"reply_user_name\";s:0:\"\";s:15:\"deal_info_cache\";s:0:\"\";}}s:12:\"more_comment\";b:0;}', 'a:1:{s:9:\"deal_info\";a:45:{s:2:\"id\";s:2:\"55\";s:4:\"name\";s:69:\"原创DIY桌面游戏《功夫》《黄金密码》期待您的支持\";s:10:\"name_match\";s:633:\"ux21151ux22827,ux26700ux38754,ux26399ux24453,ux23494ux30721,ux40644ux37329,ux25903ux25345,ux21407ux21019,ux28216ux25103,ux68ux73ux89,ux21407ux21019ux68ux73ux89ux26700ux38754ux28216ux25103ux12298ux21151ux22827ux12299ux12298ux40644ux37329ux23494ux30721ux12299ux26399ux24453ux24744ux30340ux25903ux25345,ux21407ux21019ux68ux73ux89ux26700ux38754ux28216ux25103ux12298ux21151ux22827ux12299ux12298ux40644ux37329ux23494ux30721ux12299ux26399ux24453ux24744ux30340ux25903ux25345,ux21407ux21019ux68ux73ux89ux26700ux38754ux28216ux25103ux12298ux21151ux22827ux12299ux12298ux40644ux37329ux23494ux30721ux12299ux26399ux24453ux24744ux30340ux25903ux25345\";s:14:\"name_match_row\";s:269:\"功夫,桌面,期待,密码,黄金,支持,原创,游戏,DIY,原创DIY桌面游戏《功夫》《黄金密码》期待您的支持,原创DIY桌面游戏《功夫》《黄金密码》期待您的支持,原创DIY桌面游戏《功夫》《黄金密码》期待您的支持\";s:5:\"image\";s:71:\"./public/attachment/201211/07/10/021e2f6812298468cfab78cbd07b90ee85.jpg\";s:12:\"source_vedio\";s:0:\"\";s:5:\"vedio\";s:0:\"\";s:9:\"deal_days\";s:2:\"15\";s:10:\"begin_time\";s:10:\"1351710606\";s:8:\"end_time\";s:10:\"1383765012\";s:9:\"is_effect\";s:1:\"1\";s:11:\"limit_price\";s:9:\"3000.0000\";s:5:\"brief\";s:192:\"这次给大家带来的是我们自己原创的两个桌面游戏《功夫》和《黄金密码》，由于我们并非专业的桌游制作公司，希望大家能够喜欢并支持我们！\";s:11:\"description\";s:4384:\"这次给大家带来的是我们自己原创的两个桌面游戏《功夫》和《黄金密码》，由于我们并非专业的桌游制作公司，所以在游戏的美术、包装、宣传等方面都会存在一些不足。但本次带来的两个作品都是我们利用几乎所有的业余时间尽心尽力制作出来的，希望大家能够喜欢并支持我们！<p><br />\r\n</p>\r\n<h3>我想要做什么</h3>\r\n<p>&nbsp; 桌面游戏是一种健康的休闲方式，你不用整天面对电脑的辐射，同时也让你可以不再过度沉迷于虚拟的网络世界中。因为桌面游戏方式的特殊性，能使你更加注重加强与人面对面的交流，提高自己的语言和沟通能力，还可以在现实生活中用这种轻松愉快的休闲方式结交更多的朋友。</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;我们就是这样一群喜爱桌游，同时喜欢设计桌游的年轻人，我们并非专业的桌游制作团队，我们只是凭着对桌游的爱好开始了对桌游设计的探索。我们希望通过努力，将桌游的快乐带给更多喜欢轻松休闲、热爱生活的朋友。但是，我们的资金及能力有限，需要得到大家的帮助与支持，才能实现这样的梦想。也希望您在支持我们的同时收获一份快乐和惊喜！</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;我们这次将原创的桌面游戏《功夫》和《黄金密码》一起放到这里，希望得到大家的支持！&nbsp;&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><br />\r\n<img src=\"./public/attachment/201211/07/16/da4f6f7e11b249dcf71bf5e9c6a86d8a83o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n</p>\r\n<p>游戏人数：2-4人</p>\r\n<p>适合年龄：8+</p>\r\n<p>游戏时间：10-30分钟</p>\r\n<p>游戏类型：手牌管理</p>\r\n<p>游戏背景：你在游戏中扮演一名武者，灵活运用你掌握的功夫（手牌）和装备（装备牌）对抗其他的武者并最终打败他们。</p>\r\n<p>游戏目标：扣除敌方所有人物的体力为胜。</p>\r\n游戏配件：69张动作牌（手牌）、6张道具牌、2张血量牌（需自行制作）<p><br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/7a404c90f81ca1368ff0f5b24e26a5d781o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n</p>\r\n<p>游戏过程：游戏的每个回合分两个阶段，第一阶段为热身阶段，获得热身阶段胜利的玩家成为第二阶段（攻击阶段）的主导者，由他决定第二阶段如何进行。</p>\r\n<p>&nbsp;&nbsp;&nbsp;《功夫》用卡牌较好的模拟再现了格斗中的一些乐趣，比如热身阶段的猜招、攻击阶段一招一式的过招，同时结合手牌管理的一些特点，打出组合招式及连招，配合你获得的道具，最终战胜对手。在游戏过程中，当你取得一定的优势时，也不能掉以轻心，形式可能会因为你的任何一个破绽而发生逆转，这与格斗、搏击的情况十分相似。所以如何保持良好的心态，灵活的运用手牌才是这个游戏制胜的关键所在。（具体规则见最下方及本项目动态）</p>\r\n<p><br />\r\n</p>\r\n<p><br />\r\n</p>\r\n<p>游戏人数：3-4人</p>\r\n<p>适合年龄：8+</p>\r\n<p>游戏时间：20-40分钟</p>\r\n<p>游戏类型：逻辑推理、谜题设计</p>\r\n<p>游戏背景：二战时期，德军将一批黄金铸成金条，分别保存在3个金库里，并派重兵把守。为了得到这批黄金，美军重金收买了一个德军守卫为内奸，内奸成功获取了金库的密码破解方法，并将密码破解方法以暗号的形式告知了美军特工。但是，与此同时德军也发现了暗号，并且金库的守卫非常森严，解开金库密码的时间只有1分钟……玩家在这个游戏中分别扮演德军、德军内奸、美军特工。如何设计出德军看不懂，美军特工又能在1分钟内解出的暗号密码。就看你的表现啦！</p>\r\n<p>游戏目标：根据身份的不同，任务也不同。德军需解开密码保住金库，特工需设置密码阻止德军解密，美军需解开密码同时选择金库获得黄金。</p>\r\n<p>游戏配件：10张密码牌、12张空箱牌、24张黄金牌、沙漏1个、草稿纸和笔（自备）</p>\r\n<p>游戏过程：每人分别扮演一次特工、德军、美军，完成后计算每人所获得的黄金数量，黄金最多的玩家获胜。</p>\r\n<p><br />\r\n<br />\r\n</p>\r\n<p></p>\";s:13:\"comment_count\";s:1:\"0\";s:13:\"support_count\";s:1:\"1\";s:11:\"focus_count\";s:1:\"0\";s:10:\"view_count\";s:1:\"3\";s:9:\"log_count\";s:1:\"1\";s:14:\"support_amount\";s:7:\"15.0000\";s:10:\"pay_amount\";s:7:\"18.5000\";s:19:\"delivery_fee_amount\";s:6:\"5.0000\";s:11:\"create_time\";s:10:\"1352229030\";s:9:\"seo_title\";s:0:\"\";s:11:\"seo_keyword\";s:0:\"\";s:15:\"seo_description\";s:0:\"\";s:4:\"tags\";s:59:\"功夫 桌面 期待 密码 黄金 支持 原创 游戏 DIY\";s:10:\"tags_match\";s:132:\"ux21151ux22827,ux26700ux38754,ux26399ux24453,ux23494ux30721,ux40644ux37329,ux25903ux25345,ux21407ux21019,ux28216ux25103,ux68ux73ux89\";s:14:\"tags_match_row\";s:59:\"功夫,桌面,期待,密码,黄金,支持,原创,游戏,DIY\";s:12:\"success_time\";s:1:\"0\";s:10:\"is_success\";s:1:\"0\";s:7:\"cate_id\";s:1:\"8\";s:8:\"province\";s:6:\"福建\";s:4:\"city\";s:6:\"福州\";s:7:\"user_id\";s:2:\"17\";s:4:\"sort\";s:1:\"0\";s:9:\"user_name\";s:5:\"fanwe\";s:12:\"is_recommend\";s:1:\"1\";s:10:\"is_classic\";s:1:\"1\";s:9:\"is_delete\";s:1:\"0\";s:16:\"deal_extra_cache\";s:0:\"\";s:7:\"is_edit\";s:1:\"0\";s:13:\"description_1\";s:0:\"\";s:11:\"remain_days\";d:3;s:7:\"percent\";d:1;}}');
INSERT INTO `%DB_PREFIX%deal_log` VALUES ('27', '每当我们踏上新的旅程，总是带着期待和兴奋\r\n\r\n而每次踏上归程，多多少少都会怀有一丝的失落\r\n\r\n在路上，我们拥有一拍即合、相谈甚欢的朋友\r\n\r\n在路上，我们总能遇到有趣的人，听到有意思的故事\r\n\r\n在路上，我们可以遗忘时间，丢开工作，在任何一方天地里享用美食和咖啡\r\n\r\n但是归来后，工作和生活又将我们丢回压力和快节奏之下\r\n\r\n我们想要一个在城市中，也能随时抽离的天地\r\n\r\n找朋友，找梦想，找快乐\r\n\r\n \r\n\r\n我们的小窝不会很大，但足以容纳所有的做梦者\r\n\r\n这里有齐全的旅行攻略书籍、各种旅行散文、绘本、游记……\r\n\r\n这里有香浓的咖啡和好吃的甜点\r\n\r\n这里有同样喜爱旅行，爱结交朋友的年轻人\r\n\r\n每一个将这里当做家的人，你们是我们的客人，更是这里的主人', '1352230347', '18', 'fzmatthew', '56', './public/attachment/201211/07/11/714396a1e4416b0f7510d97e6966190459.jpg', '', '', 'a:3:{s:13:\"comment_count\";s:1:\"1\";s:12:\"comment_list\";a:1:{i:0;a:13:{s:2:\"id\";s:3:\"171\";s:7:\"deal_id\";s:2:\"56\";s:7:\"content\";s:18:\"感谢支持！！\";s:7:\"user_id\";s:2:\"18\";s:11:\"create_time\";s:10:\"1352230363\";s:6:\"log_id\";s:2:\"27\";s:9:\"user_name\";s:9:\"fzmatthew\";s:3:\"pid\";s:1:\"0\";s:12:\"deal_user_id\";s:2:\"18\";s:13:\"reply_user_id\";s:1:\"0\";s:14:\"deal_user_name\";s:9:\"fzmatthew\";s:15:\"reply_user_name\";s:0:\"\";s:15:\"deal_info_cache\";s:0:\"\";}}s:12:\"more_comment\";b:0;}', 'a:1:{s:9:\"deal_info\";a:45:{s:2:\"id\";s:2:\"56\";s:4:\"name\";s:24:\"拥有自己的咖啡馆\";s:10:\"name_match\";s:108:\"ux21654ux21857ux39302,ux25317ux26377,ux33258ux24049,ux25317ux26377ux33258ux24049ux30340ux21654ux21857ux39302\";s:14:\"name_match_row\";s:48:\"咖啡馆,拥有,自己,拥有自己的咖啡馆\";s:5:\"image\";s:71:\"./public/attachment/201211/07/11/40e44eb97b0ca5aed5148e59c2cc8dcb95.jpg\";s:12:\"source_vedio\";s:0:\"\";s:5:\"vedio\";s:0:\"\";s:9:\"deal_days\";s:2:\"30\";s:10:\"begin_time\";s:10:\"1351711495\";s:8:\"end_time\";s:10:\"1384975499\";s:9:\"is_effect\";s:1:\"1\";s:11:\"limit_price\";s:9:\"5000.0000\";s:5:\"brief\";s:122:\"每个人心目中都有一个属于自己的咖啡馆,我们也是.但我们想要的咖啡馆，又不仅仅是咖啡馆\";s:11:\"description\";s:1396:\"<h3>关于我</h3>\r\n<p>每个人心目中都有一个属于自己的咖啡馆<br />\r\n我们也是<br />\r\n但我们想要的咖啡馆，又不仅仅是咖啡馆<br />\r\n这里除了售卖咖啡和甜点，还有旅行的梦想<br />\r\n我们想要一个“窝”，一个无论在出发前还是归来后随时开放的地方<br />\r\n梦想着有一天<br />\r\n我们可以带着咖啡的香气出发<br />\r\n又满载着旅行的收获回到充满咖啡香气的小“窝”</p>\r\n<h3>我想要做什么</h3>\r\n<p>以图文并茂的方式简洁生动地说明你的项目，让大家一目了然，这会决定是否将你的项目描述继续看下去。建议不超过300字。<br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/0482ef5836f6745af0f59ff40d40805765o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\r\n</p>\r\n<h3>为什么我需要你的支持</h3>\r\n<p>这是加分项。说说你的项目不同寻常的特色、资金用途、以及大家支持你的理由。这会让更多人能够支持你，不超过200个汉字。<br />\r\n<br />\r\n</p>\r\n<h3>我的承诺与回报</h3>\r\n让大家感到你对待项目的认真程度，鞭策你将项目执行最终成功。同时向大家展示一下你为支持者准备的回报，来吸引更多人支持你。<br />\r\n<br />\r\n<img src=\"./public/attachment/201211/07/16/2ae4c7149cfd31f12d91453713322f9076o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\";s:13:\"comment_count\";s:1:\"0\";s:13:\"support_count\";s:2:\"11\";s:11:\"focus_count\";s:1:\"1\";s:10:\"view_count\";s:1:\"4\";s:9:\"log_count\";s:1:\"1\";s:14:\"support_amount\";s:9:\"5500.0000\";s:10:\"pay_amount\";s:9:\"4950.0000\";s:19:\"delivery_fee_amount\";s:6:\"0.0000\";s:11:\"create_time\";s:10:\"1352229954\";s:9:\"seo_title\";s:0:\"\";s:11:\"seo_keyword\";s:0:\"\";s:15:\"seo_description\";s:0:\"\";s:4:\"tags\";s:23:\"咖啡馆 拥有 自己\";s:10:\"tags_match\";s:51:\"ux21654ux21857ux39302,ux25317ux26377,ux33258ux24049\";s:14:\"tags_match_row\";s:23:\"咖啡馆,拥有,自己\";s:12:\"success_time\";s:10:\"1352230293\";s:10:\"is_success\";s:1:\"1\";s:7:\"cate_id\";s:1:\"1\";s:8:\"province\";s:6:\"北京\";s:4:\"city\";s:9:\"东城区\";s:7:\"user_id\";s:2:\"18\";s:4:\"sort\";s:1:\"0\";s:9:\"user_name\";s:9:\"fzmatthew\";s:12:\"is_recommend\";s:1:\"1\";s:10:\"is_classic\";s:1:\"1\";s:9:\"is_delete\";s:1:\"0\";s:16:\"deal_extra_cache\";s:0:\"\";s:7:\"is_edit\";s:1:\"0\";s:13:\"description_1\";s:0:\"\";s:11:\"remain_days\";d:17;s:7:\"percent\";d:110;}}');
INSERT INTO `%DB_PREFIX%deal_log` VALUES ('28', '在电影里看到的最自然的场景在拍摄的时候都是要用灯光特别加工出来的，因为摄影机和人对光的感受能力不一样。人的眼睛可以说是世界上最好的摄影机。这一幕女主角站在窗边充满惆怅的向男主角的方向望过去，明显的受到了日本导演岩井俊二的影响。', '1352230864', '17', 'fanwe', '57', './public/attachment/201211/07/11/eab603d5c65ec25f88a7fdd8ec9a5c1095.jpg', '', '', 'a:3:{s:13:\"comment_count\";s:1:\"2\";s:12:\"comment_list\";a:2:{i:0;a:13:{s:2:\"id\";s:3:\"173\";s:7:\"deal_id\";s:2:\"57\";s:7:\"content\";s:32:\"回复 fzmatthew:一定会的。\";s:7:\"user_id\";s:2:\"17\";s:11:\"create_time\";s:10:\"1352230924\";s:6:\"log_id\";s:2:\"28\";s:9:\"user_name\";s:5:\"fanwe\";s:3:\"pid\";s:3:\"172\";s:12:\"deal_user_id\";s:2:\"17\";s:13:\"reply_user_id\";s:2:\"18\";s:14:\"deal_user_name\";s:5:\"fanwe\";s:15:\"reply_user_name\";s:9:\"fzmatthew\";s:15:\"deal_info_cache\";s:0:\"\";}i:1;a:13:{s:2:\"id\";s:3:\"172\";s:7:\"deal_id\";s:2:\"57\";s:7:\"content\";s:15:\"好好加油！\";s:7:\"user_id\";s:2:\"18\";s:11:\"create_time\";s:10:\"1352230882\";s:6:\"log_id\";s:2:\"28\";s:9:\"user_name\";s:9:\"fzmatthew\";s:3:\"pid\";s:1:\"0\";s:12:\"deal_user_id\";s:2:\"17\";s:13:\"reply_user_id\";s:1:\"0\";s:14:\"deal_user_name\";s:5:\"fanwe\";s:15:\"reply_user_name\";s:0:\"\";s:15:\"deal_info_cache\";s:0:\"\";}}s:12:\"more_comment\";b:0;}', 'a:1:{s:9:\"deal_info\";a:45:{s:2:\"id\";s:2:\"57\";s:4:\"name\";s:28:\"短片电影《Blind Love》\";s:10:\"name_match\";s:160:\"ux30701ux29255,ux30005ux24433,ux66ux108ux105ux110ux100,ux76ux111ux118ux101,ux30701ux29255ux30005ux24433ux12298ux66ux108ux105ux110ux100ux76ux111ux118ux101ux12299\";s:14:\"name_match_row\";s:53:\"短片,电影,Blind,Love,短片电影《Blind Love》\";s:5:\"image\";s:71:\"./public/attachment/201211/07/11/0c067c4522bba51595c324028be7070d11.jpg\";s:12:\"source_vedio\";s:58:\"http://player.youku.com/player.php/sid/XMzgyNjMzNDA4/v.swf\";s:5:\"vedio\";s:47:\"http://v.youku.com/v_show/id_XMzgyNjMzNDA4.html\";s:9:\"deal_days\";s:2:\"30\";s:10:\"begin_time\";s:10:\"1349034009\";s:8:\"end_time\";s:10:\"1383766813\";s:9:\"is_effect\";s:1:\"1\";s:11:\"limit_price\";s:9:\"3000.0000\";s:5:\"brief\";s:181:\"我叫武秋辰， 美国圣地亚哥大学影视专业硕士毕业。这是我在毕业后的第一部独立电影作品，讲述了一个关于盲人画家的唯美爱情故事。\";s:11:\"description\";s:2321:\"<p>我叫武秋辰， 美国圣地亚哥大学影视专业硕士毕业。这是我在毕业后的第一部独立电影作品，讲述了一个关于盲人画家的唯美爱情故事。</p>\r\n <p>这是一个需要爱与被爱的世界，然而在我们面对这纷繁复杂多变的世界时，我们如何过滤掉那迷乱双眼的尘沙找到真爱？我们在爱中得救，在爱中迷失。我们过度相信我们用双眼所见的，却忘记听从内心最真的感受！<br />\r\n<br />\r\n</p>\r\n<p>我们一路奔跑、一路追逐，生活的洪流把我们涌向未来不确定的方向，我们有着一双能望穿苍穹的眼睛，却不断的迷失在路途中。如果有一天我们的双眼失去光明……<br />\r\n<br />\r\n</p>\r\n<p>真爱是否还遥远？<br />\r\n<br />\r\n</p>\r\n<p>导演武秋辰将用电影语言为我们讲述一位盲人画家的爱情故事，如同她所写道的：“我们视觉正常的人很容易被表象所迷惑，而我们的触觉，听觉和嗅觉却非常的精准，给我们带来更丰富的感知。”当我们不仅凭双眼去认识这个世界的时候，也许答案就在那里！<br />\r\n<br />\r\n</p>\r\n<p>为了使影片更富深入性、更具专业性，导演请来了好莱坞的职业演员，就连剧中的盲人画像也由美国著名画家OlyaLusina特为此片创作。<br />\r\n<br />\r\n</p>\r\n<p>该片不仅是一个远赴美国实现梦想的中国女孩的心血之作，同时也深刻展现了一个盲人心中的世界，从“他”的角度为因爱迷失的人们找到了一个诗意的出口。<br />\r\n<br />\r\n</p>\r\n<p>在这里，真诚地感谢您的关注！关注武秋辰和她的《BlindLove》！<br />\r\n<br />\r\n</p>\r\n<h3>自我介绍<br />\r\n</h3>\r\n<p>我是一个在美国学电影做电影的中国女孩。在美国圣地亚哥大学电影系求学的过程中，我学会了编剧，导演，拍摄和剪辑，参与了几十部电影的创作。“盲爱”是我在硕士毕业后自编自导的第一部独立电影作品。</p>\r\n<p><br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/148cb883cbb170735c331125a96c11e162o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n</p>\r\n<p><br />\r\n</p>\r\n<p><img src=\"./public/attachment/201211/07/16/875016977d65ee2cc679ab0cfd7a7f6620o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\r\n<br />\r\n</p>\";s:13:\"comment_count\";s:1:\"0\";s:13:\"support_count\";s:1:\"0\";s:11:\"focus_count\";s:1:\"0\";s:10:\"view_count\";s:1:\"3\";s:9:\"log_count\";s:1:\"1\";s:14:\"support_amount\";s:6:\"0.0000\";s:10:\"pay_amount\";s:6:\"0.0000\";s:19:\"delivery_fee_amount\";s:6:\"0.0000\";s:11:\"create_time\";s:10:\"1352230821\";s:9:\"seo_title\";s:0:\"\";s:11:\"seo_keyword\";s:0:\"\";s:15:\"seo_description\";s:0:\"\";s:4:\"tags\";s:24:\"短片 电影 Blind Love\";s:10:\"tags_match\";s:74:\"ux30701ux29255,ux30005ux24433,ux66ux108ux105ux110ux100,ux76ux111ux118ux101\";s:14:\"tags_match_row\";s:24:\"短片,电影,Blind,Love\";s:12:\"success_time\";s:1:\"0\";s:10:\"is_success\";s:1:\"0\";s:7:\"cate_id\";s:1:\"3\";s:8:\"province\";s:6:\"福建\";s:4:\"city\";s:6:\"福州\";s:7:\"user_id\";s:2:\"17\";s:4:\"sort\";s:1:\"0\";s:9:\"user_name\";s:5:\"fanwe\";s:12:\"is_recommend\";s:1:\"1\";s:10:\"is_classic\";s:1:\"1\";s:9:\"is_delete\";s:1:\"0\";s:16:\"deal_extra_cache\";s:0:\"\";s:7:\"is_edit\";s:1:\"0\";s:13:\"description_1\";s:0:\"\";s:11:\"remain_days\";d:3;s:7:\"percent\";d:0;}}');
INSERT INTO `%DB_PREFIX%deal_log` VALUES ('29', '谢谢这几天来帮忙的朋友们，昨天一群的同学们让窗户变得明亮，虽然还是挺乱但却充满了快乐与欢。。爱天使每天都要这样充满爱与快乐。。谢谢有你们！因为东西太多可能还要打理两天才能开业，希望最近有空的朋友还能过来帮忙。下午两点过来便可13400642022。地址文化艺术中心大润发楼上正中间店。谢谢！', '1352231575', '17', 'fanwe', '58', './public/attachment/201211/07/11/85a7d1e781bfb8812271b6f6f1bee91d25.jpg', '', '', 'a:3:{s:13:\"comment_count\";s:1:\"1\";s:12:\"comment_list\";a:1:{i:0;a:13:{s:2:\"id\";s:3:\"174\";s:7:\"deal_id\";s:2:\"58\";s:7:\"content\";s:6:\"感谢\";s:7:\"user_id\";s:2:\"17\";s:11:\"create_time\";s:10:\"1352231585\";s:6:\"log_id\";s:2:\"29\";s:9:\"user_name\";s:5:\"fanwe\";s:3:\"pid\";s:1:\"0\";s:12:\"deal_user_id\";s:2:\"17\";s:13:\"reply_user_id\";s:1:\"0\";s:14:\"deal_user_name\";s:5:\"fanwe\";s:15:\"reply_user_name\";s:0:\"\";s:15:\"deal_info_cache\";s:0:\"\";}}s:12:\"more_comment\";b:0;}', 'a:1:{s:9:\"deal_info\";a:45:{s:2:\"id\";s:2:\"58\";s:4:\"name\";s:75:\"流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！\";s:10:\"name_match\";s:826:\"ux21654ux21857ux39302,ux37325ux24314,ux20844ux30410,ux27969ux28010,ux21147ux37327,ux38656ux35201,ux22825ux20351,ux22823ux23478,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281,ux27969ux28010ux29483ux30340ux23478ux8212ux29233ux22825ux20351ux20844ux30410ux21654ux21857ux39302ux30340ux37325ux24314ux38656ux35201ux22823ux23478ux30340ux21147ux37327ux65281\";s:14:\"name_match_row\";s:362:\"咖啡馆,重建,公益,流浪,力量,需要,天使,大家,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！,流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！\";s:5:\"image\";s:71:\"./public/attachment/201211/07/11/438813e6d75cb84c6b0df8ffbad7aa8c31.jpg\";s:12:\"source_vedio\";s:38:\"http://www.tudou.com/v/153527563/v.swf\";s:5:\"vedio\";s:58:\"http://www.tudou.com/listplay/i67lCgQt5nQ/i9toRdup3ok.html\";s:9:\"deal_days\";s:2:\"50\";s:10:\"begin_time\";s:10:\"1352145022\";s:8:\"end_time\";s:10:\"1385668225\";s:9:\"is_effect\";s:1:\"1\";s:11:\"limit_price\";s:9:\"3000.0000\";s:5:\"brief\";s:126:\"爱天使成立的猫天使驿站三年多收养救助了两百余只的流浪猫并为它们找到了一个个温暖的家。\";s:11:\"description\";s:2312:\"<p>爱天使成立的猫天使驿站三年多收养救助了两百余只的流浪猫并为它们找到了一个个温暖的家。爱天使是一种爱，更是一种生活！坚持个人信念的我一直努力活出这个世上不一般的价值人生。那就是不追求自己能拥有什么而在能为自己以外的生命带去什么。。。爱天使在今年因合同到期而到了转折点，重建是艰辛的却也坚信必将更加强大。</p>\r\n <h3>【关于我】——将救助流浪猫视为自己的事业！</h3>\r\n<p>首先做个自我介绍：</p>\r\n<p>我叫李文婷，英文名ANGELLI。</p>\r\n<p>是一名爱猫如命的“狂热分子”，</p>\r\n<p>作为流浪猫的代理麻麻已收养救助过两百余只猫咪；</p>\r\n<p>00年在大学校园宿舍开始拨号上网的网络生活，</p>\r\n<p>担任系学生会副主席及宣传部长等，</p>\r\n<p>参与系女篮队、校诗朗诵比赛、主持系选举活动，<br />\r\n</p>\r\n<p>组织带领系队作为一辩参加校辩论赛获得季军，</p>\r\n<p>毕业后于厦门海尔及三五互联等公司工作近六年。</p>\r\n<p>工作中一直表现突出主持公司千人晚会并荣获过部门最高荣誉奖。</p>\r\n<p>08年辞去部门经理一职后成为SOHO一族，</p>\r\n<p>经营LA爱天使韩国饰品成为淘宝卖家。</p>\r\n<p>于短短半年间毫无虚假的升为二钻一年后升至三钻，</p>\r\n<p>于09年6月20日在老爸大力的支持下经营爱天使咖啡馆，</p>\r\n<p>于2010年10月创办猫天使驿站正式收养救助流浪猫，</p>\r\n<p>先后接受了海峡导报厦门卫视等媒体及大学生的多次采访报道。<br />\r\n</p>\r\n<p>三年间收养救助了两百余只流浪猫并为它们找到了一个个温暖的家。</p>\r\n<p>与仔仔、全全、QQ、EE四只咪咪一起相伴爱天使救命流浪猫的生活。</p>\r\n<p>爱天使就是流浪猫们的家，是我将用余生为之奋斗的事业！</p>\r\n将“关爱弱小弱势生命，传递爱分享快乐”救助流浪猫视为毕生为之努力的事业。<br />\r\n<br />\r\n<img src=\"./public/attachment/201211/07/16/dda29128a6310c273da111f1f30296c172o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\r\n<br />\r\n<img src=\"./public/attachment/201211/07/16/c7650c3dd93e5585dbfad780ba3bbced31o5700.jpg\" rel=\"0\" /><br />\r\n<br />\r\n<br />\";s:13:\"comment_count\";s:1:\"1\";s:13:\"support_count\";s:1:\"2\";s:11:\"focus_count\";s:1:\"1\";s:10:\"view_count\";s:1:\"3\";s:9:\"log_count\";s:1:\"1\";s:14:\"support_amount\";s:9:\"5000.0000\";s:10:\"pay_amount\";s:9:\"4500.0000\";s:19:\"delivery_fee_amount\";s:6:\"0.0000\";s:11:\"create_time\";s:10:\"1352231478\";s:9:\"seo_title\";s:0:\"\";s:11:\"seo_keyword\";s:0:\"\";s:15:\"seo_description\";s:0:\"\";s:4:\"tags\";s:58:\"咖啡馆 重建 公益 流浪 力量 需要 天使 大家\";s:10:\"tags_match\";s:126:\"ux21654ux21857ux39302,ux37325ux24314,ux20844ux30410,ux27969ux28010,ux21147ux37327,ux38656ux35201,ux22825ux20351,ux22823ux23478\";s:14:\"tags_match_row\";s:58:\"咖啡馆,重建,公益,流浪,力量,需要,天使,大家\";s:12:\"success_time\";s:10:\"1352231704\";s:10:\"is_success\";s:1:\"1\";s:7:\"cate_id\";s:1:\"7\";s:8:\"province\";s:6:\"福建\";s:4:\"city\";s:6:\"福州\";s:7:\"user_id\";s:2:\"17\";s:4:\"sort\";s:1:\"0\";s:9:\"user_name\";s:5:\"fanwe\";s:12:\"is_recommend\";s:1:\"1\";s:10:\"is_classic\";s:1:\"1\";s:9:\"is_delete\";s:1:\"0\";s:16:\"deal_extra_cache\";s:0:\"\";s:7:\"is_edit\";s:1:\"0\";s:13:\"description_1\";s:0:\"\";s:11:\"remain_days\";d:25;s:7:\"percent\";d:167;}}');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_msg_list`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_msg_list`;
CREATE TABLE `%DB_PREFIX%deal_msg_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dest` varchar(255) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `content` text NOT NULL,
  `send_time` int(11) NOT NULL,
  `is_send` tinyint(1) NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `result` text NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  `title` text NOT NULL,
  `is_youhui` tinyint(1) NOT NULL,
  `youhui_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='//私信列表';

-- ----------------------------
-- Records of fanwe_deal_msg_list
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_notify`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_notify`;
CREATE TABLE `%DB_PREFIX%deal_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='//准备发送通知的项目ID';

-- ----------------------------
-- Records of fanwe_deal_notify
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_order`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_order`;
CREATE TABLE `%DB_PREFIX%deal_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `deal_item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `pay_time` int(11) NOT NULL,
  `total_price` decimal(20,2) NOT NULL COMMENT '总价',
  `delivery_fee` decimal(20,2) NOT NULL COMMENT '运费',
  `deal_price` decimal(20,2) NOT NULL COMMENT '项目费用',
  `support_memo` text NOT NULL,
  `payment_id` int(11) NOT NULL,
  `bank_id` varchar(255) NOT NULL,
  `credit_pay` decimal(20,2) NOT NULL COMMENT '信贷付款',
  `online_pay` decimal(20,2) NOT NULL COMMENT '在线付款',
  `deal_name` varchar(255) NOT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '0:未支付 1:已支付(过期) 2:已支付(无库存) 3:成功',
  `create_time` int(11) NOT NULL,
  `consignee` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `repay_time` int(11) NOT NULL COMMENT '回报更新时间',
  `repay_memo` text NOT NULL COMMENT '回报备注，由发起人更新',
  `is_refund` tinyint(1) NOT NULL COMMENT '已退款 0:未 1:已',
  `is_has_send_success` tinyint(1) NOT NULL,
  `repay_make_time` int(11) NOT NULL DEFAULT '0' COMMENT '回报确认时间',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '购买数量',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单类型 0表示普通众筹 1表示股权众筹',
  `invest_id` int(11) NOT NULL DEFAULT '0' COMMENT 'invest 的ID',
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `deal_item_id` (`deal_item_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='// 订单信息';

-- ----------------------------
-- Records of fanwe_deal_order
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('65', '55', '18', '18', 'fzmatthew', '1352229388', '20.00', '5.00', '15.00', '请在上班时间配送。', '0', 'COMM', '20.00', '0.00', '原创DIY桌面游戏《功夫》《黄金密码》期待您的支持', '3', '1352229388', '方维', '350000', '13333333333', '福建', '福州', '福建福州台江区工业路博美诗邦', '0', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('66', '56', '24', '17', 'fanwe', '1352230101', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230101', '方维', '22222', '14444444444', '福建', '福州', '方维方维方维方维方维', '1', '1352230424', '回报已经发货，发货单号123456, 有问题请联系我。', '0', '0', '1424910145', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('67', '56', '24', '19', 'test', '1352230180', '500.00', '0.00', '500.00', '', '24', 'ICBCB2C', '0.00', '500.00', '拥有自己的咖啡馆', '3', '1352230157', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('68', '56', '24', '19', 'test', '1352230228', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230228', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('69', '56', '24', '19', 'test', '1352230232', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230232', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('70', '56', '24', '19', 'test', '1352230237', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230237', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('71', '56', '24', '19', 'test', '1352230240', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230240', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('72', '56', '24', '19', 'test', '1352230243', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230243', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('73', '56', '24', '19', 'test', '1352230247', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230247', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('74', '56', '24', '19', 'test', '1352230268', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230268', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('75', '56', '24', '19', 'test', '1352230270', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230270', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('76', '56', '24', '19', 'test', '1352230293', '500.00', '0.00', '500.00', '', '0', '', '500.00', '0.00', '拥有自己的咖啡馆', '3', '1352230293', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('77', '58', '31', '18', 'fzmatthew', '1352231539', '2000.00', '0.00', '2000.00', 'test', '0', '', '2000.00', '0.00', '流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！', '3', '1352231539', '方维', '350000', '13333333333', '福建', '福州', '福建福州台江区工业路博美诗邦', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('78', '58', '30', '19', 'test', '0', '1000.00', '0.00', '1000.00', 'ttt', '24', 'CCB', '500.00', '0.00', '流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！', '0', '1352231631', 'test', 'test', '13344455555', '湖北', '襄樊', 'test', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('79', '56', '24', '17', 'fanwe', '0', '500.00', '0.00', '500.00', '部份支付', '24', 'ICBCB2C', '300.00', '0.00', '拥有自己的咖啡馆', '0', '1352231671', '方维', '22222', '14444444444', '福建', '福州', '方维方维方维方维方维', '1', '0', '', '0', '0', '0', '1', '0', '0');
INSERT INTO `%DB_PREFIX%deal_order` VALUES ('80', '58', '32', '18', 'fzmatthew', '1352231704', '3000.00', '0.00', '3000.00', '', '0', '', '3000.00', '0.00', '流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！', '3', '1352231704', '方维', '350000', '13333333333', '福建', '福州', '福建福州台江区工业路博美诗邦', '1', '0', '', '0', '0', '0', '1', '0', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_pay_log`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_pay_log`;
CREATE TABLE `%DB_PREFIX%deal_pay_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `money` double(20,4) NOT NULL,
  `create_time` int(11) NOT NULL,
  `log_info` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='//项目支持金额发放记录';

-- ----------------------------
-- Records of fanwe_deal_pay_log
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_support_log`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_support_log`;
CREATE TABLE `%DB_PREFIX%deal_support_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `price` decimal(20,2) NOT NULL COMMENT '金额',
  `deal_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`),
  KEY `deal_item_id` (`deal_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='// 项目记录';

-- ----------------------------
-- Records of fanwe_deal_support_log
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('41', '55', '18', '1352229388', '15.00', '18');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('42', '56', '17', '1352230101', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('43', '56', '19', '1352230180', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('44', '56', '19', '1352230228', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('45', '56', '19', '1352230232', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('46', '56', '19', '1352230237', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('47', '56', '19', '1352230240', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('48', '56', '19', '1352230243', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('49', '56', '19', '1352230247', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('50', '56', '19', '1352230268', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('51', '56', '19', '1352230270', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('52', '56', '19', '1352230293', '500.00', '24');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('53', '58', '18', '1352231539', '2000.00', '31');
INSERT INTO `%DB_PREFIX%deal_support_log` VALUES ('54', '58', '18', '1352231704', '3000.00', '32');

-- ----------------------------
-- Table structure for `%DB_PREFIX%deal_visit_log`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%deal_visit_log`;
CREATE TABLE `%DB_PREFIX%deal_visit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `client_ip` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 COMMENT='// 访问记录';

-- ----------------------------
-- Records of fanwe_deal_visit_log
-- ----------------------------
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('117', '55', '127.0.0.1', '1352229137');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('118', '56', '127.0.0.1', '1352230070');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('119', '57', '127.0.0.1', '1352230830');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('120', '58', '127.0.0.1', '1352231514');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('121', '56', '127.0.0.1', '1352231651');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('122', '55', '127.0.0.1', '1352232299');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('123', '58', '127.0.0.1', '1352232420');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('124', '56', '127.0.0.1', '1352232590');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('125', '57', '127.0.0.1', '1352232717');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('126', '55', '127.0.0.1', '1352246374');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('127', '57', '127.0.0.1', '1352246699');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('128', '56', '127.0.0.1', '1352246710');
INSERT INTO `%DB_PREFIX%deal_visit_log` VALUES ('129', '58', '127.0.0.1', '1352246719');

-- ----------------------------
-- Table structure for `%DB_PREFIX%faq`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%faq`;
CREATE TABLE `%DB_PREFIX%faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='// 常见问题设置';

-- ----------------------------
-- Records of fanwe_faq
-- ----------------------------
INSERT INTO `%DB_PREFIX%faq` VALUES ('1', '基本问题', '这是什么站?', '我们是一个让你可以发起和支持创意项目的平台。如果你有一个创意的想法(新颖的产品?独立电影?)，我们欢迎你到我们的平台上发起项目，向公众推广，并得到资金的支持去完成你的想法。如果你喜欢创意，我们欢迎你来到我们平台，浏览各种有趣的项目，并力所能及支持他们。', '1');
INSERT INTO `%DB_PREFIX%faq` VALUES ('2', '基本问题', '什么样的项目适合我们的平台?', '我们欢迎一切有创意的想法，欢迎艺术家，电影工作者，音乐家，产品设计师，作家，画家，表演者，DJ等等来我们平台推广他们的创意。但是，我们的平台不适用于慈善项目或是创业投资项目。如果你不确定你的想法是否适合我们的平台，欢迎你直接与我们联系。', '2');
INSERT INTO `%DB_PREFIX%faq` VALUES ('3', '基本问题', '这种模式有非法集资的风险吗?', '不会，因为我们要求项目不能够以股权或是资金作为对支持者的回报。项目发起人更不能向支持者许诺任何资金上的收益。项目的回报必须是以实物（如产品，出版物），或者媒体内容（如提供视频或者音乐的流媒体播放或者下载）。我们平台项目接受支持，不能够以股权或者债券的形式。支持者对一个项目的支持属于购买行为，而不是投资行为。', '3');
INSERT INTO `%DB_PREFIX%faq` VALUES ('4', '基本问题', '这个平台接受慈善项目类的提案么?', '我们不接受慈善类项目。作为个人，我们支持社会公益慈善事业，但是我们平台不是支持此类项目的平台。我们所接受的是商业类，有销售购买行为的设计或者文创类的项目。项目发起人需要给支持以实物或者媒体内容类的回报。', '4');
INSERT INTO `%DB_PREFIX%faq` VALUES ('5', '项目发起人相关问题', '是否会要求产品或作品的知识产权?', '不会。我们只是提供一个宣传和支持的平台，知识产权由项目发起人所有。', '5');
INSERT INTO `%DB_PREFIX%faq` VALUES ('6', '项目发起人相关问题', '什么人可以发起项目?', '目前任何在两岸三地(中国大陆，台湾，港澳)的有创意的人都可以发起项目。你可以是一个从事创意行业的自由职业者，也可以是公司职员。只要你有个点子，我们都希望收到你的项目提案。', '6');
INSERT INTO `%DB_PREFIX%faq` VALUES ('7', '项目发起人相关问题', '我怎么发起项目呢?', '请到我们的网站并注册用户后，在我们网站上提交所需要的基本项目信息，包括项目的内容，目前进行的阶段等等。我们会有专人跟进，与你联系。', '7');
INSERT INTO `%DB_PREFIX%faq` VALUES ('8', '项目发起人相关问题', '我想发起项目，但是我担心我的知识产权被人抄袭?', '作为项目发起人，你可以选择公布更多的信息。知识产权敏感的信息，你可以选择不公开。同时，我们平台是一个面对公众的平台。你所提供的信息越丰富，越翔实，就越容易打动和说服别人的支持。', '8');
INSERT INTO `%DB_PREFIX%faq` VALUES ('9', '项目发起人相关问题', '项目目标金额是否有上下限制?', '我们对目标金额的下限是1000元人民币。原则上没有上限。但是资金的要求越高，成功的概率就越低。目前常见的目标金额从几千到几万不等。', '9');
INSERT INTO `%DB_PREFIX%faq` VALUES ('10', '项目发起人相关问题', '没有达到目标金额，是否就不能得到支持?', '是的。如果在项目截至日期到达时，没有达到预期，那么已经收到的资金会退还给支持者。这么做的原因是为了给支持者提供风险保护。只有当项目有足够多的人支持足够多的资金时，他们的支持才生效。', '10');
INSERT INTO `%DB_PREFIX%faq` VALUES ('11', '项目发起人相关问题', '我的项目成功了，然后呢?', '我们会分两次把资金打入你所提供的银行账户。两次汇款的时间和金额因项目而异，在项目上线之前，由我们平台与项目发起人确定。在资金的支持下，你就可以开始进行你的项目，给你的支持者以邮件或者其他形式的更新，并如期实现你承诺的回报。', '11');
INSERT INTO `%DB_PREFIX%faq` VALUES ('12', '项目发起人相关问题', '如何设定项目截止日期?', '一般来说，时间设置在一个月或以内比较合适。数据显示，绝大部分的支持发生在项目上线开始和结束前的一个星期中。', '12');
INSERT INTO `%DB_PREFIX%faq` VALUES ('13', '项目发起人相关问题', '收到的金额能够超过预设的目标?', '可以。在截至日期之前，项目可以一直接受资金支持。', '13');
INSERT INTO `%DB_PREFIX%faq` VALUES ('14', '项目发起人相关问题', '大家支持的动机是什么?', '大家对项目支持的动机是多样的。有些是因为项目发起者提供了有吸引力的回报，特别是产品设计类的项目。有些是因为认可这个项目，希望它能够实现。有些是因为认可项目的发起人，希望助他一臂之力。', '14');
INSERT INTO `%DB_PREFIX%faq` VALUES ('15', '项目发起人相关问题', '什么样的回报比较合适?', '回报因项目而异。可以是实物，比如如果是电影项目，可以提供成片后的DVD;如果是产品设计，可以提供产品;其他还有如明信片，T恤，出版物。也可以是非实物，比如鸣谢，与项目发起人共进晚餐，影片首映的门票等。我们欢迎项目发起人展开想象，设计出各式各样的回报。', '15');
INSERT INTO `%DB_PREFIX%faq` VALUES ('16', '项目发起人相关问题', '如何能够吸引更多的人来支持我的项目?', '对此，我们会另外详细介绍。简短来说，有以下要点\r\n- 拍摄一个有趣，吸引人的视频。讲述这个项目背后的故事。\r\n- 提供有吸引力，物有所值的回报。\r\n- 项目刚上线时，要发动你的亲朋好友来支持你。让你的项目有一个基本的人气。\r\n- 充分运用微博，人人等社交网站来推广。\r\n- 在项目上线期间，经常性的在你的项目页上提供项目的更新，与支持者，询问者的互动。\r\n- 项目宣传视频是必须的么?\r\n宣传视频是项目页上的重要内容。是公众了解你和你的项目的第一步。一个好的宣传视频，能够比文字和图片起到更好的宣传效果。基于这个原因，我们要求每个项目都提供一个视频。有必要的话，我们平台可以提供视频拍摄的支持。', '16');
INSERT INTO `%DB_PREFIX%faq` VALUES ('17', '项目发起人相关问题', '项目宣传视频有什么要求?', '我们要求宣传视频在两分钟之内。内容上，强烈建议包括以下内容\r\n发起人姓名\r\n项目简短描述(特别说明其吸引人的地方)，目前进展\r\n为什么需要支持\r\n谢谢大家', '17');
INSERT INTO `%DB_PREFIX%faq` VALUES ('18', '项目支持者相关问题', '如果项目没有达到目标金额，我支持的资金会还给我么?', '是的。如果项目在截止日期没有达到目标，你所支持的金额会返还给你。', '18');
INSERT INTO `%DB_PREFIX%faq` VALUES ('19', '项目支持者相关问题', '如何支持一个项目?', '每个项目页的右侧有可选择的支持额度和相应的回报介绍。想支持的话，选择你想支持的金额，鼠标点击绿色的按钮，即可。你可以选择支付宝或者财付通来完成付款。', '19');
INSERT INTO `%DB_PREFIX%faq` VALUES ('20', '项目支持者相关问题', '如何保证项目发起人能够实现他们的承诺呢?', '很多项目本身存在着风险，比如产品设计和纪录片的拍摄。有可能存在项目发起人无法完成其许诺的情况。项目支持者一方面要了解创意项目本身是有风险的，另一方面，我们要求项目发起人提供联系方式，并且鼓励有意支持者直接联系他们，在与项目发起人的沟通和互动中对项目的价值，风险，项目发起人的执行力等等有所判断。', '20');

-- ----------------------------
-- Table structure for `%DB_PREFIX%help`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%help`;
CREATE TABLE `%DB_PREFIX%help` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_fix` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='// 帮助介绍';

-- ----------------------------
-- Records of fanwe_help
-- ----------------------------
INSERT INTO `%DB_PREFIX%help` VALUES ('1', '服务条款', '<div class=\"layout960\"><p><strong>一、接受条款</strong></p>\r\n<p>我们所提供的服务包含我们平台网站体验和使用、我们平台互联网消息传递服务以及我们平台提供的与我们平台网站有关的任何其他特色功能、内容或应用程序(合称\"我们平台服务\")。无论用户是以\"访客\"(表示用户只是浏览我们平台网站)还是\"成员\"(表示用户已在我们平台注册并登录)的身份使用我们平台服务，均表示该用户同意遵守本使用协议。</p>\r\n<p>如果用户自愿成为我们平台成员并与其他成员交流(包括通过我们平台网站直接联系或通过我们平台各种服务而连接到的成员)，以及使用我们平台网站及其各种附加服务，请务必认真阅读本协议并在注册过程中表明同意接受本协议。本协议的内容包含我们平台关于接受我们平台服务和在我们平台网站上发布内容的规定、用户使用我们平台服务所享有的权利、承担的义务和对使用我们平台服务所受的限制、以及我们平台的隐私条款。如果用户选择使用某些我们平台服务，可能会收到要求其下载软件或内容的通知，和/或要求用户同意附加条款和条件的通知。除非用户选择使用的我们平台服务相关的附加条款和条件另有规定，附加的条款和条件都应被包含于本协议中。</p>\r\n<p>我们平台有权随时修改本协议文本中的任何条款。一旦我们平台对本协议进行修改,我们平台将会以公告形式发布通知。任何该等修改自发布之日起生效。如果用户在该等修改发布后继续使用我们平台服务，则表示该用户同意遵守对本协议所作出的该等修改。因此，请用户务必定期查阅本协议，以确保了解所有关于本协议的最新修改。如果用户不同意我们平台对本协议进行的修改，请用户离开我们平台网站并立即停止使用我们平台服务。同时，用户还应当删除个人档案并注销成员资格。</p>\r\n<p><strong>二、遵守法律</strong></p>\r\n<p>当使用我们平台服务时，用户同意遵守中华人民共和国(下称\"中国\")的相关法律法规，包括但不限于《中华人民共和国宪法》、《中华人民共和国合同法》、《中华人民共和国电信条例》、《互联网信息服务管理办法》、《互联网电子公告服务管理规定》、《中华人民共和国保守国家秘密法》、《全国人民代表大会常务委员会关于维护互联网安全的决定》、《中华人民共和国计算机信息系统安全保护条例》、《计算机信息网络国际联网安全保护管理办法》、《中华人民共和国著作权法》及其实施条例、《互联网著作权行政保护办法》等。用户只有在同意遵守所有相关法律法规和本协议时，才有权使用我们平台服务(无论用户是否有意访问或使用此服务)。请用户仔细阅读本协议并将其妥善保存。</p>\r\n<p><strong>三、用户帐号、密码及安全</strong></p>\r\n<p>用户应提供及时、详尽、准确的个人资料，并不断及时更新注册时提供的个人资料，保持其详尽、准确。所有用户输入的资料将引用为注册资料。我们平台不对因用户提交的注册信息不真实或未及时准确变更信息而引起的问题、争议及其后果承担责任。</p>\r\n<p>用户不应将其帐号、密码转让、出借或告知他人，供他人使用。如用户发现帐号遭他人非法使用，应立即通知我们平台。因黑客行为或用户的保管疏忽导致帐号、密码遭他人非法使用的，我们平台不承担任何责任。</p>\r\n<p><strong>四、隐私权政策</strong></p>\r\n<p>用户提供的注册信息及我们平台保留的用户所有资料将受到中国相关法律法规和我们平台《隐私权政策》的规范。《隐私权政策》构成本协议不可分割的一部分。</p>\r\n<p><strong>五、上传内容</strong></p>\r\n<p>用户通过任何我们平台提供的服务上传、张贴、发送(通过电子邮件或任何其它方式传送)的文本、文件、图像、照片、视频、声音、音乐、其他创作作品或任何其他材料(以下简称\"内容\"，包括用户个人的或个人创作的照片、声音、视频等)，无论系公开还是私下传播，均由用户和内容提供者承担责任，我们平台不对该等内容的正确性、完整性或品质作出任何保证。用户在使用我们平台服务时，可能会接触到令人不快、不适当或令人厌恶之内容，用户需在接受服务前自行做出判断。在任何情况下，我们平台均不为任何内容负责(包括但不限于任何内容的错误、遗漏、不准确或不真实)，亦不对通过我们平台服务上传、张贴、发送(通过电子邮件或任何其它方式传送)的内容衍生的任何损失或损害负责。我们平台在管理过程中发现或接到举报并进行初步调查后，有权依法停止任何前述内容的传播并采取进一步行动，包括但不限于暂停某些用户使用我们平台的全部或部分服务，保存有关记录，并向有关机关报告。</p>\r\n<p><strong>六、用户行为</strong></p>\r\n<p>用户在使用我们平台服务时，必须遵守中华人民共和国相关法律法规的规定，用户保证不会利用我们平台服务进行任何违法或不正当的活动，包括但不限于下列行为∶</p>\r\n<p>上传、展示、张贴或以其它方式传播含有下列内容之一的信息：</p>\r\n<p>反对宪法及其他法律的基本原则的;</p>\r\n<p>危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的;</p>\r\n<p>损害国家荣誉和利益的;</p>\r\n<p>煽动民族仇恨、民族歧视、破坏民族团结的;</p>\r\n<p>破坏国家宗教政策，宣扬邪教和封建迷信的;</p>\r\n<p>散布谣言，扰乱社会秩序，破坏社会稳定的;</p>\r\n<p>散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的;</p>\r\n<p>侮辱或者诽谤他人，侵害他人合法权利的;</p>\r\n<p>含有虚假、有害、胁迫、侵害他人隐私、骚扰、中伤、粗俗、猥亵、或其它道德上令人反感的内容;</p>\r\n<p>含有中国法律、法规、规章、条例以及任何具有法律效力的规范所限制或禁止的其它内容的;</p>\r\n<p>不得为任何非法目的而使用网络服务系统;</p>\r\n<p>用户同时保证不会利用我们平台服务从事以下活动：</p>\r\n<p>未经允许，进入计算机信息网络或者使用计算机信息网络资源的;</p>\r\n<p>未经允许，对计算机信息网络功能进行删除、修改或者增加的;</p>\r\n<p>未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的;故意制作、传播计算机病毒等破坏性程序的;</p>\r\n<p>其他危害计算机信息网络安全的行为。</p>\r\n<p>如用户在使用网络服务时违反任何上述规定，我们平台或经其授权者有权要求该用户改正或直接采取一切必要措施(包括但不限于更改、删除相关内容、暂停或终止相关用户使用我们平台服务)以减轻和消除该用户不当行为造成的影响。</p>\r\n<p>用户不得对我们平台服务的任何部分或全部以及通过我们平台取得的任何形式的信息，进行复制、拷贝、出售、转售或用于任何其它商业目的。</p>\r\n<p>用户须对自己在使用我们平台服务过程中的行为承担法律责任。用户承担法律责任的形式包括但不限于：停止侵害行为，向受到侵害者公开赔礼道歉，恢复受到侵害这的名誉，对受到侵害者进行赔偿。如果我们平台网站因某用户的非法或不当行为受到行政处罚或承担了任何形式的侵权损害赔偿责任，该用户应向我们平台进行赔偿(不低于我们平台向第三方赔偿的金额)并通过全国性的媒体向我们平台公开赔礼道歉。</p>\r\n<p><strong>七、知识产权和其他合法权益(包括但不限于名誉权、商誉等)</strong></p>\r\n<p>我们平台并不对用户发布到我们平台服务中的文本、文件、图像、照片、视频、声音、音乐、其他创作作品或任何其他材料(前文称为\"内容\")拥有任何所有权。在用户将内容发布到我们平台服务中后，用户将继续对内容享有权利，并且有权选择恰当的方式使用该等内容。如果用户在我们平台服务中或通过我们平台服务展示或发表任何内容，即表明该用户就此授予我们平台一个有限的许可以使我们平台能够合法使用、修改、复制、传播和出版此类内容。</p>\r\n<p>用户同意其已就在我们平台服务所发布的内容，授予我们平台可以免费的、永久有效的、不可撤销的、非独家的、可转授权的、在全球范围内对所发布内容进行使用、复制、修改、改写、改编、发行、翻译、创造衍生性著作的权利，及/或可以将前述部分或全部内容加以传播、表演、展示，及/或可以将前述部分或全部内容放入任何现在已知和未来开发出的以任何形式、媒体或科技承载的著作当中。</p>\r\n<p>用户声明并保证：用户对其在我们平台服务中或通过我们平台服务发布的内容拥有合法权利;用户在我们平台服务中或通过我们平台服务发布的内容不侵犯任何人的肖像权、隐私权、著作权、商标权、专利权、及其它合同权利。如因用户在我们平台服务中或通过我们平台服务发布的内容而需向其他任何人支付许可费或其它费用，全部由该用户承担。</p>\r\n<p>我们平台服务中包含我们平台提供的内容，包含用户和其他我们平台许可方的内容(下称\"我们平台的内容\")。我们平台的内容受《中华人民共和国著作权法》、《中华人民共和国商标法》、《中华人民共和国专利法》、《中华人民共和国反不正当竞争法》和其他相关法律法规的保护，我们平台拥有并保持对我们平台的内容和我们平台服务的所有权利。</p>\r\n<p><strong>八、国际使用之特别警告</strong></p>\r\n<p>用户已了解国际互联网的无国界性，同意遵守所有关于网上行为、内容的法律法规。用户特别同意遵守有关从中国或用户所在国家或地区输出信息所可能涉及、适用的全部法律法规。</p>\r\n<p><strong>九、赔偿</strong></p>\r\n<p>由于用户通过我们平台服务上传、张贴、发送或传播的内容，或因用户与本服务连线，或因用户违反本使用协议，或因用户侵害他人任何权利而导致任何第三人向我们平台提出赔偿请求，该用户同意赔偿我们平台及其股东、子公司、关联企业、代理人、品牌共有人或其它合作伙伴相应的赔偿金额(包括我们平台支付的律师费等)，以使我们平台的利益免受损害。</p>\r\n<p><strong>十、关于使用及储存的一般措施</strong></p>\r\n<p>用户承认我们平台有权制定关于服务使用的一般措施及限制，包括但不限于我们平台服务将保留用户的电子邮件信息、用户所张贴内容或其它上载内容的最长保留期间、用户一个帐号可收发信息的最大数量、用户帐号当中可收发的单个信息的大小、我们平台服务器为用户分配的最大磁盘空间，以及一定期间内用户使用我们平台服务的次数上限(及每次使用时间之上限)。通过我们平台服务存储或传送的任何信息、通讯资料和其它任何内容，如被删除或未予储存，用户同意我们平台毋须承担任何责任。用户亦同意，超过一年未使用的帐号，我们平台有权关闭。我们平台有权依其自行判断和决定，随时变更相关一般措施及限制。</p>\r\n<p><strong>十一、服务的修改</strong></p>\r\n<p>用户了解并同意，无论通知与否，我们平台有权于任何时间暂时或永久修改或终止部分或全部我们平台服务，对此，我们平台对用户和任何第三人均无需承担任何责任。用户同意，所有上传、张贴、发送到我们平台的内容，我们平台均无保存义务，用户应自行备份。我们平台不对任何内容丢失以及用户因此而遭受的相关损失承担责任。</p>\r\n<p><strong>十二、终止服务</strong></p>\r\n<p>用户同意我们平台可单方面判断并决定，如果用户违反本使用协议或用户长时间未能使用其帐号，我们平台可以终止该用户的密码、帐号或某些服务的使用，并可将该用户在我们平台服务中留存的任何内容加以移除或删除。我们平台亦可基于自身考虑，在通知或未通知之情形下，随时对该用户终止部分或全部服务。用户了解并同意依本使用协议，无需进行事先通知，我们平台可在发现任何不适宜内容时，立即关闭或删除该用户的帐号及其帐号中所有相关信息及文件，并暂时或永久禁止该用户继续使用前述文件或帐号。</p>\r\n<p><strong>十三、与广告商进行的交易</strong></p>\r\n<p>用户通过我们平台服务与广告商进行任何形式的通讯或商业往来，或参与促销活动(包括相关商品或服务的付款及交付)，以及达成的其它任何条款、条件、保证或声明，完全是用户与广告商之间的行为。除有关法律法规明文规定要求我们平台承担责任外，用户因前述任何交易、沟通等而遭受的任何性质的损失或损害，我们平台均不予负责。</p>\r\n<p><strong>十四、链接</strong></p>\r\n<p>用户了解并同意，对于我们平台服务或第三人提供的其它网站或资源的链接是否可以利用，我们平台不予负责;存在或源于此类网站或资源的任何内容、广告、产品或其它资料，我们平台亦不保证或负责。因使用或信赖任何此类网站或资源发布的或经由此类网站或资源获得的任何商品、服务、信息，如对用户造成任何损害，我们平台不负任何直接或间接责任。</p>\r\n<p><strong>十五、禁止商业行为</strong></p>\r\n<p>用户同意不对我们平台服务的任何部分或全部以及用户通过我们平台的服务取得的任何物品、服务、信息等，进行复制、拷贝、出售、转售或用于任何其它商业目的。</p>\r\n<p><strong>十六、我们平台的专属权利</strong></p>\r\n<p>用户了解并同意，我们平台服务及其所使用的相关软件(以下简称\"服务软件\")含有受到相关知识产权及其它法律保护的专有保密资料。用户同时了解并同意，经由我们平台服务或广告商向用户呈现的赞助广告或信息所包含之内容，亦可能受到著作权、商标、专利等相关法律的保护。未经我们平台或广告商书面授权，用户不得修改、出售、传播部分或全部服务内容或软件，或加以制作衍生服务或软件。我们平台仅授予用户个人非专属的使用权，用户不得(也不得允许任何第三人)复制、修改、创作衍生著作，或通过进行还原工程、反向组译及其它方式破译原代码。用户也不得以转让、许可、设定任何担保或其它方式移转服务和软件的任何权利。用户同意只能通过由我们平台所提供的界面而非任何其它方式使用我们平台服务。</p>\r\n<p><strong>十七、担保与保证</strong></p>\r\n<p>我们平台使用协议的任何规定均不会免除因我们平台造成用户人身伤害或因故意造成用户财产损失而应承担的任何责任。</p>\r\n<p>用户使用我们平台服务的风险由用户个人承担。我们平台对服务不提供任何明示或默示的担保或保证，包括但不限于商业适售性、特定目的的适用性及未侵害他人权利等的担保或保证。</p>\r\n<p>我们平台亦不保证以下事项：</p>\r\n<p>服务将符合用户的要求;</p>\r\n<p>服务将不受干扰、及时提供、安全可靠或不会出错;</p>\r\n<p>使用服务取得的结果正确可靠;</p>\r\n<p>用户经由我们平台服务购买或取得的任何产品、服务、资讯或其它信息将符合用户的期望，且软件中任何错误都将得到更正。</p>\r\n<p>用户应自行决定使用我们平台服务下载或取得任何资料且自负风险，因任何资料的下载而导致的用户电脑系统损坏或数据流失等后果，由用户自行承担。</p>\r\n<p>用户经由我们平台服务获知的任何建议或信息(无论书面或口头形式)，除非使用协议有明确规定，将不构成我们平台对用户的任何保证。</p>\r\n<p><strong>十八、责任限制</strong></p>\r\n<p>用户明确了解并同意，基于以下原因而造成的任何损失，我们平台均不承担任何直接、间接、附带、特别、衍生性或惩罚性赔偿责任(即使我们平台事先已被告知用户或第三方可能会产生相关损失)：</p>\r\n<p>我们平台服务的使用或无法使用;</p>\r\n<p>通过我们平台服务购买、兑换、交换取得的任何商品、数据、信息、服务、信息，或缔结交易而发生的成本;</p>\r\n<p>用户的传输或数据遭到未获授权的存取或变造;</p>\r\n<p>任何第三方在我们平台服务中所作的声明或行为;</p>\r\n<p>与我们平台服务相关的其它事宜，但本使用协议有明确规定的除外。</p>\r\n<p><strong>十九、一般性条款</strong></p>\r\n<p>本使用协议构成用户与我们平台之间的正式协议，并用于规范用户的使用行为。在用户使用我们平台服务、使用第三方提供的内容或软件时，在遵守本协议的基础上，亦应遵守与该等服务、内容、软件有关附加条款及条件。</p>\r\n<p>本使用协以及用户与我们平台之间的关系，均受到中华人民共和国法律管辖。</p>\r\n<p>用户与我们平台就服务本身、本使用协议或其它有关事项发生的争议，应通过友好协商解决。协商不成的，应向北京市东城区人民法院提起诉讼。</p>\r\n<p>我们平台未行使或执行本使用协议设定、赋予的任何权利，不构成对该等权利的放弃。</p>\r\n<p>本使用协议中的任何条款因与中华人民共和国法律相抵触而无效，并不影响其它条款的效力。</p>\r\n<p>本使用协议的标题仅供方便阅读而设，如与协议内容存在矛盾，以协议内容为准。</p>\r\n<p><strong>二十、举报</strong></p>\r\n<p>如用户发现任何违反本服务条款的情事，请及时通知我们平台。</p>\r\n</div>', 'term', '', '1', '1');
INSERT INTO `%DB_PREFIX%help` VALUES ('2', '服务介绍', '', 'intro', '', '1', '1');
INSERT INTO `%DB_PREFIX%help` VALUES ('3', '隐私策略', '', 'privacy', '', '1', '1');
INSERT INTO `%DB_PREFIX%help` VALUES ('4', '关于我们', '', 'about', '', '1', '1');
INSERT INTO `%DB_PREFIX%help` VALUES ('5', '官方微博', 'adsfadsfasdf', '', 'http://weibo.com/fzmatthew', '0', '1');
INSERT INTO `%DB_PREFIX%help` VALUES ('7', '撰写指南', '', 'write_guide', '', '1', '1');

-- ----------------------------
-- Table structure for `%DB_PREFIX%index_image`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%index_image`;
CREATE TABLE `%DB_PREFIX%index_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示首页轮播 1表示产品页轮播 2表示股权轮播',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='//首页图片';

-- ----------------------------
-- Records of fanwe_index_image
-- ----------------------------
INSERT INTO `%DB_PREFIX%index_image` VALUES ('5', './public/attachment/201211/07/10/5099c97ad9f82.gif', 'http://zc.fanwe.cn', '1', '方维众筹', '0');
INSERT INTO `%DB_PREFIX%index_image` VALUES ('6', './public/attachment/201211/07/10/5099c984946c3.jpg', 'http://zc.fanwe.cn', '2', '方维众筹', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%investment_list`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%investment_list`;
CREATE TABLE `%DB_PREFIX%investment_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(11) NOT NULL DEFAULT '0' COMMENT '投资的类型 0 表示 询价，1表示领投，2表示跟投,3表示追加的金额',
  `money` decimal(20,2) NOT NULL COMMENT '投资的金额',
  `stock_value` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '估指',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0表示 未来审核，1表示同意，2表示不同意',
  `introduce` text NOT NULL COMMENT '领投人的个人简介',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `deal_id` int(11) NOT NULL COMMENT '股权众筹ID',
  `cates` text NOT NULL COMMENT '分类信息',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `investment_reason` text NOT NULL COMMENT '投资请求',
  `funding_to_help` text NOT NULL COMMENT '资金帮助',
  `investor_money_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '投资金额0 表示未审核 1表示审核通过 2表示审核拒绝 3表示已支付投资成功 4表示未按时间支付，违约',
  `order_id` int(11) NOT NULL COMMENT '订单号',
  `is_partner` tinyint(11) NOT NULL COMMENT '0表示无状态 1表示愿意承担企业合伙人 2表示不愿意承担企业合伙人',
  `leader_moban` text NOT NULL COMMENT '尽职调查和条款清单模板',
  `leader_help` text NOT NULL COMMENT '他为创业者还能提供的其它帮助',
  `leader_for_team` text NOT NULL COMMENT '对创业团队评价',
  `leader_for_project` text NOT NULL COMMENT '对创业项目评价',
  `send_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示未发送 1发送成功',
  `detailed_information` text NOT NULL COMMENT '详细资料',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fanwe_investment_list
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%link`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%link`;
CREATE TABLE `%DB_PREFIX%link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `count` int(11) NOT NULL,
  `show_index` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT='//链接';

-- ----------------------------
-- Records of fanwe_link
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%link_group`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%link_group`;
CREATE TABLE `%DB_PREFIX%link_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '友情链接分组名称',
  `sort` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 文字描述 1图片描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='//链接组';

-- ----------------------------
-- Records of fanwe_link_group
-- ----------------------------
INSERT INTO `%DB_PREFIX%link_group` VALUES ('14', '友情链接', '1', '1', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%log`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%log`;
CREATE TABLE `%DB_PREFIX%log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL,
  `log_time` int(11) NOT NULL,
  `log_admin` int(11) NOT NULL,
  `log_ip` varchar(255) NOT NULL,
  `log_status` tinyint(1) NOT NULL,
  `module` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2382 DEFAULT CHARSET=utf8 COMMENT='//记录';

-- ----------------------------
-- Records of fanwe_log
-- ----------------------------
INSERT INTO `%DB_PREFIX%log` VALUES ('2380', '发起项目更新成功', '1417975607', '1', '127.0.0.1', '1', 'Article', 'update');
INSERT INTO `%DB_PREFIX%log` VALUES ('2381', 'TPL_MAIL_INVESTOR_PAY_STATUS更新成功', '1422475811', '1', '127.0.0.1', '1', 'MsgTemplate', 'update');

-- ----------------------------
-- Table structure for `%DB_PREFIX%mail_list`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%mail_list`;
CREATE TABLE `%DB_PREFIX%mail_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_address` varchar(255) NOT NULL,
  `city_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mail_address_idx` (`mail_address`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='//邮件列表';

-- ----------------------------
-- Records of fanwe_mail_list
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%mail_server`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%mail_server`;
CREATE TABLE `%DB_PREFIX%mail_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smtp_server` varchar(255) NOT NULL,
  `smtp_name` varchar(255) NOT NULL,
  `smtp_pwd` varchar(255) NOT NULL,
  `is_ssl` tinyint(1) NOT NULL,
  `smtp_port` varchar(255) NOT NULL,
  `use_limit` int(11) NOT NULL,
  `is_reset` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `total_use` int(11) NOT NULL,
  `is_verify` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='// 邮件服务器';

-- ----------------------------
-- Records of fanwe_mail_server
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%mobile_verify_code`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%mobile_verify_code`;
CREATE TABLE `%DB_PREFIX%mobile_verify_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `verify_code` varchar(10) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `create_time` int(11) NOT NULL,
  `client_ip` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL COMMENT '邮件',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='//手机验证';

-- ----------------------------
-- Records of fanwe_mobile_verify_code
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%mortgate`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%mortgate`;
CREATE TABLE `%DB_PREFIX%mortgate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `notice_id` int(11) NOT NULL COMMENT '0 表示为余额支付 大于0表示在线支付',
  `money` int(11) NOT NULL COMMENT '诚意金 金额',
  `status` tinyint(1) NOT NULL COMMENT '状态 1表示诚意金支付 2表示扣除诚意金 3表示诚意金解冻到余额',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fanwe_mortgate
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%msg_template`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%msg_template`;
CREATE TABLE `%DB_PREFIX%msg_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '名字',
  `content` text NOT NULL COMMENT '内容',
  `type` tinyint(1) NOT NULL COMMENT '类型',
  `is_html` tinyint(1) NOT NULL COMMENT '是否成功：1表示成功，0表示失败',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='// 邮箱验证';

-- ----------------------------
-- Records of fanwe_msg_template
-- ----------------------------
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('1', 'TPL_MAIL_USER_PASSWORD', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}你好，请点击以下链接修改您的密码：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.password_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.password_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.site_name}团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n \r\n</tbody>\r\n</table>', '1', '1');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('3', 'TPL_MAIL_USER_VERIFY', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 {$user.send_time_ms} 注册帐号 <a href=\"mailto:{$user.email}\" target=\"_blank\">{$user.email}<wbr>.com</a> ，点击以下链接，即可激活该帐号：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.verify_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.verify_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">1、为了保障您帐号的安全性，请在 48小时内完成激活，此链接将在您激活过一次后失效！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">2、注册的帐号可以畅行{$user.site_name}产品</p>\r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.site_name}帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('18', 'TPL_SMS_DEAL_FAIL', '{$fail_user_info.user_name}您好，很遗憾的通知您，您所支持的 \"{$fail_user_info.deal_name}\"项目筹资失败!', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('20', 'TPL_SMS_USER_VERIFY', '恭喜你{$success_user_info.user_name}，注册验证成功!', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('21', 'TPL_SMS_USER_S', '{$user_s_msg.user_name}您好，恭喜你，您发起的{$user_s_msg.deal_name}项目筹资成功!', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('22', 'TPL_SMS_USER_F', '{$user_f_msg.user_name}您好，很遗憾的通知您，您发起的{$user_f_msg.deal_name}项目筹资失败!', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('23', 'TPL_SMS_VERIFY_CODE', '你的手机号为{$verify.mobile},验证码为{$verify.code}', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('17', 'TPL_SMS_DEAL_SUCCESS', '{$success_user_info.user_name}您好，恭喜你，您所支持的 \"{$success_user_info.deal_name}\" 项目筹资成功,近期将会发放回报!', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('4', 'TPL_MAIL_CHANGE_USER_VERIFY', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 {$user.send_time_ms} 进行邮件修改 <a href=\"mailto:{$user.email}\" target=\"_blank\">{$user.email}<wbr>.com</a> ，点击以下链接，即可进行下一步操作：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.verify_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.verify_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">1、为了保障您帐号的安全性，请在 48小时内完成激活，此链接将在您激活过一次后失效！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">2、注册的帐号可以畅行{$user.site_name}产品</p>\r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.site_name}帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('5', 'TPL_MAIL_INVESTOR_STATUS', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 {$user.send_time_ms} 进行{$user.is_investor_name}申请，{if $user.investor_status eq 1}很高兴您审核通过,点击以下链接，即可进行下一步操作{else}很遗憾您的申请未通过,理由是：{$user.investor_send_info};点击以下链接，即可重新申请{/if}：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.verify_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.verify_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n 				<div style=\"line-height:80px;height:80px;\"></div>\r\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('25', 'TPL_MAIL_INVESTOR_PAY_STATUS', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}您好，您的投资申请已通过，请在{$user.pay_end_time}前进行支付{$user.money}元;点击以下链接</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.note_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.note_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('26', 'TPL_SMS_INVESTOR_PAY_STATUS', '{$user.user_name}您好，您的投资申请已通过，请在{$user.pay_end_time}前进行支付{$user.money}元', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('6', 'TPL_SMS_INVESTOR_STATUS', '{$user.user_name}您好，{if $user.investor_status eq 1}恭喜您{else}很遗憾,{$user.investor_send_info}{/if},您申请的{$user.is_investor_name}{$user.investor_status_name}', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('27', 'TPL_SMS_INVESTOR_PAID_STATUS', '恭喜您，已经支付{$user.paid_money}元,支付单号为{$user.notice_sn}', '0', '0');
INSERT INTO `%DB_PREFIX%msg_template` VALUES ('28', 'TPL_MAIL_INVESTOR_PAID_STATUS', '<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}您好，恭喜您，已经支付{$user.paid_money}元,支付单号为{$user.notice_sn}</p>\r\n				\r\n  				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>', '1', '1');

-- ----------------------------
-- Table structure for `%DB_PREFIX%m_adv`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%m_adv`;
CREATE TABLE `%DB_PREFIX%m_adv` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `img` varchar(255) DEFAULT '',
  `page` varchar(20) DEFAULT '',
  `type` tinyint(1) DEFAULT '0' COMMENT '1.标签集,2.url地址,3.分类排行,4.最亮达人,5.搜索发现,6.一起拍,7.热门单品排行,8.直接显示某个分享',
  `data` text,
  `sort` smallint(5) DEFAULT '10',
  `status` tinyint(1) DEFAULT '1',
  `open_url_type` int(11) DEFAULT '0' COMMENT '0:使用内置浏览器打开url;1:使用外置浏览器打开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fanwe_m_adv
-- ----------------------------
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('20', '171', '', 'deal', '1', '216', '12', '1', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('22', '百度广告', 'http://www.baidu.com/img/bd_logo.png', 'top', '2', 'http://www.baidu.com', '14', '0', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('13', '享客来1', '', 'deal', '1', '135', '5', '1', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('11', '手机广告', './public/attachment/201203/03/09/4f5175debd973.jpg', 'top', '2', 'http://www.baidu.com', '4', '0', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('21', 'test', './public/attachment/201408/14/14/53ec52560a0cd.jpg', 'top', '2', 'http://www.baidu.com', '13', '1', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('19', '108', '', 'deal', '1', '108', '11', '1', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('23', '平整占2', '', 'top', '1', '1', '15', '0', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('17', '首页广告测试刷新功能', './public/attachment/201407/30/09/53d84720ecff4.jpg', 'top', '2', 'http://www.baidu.com', '9', '1', '0');
INSERT INTO `%DB_PREFIX%m_adv` VALUES ('18', '信贷的测试2', './public/attachment/201407/29/15/53d752859c703.jpg', 'top', '2', 'http://www.baidu.com', '10', '1', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%m_config`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%m_config`;
CREATE TABLE `%DB_PREFIX%m_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `val` text,
  `type` tinyint(1) NOT NULL,
  `sort` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fanwe_m_config
-- ----------------------------
INSERT INTO `%DB_PREFIX%m_config` VALUES ('10', 'kf_phone', '客服电话', '400-000-0000', '0', '1');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('11', 'kf_email', '客服邮箱', 'qq@fanwe.com', '0', '2');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('29', 'ios_upgrade', 'ios版本升级内容', '', '3', '9');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('16', 'page_size', '分页大小', '10', '0', '10');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('17', 'about_info', '关于我们(填文章ID)', '66', '0', '3');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('18', 'program_title', '程序标题名称', '众筹系统', '0', '0');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('22', 'android_version', 'android版本号(yyyymmddnn)', '2014082101', '0', '4');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('23', 'android_filename', 'android下载包名(放程序根目录下)', 'fanwe_P2P.apk', '0', '5');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('24', 'ios_version', 'ios版本号(yyyymmddnn)', '2014082009', '0', '7');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('25', 'ios_down_url', 'ios下载地址(appstore连接地址)', '', '0', '8');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('28', 'android_upgrade', 'android版本升级内容', '修复bug', '3', '6');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('30', 'article_cate_id', '文章分类ID', '15', '0', '11');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('31', 'android_forced_upgrade', '是否强制升级(0:否;1:是)', '1', '0', '0');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('32', 'ios_forced_upgrade', '是否强制升级(0:否;1:是)', '1', '0', '0');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('35', 'logo', '系统LOGO', '', '2', '1');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('33', 'index_adv_num', '首页广告数', '5', '0', '33');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('34', 'index_pro_num', '首页推荐商品数', '0', '0', '34');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('36', 'wx_appid', '微信APPID', '', '0', '36');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('37', 'wx_secrit', '微信SECRIT', '', '0', '37');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('38', 'sina_app_key', '新浪APP_KEY', null, '0', '38');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('39', 'sina_app_secret', '新浪APP_SECRET', null, '0', '39');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('40', 'sina_bind_url', '新浪回调地址', null, '0', '40');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('41', 'qq_app_key', 'QQ登录APP_KEY', null, '0', '41');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('42', 'qq_app_secret', 'QQ登录APP_SECRET', null, '0', '42');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('43', 'wx_app_key', '微信(分享)appkey', null, '0', '43');
INSERT INTO `%DB_PREFIX%m_config` VALUES ('44', 'wx_app_secret', '微信(分享)appSecret', null, '0', '44');

-- ----------------------------
-- Table structure for `%DB_PREFIX%nav`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%nav`;
CREATE TABLE `%DB_PREFIX%nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `blank` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `u_module` varchar(255) NOT NULL,
  `u_action` varchar(255) NOT NULL,
  `u_id` int(11) NOT NULL,
  `u_param` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='//导航菜单列表';

-- ----------------------------
-- Records of fanwe_nav
-- ----------------------------
INSERT INTO `%DB_PREFIX%nav` VALUES ('42', '首页', '', '0', '1', '1', 'index', '', '0', '');
INSERT INTO `%DB_PREFIX%nav` VALUES ('47', '经典项目', '', '0', '3', '1', 'deals', 'index', '0', 'r=classic');
INSERT INTO `%DB_PREFIX%nav` VALUES ('46', '所有项目', '', '0', '2', '1', 'deals', 'index', '0', '');
INSERT INTO `%DB_PREFIX%nav` VALUES ('48', '最新动态', '', '0', '4', '1', 'news', 'index', '0', '');
INSERT INTO `%DB_PREFIX%nav` VALUES ('49', '文章', 'index.php?ctl=article_cate', '0', '20', '1', '', '', '0', '');

-- ----------------------------
-- Table structure for `%DB_PREFIX%payment`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%payment`;
CREATE TABLE `%DB_PREFIX%payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `online_pay` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `total_amount` decimal(20,2) NOT NULL COMMENT '总金额',
  `config` text NOT NULL,
  `logo` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='// 付款';

-- ----------------------------
-- Records of fanwe_payment
-- ----------------------------
INSERT INTO `%DB_PREFIX%payment` VALUES ('24', 'AlipayBank', '1', '1', '支付宝银行直连支付', '', '0.00', 'a:4:{s:14:\"alipay_partner\";s:0:\"\";s:14:\"alipay_account\";s:0:\"\";s:10:\"alipay_key\";s:0:\"\";s:14:\"alipay_gateway\";a:17:{s:7:\"ICBCB2C\";s:1:\"1\";s:3:\"CMB\";s:1:\"1\";s:3:\"CCB\";s:1:\"1\";s:3:\"ABC\";s:1:\"1\";s:4:\"SPDB\";s:1:\"1\";s:3:\"SDB\";s:1:\"1\";s:3:\"CIB\";s:1:\"1\";s:6:\"BJBANK\";s:1:\"1\";s:7:\"CEBBANK\";s:1:\"1\";s:4:\"CMBC\";s:1:\"1\";s:5:\"CITIC\";s:1:\"1\";s:3:\"GDB\";s:1:\"1\";s:7:\"SPABANK\";s:1:\"1\";s:6:\"BOCB2C\";s:1:\"1\";s:4:\"COMM\";s:1:\"1\";s:7:\"ICBCBTB\";s:1:\"1\";s:10:\"PSBC-DEBIT\";s:1:\"1\";}}', '', '1');

-- ----------------------------
-- Table structure for `%DB_PREFIX%payment_notice`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%payment_notice`;
CREATE TABLE `%DB_PREFIX%payment_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_sn` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `pay_time` int(11) NOT NULL,
  `order_id` int(11) NOT NULL COMMENT 'order_id为0时为充值',
  `is_paid` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `bank_id` varchar(255) NOT NULL,
  `memo` text NOT NULL,
  `money` decimal(20,2) NOT NULL COMMENT '金额',
  `outer_notice_sn` varchar(255) NOT NULL,
  `deal_id` int(11) NOT NULL COMMENT '0为充值',
  `deal_item_id` int(11) NOT NULL COMMENT '0为充值',
  `deal_name` varchar(255) NOT NULL COMMENT '空为充值',
  `is_has_send_success` tinyint(1) NOT NULL COMMENT '（0表示发送不成功，1表示发送成功）',
  `is_mortgate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是诚意金 0表示否 1表示 是 2表示诚意金已经冻结（从余额中取出）',
  `paid_send` tinyint(1) NOT NULL COMMENT '支付成功后是否发送',
  PRIMARY KEY (`id`),
  UNIQUE KEY `notice_sn_unk` (`notice_sn`),
  KEY `order_id` (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `payment_id` (`payment_id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=204 DEFAULT CHARSET=utf8 COMMENT='// 付款单号列表';

-- ----------------------------
-- Records of fanwe_payment_notice
-- ----------------------------
INSERT INTO `%DB_PREFIX%payment_notice` VALUES ('200', '20121107399', '1352230157', '0', '67', '0', '19', '24', 'ICBCB2C', '', '500.00', '', '56', '24', '拥有自己的咖啡馆', '0', '0', '0');
INSERT INTO `%DB_PREFIX%payment_notice` VALUES ('201', '20121107985', '1352230180', '1352230180', '67', '1', '19', '0', '', '管理员收款', '500.00', '', '56', '24', '拥有自己的咖啡馆', '0', '0', '0');
INSERT INTO `%DB_PREFIX%payment_notice` VALUES ('202', '20121107931', '1352231631', '0', '78', '0', '19', '24', 'CCB', 'ttt', '500.00', '', '58', '30', '流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！', '0', '0', '0');
INSERT INTO `%DB_PREFIX%payment_notice` VALUES ('203', '20121107124', '1352231671', '0', '79', '0', '17', '24', 'ICBCB2C', '部份支付', '200.00', '', '56', '24', '拥有自己的咖啡馆', '0', '0', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%promote_msg`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%promote_msg`;
CREATE TABLE `%DB_PREFIX%promote_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '0:短信 1:邮件',
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `send_time` int(11) NOT NULL,
  `send_status` tinyint(1) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `send_type_id` int(11) NOT NULL,
  `send_define_data` text NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `send_type` (`send_type`),
  KEY `send_type_id` (`send_type_id`),
  KEY `send_status` (`send_status`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='// 推广信息';

-- ----------------------------
-- Records of fanwe_promote_msg
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%promote_msg_list`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%promote_msg_list`;
CREATE TABLE `%DB_PREFIX%promote_msg_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dest` varchar(255) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `content` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `send_time` int(11) NOT NULL,
  `is_send` tinyint(1) NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `result` text NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  `msg_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dest_idx` (`dest`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='// 推广信息队列表';

-- ----------------------------
-- Records of fanwe_promote_msg_list
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%recommend`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%recommend`;
CREATE TABLE `%DB_PREFIX%recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memo` text NOT NULL COMMENT '推荐理由',
  `deal_id` int(11) NOT NULL COMMENT '项目编号',
  `user_id` int(11) NOT NULL COMMENT '推送给哪个会员',
  `recommend_user_id` int(11) NOT NULL COMMENT '推送人ID',
  `create_time` int(11) NOT NULL COMMENT '推荐时间',
  `deal_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型 0表示普通项目 1表示股权项目',
  `deal_name` varchar(255) NOT NULL COMMENT '项目名称',
  `deal_image` varchar(255) NOT NULL COMMENT '推荐项目图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fanwe_recommend
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%region_conf`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%region_conf`;
CREATE TABLE `%DB_PREFIX%region_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '地区名称',
  `region_level` tinyint(4) NOT NULL COMMENT '1:国 2:省 3:市(县) 4:区(镇)',
  `py` varchar(50) NOT NULL,
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为热门地区',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3401 DEFAULT CHARSET=utf8 COMMENT='//地区配置';

-- ----------------------------
-- Records of fanwe_region_conf
-- ----------------------------
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3', '1', '安徽', '2', 'anhui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('4', '1', '福建', '2', 'fujian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('5', '1', '甘肃', '2', 'gansu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('6', '1', '广东', '2', 'guangdong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('7', '1', '广西', '2', 'guangxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('8', '1', '贵州', '2', 'guizhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('9', '1', '海南', '2', 'hainan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('10', '1', '河北', '2', 'hebei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('11', '1', '河南', '2', 'henan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('12', '1', '黑龙江', '2', 'heilongjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('13', '1', '湖北', '2', 'hubei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('14', '1', '湖南', '2', 'hunan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('15', '1', '吉林', '2', 'jilin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('16', '1', '江苏', '2', 'jiangsu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('17', '1', '江西', '2', 'jiangxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('18', '1', '辽宁', '2', 'liaoning', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('19', '1', '内蒙古', '2', 'neimenggu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('20', '1', '宁夏', '2', 'ningxia', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('21', '1', '青海', '2', 'qinghai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('22', '1', '山东', '2', 'shandong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('23', '1', '山西', '2', 'shanxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('24', '1', '陕西', '2', 'shanxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('26', '1', '四川', '2', 'sichuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('28', '1', '西藏', '2', 'xicang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('29', '1', '新疆', '2', 'xinjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('30', '1', '云南', '2', 'yunnan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('31', '1', '浙江', '2', 'zhejiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('36', '3', '安庆', '3', 'anqing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('37', '3', '蚌埠', '3', 'bangbu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('38', '3', '巢湖', '3', 'chaohu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('39', '3', '池州', '3', 'chizhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('40', '3', '滁州', '3', 'chuzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('41', '3', '阜阳', '3', 'fuyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('42', '3', '淮北', '3', 'huaibei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('43', '3', '淮南', '3', 'huainan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('44', '3', '黄山', '3', 'huangshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('45', '3', '六安', '3', 'liuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('46', '3', '马鞍山', '3', 'maanshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('47', '3', '宿州', '3', 'suzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('48', '3', '铜陵', '3', 'tongling', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('49', '3', '芜湖', '3', 'wuhu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('50', '3', '宣城', '3', 'xuancheng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('51', '3', '亳州', '3', 'zhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('52', '2', '北京', '2', 'beijing', '1');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('53', '4', '福州', '3', 'fuzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('54', '4', '龙岩', '3', 'longyan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('55', '4', '南平', '3', 'nanping', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('56', '4', '宁德', '3', 'ningde', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('57', '4', '莆田', '3', 'putian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('58', '4', '泉州', '3', 'quanzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('59', '4', '三明', '3', 'sanming', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('60', '4', '厦门', '3', 'xiamen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('61', '4', '漳州', '3', 'zhangzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('62', '5', '兰州', '3', 'lanzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('63', '5', '白银', '3', 'baiyin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('64', '5', '定西', '3', 'dingxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('65', '5', '甘南', '3', 'gannan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('66', '5', '嘉峪关', '3', 'jiayuguan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('67', '5', '金昌', '3', 'jinchang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('68', '5', '酒泉', '3', 'jiuquan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('69', '5', '临夏', '3', 'linxia', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('70', '5', '陇南', '3', 'longnan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('71', '5', '平凉', '3', 'pingliang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('72', '5', '庆阳', '3', 'qingyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('73', '5', '天水', '3', 'tianshui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('74', '5', '武威', '3', 'wuwei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('75', '5', '张掖', '3', 'zhangye', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('76', '6', '广州', '3', 'guangzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('77', '6', '深圳', '3', 'shen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('78', '6', '潮州', '3', 'chaozhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('79', '6', '东莞', '3', 'dong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('80', '6', '佛山', '3', 'foshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('81', '6', '河源', '3', 'heyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('82', '6', '惠州', '3', 'huizhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('83', '6', '江门', '3', 'jiangmen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('84', '6', '揭阳', '3', 'jieyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('85', '6', '茂名', '3', 'maoming', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('86', '6', '梅州', '3', 'meizhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('87', '6', '清远', '3', 'qingyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('88', '6', '汕头', '3', 'shantou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('89', '6', '汕尾', '3', 'shanwei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('90', '6', '韶关', '3', 'shaoguan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('91', '6', '阳江', '3', 'yangjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('92', '6', '云浮', '3', 'yunfu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('93', '6', '湛江', '3', 'zhanjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('94', '6', '肇庆', '3', 'zhaoqing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('95', '6', '中山', '3', 'zhongshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('96', '6', '珠海', '3', 'zhuhai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('97', '7', '南宁', '3', 'nanning', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('98', '7', '桂林', '3', 'guilin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('99', '7', '百色', '3', 'baise', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('100', '7', '北海', '3', 'beihai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('101', '7', '崇左', '3', 'chongzuo', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('102', '7', '防城港', '3', 'fangchenggang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('103', '7', '贵港', '3', 'guigang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('104', '7', '河池', '3', 'hechi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('105', '7', '贺州', '3', 'hezhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('106', '7', '来宾', '3', 'laibin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('107', '7', '柳州', '3', 'liuzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('108', '7', '钦州', '3', 'qinzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('109', '7', '梧州', '3', 'wuzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('110', '7', '玉林', '3', 'yulin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('111', '8', '贵阳', '3', 'guiyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('112', '8', '安顺', '3', 'anshun', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('113', '8', '毕节', '3', 'bijie', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('114', '8', '六盘水', '3', 'liupanshui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('115', '8', '黔东南', '3', 'qiandongnan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('116', '8', '黔南', '3', 'qiannan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('117', '8', '黔西南', '3', 'qianxinan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('118', '8', '铜仁', '3', 'tongren', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('119', '8', '遵义', '3', 'zunyi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('120', '9', '海口', '3', 'haikou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('121', '9', '三亚', '3', 'sanya', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('122', '9', '白沙', '3', 'baisha', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('123', '9', '保亭', '3', 'baoting', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('124', '9', '昌江', '3', 'changjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('125', '9', '澄迈县', '3', 'chengmaixian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('126', '9', '定安县', '3', 'dinganxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('127', '9', '东方', '3', 'dongfang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('128', '9', '乐东', '3', 'ledong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('129', '9', '临高县', '3', 'lingaoxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('130', '9', '陵水', '3', 'lingshui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('131', '9', '琼海', '3', 'qionghai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('132', '9', '琼中', '3', 'qiongzhong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('133', '9', '屯昌县', '3', 'tunchangxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('134', '9', '万宁', '3', 'wanning', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('135', '9', '文昌', '3', 'wenchang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('136', '9', '五指山', '3', 'wuzhishan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('137', '9', '儋州', '3', 'zhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('138', '10', '石家庄', '3', 'shijiazhuang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('139', '10', '保定', '3', 'baoding', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('140', '10', '沧州', '3', 'cangzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('141', '10', '承德', '3', 'chengde', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('142', '10', '邯郸', '3', 'handan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('143', '10', '衡水', '3', 'hengshui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('144', '10', '廊坊', '3', 'langfang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('145', '10', '秦皇岛', '3', 'qinhuangdao', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('146', '10', '唐山', '3', 'tangshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('147', '10', '邢台', '3', 'xingtai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('148', '10', '张家口', '3', 'zhangjiakou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('149', '11', '郑州', '3', 'zhengzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('150', '11', '洛阳', '3', 'luoyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('151', '11', '开封', '3', 'kaifeng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('152', '11', '安阳', '3', 'anyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('153', '11', '鹤壁', '3', 'hebi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('154', '11', '济源', '3', 'jiyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('155', '11', '焦作', '3', 'jiaozuo', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('156', '11', '南阳', '3', 'nanyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('157', '11', '平顶山', '3', 'pingdingshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('158', '11', '三门峡', '3', 'sanmenxia', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('159', '11', '商丘', '3', 'shangqiu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('160', '11', '新乡', '3', 'xinxiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('161', '11', '信阳', '3', 'xinyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('162', '11', '许昌', '3', 'xuchang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('163', '11', '周口', '3', 'zhoukou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('164', '11', '驻马店', '3', 'zhumadian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('165', '11', '漯河', '3', 'he', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('166', '11', '濮阳', '3', 'yang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('167', '12', '哈尔滨', '3', 'haerbin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('168', '12', '大庆', '3', 'daqing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('169', '12', '大兴安岭', '3', 'daxinganling', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('170', '12', '鹤岗', '3', 'hegang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('171', '12', '黑河', '3', 'heihe', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('172', '12', '鸡西', '3', 'jixi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('173', '12', '佳木斯', '3', 'jiamusi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('174', '12', '牡丹江', '3', 'mudanjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('175', '12', '七台河', '3', 'qitaihe', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('176', '12', '齐齐哈尔', '3', 'qiqihaer', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('177', '12', '双鸭山', '3', 'shuangyashan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('178', '12', '绥化', '3', 'suihua', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('179', '12', '伊春', '3', 'yichun', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('180', '13', '武汉', '3', 'wuhan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('181', '13', '仙桃', '3', 'xiantao', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('182', '13', '鄂州', '3', 'ezhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('183', '13', '黄冈', '3', 'huanggang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('184', '13', '黄石', '3', 'huangshi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('185', '13', '荆门', '3', 'jingmen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('186', '13', '荆州', '3', 'jingzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('187', '13', '潜江', '3', 'qianjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('188', '13', '神农架林区', '3', 'shennongjialinqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('189', '13', '十堰', '3', 'shiyan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('190', '13', '随州', '3', 'suizhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('191', '13', '天门', '3', 'tianmen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('192', '13', '咸宁', '3', 'xianning', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('193', '13', '襄樊', '3', 'xiangfan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('194', '13', '孝感', '3', 'xiaogan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('195', '13', '宜昌', '3', 'yichang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('196', '13', '恩施', '3', 'enshi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('197', '14', '长沙', '3', 'changsha', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('198', '14', '张家界', '3', 'zhangjiajie', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('199', '14', '常德', '3', 'changde', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('200', '14', '郴州', '3', 'chenzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('201', '14', '衡阳', '3', 'hengyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('202', '14', '怀化', '3', 'huaihua', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('203', '14', '娄底', '3', 'loudi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('204', '14', '邵阳', '3', 'shaoyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('205', '14', '湘潭', '3', 'xiangtan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('206', '14', '湘西', '3', 'xiangxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('207', '14', '益阳', '3', 'yiyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('208', '14', '永州', '3', 'yongzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('209', '14', '岳阳', '3', 'yueyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('210', '14', '株洲', '3', 'zhuzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('211', '15', '长春', '3', 'changchun', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('212', '15', '吉林', '3', 'jilin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('213', '15', '白城', '3', 'baicheng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('214', '15', '白山', '3', 'baishan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('215', '15', '辽源', '3', 'liaoyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('216', '15', '四平', '3', 'siping', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('217', '15', '松原', '3', 'songyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('218', '15', '通化', '3', 'tonghua', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('219', '15', '延边', '3', 'yanbian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('220', '16', '南京', '3', 'nanjing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('221', '16', '苏州', '3', 'suzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('222', '16', '无锡', '3', 'wuxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('223', '16', '常州', '3', 'changzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('224', '16', '淮安', '3', 'huaian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('225', '16', '连云港', '3', 'lianyungang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('226', '16', '南通', '3', 'nantong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('227', '16', '宿迁', '3', 'suqian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('228', '16', '泰州', '3', 'taizhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('229', '16', '徐州', '3', 'xuzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('230', '16', '盐城', '3', 'yancheng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('231', '16', '扬州', '3', 'yangzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('232', '16', '镇江', '3', 'zhenjiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('233', '17', '南昌', '3', 'nanchang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('234', '17', '抚州', '3', 'fuzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('235', '17', '赣州', '3', 'ganzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('236', '17', '吉安', '3', 'jian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('237', '17', '景德镇', '3', 'jingdezhen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('238', '17', '九江', '3', 'jiujiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('239', '17', '萍乡', '3', 'pingxiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('240', '17', '上饶', '3', 'shangrao', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('241', '17', '新余', '3', 'xinyu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('242', '17', '宜春', '3', 'yichun', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('243', '17', '鹰潭', '3', 'yingtan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('244', '18', '沈阳', '3', 'shenyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('245', '18', '大连', '3', 'dalian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('246', '18', '鞍山', '3', 'anshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('247', '18', '本溪', '3', 'benxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('248', '18', '朝阳', '3', 'chaoyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('249', '18', '丹东', '3', 'dandong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('250', '18', '抚顺', '3', 'fushun', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('251', '18', '阜新', '3', 'fuxin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('252', '18', '葫芦岛', '3', 'huludao', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('253', '18', '锦州', '3', 'jinzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('254', '18', '辽阳', '3', 'liaoyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('255', '18', '盘锦', '3', 'panjin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('256', '18', '铁岭', '3', 'tieling', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('257', '18', '营口', '3', 'yingkou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('258', '19', '呼和浩特', '3', 'huhehaote', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('259', '19', '阿拉善盟', '3', 'alashanmeng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('260', '19', '巴彦淖尔盟', '3', 'bayannaoermeng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('261', '19', '包头', '3', 'baotou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('262', '19', '赤峰', '3', 'chifeng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('263', '19', '鄂尔多斯', '3', 'eerduosi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('264', '19', '呼伦贝尔', '3', 'hulunbeier', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('265', '19', '通辽', '3', 'tongliao', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('266', '19', '乌海', '3', 'wuhai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('267', '19', '乌兰察布市', '3', 'wulanchabushi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('268', '19', '锡林郭勒盟', '3', 'xilinguolemeng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('269', '19', '兴安盟', '3', 'xinganmeng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('270', '20', '银川', '3', 'yinchuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('271', '20', '固原', '3', 'guyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('272', '20', '石嘴山', '3', 'shizuishan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('273', '20', '吴忠', '3', 'wuzhong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('274', '20', '中卫', '3', 'zhongwei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('275', '21', '西宁', '3', 'xining', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('276', '21', '果洛', '3', 'guoluo', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('277', '21', '海北', '3', 'haibei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('278', '21', '海东', '3', 'haidong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('279', '21', '海南', '3', 'hainan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('280', '21', '海西', '3', 'haixi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('281', '21', '黄南', '3', 'huangnan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('282', '21', '玉树', '3', 'yushu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('283', '22', '济南', '3', 'jinan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('284', '22', '青岛', '3', 'qingdao', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('285', '22', '滨州', '3', 'binzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('286', '22', '德州', '3', 'dezhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('287', '22', '东营', '3', 'dongying', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('288', '22', '菏泽', '3', 'heze', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('289', '22', '济宁', '3', 'jining', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('290', '22', '莱芜', '3', 'laiwu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('291', '22', '聊城', '3', 'liaocheng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('292', '22', '临沂', '3', 'linyi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('293', '22', '日照', '3', 'rizhao', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('294', '22', '泰安', '3', 'taian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('295', '22', '威海', '3', 'weihai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('296', '22', '潍坊', '3', 'weifang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('297', '22', '烟台', '3', 'yantai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('298', '22', '枣庄', '3', 'zaozhuang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('299', '22', '淄博', '3', 'zibo', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('300', '23', '太原', '3', 'taiyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('301', '23', '长治', '3', 'changzhi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('302', '23', '大同', '3', 'datong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('303', '23', '晋城', '3', 'jincheng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('304', '23', '晋中', '3', 'jinzhong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('305', '23', '临汾', '3', 'linfen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('306', '23', '吕梁', '3', 'lvliang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('307', '23', '朔州', '3', 'shuozhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('308', '23', '忻州', '3', 'xinzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('309', '23', '阳泉', '3', 'yangquan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('310', '23', '运城', '3', 'yuncheng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('311', '24', '西安', '3', 'xian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('312', '24', '安康', '3', 'ankang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('313', '24', '宝鸡', '3', 'baoji', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('314', '24', '汉中', '3', 'hanzhong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('315', '24', '商洛', '3', 'shangluo', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('316', '24', '铜川', '3', 'tongchuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('317', '24', '渭南', '3', 'weinan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('318', '24', '咸阳', '3', 'xianyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('319', '24', '延安', '3', 'yanan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('320', '24', '榆林', '3', 'yulin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('321', '25', '上海', '2', 'shanghai', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('322', '26', '成都', '3', 'chengdu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('323', '26', '绵阳', '3', 'mianyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('324', '26', '阿坝', '3', 'aba', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('325', '26', '巴中', '3', 'bazhong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('326', '26', '达州', '3', 'dazhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('327', '26', '德阳', '3', 'deyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('328', '26', '甘孜', '3', 'ganzi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('329', '26', '广安', '3', 'guangan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('330', '26', '广元', '3', 'guangyuan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('331', '26', '乐山', '3', 'leshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('332', '26', '凉山', '3', 'liangshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('333', '26', '眉山', '3', 'meishan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('334', '26', '南充', '3', 'nanchong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('335', '26', '内江', '3', 'neijiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('336', '26', '攀枝花', '3', 'panzhihua', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('337', '26', '遂宁', '3', 'suining', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('338', '26', '雅安', '3', 'yaan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('339', '26', '宜宾', '3', 'yibin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('340', '26', '资阳', '3', 'ziyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('341', '26', '自贡', '3', 'zigong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('342', '26', '泸州', '3', 'zhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('343', '27', '天津', '2', 'tianjin', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('344', '28', '拉萨', '3', 'lasa', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('345', '28', '阿里', '3', 'ali', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('346', '28', '昌都', '3', 'changdu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('347', '28', '林芝', '3', 'linzhi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('348', '28', '那曲', '3', 'naqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('349', '28', '日喀则', '3', 'rikaze', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('350', '28', '山南', '3', 'shannan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('351', '29', '乌鲁木齐', '3', 'wulumuqi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('352', '29', '阿克苏', '3', 'akesu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('353', '29', '阿拉尔', '3', 'alaer', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('354', '29', '巴音郭楞', '3', 'bayinguoleng', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('355', '29', '博尔塔拉', '3', 'boertala', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('356', '29', '昌吉', '3', 'changji', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('357', '29', '哈密', '3', 'hami', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('358', '29', '和田', '3', 'hetian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('359', '29', '喀什', '3', 'kashi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('360', '29', '克拉玛依', '3', 'kelamayi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('361', '29', '克孜勒苏', '3', 'kezilesu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('362', '29', '石河子', '3', 'shihezi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('363', '29', '图木舒克', '3', 'tumushuke', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('364', '29', '吐鲁番', '3', 'tulufan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('365', '29', '五家渠', '3', 'wujiaqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('366', '29', '伊犁', '3', 'yili', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('367', '30', '昆明', '3', 'kunming', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('368', '30', '怒江', '3', 'nujiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('369', '30', '普洱', '3', 'puer', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('370', '30', '丽江', '3', 'lijiang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('371', '30', '保山', '3', 'baoshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('372', '30', '楚雄', '3', 'chuxiong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('373', '30', '大理', '3', 'dali', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('374', '30', '德宏', '3', 'dehong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('375', '30', '迪庆', '3', 'diqing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('376', '30', '红河', '3', 'honghe', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('377', '30', '临沧', '3', 'lincang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('378', '30', '曲靖', '3', 'qujing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('379', '30', '文山', '3', 'wenshan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('380', '30', '西双版纳', '3', 'xishuangbanna', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('381', '30', '玉溪', '3', 'yuxi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('382', '30', '昭通', '3', 'zhaotong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('383', '31', '杭州', '3', 'hangzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('384', '31', '湖州', '3', 'huzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('385', '31', '嘉兴', '3', 'jiaxing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('386', '31', '金华', '3', 'jinhua', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('387', '31', '丽水', '3', 'lishui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('388', '31', '宁波', '3', 'ningbo', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('389', '31', '绍兴', '3', 'shaoxing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('390', '31', '台州', '3', 'taizhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('391', '31', '温州', '3', 'wenzhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('392', '31', '舟山', '3', 'zhoushan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('393', '31', '衢州', '3', 'zhou', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('394', '32', '重庆', '2', 'zhongqing', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('395', '33', '香港', '2', 'xianggang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('396', '34', '澳门', '2', 'aomen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('397', '35', '台湾', '2', 'taiwan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('500', '52', '东城区', '3', 'dongchengqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('501', '52', '西城区', '3', 'xichengqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('502', '52', '海淀区', '3', 'haidianqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('503', '52', '朝阳区', '3', 'chaoyangqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('504', '52', '崇文区', '3', 'chongwenqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('505', '52', '宣武区', '3', 'xuanwuqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('506', '52', '丰台区', '3', 'fengtaiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('507', '52', '石景山区', '3', 'shijingshanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('508', '52', '房山区', '3', 'fangshanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('509', '52', '门头沟区', '3', 'mentougouqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('510', '52', '通州区', '3', 'tongzhouqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('511', '52', '顺义区', '3', 'shunyiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('512', '52', '昌平区', '3', 'changpingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('513', '52', '怀柔区', '3', 'huairouqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('514', '52', '平谷区', '3', 'pingguqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('515', '52', '大兴区', '3', 'daxingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('516', '52', '密云县', '3', 'miyunxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('517', '52', '延庆县', '3', 'yanqingxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2703', '321', '长宁区', '3', 'changningqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2704', '321', '闸北区', '3', 'zhabeiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2705', '321', '闵行区', '3', 'xingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2706', '321', '徐汇区', '3', 'xuhuiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2707', '321', '浦东新区', '3', 'pudongxinqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2708', '321', '杨浦区', '3', 'yangpuqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2709', '321', '普陀区', '3', 'putuoqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2710', '321', '静安区', '3', 'jinganqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2711', '321', '卢湾区', '3', 'luwanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2712', '321', '虹口区', '3', 'hongkouqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2713', '321', '黄浦区', '3', 'huangpuqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2714', '321', '南汇区', '3', 'nanhuiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2715', '321', '松江区', '3', 'songjiangqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2716', '321', '嘉定区', '3', 'jiadingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2717', '321', '宝山区', '3', 'baoshanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2718', '321', '青浦区', '3', 'qingpuqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2719', '321', '金山区', '3', 'jinshanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2720', '321', '奉贤区', '3', 'fengxianqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2721', '321', '崇明县', '3', 'chongmingxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2912', '343', '和平区', '3', 'hepingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2913', '343', '河西区', '3', 'hexiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2914', '343', '南开区', '3', 'nankaiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2915', '343', '河北区', '3', 'hebeiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2916', '343', '河东区', '3', 'hedongqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2917', '343', '红桥区', '3', 'hongqiaoqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2918', '343', '东丽区', '3', 'dongliqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2919', '343', '津南区', '3', 'jinnanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2920', '343', '西青区', '3', 'xiqingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2921', '343', '北辰区', '3', 'beichenqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2922', '343', '塘沽区', '3', 'tangguqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2923', '343', '汉沽区', '3', 'hanguqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2924', '343', '大港区', '3', 'dagangqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2925', '343', '武清区', '3', 'wuqingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2926', '343', '宝坻区', '3', 'baoqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2927', '343', '经济开发区', '3', 'jingjikaifaqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2928', '343', '宁河县', '3', 'ninghexian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2929', '343', '静海县', '3', 'jinghaixian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('2930', '343', '蓟县', '3', 'jixian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3325', '394', '合川区', '3', 'hechuanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3326', '394', '江津区', '3', 'jiangjinqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3327', '394', '南川区', '3', 'nanchuanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3328', '394', '永川区', '3', 'yongchuanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3329', '394', '南岸区', '3', 'nananqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3330', '394', '渝北区', '3', 'yubeiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3331', '394', '万盛区', '3', 'wanshengqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3332', '394', '大渡口区', '3', 'dadukouqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3333', '394', '万州区', '3', 'wanzhouqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3334', '394', '北碚区', '3', 'beiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3335', '394', '沙坪坝区', '3', 'shapingbaqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3336', '394', '巴南区', '3', 'bananqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3337', '394', '涪陵区', '3', 'fulingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3338', '394', '江北区', '3', 'jiangbeiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3339', '394', '九龙坡区', '3', 'jiulongpoqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3340', '394', '渝中区', '3', 'yuzhongqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3341', '394', '黔江开发区', '3', 'qianjiangkaifaqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3342', '394', '长寿区', '3', 'changshouqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3343', '394', '双桥区', '3', 'shuangqiaoqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3344', '394', '綦江县', '3', 'jiangxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3345', '394', '潼南县', '3', 'nanxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3346', '394', '铜梁县', '3', 'tongliangxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3347', '394', '大足县', '3', 'dazuxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3348', '394', '荣昌县', '3', 'rongchangxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3349', '394', '璧山县', '3', 'shanxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3350', '394', '垫江县', '3', 'dianjiangxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3351', '394', '武隆县', '3', 'wulongxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3352', '394', '丰都县', '3', 'fengduxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3353', '394', '城口县', '3', 'chengkouxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3354', '394', '梁平县', '3', 'liangpingxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3355', '394', '开县', '3', 'kaixian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3356', '394', '巫溪县', '3', 'wuxixian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3357', '394', '巫山县', '3', 'wushanxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3358', '394', '奉节县', '3', 'fengjiexian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3359', '394', '云阳县', '3', 'yunyangxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3360', '394', '忠县', '3', 'zhongxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3361', '394', '石柱', '3', 'shizhu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3362', '394', '彭水', '3', 'pengshui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3363', '394', '酉阳', '3', 'youyang', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3364', '394', '秀山', '3', 'xiushan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3365', '395', '沙田区', '3', 'shatianqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3366', '395', '东区', '3', 'dongqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3367', '395', '观塘区', '3', 'guantangqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3368', '395', '黄大仙区', '3', 'huangdaxianqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3369', '395', '九龙城区', '3', 'jiulongchengqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3370', '395', '屯门区', '3', 'tunmenqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3371', '395', '葵青区', '3', 'kuiqingqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3372', '395', '元朗区', '3', 'yuanlangqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3373', '395', '深水埗区', '3', 'shenshui', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3374', '395', '西贡区', '3', 'xigongqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3375', '395', '大埔区', '3', 'dapuqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3376', '395', '湾仔区', '3', 'wanziqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3377', '395', '油尖旺区', '3', 'youjianwangqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3378', '395', '北区', '3', 'beiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3379', '395', '南区', '3', 'nanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3380', '395', '荃湾区', '3', 'wanqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3381', '395', '中西区', '3', 'zhongxiqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3382', '395', '离岛区', '3', 'lidaoqu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3383', '396', '澳门', '3', 'aomen', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3384', '397', '台北', '3', 'taibei', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3385', '397', '高雄', '3', 'gaoxiong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3386', '397', '基隆', '3', 'jilong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3387', '397', '台中', '3', 'taizhong', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3388', '397', '台南', '3', 'tainan', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3389', '397', '新竹', '3', 'xinzhu', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3390', '397', '嘉义', '3', 'jiayi', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3391', '397', '宜兰县', '3', 'yilanxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3392', '397', '桃园县', '3', 'taoyuanxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3393', '397', '苗栗县', '3', 'miaolixian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3394', '397', '彰化县', '3', 'zhanghuaxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3395', '397', '南投县', '3', 'nantouxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3396', '397', '云林县', '3', 'yunlinxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3397', '397', '屏东县', '3', 'pingdongxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3398', '397', '台东县', '3', 'taidongxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3399', '397', '花莲县', '3', 'hualianxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('3400', '397', '澎湖县', '3', 'penghuxian', '0');
INSERT INTO `%DB_PREFIX%region_conf` VALUES ('1', '0', '全国', '1', 'quanguo', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%role`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role`;
CREATE TABLE `%DB_PREFIX%role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='//后台的权限节点';

-- ----------------------------
-- Records of fanwe_role
-- ----------------------------
INSERT INTO `%DB_PREFIX%role` VALUES ('4', '测试管理员', '1', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%role_access`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role_access`;
CREATE TABLE `%DB_PREFIX%role_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `node_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='//访问权限';

-- ----------------------------
-- Records of fanwe_role_access
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%role_group`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role_group`;
CREATE TABLE `%DB_PREFIX%role_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `nav_id` int(11) NOT NULL COMMENT '后台导航分组ID',
  `is_delete` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COMMENT='//组权限';

-- ----------------------------
-- Records of fanwe_role_group
-- ----------------------------
INSERT INTO `%DB_PREFIX%role_group` VALUES ('1', '首页', '1', '0', '1', '1');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('5', '系统设置', '3', '0', '1', '1');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('7', '管理员', '3', '0', '1', '2');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('8', '数据库操作', '3', '0', '1', '6');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('9', '系统日志', '3', '0', '1', '7');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('19', '菜单设置', '11', '0', '1', '17');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('28', '邮件管理', '10', '0', '1', '26');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('29', '短信管理', '10', '0', '1', '27');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('31', '广告设置', '11', '0', '1', '29');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('33', '队列管理', '10', '0', '1', '31');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('69', '会员管理', '5', '0', '1', '31');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('70', '会员整合', '5', '0', '1', '32');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('71', '同步登录', '5', '0', '1', '33');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('72', '项目管理', '13', '0', '1', '33');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('73', '项目支持', '13', '0', '1', '34');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('74', '项目点评', '13', '0', '1', '35');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('75', '支付接口', '14', '0', '1', '1');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('76', '付款记录', '14', '0', '1', '2');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('77', '消息模板', '10', '0', '1', '1');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('78', '提现记录', '14', '0', '1', '3');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('79', '友情链接', '11', '0', '1', '36');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('80', '文章管理', '11', '0', '1', '37');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('81', '文章分类管理', '11', '0', '1', '38');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('82', '地区管理', '13', '0', '1', '39');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('83', '系统监测', '3', '0', '1', '83');
INSERT INTO `%DB_PREFIX%role_group` VALUES ('62', '手机端设置', '3', '0', '1', '1');

-- ----------------------------
-- Table structure for `%DB_PREFIX%role_module`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role_module`;
CREATE TABLE `%DB_PREFIX%role_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='//模块权限';

-- ----------------------------
-- Records of fanwe_role_module
-- ----------------------------
INSERT INTO `%DB_PREFIX%role_module` VALUES ('5', 'Role', '权限组别', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('6', 'Admin', '管理员', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('12', 'Conf', '系统配置', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('13', 'Database', '数据库', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('15', 'Log', '系统日志', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('19', 'File', '文件管理', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('58', 'Index', '首页', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('36', 'Nav', '导航菜单', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('47', 'MailServer', '邮件服务器', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('48', 'Sms', '短信接口', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('53', 'Adv', '广告模块', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('56', 'DealMsgList', '业务群发队列', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('92', 'Cache', '缓存处理', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('113', 'User', '会员管理', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('114', 'MsgTemplate', '消息模板管理', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('115', 'Integrate', '会员整合', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('116', 'ApiLogin', '同步登录', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('117', 'DealCate', '项目分类', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('118', 'Deal', '项目管理', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('119', 'Payment', '支付接口', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('120', 'IndexImage', '轮播广告图', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('121', 'Help', '站点帮助', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('122', 'Faq', '常见问题', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('123', 'DealOrder', '项目支持', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('124', 'DealComment', '项目点评', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('125', 'PaymentNotice', '付款记录', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('126', 'UserRefund', '用户提现', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('127', 'PromoteMsg', '推广模块', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('128', 'PromoteMsgList', '推广队列', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('129', 'Link', '友情链接', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('130', 'LinkGroup', '友情链接分组', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('131', 'UserLevel', '会员等级', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('132', 'DealLevel', '项目等级', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('133', 'Article', '文章', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('134', 'ArticleCate', '文章分类', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('135', 'RegionConf', '地区', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('136', 'SqlCheck', '系统监测', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('93', 'MAdv', '手机端广告', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('137', 'UserInvestor', '投资人申请管理', '1', '0');
INSERT INTO `%DB_PREFIX%role_module` VALUES ('138', 'Bank', '提现银行设置', '1', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%role_nav`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role_nav`;
CREATE TABLE `%DB_PREFIX%role_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='// 导航权限';

-- ----------------------------
-- Records of fanwe_role_nav
-- ----------------------------
INSERT INTO `%DB_PREFIX%role_nav` VALUES ('1', '首页', '0', '1', '1');
INSERT INTO `%DB_PREFIX%role_nav` VALUES ('3', '系统设置', '0', '1', '10');
INSERT INTO `%DB_PREFIX%role_nav` VALUES ('5', '会员管理', '0', '1', '3');
INSERT INTO `%DB_PREFIX%role_nav` VALUES ('10', '短信邮件', '0', '1', '7');
INSERT INTO `%DB_PREFIX%role_nav` VALUES ('13', '项目管理', '0', '1', '4');
INSERT INTO `%DB_PREFIX%role_nav` VALUES ('14', '支付管理', '0', '1', '5');
INSERT INTO `%DB_PREFIX%role_nav` VALUES ('11', '前端设置', '0', '1', '6');

-- ----------------------------
-- Table structure for `%DB_PREFIX%role_node`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%role_node`;
CREATE TABLE `%DB_PREFIX%role_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `group_id` int(11) NOT NULL COMMENT '后台分组菜单分组ID',
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6869 DEFAULT CHARSET=utf8 COMMENT='// 权限节点';

-- ----------------------------
-- Records of fanwe_role_node
-- ----------------------------
INSERT INTO `%DB_PREFIX%role_node` VALUES ('334', 'main', '首页', '1', '0', '1', '58');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('11', 'index', '管理员分组列表', '1', '0', '7', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('13', 'trash', '管理员分组回收站', '1', '0', '7', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('14', 'index', '管理员列表', '1', '0', '7', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('15', 'trash', '管理员回收站', '1', '0', '7', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('16', 'index', '系统配置', '1', '0', '5', '12');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('17', 'index', '数据库备份列表', '1', '0', '8', '13');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('18', 'sql', 'SQL操作', '1', '0', '8', '13');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('19', 'index', '系统日志列表', '1', '0', '9', '15');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('24', 'do_upload', '编辑器图片上传', '1', '0', '0', '19');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('43', 'index', '导航菜单列表', '1', '0', '19', '36');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('57', 'index', '邮件服务器列表', '1', '0', '28', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('58', 'index', '短信接口列表', '1', '0', '29', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('63', 'index', '广告列表', '1', '0', '31', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('66', 'index', '业务队列列表', '1', '0', '33', '56');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('68', 'add', '添加页面', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('69', 'edit', '编辑页面', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('70', 'set_effect', '设置生效', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('71', 'add', '添加执行', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('72', 'update', '编辑执行', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('73', 'delete', '删除', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('74', 'restore', '恢复', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('75', 'foreverdelete', '永久删除', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('76', 'set_default', '设置默认管理员', '1', '0', '0', '6');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('77', 'add', '添加页面', '1', '0', '0', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('78', 'edit', '编辑页面', '1', '0', '0', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('79', 'update', '编辑执行', '1', '0', '0', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('80', 'foreverdelete', '永久删除', '1', '0', '0', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('81', 'set_effect', '设置生效', '1', '0', '0', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('99', 'update', '更新配置', '1', '0', '0', '12');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('100', 'dump', '备份数据', '1', '0', '0', '13');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('101', 'delete', '删除备份', '1', '0', '0', '13');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('102', 'restore', '恢复备份', '1', '0', '0', '13');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('103', 'load_file', '读取页面', '1', '0', '0', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('104', 'load_adv_id', '读取广告位', '1', '0', '0', '53');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('105', 'execute', '执行SQL语句', '1', '0', '0', '13');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('147', 'show_content', '显示内容', '1', '0', '0', '56');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('148', 'send', '手动发送', '1', '0', '0', '56');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('149', 'foreverdelete', '永久删除', '1', '0', '0', '56');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('181', 'do_upload_img', '图片控件上传', '1', '0', '0', '19');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('182', 'deleteImg', '删除图片', '1', '0', '0', '19');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('198', 'foreverdelete', '永久删除', '1', '0', '0', '15');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('205', 'add', '添加页面', '1', '0', '0', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('206', 'insert', '添加执行', '1', '0', '0', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('207', 'edit', '编辑页面', '1', '0', '0', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('208', 'update', '编辑执行', '1', '0', '0', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('209', 'set_effect', '设置生效', '1', '0', '0', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('210', 'foreverdelete', '永久删除', '1', '0', '0', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('211', 'send_demo', '发送测试邮件', '1', '0', '0', '47');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('229', 'edit', '编辑页面', '1', '0', '0', '36');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('230', 'update', '编辑执行', '1', '0', '0', '36');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('231', 'set_effect', '设置生效', '1', '0', '0', '36');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('232', 'set_sort', '排序', '1', '0', '0', '36');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('257', 'add', '添加页面', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('258', 'insert', '添加执行', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('259', 'edit', '编辑页面', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('260', 'update', '编辑执行', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('261', 'set_effect', '设置生效', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('262', 'delete', '删除', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('263', 'restore', '恢复', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('264', 'foreverdelete', '永久删除', '1', '0', '0', '5');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('265', 'insert', '安装页面', '1', '0', '0', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('266', 'insert', '安装保存', '1', '0', '0', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('267', 'edit', '编辑页面', '1', '0', '0', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('268', 'update', '编辑执行', '1', '0', '0', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('269', 'uninstall', '卸载', '1', '0', '0', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('270', 'set_effect', '设置生效', '1', '0', '0', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('271', 'send_demo', '发送测试短信', '1', '0', '0', '48');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('474', 'index', '缓存处理', '1', '0', '0', '92');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('475', 'clear_parse_file', '清空脚本样式缓存', '1', '0', '0', '92');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('477', 'clear_data', '清空数据缓存', '1', '0', '0', '92');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('480', 'syn_data', '同步数据', '1', '0', '0', '92');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('481', 'clear_image', '清空图片缓存', '1', '0', '0', '92');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('482', 'clear_admin', '清空后台缓存', '1', '0', '0', '92');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('605', 'index', '消息模板', '1', '0', '77', '114');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('606', 'update', '更新模板', '1', '0', '0', '114');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('607', 'index', '会员列表', '1', '0', '69', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('608', 'add', '添加会员', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('609', 'insert', '添提执行', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('610', 'edit', '编辑会员', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('611', 'update', '编辑执行', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('612', 'delete', '删除会员', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('613', 'modify_account', '会员资金变更', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('614', 'account_detail', '帐户日志', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('615', 'foreverdelete_account_detail', '删除帐户日志', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('616', 'consignee', '配送地址', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('617', 'foreverdelete_consignee', '删除配送地址', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('618', 'weibo', '微博列表', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('619', 'foreverdelete_weibo', '删除微博', '1', '0', '0', '113');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('620', 'index', '会员整合', '1', '0', '70', '115');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('621', 'save', '执行整合', '1', '0', '0', '115');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('622', 'uninstall', '卸载整合', '1', '0', '0', '115');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('623', 'index', '同步登录接口', '1', '0', '71', '116');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('624', 'insert', '安装接口', '1', '0', '0', '116');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('625', 'update', '更新配置', '1', '0', '0', '116');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('626', 'uninstall', '卸载接口', '1', '0', '0', '116');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('627', 'index', '分类列表', '1', '0', '72', '117');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('628', 'insert', '添加分类', '1', '0', '0', '117');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('629', 'update', '更新分类', '1', '0', '0', '117');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('630', 'foreverdelete', '删除分类', '1', '0', '0', '117');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('631', 'online_index', '上线项目列表', '1', '0', '72', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('632', 'submit_index', '未审核项目', '1', '0', '72', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('633', 'index', '支付接口列表', '1', '0', '75', '119');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('634', 'insert', '安装支付接口', '1', '0', '0', '119');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('635', 'update', '更新支付接口', '1', '0', '0', '119');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('636', 'uninstall', '卸载接口', '1', '0', '0', '119');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('637', 'index', '轮播广告设置', '1', '0', '5', '120');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('638', 'insert', '添加广告', '1', '0', '0', '120');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('639', 'update', '修改广告', '1', '0', '0', '120');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('640', 'foreverdelete', '删除广告', '1', '0', '0', '120');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('641', 'delete_index', '回收站', '1', '0', '72', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('642', 'index', '帮助列表', '1', '0', '5', '121');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('643', 'insert', '添加帮助', '1', '0', '0', '121');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('644', 'update', '修改帮助', '1', '0', '0', '121');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('645', 'foreverdelete', '删除帮助', '1', '0', '0', '121');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('646', 'index', '常见问题', '1', '0', '5', '122');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('647', 'insert', '添加问题', '1', '0', '0', '122');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('648', 'update', '更新问题', '1', '0', '0', '122');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('649', 'foreverdelete', '删除问题', '1', '0', '0', '122');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('650', 'pay_log', '筹款发放', '1', '0', '0', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('651', 'save_pay_log', '发放', '1', '0', '0', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('652', 'del_pay_log', '删除发放', '1', '0', '0', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('653', 'deal_log', '项目日志', '1', '0', '0', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('654', 'del_deal_log', '删除日志', '1', '0', '0', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('655', 'batch_refund', '批量退款', '1', '0', '0', '118');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('656', 'index', '项目支持', '1', '0', '73', '123');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('657', 'view', '查看详情', '1', '0', '0', '123');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('658', 'refund', '项目退款', '1', '0', '0', '123');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('659', 'delete', '删除支持', '1', '0', '0', '123');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('660', 'incharge', '项目收款', '1', '0', '0', '123');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('661', 'index', '项目点评', '1', '0', '74', '124');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('662', 'index', '付款记录', '1', '0', '76', '125');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('663', 'delete', '删除记录', '1', '0', '0', '125');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('664', 'index', '提现记录', '1', '0', '78', '126');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('665', 'delete', '删除记录', '1', '0', '0', '126');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('666', 'confirm', '确认提现', '1', '0', '0', '126');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('667', 'mail_index', '邮件列表', '1', '0', '28', '127');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('668', 'sms_index', '短信列表', '1', '0', '29', '127');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('669', 'insert_mail', '新增邮件', '1', '0', '0', '127');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('670', 'insert_sms', '新增短信', '1', '0', '0', '127');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('671', 'update_mail', '更新邮件', '1', '0', '0', '127');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('672', 'update_sms', '更新短信', '1', '0', '0', '127');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('673', 'foreverdelete', '删除', '1', '0', '0', '127');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('674', 'index', '推广队列列表', '1', '0', '33', '128');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('675', 'send', '发送', '1', '0', '0', '128');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('676', 'foreverdelete', '删除', '1', '0', '0', '128');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('677', 'index', '友情链接列表', '1', '0', '79', '129');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('678', 'insert', '添加链接', '1', '0', '0', '129');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('679', 'update', '更新链接', '1', '0', '0', '129');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('680', 'index', '友情链接分组列表', '1', '0', '79', '130');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('681', 'index', '会员等级', '1', '0', '69', '131');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('682', 'index', '项目等级', '1', '0', '72', '132');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('684', 'index', '文章列表', '1', '0', '80', '133');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('685', 'trash', '文章回收站', '1', '0', '80', '133');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('686', 'index', '文章分类列表', '1', '0', '81', '134');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('687', 'trash', '文章分类回收站', '1', '0', '81', '134');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('688', 'index', '地区列表', '1', '0', '82', '135');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('689', 'index', '系统监测列表', '1', '0', '83', '136');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('483', 'mobile', '手机端配置', '1', '0', '62', '12');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('484', 'index', '手机端广告列表', '1', '0', '62', '93');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('485', 'savemobile', '保存手机端配置', '1', '0', '0', '12');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('6867', 'index', '投资申请列表', '1', '0', '69', '137');
INSERT INTO `%DB_PREFIX%role_node` VALUES ('6868', 'index', '提现银行设置', '1', '0', '5', '138');

-- ----------------------------
-- Table structure for `%DB_PREFIX%sms`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%sms`;
CREATE TABLE `%DB_PREFIX%sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `server_url` text NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `config` text NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='// 短信';

-- ----------------------------
-- Records of fanwe_sms
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%sql_check`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%sql_check`;
CREATE TABLE `%DB_PREFIX%sql_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `module_action` varchar(255) NOT NULL,
  `para` varchar(255) NOT NULL COMMENT '参数',
  `module_action_para` varchar(255) NOT NULL,
  `sql_num` int(11) NOT NULL,
  `sql_str` text NOT NULL,
  `query_time` float(11,6) NOT NULL DEFAULT '0.000000' COMMENT 'SQL运行时间',
  `run_time` float(11,6) NOT NULL DEFAULT '0.000000' COMMENT '运行时间',
  `memory_usage` float(11,4) NOT NULL DEFAULT '0.0000' COMMENT '内存占用情况',
  `gzip_on` tinyint(1) NOT NULL COMMENT '是否开启gzip_on',
  `url` varchar(255) NOT NULL COMMENT '请求地址',
  `file_name` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='//系统监测';

-- ----------------------------
-- Records of fanwe_sql_check
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%user`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user`;
CREATE TABLE `%DB_PREFIX%user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_pwd` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `money` decimal(20,2) NOT NULL COMMENT '金额',
  `login_time` int(11) NOT NULL,
  `login_ip` varchar(50) NOT NULL,
  `province` varchar(10) NOT NULL,
  `city` varchar(10) NOT NULL,
  `password_verify` varchar(255) NOT NULL COMMENT '找回密码的验证号',
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `build_count` int(11) NOT NULL COMMENT '发起的拼地数',
  `support_count` int(11) NOT NULL COMMENT '支持的拼地数',
  `focus_count` int(11) NOT NULL COMMENT '关注的拼地数',
  `integrate_id` int(11) NOT NULL,
  `intro` text NOT NULL COMMENT '个人简介',
  `ex_real_name` varchar(255) NOT NULL COMMENT '发布者真实姓名',
  `ex_account_bank` text NOT NULL,
  `ex_account_info` text NOT NULL COMMENT '银行帐号等信息',
  `ex_contact` text NOT NULL COMMENT '联系方式',
  `ex_qq` text NOT NULL,
  `code` varchar(255) NOT NULL,
  `sina_id` varchar(255) NOT NULL,
  `sina_token` varchar(255) NOT NULL,
  `sina_secret` varchar(255) NOT NULL,
  `sina_url` varchar(255) NOT NULL,
  `tencent_id` varchar(255) NOT NULL,
  `tencent_token` varchar(255) NOT NULL,
  `tencent_secret` varchar(255) NOT NULL,
  `tencent_url` varchar(255) NOT NULL,
  `verify` varchar(255) NOT NULL,
  `user_level` int(11) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `user_type` int(11) NOT NULL,
  `is_has_send_success` tinyint(1) NOT NULL,
  `is_bank` tinyint(1) NOT NULL COMMENT '（0表示银行账户信息未提交，1表示银行账户信息提交）',
  `verify_time` int(11) DEFAULT NULL COMMENT '验证发送时间',
  `verify_setting` varchar(255) DEFAULT NULL COMMENT '设置时候的验证码',
  `verify_setting_time` int(11) NOT NULL COMMENT '设置时间',
  `identify_name` varchar(255) NOT NULL COMMENT '身份证名称',
  `identify_number` varchar(255) NOT NULL COMMENT '身份证号码',
  `identify_positive_image` varchar(255) NOT NULL COMMENT '身份证正面',
  `identify_nagative_image` varchar(255) NOT NULL COMMENT '身份证反面',
  `identify_business_licence` varchar(255) NOT NULL COMMENT '营业执照',
  `identify_business_code` varchar(255) NOT NULL COMMENT '组织机构代码证',
  `identify_business_tax` varchar(255) NOT NULL COMMENT '税务登记证',
  `identify_business_name` varchar(255) NOT NULL COMMENT '机构名称',
  `is_investor` tinyint(1) NOT NULL DEFAULT '0' COMMENT '判断是否为投资者，默认0表示非投资者，1表示投资者,2 表示机构投资者',
  `mortgage_money` decimal(20,2) NOT NULL COMMENT '诚意金',
  `investor_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '投资认证是否通过 0 表示未通过，1表示通过审核',
  `investor_status_send` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核结果通知用户，0表示未发送，1表示已发送',
  `break_num` tinyint(1) NOT NULL DEFAULT '0' COMMENT '毁约次数',
  `wx_openid` varchar(255) NOT NULL COMMENT '微信openid',
  `investor_send_info` varchar(255) NOT NULL COMMENT '审核信息',
  `paypassword` varchar(255) NOT NULL COMMENT '提现和支付密码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `is_effect` (`is_effect`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='//用户信息';

-- ----------------------------
-- Records of fanwe_user
-- ----------------------------
INSERT INTO `%DB_PREFIX%user` VALUES ('17', 'fanwe', '6714ccb93be0fda4e51f206b91b46358', '1352227130', '1352227130', '1', '97139915@qq.com', '1200.00', '1417975554', '127.0.0.1', '福建', '福州', '', '1', '3', '1', '1', '0', '方维众筹 - http://zc.fanwe.cn', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '', '0', '0', '0', null, null, '0', '', '', '', '', '', '', '', '', '0', '0.00', '0', '0', '0', '', '', '');
INSERT INTO `%DB_PREFIX%user` VALUES ('18', 'fzmatthew', '6714ccb93be0fda4e51f206b91b46358', '1352229180', '1352229180', '1', 'fanwe@fanwe.com', '980.00', '1352246617', '127.0.0.1', '北京', '东城区', '', '1', '0', '3', '1', '0', '爱旅行的猫，生活在路上', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '', '0', '0', '0', null, null, '0', '', '', '', '', '', '', '', '', '0', '0.00', '0', '0', '0', '', '', '');
INSERT INTO `%DB_PREFIX%user` VALUES ('19', 'test', '098f6bcd4621d373cade4e832627b4f6', '1352230142', '1352230142', '1', 'test@test.com', '0.00', '1352232937', '127.0.0.1', '广东', '江门', '', '0', '0', '10', '0', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '', '0', '0', '0', null, null, '0', '', '', '', '', '', '', '', '', '0', '0.00', '0', '0', '0', '', '', '');

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_bank`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_bank`;
CREATE TABLE `%DB_PREFIX%user_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '体现人（标识ID）',
  `bank_id` int(11) NOT NULL COMMENT '银行(标识ID)',
  `bank_name` varchar(255) NOT NULL,
  `bankcard` varchar(30) NOT NULL COMMENT '卡号',
  `real_name` varchar(20) NOT NULL COMMENT '姓名',
  `region_lv1` varchar(50) NOT NULL,
  `region_lv2` varchar(50) NOT NULL,
  `region_lv3` varchar(50) NOT NULL,
  `region_lv4` varchar(50) NOT NULL,
  `bankzone` varchar(255) NOT NULL COMMENT '开户网点',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `bank_id` (`bank_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fanwe_user_bank
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_consignee`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_consignee`;
CREATE TABLE `%DB_PREFIX%user_consignee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `consignee` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认地址',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='//收件人';

-- ----------------------------
-- Records of fanwe_user_consignee
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_deal_notify`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_deal_notify`;
CREATE TABLE `%DB_PREFIX%user_deal_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `deal_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deal_id_user_id` (`user_id`,`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='//用于发送下单成功的用户与关注用户的项目成功准备队列';

-- ----------------------------
-- Records of fanwe_user_deal_notify
-- ----------------------------
INSERT INTO `%DB_PREFIX%user_deal_notify` VALUES ('20', '18', '55', '1352229388');

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_level`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_level`;
CREATE TABLE `%DB_PREFIX%user_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '等级名',
  `level` int(11) DEFAULT NULL COMMENT '等级大小   大->小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='//用户等级';

-- ----------------------------
-- Records of fanwe_user_level
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_log`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_log`;
CREATE TABLE `%DB_PREFIX%user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL,
  `log_time` int(11) NOT NULL,
  `log_admin_id` int(11) NOT NULL,
  `money` double(20,4) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型 0表示普通的 1表示 加入诚意金 2表示违约扣除诚意金',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=133 DEFAULT CHARSET=utf8 COMMENT='//帐户资金变动日志';

-- ----------------------------
-- Records of fanwe_user_log
-- ----------------------------
INSERT INTO `%DB_PREFIX%user_log` VALUES ('114', '管理员测试充值', '1352229203', '1', '1000.0000', '18', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('115', '支持原创DIY桌面游戏《功夫》《黄金密码》期待您的支持项目支付', '1352229388', '1', '-20.0000', '18', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('116', '管理员测试充值', '1352229989', '1', '2000.0000', '17', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('117', '支持拥有自己的咖啡馆项目支付', '1352230101', '1', '-500.0000', '17', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('118', 'test', '1352230213', '1', '5000.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('119', '支持拥有自己的咖啡馆项目支付', '1352230228', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('120', '支持拥有自己的咖啡馆项目支付', '1352230232', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('121', '支持拥有自己的咖啡馆项目支付', '1352230237', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('122', '支持拥有自己的咖啡馆项目支付', '1352230240', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('123', '支持拥有自己的咖啡馆项目支付', '1352230243', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('124', '支持拥有自己的咖啡馆项目支付', '1352230247', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('125', '支持拥有自己的咖啡馆项目支付', '1352230268', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('126', '支持拥有自己的咖啡馆项目支付', '1352230270', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('127', '支持拥有自己的咖啡馆项目支付', '1352230293', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('128', '继续测试', '1352231510', '1', '5000.0000', '18', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('129', '支持流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！项目支付', '1352231539', '1', '-2000.0000', '18', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('130', '支持流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！项目支付', '1352231631', '1', '-500.0000', '19', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('131', '支持拥有自己的咖啡馆项目支付', '1352231671', '1', '-300.0000', '17', '0');
INSERT INTO `%DB_PREFIX%user_log` VALUES ('132', '支持流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！项目支付', '1352231704', '1', '-3000.0000', '18', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_message`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_message`;
CREATE TABLE `%DB_PREFIX%user_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `message` text NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '该私信所属人ID',
  `dest_user_id` int(11) NOT NULL COMMENT '对方的用户ID（如果user_id是发件人，该ID为收件，反之为发件人ID）',
  `send_user_id` int(11) NOT NULL COMMENT '发件人ID',
  `receive_user_id` int(11) NOT NULL COMMENT '收件人ID',
  `user_name` varchar(255) NOT NULL,
  `dest_user_name` varchar(255) NOT NULL,
  `send_user_name` varchar(255) NOT NULL,
  `receive_user_name` varchar(255) NOT NULL,
  `message_type` enum('inbox','outbox') NOT NULL COMMENT '类型：inbox(收件) outbox(发件)',
  `is_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='// 用户私信';

-- ----------------------------
-- Records of fanwe_user_message
-- ----------------------------
INSERT INTO `%DB_PREFIX%user_message` VALUES ('47', '1352230383', '感谢支持', '18', '19', '18', '19', 'fzmatthew', 'test', 'fzmatthew', 'test', 'outbox', '1');
INSERT INTO `%DB_PREFIX%user_message` VALUES ('48', '1352230383', '感谢支持', '19', '18', '18', '19', 'test', 'fzmatthew', 'fzmatthew', 'test', 'inbox', '0');
INSERT INTO `%DB_PREFIX%user_message` VALUES ('49', '1352230403', '感谢您的支持!!!', '18', '17', '18', '17', 'fzmatthew', 'fanwe', 'fzmatthew', 'fanwe', 'outbox', '1');
INSERT INTO `%DB_PREFIX%user_message` VALUES ('50', '1352230403', '感谢您的支持!!!', '17', '18', '18', '17', 'fanwe', 'fzmatthew', 'fzmatthew', 'fanwe', 'inbox', '0');
INSERT INTO `%DB_PREFIX%user_message` VALUES ('51', '1352230499', '谢谢!!!', '17', '18', '17', '18', 'fanwe', 'fzmatthew', 'fanwe', 'fzmatthew', 'outbox', '1');
INSERT INTO `%DB_PREFIX%user_message` VALUES ('52', '1352230499', '谢谢!!!', '18', '17', '17', '18', 'fzmatthew', 'fanwe', 'fanwe', 'fzmatthew', 'inbox', '0');

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_notify`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_notify`;
CREATE TABLE `%DB_PREFIX%user_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `log_info` text NOT NULL,
  `log_time` int(11) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `url_route` varchar(255) NOT NULL,
  `url_param` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='// 公告';

-- ----------------------------
-- Records of fanwe_user_notify
-- ----------------------------
INSERT INTO `%DB_PREFIX%user_notify` VALUES ('69', '17', '拥有自己的咖啡馆 在 2012-11-07 11:31:10 成功拼到 ¥5,000.00', '1352230271', '0', 'deal#show', 'id=56');
INSERT INTO `%DB_PREFIX%user_notify` VALUES ('70', '19', '拥有自己的咖啡馆 在 2012-11-07 11:31:10 成功拼到 ¥5,000.00', '1352230271', '0', 'deal#show', 'id=56');
INSERT INTO `%DB_PREFIX%user_notify` VALUES ('71', '17', '您参与的拼地拥有自己的咖啡馆回报已发放', '1352230424', '0', 'account#view_order', 'id=66');
INSERT INTO `%DB_PREFIX%user_notify` VALUES ('72', '18', '流浪猫的家—爱天使公益咖啡馆的重建需要大家的力量！ 在 2012-11-07 11:55:04 成功拼到 ¥3,000.00', '1352231704', '0', 'deal#show', 'id=58');

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_refund`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_refund`;
CREATE TABLE `%DB_PREFIX%user_refund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` double(20,4) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL COMMENT '提现申请时间',
  `reply` text NOT NULL COMMENT '提现审核回复',
  `is_pay` tinyint(1) NOT NULL,
  `pay_time` int(11) NOT NULL,
  `memo` text NOT NULL COMMENT '提现的备注',
  `pay_log` text NOT NULL COMMENT '支付说明',
  `user_bank_id` int(11) NOT NULL COMMENT '银行ID',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='// 用户退款';

-- ----------------------------
-- Records of fanwe_user_refund
-- ----------------------------

-- ----------------------------
-- Table structure for `%DB_PREFIX%user_weibo`
-- ----------------------------
DROP TABLE IF EXISTS `%DB_PREFIX%user_weibo`;
CREATE TABLE `%DB_PREFIX%user_weibo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `weibo_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='//微博';

-- ----------------------------
-- Records of fanwe_user_weibo
-- ----------------------------
INSERT INTO `%DB_PREFIX%user_weibo` VALUES ('55', '17', 'http://weibo.com/fzmatthew');
