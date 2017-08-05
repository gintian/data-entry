drop table if exists PU_ACT_DRAFT;

DROP TABLE IF EXISTS `sys_user_voice`;

/*==============================================================*/
/* Table: PU_ACT_DRAFT                                          */
/*==============================================================*/
create table PU_ACT_DRAFT
(
   PK_ACT_DRAFT         int not null auto_increment,
   PROCESS_INSTANCE_NAME varchar(1000) not null comment '流程标题',
   BUSINESS_KEY         int not null comment '业务表PK',
   FLOW_KEY             varchar(128) not null comment '流程模型KEY',
   BUSINESS_BEAN_NAME   varchar(128) not null comment '业务实现类的BEAN_NAME（例如userService）',
   IS_READ              tinyint not null comment '是否阅读过(0没有，1有)',
   CREATE_BY_ID         int not null comment '本条记录添加者ID',
   CREATE_BY_TIME       datetime not null comment '本条记录添加时间 ',
   UPDATE_BY_ID         int comment '本条记录修改者ID',
   UPDATE_BY_TIME       datetime comment '本条记录修改时间',
   primary key (PK_ACT_DRAFT)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8;

alter table PU_ACT_DRAFT comment '流程草稿箱';


drop table if exists PU_ATTACH_FILE;

/*==============================================================*/
/* Table: PU_ATTACH_FILE                                        */
/*==============================================================*/
create table PU_ATTACH_FILE
(
   PK_ATTACH_FILE       int not null auto_increment,
   STORE_FILE_NAME      varchar(1024) not null comment '存储文件名',
   FILE_TYPE            int not null comment '文件类型（常量1:普通文件；2:图片；3:文本；4:压缩包；5:安装包；6:媒体文件）',
   REAL_FILE_NAME       varchar(64) comment '真实文件名（上传的文件名）',
   FILE_SUFFIX          varchar(16) comment '文件后缀名',
   RELATIVE_PATH        varchar(256) comment '相对路径',
   ABSOLUTE_PATH        varchar(256) comment '绝对路径',
   URL_PATH             varchar(256) comment 'URL访问地址',
   SAVE_TYPE            int comment '保存方式（常量1:保存到硬盘；2:保存到FTP；3:保存到硬盘 和 FTP）',
   FILE_SIZE            bigint(10) comment '文件大小',
   PROCESS_INSTANCE_ID  varchar(64) comment '流程实例ID',
   BUSINESS_TABLE_NAME  varchar(128) comment '业务表表名',
   BUSINESS_KEY         varchar(64) comment '业务表实例PK',
   TASK_DEFINITION_KEY  varchar(64) comment '流程任务节点key',
   CREATE_BY_ID         int not null comment '本条记录添加者ID',
   CREATE_BY_TIME       datetime not null comment '本条记录添加时间 ',
   primary key (PK_ATTACH_FILE)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8;

alter table PU_ATTACH_FILE comment '附件信息表';



insert into sys_dict (dictName, dictCode, dictType, remark, status) values('FTP配置','DICT_FTP_CFG','0','','1');
insert into sys_dict (dictName, dictCode, dictType, remark, status) values('磁盘附件配置','DICT_ATTACH_DISK','0','','1');


INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '统一域名','DICT_NET_ADDRESS','192.168.1.17','',1,'1' FROM sys_dict t WHERE t.dictCode = 'DICT_FTP_CFG';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, 'IP','DICT_FTP_REMOTE_IP','192.168.1.17','',1,'2' FROM sys_dict t WHERE t.dictCode = 'DICT_FTP_CFG';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '端口','DICT_FTP_REMOTE_PORT','21','',1,'3' FROM sys_dict t WHERE t.dictCode = 'DICT_FTP_CFG';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '账号','DICT_FTP_REMOTE_USER','zhj','',1,'4' FROM sys_dict t WHERE t.dictCode = 'DICT_FTP_CFG';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '密码','DICT_FTP_REMOTE_PASSWORD','zhj','',1,'5' FROM sys_dict t WHERE t.dictCode = 'DICT_FTP_CFG';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '基础路径','DICT_FTP_BASE_PATH','f:/attach','',1,'6' FROM sys_dict t WHERE t.dictCode = 'DICT_FTP_CFG';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '资源服务器图片应用地址','DICT_FTP_URL_PATH','http://192.168.1.17:8080/picWeb/','',1,'7' FROM sys_dict t WHERE t.dictCode = 'DICT_FTP_CFG';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '磁盘附件根目录','DICT_DISK_BASE_PATH','attach/','',1,'1' FROM sys_dict t WHERE t.dictCode = 'DICT_ATTACH_DISK';
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) SELECT t.dictId, '磁盘附件压缩目录','DICT_DISK_ZIP_PATH','zip_files/','',1,'2' FROM sys_dict t WHERE t.dictCode = 'DICT_ATTACH_DISK';


CREATE TABLE `sys_user_voice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL COMMENT '验证码内容',
  `phone` varchar(11) DEFAULT NULL COMMENT '接收号码',
  `ip` varchar(50) DEFAULT NULL COMMENT '请求ip',
  `sendTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发送时间',
  `status` tinyint(2) DEFAULT NULL COMMENT '发送状态 0初始 1正常 -1失败',
  `bizType` varchar(30) DEFAULT NULL COMMENT '业务类型',
  `resMsg` varchar(250) DEFAULT NULL COMMENT '返回信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160331 DEFAULT CHARSET=utf8;
