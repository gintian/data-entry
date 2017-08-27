/*创建系统框架表、初始化系统字典项、资源权限、省市数据*/
SET FOREIGN_KEY_CHECKS = 0;

-- Table "sys_city" DDL
drop table if exists sys_city;

CREATE TABLE `sys_city` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ORDERID` int(11) DEFAULT NULL COMMENT '排序号',
  `NAME` varchar(32) DEFAULT NULL COMMENT '城市名称',
  `PID` int(11) DEFAULT NULL COMMENT '省份id',
  `PHONE_CODE` varchar(4) DEFAULT NULL COMMENT '电话区号',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=392 DEFAULT CHARSET=utf8;


-- Table "sys_provincial" DDL
drop table if exists sys_provincial;

CREATE TABLE `sys_provincial` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `wm` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;


-- Table "sys_auth" DDL
drop table if exists sys_auth;

CREATE TABLE `sys_auth` (
  `authId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menuId` int(10) unsigned DEFAULT NULL,
  `authName` varchar(16) NOT NULL,
  `authCode` varchar(64) NOT NULL,
  `remark` varchar(512) DEFAULT NULL,
  `status` tinyint(2) unsigned DEFAULT NULL,
  PRIMARY KEY (`authId`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;



-- Table "sys_dept" DDL
drop table if exists sys_dept;

CREATE TABLE `sys_dept` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `deptName` varchar(64) NOT NULL COMMENT '部门名称',
  `deptCode` varchar(32) NOT NULL COMMENT '部门编码',
  `orderNo` int(4) DEFAULT NULL COMMENT '排序',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `pid` bigint(10) NOT NULL COMMENT '父id',
  `deptTel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `deptAddr` varchar(128) DEFAULT NULL COMMENT '联系地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


-- Table "sys_dict" DDL
drop table if exists sys_dict;

CREATE TABLE `sys_dict` (
  `dictId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dictName` varchar(64) NOT NULL,
  `dictCode` varchar(32) NOT NULL,
  `dictType` tinyint(4) NOT NULL,
  `remark` varchar(512) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`dictId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;


-- Table "sys_dict_item" DDL
drop table if exists sys_dict_item;

CREATE TABLE `sys_dict_item` (
  `dictItemId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dictId` int(10) unsigned NOT NULL,
  `itemName` varchar(64) NOT NULL,
  `itemCode` varchar(64) NOT NULL,
  `itemVal` varchar(1024) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `orderNo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`dictItemId`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;


-- Table "sys_file_info" DDL
drop table if exists sys_file_info;

CREATE TABLE `sys_file_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fileName` varchar(1024) NOT NULL COMMENT '文件名',
  `fileType` int(2) NOT NULL COMMENT '文件类型',
  `realFileName` varchar(64) NOT NULL COMMENT '原文件名',
  `fileSuffix` varchar(16) NOT NULL COMMENT '文件后缀名',
  `filePath` varchar(256) NOT NULL COMMENT '文件路径',
  `absolutePath` varchar(256) DEFAULT NULL COMMENT '绝对路径',
  `urlPath` varchar(256) NOT NULL COMMENT 'url访问地址',
  `saveWay` int(2) NOT NULL COMMENT '保存方式',
  `width` int(6) DEFAULT NULL COMMENT '图片宽度',
  `height` int(6) DEFAULT NULL COMMENT '图片高度',
  `fileSize` bigint(10) NOT NULL COMMENT '文件大小',
  `originalImgId` bigint(10) DEFAULT NULL COMMENT '原始图Id',
  `extInfo` varchar(512) DEFAULT NULL COMMENT '扩展信息',
  `creator` bigint(10) DEFAULT NULL COMMENT '创建人',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;


-- Table "sys_log" DDL
drop table if exists sys_log;

CREATE TABLE `sys_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `opt` varchar(64) DEFAULT NULL,
  `cnName` varchar(128) DEFAULT NULL,
  `tableName` varchar(64) DEFAULT NULL,
  `uri` varchar(128) DEFAULT NULL,
  `datas` longtext,
  `ip` varchar(15) DEFAULT NULL,
  `createTime` bigint(15) DEFAULT NULL,
  `creator` int(10) DEFAULT NULL,
  `callOrder` int(4) unsigned DEFAULT NULL,
  `methodCostTime` int(6) unsigned DEFAULT NULL,
  `costTime` int(6) unsigned DEFAULT NULL,
  `rsType` int(2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2998 DEFAULT CHARSET=utf8;


-- Table "sys_menu" DDL
drop table if exists sys_menu;

CREATE TABLE `sys_menu` (
  `menuId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(10) unsigned DEFAULT NULL,
  `menuName` varchar(64) DEFAULT NULL,
  `menuType` tinyint(4) DEFAULT NULL,
  `menuUrl` varchar(255) DEFAULT NULL,
  `inco` varchar(128) DEFAULT NULL,
  `openType` tinyint(4) DEFAULT NULL,
  `orderNo` int(6) DEFAULT NULL,
  `openState` tinyint(4) DEFAULT NULL,
  `isPublic` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`menuId`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Table "sys_resource" DDL
drop table if exists sys_resource;

CREATE TABLE `sys_resource` (
  `resId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `authId` int(10) unsigned DEFAULT NULL COMMENT '所属权限',
  `url` varchar(255) DEFAULT NULL,
  `info` varchar(512) DEFAULT NULL,
  `authType` int(2) unsigned DEFAULT NULL,
  PRIMARY KEY (`resId`)
) ENGINE=InnoDB AUTO_INCREMENT=500 DEFAULT CHARSET=utf8;


-- Table "sys_role" DDL
drop table if exists sys_role;

CREATE TABLE `sys_role` (
  `roleId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleName` varchar(16) DEFAULT NULL,
  `roleCode` varchar(64) DEFAULT NULL COMMENT '角色编码',
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;



-- Table "sys_role_auth" DDL
drop table if exists sys_role_auth;

CREATE TABLE `sys_role_auth` (
  `roleAuthId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleId` int(10) unsigned DEFAULT NULL,
  `authId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`roleAuthId`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;


-- Table "sys_sms" DDL
DROP TABLE IF EXISTS sys_sms;

CREATE TABLE `sys_sms` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(1024) NOT NULL COMMENT '短信内容',
  `smsType` INT(11) NOT NULL COMMENT '短信类型',
  `toPhones` VARCHAR(1024) NOT NULL COMMENT '接收号码',
  `sendTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '定时发送时间',
  `encode` VARCHAR(1024) DEFAULT NULL COMMENT '自定义扩展号',
  `resStatus` VARCHAR(1024) DEFAULT NULL COMMENT '返回状态',
  `resMsg` VARCHAR(1024) DEFAULT NULL COMMENT '返回信息',
  `sid` VARCHAR(1024) DEFAULT NULL COMMENT 'sid',
  `overLengthIgnore` CHAR(1) DEFAULT NULL COMMENT '内容超70忽略',
  `sendRealTime` CHAR(1) DEFAULT NULL COMMENT '是否实时发送',
  `retryTime` INT(11) DEFAULT NULL COMMENT '重发次数',
  `curRetryTime` INT(11) DEFAULT NULL COMMENT '当前发送次数',
  `createTime` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `recTime` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '返回时间',
  `status` INT(11) DEFAULT NULL COMMENT '消息状态 1.待发送， 2. 发送成功， 3. 发送失败 ',
  `bisExpInfo` VARCHAR(1024) DEFAULT NULL COMMENT '异常信息',
  `originalId` INT(10) UNSIGNED DEFAULT NULL COMMENT '原始id，适应与短信内容超长分条发送',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


-- Table "sys_user" DDL
drop table if exists sys_user;

CREATE TABLE `sys_user` (
  `userId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userName` varchar(16) NOT NULL COMMENT '用户名',
  `password` varchar(64) NOT NULL COMMENT '密码',
  `realName` varchar(32) DEFAULT NULL,
  `deptId` int(10) NOT NULL,
  `email` varchar(32) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL,
  `createUserId` int(10) unsigned DEFAULT NULL,
  `lastLoginTime` timestamp NULL DEFAULT NULL,
  `loginIp` varchar(64) DEFAULT NULL,
  `addOn` varchar(1024) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `userType` tinyint(4) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL,
  `isAdmin` char(1) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;


-- Table "sys_user_role" DDL
drop table if exists sys_user_role;

CREATE TABLE `sys_user_role` (
  `userRoleId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned DEFAULT NULL,
  `roleId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`userRoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- add datas

-- 系统权限
INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (1, 3, '新增用户', 'USER_SAVE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (2, 4, '新增角色', 'ROLE_SAVE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (4, 3, '修改用户', 'USER_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (5, 4, '修改角色', 'ROLE_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (6, 3, '删除用户', 'USER_DEL', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (7, 3, '重置密码', 'USER_PASS_REST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (8, 3, '启禁用户', 'USER_STATUS', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (9, 3, '分配角色', 'USER_ROLE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (10, 3, '查看用户', 'USER_VIEW', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (11, 4, '删除角色', 'ROLE_DEL', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (12, 4, '分配权限', 'ROLE_AUTH', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (13, 4, '查看角色', 'ROLE_VIEW', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (14, 5, '新增菜单', 'MENU_SAVE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (15, 5, '修改菜单', 'MENU_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (16, 5, '删除菜单', 'MENU_DEL', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (17, 5, '查看菜单', 'MENU_VIEW', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (18, 7, '新增权限', 'AUTH_SAVE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (19, 7, '修改权限', 'AUTH_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (20, 7, '删除权限', 'AUTH_DEL', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (21, 7, '查看权限', 'AUTH_VIEW', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (22, 6, '新增字典', 'DICT_SAVE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (23, 6, '修改字典', 'DICT_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (24, 6, '删除字典', 'DICT_DEL', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (25, 6, '新增元素', 'ITEM_SAVE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (26, 6, '修改元素', 'ITEM_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (27, 6, '删除元素', 'ITEM_DEL', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (28, 6, '查看元素', 'ITEM_VIEW', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (29, 4, '启禁角色', 'ROLE_STATUS', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (30, 6, '启禁元素', 'ITEM_STATUS', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (31, 10, '新增部门', 'DEPT_SAVE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (32, 10, '修改部门', 'DEPT_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (33, 10, '查询部门', 'DEPT_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (34, 4, '查询角色', 'ROLE_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (35, 10, '删除部门', 'DEPT_DEL', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (36, 3, '查询用户', 'USER_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (37, 5, '查询菜单', 'MENU_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (38, 7, '查询权限', 'AUTH_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (39, 13, '修改资源', 'RESOURCE_UPDATE', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (40, 13, '查询资源', 'ROSOURCE_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (41, 6, '查询字典', 'DICT_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (42, 11, '日志查询', 'LOG_LIST', '', 1);

INSERT INTO sys_auth
   (`authId`, `menuId`, `authName`, `authCode`, `remark`, `status`)
VALUES
   (43, 7, '选择资源', 'AUTH_SEL', '', 1);

-- 资源
INSERT INTO `sys_resource` VALUES ('83', '16', '/menu/doDelete', '', '2');
INSERT INTO `sys_resource` VALUES ('84', '14', '/menu/doSave', '', '2');
INSERT INTO `sys_resource` VALUES ('85', '37', '/menu/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('86', '37', '/menu/goTree', '', '2');
INSERT INTO `sys_resource` VALUES ('87', '14', '/menu/goSave', '', '2');
INSERT INTO `sys_resource` VALUES ('88', '15', '/menu/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('89', '17', '/menu/goView', '', '2');
INSERT INTO `sys_resource` VALUES ('90', '15', '/menu/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('91', null, '/main', '系统主页', '1');
INSERT INTO `sys_resource` VALUES ('92', null, '/login', '用户登录', '1');
INSERT INTO `sys_resource` VALUES ('93', null, '/loginOut', '', '1');
INSERT INTO `sys_resource` VALUES ('94', '6', '/user/doDelete', '', '2');
INSERT INTO `sys_resource` VALUES ('95', '1', '/user/doSave', '', '2');
INSERT INTO `sys_resource` VALUES ('96', '36', '/user/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('97', '36', '/user/goTree', '', '2');
INSERT INTO `sys_resource` VALUES ('98', '1', '/user/goSave', '', '2');
INSERT INTO `sys_resource` VALUES ('99', '4', '/user/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('100', '10', '/user/goView', '', '2');
INSERT INTO `sys_resource` VALUES ('101', '4', '/user/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('102', '8', '/user/doChangeState', '', '2');
INSERT INTO `sys_resource` VALUES ('103', '9', '/user/goSetUserRole', '', '2');
INSERT INTO `sys_resource` VALUES ('104', null, '/user/goChangePassword', '', '1');
INSERT INTO `sys_resource` VALUES ('105', null, '/user/doChangePassword', '', '1');
INSERT INTO `sys_resource` VALUES ('106', '7', '/user/doRestPassword', '', '2');
INSERT INTO `sys_resource` VALUES ('107', '9', '/user/doSetUserRole', '', '2');
INSERT INTO `sys_resource` VALUES ('108', '11', '/role/doDelete', '', '2');
INSERT INTO `sys_resource` VALUES ('109', '2', '/role/doSave', '', '2');
INSERT INTO `sys_resource` VALUES ('110', '34', '/role/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('111', '2', '/role/goSave', '', '2');
INSERT INTO `sys_resource` VALUES ('112', '5', '/role/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('113', '13', '/role/goView', '', '2');
INSERT INTO `sys_resource` VALUES ('114', '5', '/role/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('115', '29', '/role/doChangeState', '', '2');
INSERT INTO `sys_resource` VALUES ('116', '12', '/role/goSetRoleAuth', '', '2');
INSERT INTO `sys_resource` VALUES ('117', '12', '/role/doSetRoleAuth', '', '2');
INSERT INTO `sys_resource` VALUES ('118', '40', '/resource/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('119', '40', '/resource/goTree', '', '2');
INSERT INTO `sys_resource` VALUES ('120', '39', '/resource/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('121', '39', '/resource/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('122', null, '/code/doSave', '代码生产', '3');
INSERT INTO `sys_resource` VALUES ('123', null, '/code/goList', '代码生产', '3');
INSERT INTO `sys_resource` VALUES ('124', null, '/code/doFtl', '代码生产', '3');
INSERT INTO `sys_resource` VALUES ('125', null, '/code/doClear', '代码生产', '3');
INSERT INTO `sys_resource` VALUES ('126', '35', '/dept/doDelete', '', '2');
INSERT INTO `sys_resource` VALUES ('127', '31', '/dept/doSave', '', '2');
INSERT INTO `sys_resource` VALUES ('128', '33', '/dept/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('129', '33', '/dept/goTree', '', '2');
INSERT INTO `sys_resource` VALUES ('130', '31', '/dept/goSave', '', '2');
INSERT INTO `sys_resource` VALUES ('131', '32', '/dept/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('132', '33', '/dept/goView', '', '2');
INSERT INTO `sys_resource` VALUES ('133', '32', '/dept/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('134', '19', '/auth/doDelete', '', '2');
INSERT INTO `sys_resource` VALUES ('135', '18', '/auth/doSave', '', '2');
INSERT INTO `sys_resource` VALUES ('136', '38', '/auth/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('137', '38', '/auth/goTree', '', '2');
INSERT INTO `sys_resource` VALUES ('138', '18', '/auth/goSave', '', '2');
INSERT INTO `sys_resource` VALUES ('139', '18', '/auth/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('140', '21', '/auth/goView', '', '2');
INSERT INTO `sys_resource` VALUES ('141', '18', '/auth/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('142', '27', '/dictItem/doDelete', '', '2');
INSERT INTO `sys_resource` VALUES ('143', '25', '/dictItem/doSave', '', '2');
INSERT INTO `sys_resource` VALUES ('144', '41', '/dictItem/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('145', '25', '/dictItem/goSave', '', '2');
INSERT INTO `sys_resource` VALUES ('146', '26', '/dictItem/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('147', '28', '/dictItem/goView', '', '2');
INSERT INTO `sys_resource` VALUES ('148', '26', '/dictItem/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('149', '30', '/dictItem/doChangeState', '', '2');
INSERT INTO `sys_resource` VALUES ('150', null, '/doFlushDictCache', '刷新字典配置', '3');
INSERT INTO `sys_resource` VALUES ('151', null, '/doFlushAuthCache', '刷新系统权限', '3');
INSERT INTO `sys_resource` VALUES ('152', null, '/doFlushAuthUris', '刷新权限URL信息', '3');
INSERT INTO `sys_resource` VALUES ('153', null, '/goWhoAreOnline', '显示所有在线用户', '3');
INSERT INTO `sys_resource` VALUES ('154', null, '/doForceLoginOut', '强制用户退出登录', '3');
INSERT INTO `sys_resource` VALUES ('155', '42', '/log/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('156', '42', '/log/goView', '', '2');
INSERT INTO `sys_resource` VALUES ('157', '24', '/dict/doDelete', '', '2');
INSERT INTO `sys_resource` VALUES ('158', '22', '/dict/doSave', '', '2');
INSERT INTO `sys_resource` VALUES ('159', '41', '/dict/goList', '', '2');
INSERT INTO `sys_resource` VALUES ('160', '41', '/dict/goTree', '', '2');
INSERT INTO `sys_resource` VALUES ('161', '22', '/dict/goSave', '', '2');
INSERT INTO `sys_resource` VALUES ('162', '23', '/dict/goUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('163', '23', '/dict/doUpdate', '', '2');
INSERT INTO `sys_resource` VALUES ('164', null, '/goAdmin', '管理员配置菜单', '3');
INSERT INTO `sys_resource` VALUES ('165', '43', '/resource/doSelRes', '', '2');
INSERT INTO `sys_resource` VALUES ('166', '43', '/resource/goSelList', '', '2');
INSERT INTO `sys_resource` VALUES ('167', null, '/user/goUserMainPage', '用户个人主页', '1');

-- 字典
INSERT INTO `sys_dict` VALUES ('1', '系统配置', 'DICT_SYS_CONF', '0', '系统公共配置', '1');
INSERT INTO `sys_dict` VALUES ('2', '豁免地址', 'DICT_FREE_URL', '0', '不会被权限系统拦截验证', '1');
INSERT INTO `sys_dict` VALUES ('4', '文件上传', 'DICT_FILE', '0', '', '1');
INSERT INTO `sys_dict` VALUES ('5', '短信', 'SMS', '0', '', '1');
INSERT INTO `sys_dict` VALUES ('6', '短信返回状态', 'SMS_STATUS_CODE', '0', '', '1');

-- 字典项
INSERT INTO `sys_dict_item` VALUES ('1', '1', '开启登录验证', 'VERITY_CODE_FLAG', 'false', '1', '1', '1');
INSERT INTO `sys_dict_item` VALUES ('3', '1', '单用户登录', 'ONLY_SINGLE_LOGIN', 'false', '', '1', '3');
INSERT INTO `sys_dict_item` VALUES ('11', '1', '刷新权限', 'ITEM_FLUSH_AUTH', 'auto', '自动刷新 auto  手动刷新  hand', '1', '6');
INSERT INTO `sys_dict_item` VALUES ('12', '1', '部门根节点名称', 'ITEM_DEPT_ROOT', '部门', '', '1', '7');
INSERT INTO `sys_dict_item` VALUES ('13', '4', '默认文件夹', 'ITEM_FILE_DIR', 'upload', '', '1', '1');
INSERT INTO `sys_dict_item` VALUES ('14', '4', '文件公共路径', 'ITEM_FILE_PUB_DIRS', 'file/', '', '1', '2');
INSERT INTO `sys_dict_item` VALUES ('15', '1', '开启自动登录', 'AUTO_LOGIN_FLAG', 'true', '', '1', '1');

INSERT INTO `sys_dict_item` VALUES ('83', '4', '默认文件夹', 'ITEM_FILE_DIR', 'upload', '', '1', '1');
INSERT INTO `sys_dict_item` VALUES ('84', '4', '文件公共路径', 'ITEM_FILE_PUB_DIRS', 'file/', '', '1', '2');
INSERT INTO `sys_dict_item` VALUES ('85', '1', '会员默认密码', 'DEFAULT_PASSWORD', '88888888', '', '1', '6');
INSERT INTO `sys_dict_item` VALUES ('86', '5', '短信发送地址', 'SMS_SEND_URL', 'http://116.213.72.20/SMSHttpService/send.aspx', '', '1', '1');
INSERT INTO `sys_dict_item` VALUES ('87', '5', '短信接收回复地址', 'SMS_RECV_URL', 'http://116.213.72.20/SMSHttpService/getmsg.aspx', '', '1', '2');
INSERT INTO `sys_dict_item` VALUES ('88', '5', '短信余额查询地址', 'SMS_MONEY_URL', 'http://116.213.72.20/SMSHttpService/Balance.aspx', '', '1', '3');
INSERT INTO `sys_dict_item` VALUES ('89', '5', '用户名', 'SMS_UID', 'byjr3', '', '1', '4');
INSERT INTO `sys_dict_item` VALUES ('90', '5', '用户密码', 'SMS_PWD', 'byjr3', '', '1', '5');
INSERT INTO `sys_dict_item` VALUES ('91', '5', '短信线程一次发送记录数', 'SMS_SCAN_LIMIT', '10', '', '1', '6');
INSERT INTO `sys_dict_item` VALUES ('92', '5', '短信线程扫描间隔', 'SMS_SCAN_INTERVAL', '60000', '毫秒', '1', '7');
INSERT INTO `sys_dict_item` VALUES ('100', '5', '短信签名', 'SMS_SIGN', '', '', '1', '8');
INSERT INTO `sys_dict_item` VALUES ('101', '5', '短信返回成功码', 'SMS_SUCCESS_CODE', '0', '', '1', '9');
INSERT INTO `sys_dict_item` VALUES ('93', '6', '成送成功', '0', '', '', '1', '1');
INSERT INTO `sys_dict_item` VALUES ('94', '6', '当前账号余额不足', '1002', '', '', '1', '2');
INSERT INTO `sys_dict_item` VALUES ('95', '6', '当前用户密码错误', '1001', '', '', '1', '3');
INSERT INTO `sys_dict_item` VALUES ('96', '6', '参数错误,请输入完整的参数', '1003', '', '', '1', '4');
INSERT INTO `sys_dict_item` VALUES ('97', '6', '手机号码格式不对', '-2', '', '', '1', '5');
INSERT INTO `sys_dict_item` VALUES ('98', '6', '数据保存失败', '-1', '', '', '1', '6');
INSERT INTO `sys_dict_item` VALUES ('99', '6', '其他错误', '1004', '', '', '1', '7');

-- 菜单
INSERT INTO `sys_menu` VALUES ('2', '0', '系统管理', '1', '', '', '1', '30', '1', '0');
INSERT INTO `sys_menu` VALUES ('3', '2', '用户管理', '3', '/user/goTree', '', '1', '1', '1', '0');
INSERT INTO `sys_menu` VALUES ('4', '2', '角色管理', '3', '/role/goList', '', '1', '2', '1', '0');
INSERT INTO `sys_menu` VALUES ('5', '2', '菜单管理', '3', '/menu/goTree', '', '1', '3', '1', '0');
INSERT INTO `sys_menu` VALUES ('6', '2', '字典管理', '3', '/dict/goTree', '', '1', '4', '1', '0');
INSERT INTO `sys_menu` VALUES ('7', '2', '权限管理', '3', '/auth/goTree', '', '1', '5', '1', '0');
INSERT INTO `sys_menu` VALUES ('10', '2', '组织管理', '3', '/dept/goTree', '', '1', '6', '1', '0');
INSERT INTO `sys_menu` VALUES ('11', '2', '日志查看', '3', '/log/goList', '', '1', '7', '1', '0');
INSERT INTO `sys_menu` VALUES ('13', '2', '资源管理', '3', '/resource/goTree', '', '1', '8', '1', '0');
INSERT INTO `sys_menu` VALUES ('14', '2', '缓存管理', '3', '/goAdmin', '', '1', '9', '1', '0');

-- 用户
INSERT INTO `sys_user` VALUES ('1', 'admin', '96e79218965eb72c92a549dd5a330112', '超级管理员', '0', '', '18605919378', null, '0', '2014-10-20 01:16:01', '127.0.0.1', '1', '1', '1', '1', '1');
 
 
-- 省份、城市
INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (1, '北京市', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (2, '天津市', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (3, '上海市', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (4, '重庆市', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (5, '河北省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (6, '山西省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (7, '台湾省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (8, '辽宁省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (9, '吉林省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (10, '黑龙江省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (11, '江苏省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (12, '浙江省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (13, '安徽省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (14, '福建省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (15, '江西省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (16, '山东省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (17, '河南省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (18, '湖北省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (19, '湖南省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (20, '广东省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (21, '甘肃省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (22, '四川省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (23, '贵州省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (24, '海南省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (25, '云南省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (26, '青海省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (27, '陕西省', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (28, '广西壮族自治区', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (29, '西藏自治区', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (30, '宁夏回族自治区', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (31, '新疆维吾尔自治区', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (32, '内蒙古自治区', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (33, '澳门特别行政区', NULL);

INSERT INTO sys_provincial
   (`id`, `name`, `wm`)
VALUES
   (34, '香港特别行政区', NULL);



INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (1, 1, '北京市', 1, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (2, 1, '天津市', 2, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (3, 1, '上海市', 3, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (4, 1, '重庆市', 4, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (5, 1, '石家庄市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (6, 2, '唐山市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (7, 3, '秦皇岛市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (8, 4, '邯郸市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (9, 5, '邢台市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (10, 6, '保定市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (11, 7, '张家口市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (12, 8, '承德市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (13, 9, '沧州市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (14, 10, '廊坊市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (15, 11, '衡水市', 5, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (16, 1, '太原市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (17, 2, '大同市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (18, 3, '阳泉市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (19, 4, '长治市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (20, 5, '晋城市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (21, 6, '朔州市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (22, 7, '晋中市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (23, 8, '运城市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (24, 9, '忻州市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (25, 10, '临汾市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (26, 11, '吕梁市', 6, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (27, 1, '台北市', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (28, 2, '高雄市', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (29, 3, '基隆市', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (30, 4, '台中市', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (31, 5, '台南市', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (32, 6, '新竹市', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (33, 7, '嘉义市', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (34, 8, '台北县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (35, 9, '宜兰县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (36, 10, '桃园县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (37, 11, '新竹县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (38, 12, '苗栗县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (39, 13, '台中县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (40, 14, '彰化县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (41, 15, '南投县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (42, 16, '云林县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (43, 17, '嘉义县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (44, 18, '台南县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (45, 19, '高雄县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (46, 20, '屏东县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (47, 21, '澎湖县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (48, 22, '台东县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (49, 23, '花莲县', 7, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (50, 1, '沈阳市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (51, 2, '大连市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (52, 3, '鞍山市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (53, 4, '抚顺市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (54, 5, '本溪市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (55, 6, '丹东市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (56, 7, '锦州市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (57, 8, '营口市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (58, 9, '阜新市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (59, 10, '辽阳市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (60, 11, '盘锦市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (61, 12, '铁岭市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (62, 13, '朝阳市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (63, 14, '葫芦岛市', 8, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (64, 1, '长春市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (65, 2, '吉林市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (66, 3, '四平市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (67, 4, '辽源市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (68, 5, '通化市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (69, 6, '白山市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (70, 7, '松原市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (71, 8, '白城市', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (72, 9, '延边朝鲜族自治州', 9, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (73, 1, '哈尔滨市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (74, 2, '齐齐哈尔市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (75, 3, '鹤 岗 市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (76, 4, '双鸭山市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (77, 5, '鸡 西 市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (78, 6, '大 庆 市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (79, 7, '伊 春 市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (80, 8, '牡丹江市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (81, 9, '佳木斯市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (82, 10, '七台河市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (83, 11, '黑 河 市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (84, 12, '绥 化 市', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (85, 13, '大兴安岭地区', 10, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (86, 1, '南京市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (87, 2, '无锡市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (88, 3, '徐州市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (89, 4, '常州市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (90, 5, '苏州市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (91, 6, '南通市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (92, 7, '连云港市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (93, 8, '淮安市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (94, 9, '盐城市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (95, 10, '扬州市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (96, 11, '镇江市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (97, 12, '泰州市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (98, 13, '宿迁市', 11, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (99, 1, '杭州市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (100, 2, '宁波市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (101, 3, '温州市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (102, 4, '嘉兴市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (103, 5, '湖州市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (104, 6, '绍兴市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (105, 7, '金华市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (106, 8, '衢州市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (107, 9, '舟山市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (108, 10, '台州市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (109, 11, '丽水市', 12, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (110, 1, '合肥市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (111, 2, '芜湖市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (112, 3, '蚌埠市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (113, 4, '淮南市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (114, 5, '马鞍山市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (115, 6, '淮北市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (116, 7, '铜陵市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (117, 8, '安庆市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (118, 9, '黄山市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (119, 10, '滁州市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (120, 11, '阜阳市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (121, 12, '宿州市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (122, 13, '巢湖市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (123, 14, '六安市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (124, 15, '亳州市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (125, 16, '池州市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (126, 17, '宣城市', 13, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (127, 1, '福州市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (128, 2, '厦门市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (129, 3, '莆田市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (130, 4, '三明市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (131, 5, '泉州市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (132, 6, '漳州市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (133, 7, '南平市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (134, 8, '龙岩市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (135, 9, '宁德市', 14, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (136, 1, '南昌市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (137, 2, '景德镇市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (138, 3, '萍乡市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (139, 4, '九江市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (140, 5, '新余市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (141, 6, '鹰潭市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (142, 7, '赣州市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (143, 8, '吉安市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (144, 9, '宜春市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (145, 10, '抚州市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (146, 11, '上饶市', 15, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (147, 1, '济南市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (148, 2, '青岛市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (149, 3, '淄博市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (150, 4, '枣庄市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (151, 5, '东营市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (152, 6, '烟台市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (153, 7, '潍坊市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (154, 8, '济宁市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (155, 9, '泰安市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (156, 10, '威海市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (157, 11, '日照市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (158, 12, '莱芜市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (159, 13, '临沂市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (160, 14, '德州市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (161, 15, '聊城市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (162, 16, '滨州市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (163, 17, '菏泽市', 16, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (164, 1, '郑州市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (165, 2, '开封市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (166, 3, '洛阳市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (167, 4, '平顶山市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (168, 5, '安阳市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (169, 6, '鹤壁市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (170, 7, '新乡市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (171, 8, '焦作市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (172, 9, '濮阳市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (173, 10, '许昌市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (174, 11, '漯河市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (175, 12, '三门峡市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (176, 13, '南阳市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (177, 14, '商丘市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (178, 15, '信阳市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (179, 16, '周口市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (180, 17, '驻马店市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (181, 18, '济源市', 17, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (182, 1, '武汉市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (183, 2, '黄石市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (184, 3, '十堰市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (185, 4, '荆州市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (186, 5, '宜昌市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (187, 6, '襄樊市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (188, 7, '鄂州市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (189, 8, '荆门市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (190, 9, '孝感市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (191, 10, '黄冈市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (192, 11, '咸宁市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (193, 12, '随州市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (194, 13, '仙桃市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (195, 14, '天门市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (196, 15, '潜江市', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (197, 16, '神农架林区', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (198, 17, '恩施土家族苗族自治州', 18, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (199, 1, '长沙市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (200, 2, '株洲市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (201, 3, '湘潭市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (202, 4, '衡阳市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (203, 5, '邵阳市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (204, 6, '岳阳市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (205, 7, '常德市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (206, 8, '张家界市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (207, 9, '益阳市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (208, 10, '郴州市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (209, 11, '永州市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (210, 12, '怀化市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (211, 13, '娄底市', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (212, 14, '湘西土家族苗族自治州', 19, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (213, 1, '广州市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (214, 2, '深圳市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (215, 3, '珠海市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (216, 4, '汕头市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (217, 5, '韶关市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (218, 6, '佛山市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (219, 7, '江门市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (220, 8, '湛江市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (221, 9, '茂名市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (222, 10, '肇庆市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (223, 11, '惠州市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (224, 12, '梅州市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (225, 13, '汕尾市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (226, 14, '河源市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (227, 15, '阳江市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (228, 16, '清远市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (229, 17, '东莞市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (230, 18, '中山市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (231, 19, '潮州市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (232, 20, '揭阳市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (233, 21, '云浮市', 20, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (234, 1, '兰州市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (235, 2, '金昌市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (236, 3, '白银市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (237, 4, '天水市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (238, 5, '嘉峪关市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (239, 6, '武威市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (240, 7, '张掖市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (241, 8, '平凉市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (242, 9, '酒泉市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (243, 10, '庆阳市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (244, 11, '定西市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (245, 12, '陇南市', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (246, 13, '临夏回族自治州', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (247, 14, '甘南藏族自治州', 21, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (248, 1, '成都市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (249, 2, '自贡市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (250, 3, '攀枝花市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (251, 4, '泸州市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (252, 5, '德阳市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (253, 6, '绵阳市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (254, 7, '广元市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (255, 8, '遂宁市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (256, 9, '内江市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (257, 10, '乐山市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (258, 11, '南充市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (259, 12, '眉山市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (260, 13, '宜宾市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (261, 14, '广安市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (262, 15, '达州市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (263, 16, '雅安市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (264, 17, '巴中市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (265, 18, '资阳市', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (266, 19, '阿坝藏族羌族自治州', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (267, 20, '甘孜藏族自治州', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (268, 21, '凉山彝族自治州', 22, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (269, 1, '贵阳市', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (270, 2, '六盘水市', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (271, 3, '遵义市', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (272, 4, '安顺市', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (273, 5, '铜仁地区', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (274, 6, '毕节地区', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (275, 7, '黔西南布依族苗族自治州', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (276, 8, '黔东南苗族侗族自治州', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (277, 9, '黔南布依族苗族自治州', 23, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (278, 1, '海口市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (279, 2, '三亚市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (280, 3, '五指山市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (281, 4, '琼海市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (282, 5, '儋州市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (283, 6, '文昌市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (284, 7, '万宁市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (285, 8, '东方市', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (286, 9, '澄迈县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (287, 10, '定安县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (288, 11, '屯昌县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (289, 12, '临高县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (290, 13, '白沙黎族自治县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (291, 14, '昌江黎族自治县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (292, 15, '乐东黎族自治县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (293, 16, '陵水黎族自治县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (294, 17, '保亭黎族苗族自治县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (295, 18, '琼中黎族苗族自治县', 24, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (296, 1, '昆明市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (297, 2, '曲靖市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (298, 3, '玉溪市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (299, 4, '保山市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (300, 5, '昭通市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (301, 6, '丽江市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (302, 7, '思茅市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (303, 8, '临沧市', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (304, 9, '文山壮族苗族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (305, 10, '红河哈尼族彝族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (306, 11, '西双版纳傣族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (307, 12, '楚雄彝族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (308, 13, '大理白族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (309, 14, '德宏傣族景颇族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (310, 15, '怒江傈傈族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (311, 16, '迪庆藏族自治州', 25, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (312, 1, '西宁市', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (313, 2, '海东地区', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (314, 3, '海北藏族自治州', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (315, 4, '黄南藏族自治州', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (316, 5, '海南藏族自治州', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (317, 6, '果洛藏族自治州', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (318, 7, '玉树藏族自治州', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (319, 8, '海西蒙古族藏族自治州', 26, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (320, 1, '西安市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (321, 2, '铜川市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (322, 3, '宝鸡市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (323, 4, '咸阳市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (324, 5, '渭南市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (325, 6, '延安市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (326, 7, '汉中市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (327, 8, '榆林市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (328, 9, '安康市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (329, 10, '商洛市', 27, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (330, 1, '南宁市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (331, 2, '柳州市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (332, 3, '桂林市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (333, 4, '梧州市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (334, 5, '北海市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (335, 6, '防城港市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (336, 7, '钦州市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (337, 8, '贵港市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (338, 9, '玉林市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (339, 10, '百色市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (340, 11, '贺州市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (341, 12, '河池市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (342, 13, '来宾市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (343, 14, '崇左市', 28, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (344, 1, '拉萨市', 29, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (345, 2, '那曲地区', 29, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (346, 3, '昌都地区', 29, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (347, 4, '山南地区', 29, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (348, 5, '日喀则地区', 29, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (349, 6, '阿里地区', 29, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (350, 7, '林芝地区', 29, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (351, 1, '银川市', 30, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (352, 2, '石嘴山市', 30, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (353, 3, '吴忠市', 30, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (354, 4, '固原市', 30, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (355, 5, '中卫市', 30, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (356, 1, '乌鲁木齐市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (357, 2, '克拉玛依市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (358, 3, '石河子市　', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (359, 4, '阿拉尔市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (360, 5, '图木舒克市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (361, 6, '五家渠市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (362, 7, '吐鲁番市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (363, 8, '阿克苏市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (364, 9, '喀什市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (365, 10, '哈密市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (366, 11, '和田市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (367, 12, '阿图什市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (368, 13, '库尔勒市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (369, 14, '昌吉市　', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (370, 15, '阜康市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (371, 16, '米泉市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (372, 17, '博乐市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (373, 18, '伊宁市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (374, 19, '奎屯市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (375, 20, '塔城市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (376, 21, '乌苏市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (377, 22, '阿勒泰市', 31, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (378, 1, '呼和浩特市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (379, 2, '包头市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (380, 3, '乌海市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (381, 4, '赤峰市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (382, 5, '通辽市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (383, 6, '鄂尔多斯市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (384, 7, '呼伦贝尔市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (385, 8, '巴彦淖尔市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (386, 9, '乌兰察布市', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (387, 10, '锡林郭勒盟', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (388, 11, '兴安盟', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (389, 12, '阿拉善盟', 32, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (390, 1, '澳门特别行政区', 33, NULL);

INSERT INTO sys_city
   (`ID`, `ORDERID`, `NAME`, `PID`, `PHONE_CODE`)
VALUES
   (391, 1, '香港特别行政区', 34, NULL);


/*==============================================================*/
/* Table: SYS_SEQUENCE                                      */
/*==============================================================*/
drop table if exists SYS_SEQUENCE;
   
create table SYS_SEQUENCE
(
   PK_SYS_SEQUENCE     int not null auto_increment comment 'PK_SYS_SEQUENCE',
   CUR_DATE				date not null comment '当前日期',
   CURRENT_VALUE        int not null comment '当前值',
   SEQ_TYPE             tinyint not null comment '序列类型（1收文号序列，2发文号序列）',
   CACHED_SIZE          int comment '缓存大小',
   REMARKS              varchar(24) comment '备注',
   primary key (PK_SYS_SEQUENCE)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8;

alter table SYS_SEQUENCE comment '基础序列表';

INSERT INTO SYS_SEQUENCE(CUR_DATE,CURRENT_VALUE,SEQ_TYPE,CACHED_SIZE,REMARKS) VALUES (CURDATE(),0,1,0,'收文号序列');
INSERT INTO SYS_SEQUENCE(CUR_DATE,CURRENT_VALUE,SEQ_TYPE,CACHED_SIZE,REMARKS) VALUES (CURDATE(),0,2,0,'发文号序列');