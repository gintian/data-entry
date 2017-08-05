/*
SQLyog Ultimate v11.26 (32 bit)
MySQL - 5.6.24-log : Database - protal
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*Table structure for table `sys_sms_args` */

DROP TABLE IF EXISTS `sys_sms_args`;

CREATE TABLE `sys_sms_args` (
  `pk_sys_sms_args` int(11) NOT NULL AUTO_INCREMENT,
  `arg_name` varchar(20) NOT NULL COMMENT '属性名',
  `arg_code` varchar(20) NOT NULL COMMENT '属性code',
  `arg_value` varchar(255) NOT NULL COMMENT '属性值，{}起止的为变量',
  `fk_sys_sms_product` int(11) NOT NULL COMMENT '归属产品，0为公用属性',
  `fk_sys_sms_channel` int(11) DEFAULT NULL COMMENT '归属渠道',
  PRIMARY KEY (`pk_sys_sms_args`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `sys_sms_args` */

insert  into `sys_sms_args`(`pk_sys_sms_args`,`arg_name`,`arg_code`,`arg_value`,`fk_sys_sms_product`,`fk_sys_sms_channel`) values (1,'助通科技用户名','username','ZQB888',0,1),(2,'助通科技密码(MD5)','password','0c1756efe940c21967e067e9c8adafd5',0,1),(3,'助通科技产品id','productid','712712',1,1),(4,'助通科技手机号字段','mobile','{mobile}',0,1),(5,'助通科技内容字段','content','{content}',0,1),(6,'助通科技产品id','productid','727727',2,1),(7,'助通科技产品id','productid','777335',3,1),(8,'亚迅汇通用户编号','userID','11',4,2),(9,'亚迅汇通用户密钥','cpKey','CDF4941974C7721F679ED0E2182CA3E0',4,2),(10,'亚迅汇通手机号字段','uPhone','{mobile}',4,2),(11,'亚迅汇通内容字段','content','{content}',4,2);

/*Table structure for table `sys_sms_channel` */

DROP TABLE IF EXISTS `sys_sms_channel`;

CREATE TABLE `sys_sms_channel` (
  `pk_sys_sms_channel` int(11) NOT NULL AUTO_INCREMENT,
  `channel_name` varchar(50) NOT NULL COMMENT '短信通道名',
  `channel_url` varchar(200) NOT NULL COMMENT '请求地址',
  `channel_sign` varchar(20) DEFAULT NULL COMMENT '签名',
  `channel_status` tinyint(4) NOT NULL COMMENT '通道是否启用1是，0否',
  `channel_order` tinyint(2) NOT NULL COMMENT '通道优先级，小数值优先',
  `channel_code` varchar(20) NOT NULL COMMENT '短信通道编码',
  PRIMARY KEY (`pk_sys_sms_channel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_sms_channel` */

insert  into `sys_sms_channel`(`pk_sys_sms_channel`,`channel_name`,`channel_url`,`channel_sign`,`channel_status`,`channel_order`,`channel_code`) values (1,'助通科技','http://www.ztsms.cn/sendSms.do',NULL,1,2,'ZTKJ'),(2,'亚迅汇通','http://121.43.106.228:8060/protFace/subSmsApi.aspx',NULL,0,1,'YXHT');

/*Table structure for table `sys_sms_product` */

DROP TABLE IF EXISTS `sys_sms_product`;

CREATE TABLE `sys_sms_product` (
  `pk_sys_sms_product` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(20) NOT NULL COMMENT '产品名',
  `fk_sys_sms_channel` int(11) NOT NULL,
  `sms_type` varchar(20) NOT NULL COMMENT '产品对应的短信类型，1.验证码SMS_VERIFY_TYPE 2.通知SMS_NOTICE_TYPE 3.营销SMS_MARKET_TYPE 4.通用SMS_ALL_TYPE',
  PRIMARY KEY (`pk_sys_sms_product`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `sys_sms_product` */

insert  into `sys_sms_product`(`pk_sys_sms_product`,`product_name`,`fk_sys_sms_channel`,`sms_type`) values (1,'验证码专用',1,'SMS_VERIFY_TYPE'),(2,'通知专用',1,'SMS_NOTICE_TYPE'),(3,'营销专用',1,'SMS_MARKET_TYPE'),(4,'统一通道',2,'SMS_ALL_TYPE');



DROP TABLE IF EXISTS `sys_sms`;

CREATE TABLE `sys_sms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(1024) NOT NULL COMMENT '短信内容',
  `smsType` int(11) NOT NULL COMMENT '短信类型',
  `toPhones` varchar(1024) NOT NULL COMMENT '接收号码',
  `sendTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '定时发送时间',
  `encode` varchar(1024) DEFAULT NULL COMMENT '自定义扩展号',
  `resStatus` varchar(1024) DEFAULT NULL COMMENT '返回状态',
  `resMsg` varchar(1024) DEFAULT NULL COMMENT '返回信息',
  `sid` varchar(1024) DEFAULT NULL COMMENT 'sid',
  `overLengthIgnore` char(1) DEFAULT NULL COMMENT '内容超70忽略',
  `sendRealTime` char(1) DEFAULT NULL COMMENT '是否实时发送',
  `retryTime` int(11) DEFAULT NULL COMMENT '重发次数',
  `curRetryTime` int(11) DEFAULT NULL COMMENT '当前发送次数',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `recTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '返回时间',
  `status` int(11) DEFAULT NULL COMMENT '消息状态 1.待发送， 2. 发送成功， 3. 发送失败 ',
  `bisExpInfo` varchar(1024) DEFAULT NULL COMMENT '异常信息',
  `originalId` int(10) unsigned DEFAULT NULL COMMENT '原始id，适应与短信内容超长分条发送',
  `fk_sys_sms_channel` int(11) DEFAULT NULL COMMENT '使用的短信通道',
  `isOnlyAm` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否只能早上发送 1.是 0.否',
  `channel_url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `channel_Args` varchar(1000) DEFAULT NULL COMMENT '请求内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
