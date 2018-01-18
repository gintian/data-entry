/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/12/7 10:06:20                           */
/*==============================================================*/


drop table if exists DE_ORGANIZATION;

drop table if exists DE_REC_FILE;

drop table if exists DE_REC_FILE_SIGN;

drop table if exists DE_SEND_FILE;

drop table if exists DE_SUPERVISE;

/*==============================================================*/
/* Table: DE_ORGANIZATION                                       */
/*==============================================================*/
create table DE_ORGANIZATION
(
   PK_ORGANIZATION      int(11) not null auto_increment comment '主键',
   DICT_ORG_CATEGORY    varchar(32) not null comment '机构类别，字典表：局领导、局直各单位、各分局县（市）区公安局',
   ORG_COMPANY          varchar(32) not null comment '机构单位：驻局纪检组、警务督察支队、办公室、指挥中心、政治部、边防支队、消防支队、警务队等等',
   CREATE_BY_ID         int comment '本条记录系统用户创建者ID',
   CREATE_BY_TIME       datetime comment '本条记录系统用户创建时间',
   UPDATE_BY_ID         int comment '本条记录系统用户修改者ID',
   UPDATE_BY_TIME       datetime comment '本条记录系统用户修改时间',
   IS_VALID             tinyint not null default 1 comment '删除状态位(1有效，0无效，作废的时候表示无效)',
   primary key (PK_ORGANIZATION)
);

alter table DE_ORGANIZATION comment '机构表';

/*==============================================================*/
/* Table: DE_REC_FILE                                           */
/*==============================================================*/
create table DE_REC_FILE
(
   PK_REC_FILE          int(11) not null auto_increment comment '主键',
   DICT_FILE_SOURCE     varchar(32) not null comment '文件来源，字典表：公安系统、外部系统、办公室内部收文、局直单位呈报',
   DICT_FILE_CATEGORY   varchar(32) not null comment '文件类别，字典表：公文件、机要件、挂号信件、普通信件',
   DICT_REC_COMPANY     varchar(32) not null comment '来文单位，字典表：公安部、省公安厅、市委、市政府、市委政法委、市委办公厅、市政府办公厅、市委政法委办公厅、市综治办、市委组织部、市纪委',
   REC_DATE             date not null comment '收文日期，格式yyyyMMdd',
   REC_NO               varchar(32) not null comment '收文号：流水号，自动生成',
   FILE_CODE            varchar(64) comment '文号，比如闽公宗（2017）051号',
   FILE_TITLE           varchar(256) not null comment '文件标题',
   DICT_DENSE           varchar(32) not null comment '密级，字典表：非密、秘密、机密、绝密、内部文件',
   DENSE_CODE           varchar(64) comment '密级编号，只有当选项是秘密或机密或绝密时，才出现密级编号，密级编号不是必填项，也可以填无',
   DICT_GRADE           varchar(32) comment '等级，字典表：普通，加急，平急，特提',
   FILE_CNT             int comment '文件数量',
   HANDLE_PRES          date comment '办理时效，如果选择了日期，则在超时后自动显示红色，同时用户可以手动点击已办结，然后不显示红色',
   IS_DISPATCH          tinyint comment '1是0否',
   IS_HANDLE            tinyint comment '是否办结：1是0否，',
   IS_PROPOSED          tinyint comment '是否拟办：1是0否',
   IS_NEED_FEEDBACK     tinyint comment '是否需办理反馈（1是0否）',
   PROPOSED_COMMENTS    varchar(2000) comment '拟办意见',
   LEADER_INS           varchar(2000) comment '领导批示',
   DIRECTOR_OPER        tinyint comment '1局长批示、2局长圈阅',
   SIGN_UP_STATUS       tinyint comment '签收状态：1已签收，0未完成签收',
   ATTACHMENT           varchar(2000) comment '附件',
   MEMO                 varchar(2000) comment '备注',
   CREATE_BY_ID         int comment '本条记录系统用户创建者ID',
   CREATE_BY_TIME       datetime comment '本条记录系统用户创建时间',
   UPDATE_BY_ID         int comment '本条记录系统用户修改者ID',
   UPDATE_BY_TIME       datetime comment '本条记录系统用户修改时间',
   IS_VALID             tinyint not null default 1 comment '删除状态位(1有效，0无效，作废的时候表示无效)',
   primary key (PK_REC_FILE)
);

alter table DE_REC_FILE comment '收文表';

/*==============================================================*/
/* Table: DE_REC_FILE_SIGN                                      */
/*==============================================================*/
create table DE_REC_FILE_SIGN
(
   PK_REC_FILE_SIGN     int(11) not null auto_increment comment '主键',
   FK_REC_FILE          int(11) not null comment 'FK收文表',
   FK_ORGANIZATION      int(11) not null comment 'FK机构表，适用于收文管理（公安系统）和（外部系统）（局直单位呈报）',
   SIGN_UP_OTHER        varchar(128) comment '签收单位（其他）',
   SIGN_UP              varchar(32) comment '签收人',
   SIGN_TIME            datetime comment '签收时间',
   MEMO                 varchar(2000) comment '备注',
   CREATE_BY_ID         int comment '本条记录系统用户创建者ID',
   CREATE_BY_TIME       datetime comment '本条记录系统用户创建时间',
   UPDATE_BY_ID         int comment '本条记录系统用户修改者ID',
   UPDATE_BY_TIME       datetime comment '本条记录系统用户修改时间',
   IS_VALID             tinyint not null default 1 comment '删除状态位(1有效，0无效，作废的时候表示无效)',
   primary key (PK_REC_FILE_SIGN)
);

alter table DE_REC_FILE_SIGN comment '收文签收表';

/*==============================================================*/
/* Table: DE_SEND_FILE                                          */
/*==============================================================*/
create table DE_SEND_FILE
(
   PK_SEND_FILE         int(11) not null auto_increment comment '主键',
   DICT_FILE_CATEGORY   varchar(32) not null comment '文件类别，字典表：公文件、机要件、挂号信件、普通信件',
   FILE_TITLE           varchar(256) not null comment '文件标题',
   SEND_COMPANYS        varchar(256) not null comment '发送单位：存放机构单位主键，多个以，分隔',
   SEND_COMPANYS_OTHER  varchar(64) comment '发送单位（其他）',
   SEND_DATE            date not null comment '发文日期，格式yyyyMMdd',
   SEND_NO              varchar(32) not null comment '发文号：流水号，自动生成',
   FILE_CODE            varchar(64) comment '文号，比如闽公宗（2017）051号',
   DICT_DENSE           varchar(32) comment '密级，字典表：非密、秘密、机密、绝密、内部文件',
   DENSE_CODE           varchar(64) comment '密级编号，只有当选项是秘密或机密或绝密时，才出现密级编号，密级编号不是必填项，也可以填无',
   MEMO                 varchar(2000) comment '备注',
   CREATE_BY_ID         int comment '本条记录系统用户创建者ID',
   CREATE_BY_TIME       datetime comment '本条记录系统用户创建时间',
   UPDATE_BY_ID         int comment '本条记录系统用户修改者ID',
   UPDATE_BY_TIME       datetime comment '本条记录系统用户修改时间',
   IS_VALID             tinyint not null default 1 comment '删除状态位(1有效，0无效，作废的时候表示无效)',
   primary key (PK_SEND_FILE)
);

alter table DE_SEND_FILE comment '发文表';

/*==============================================================*/
/* Table: DE_SUPERVISE                                          */
/*==============================================================*/
create table DE_SUPERVISE
(
   PK_SUPERVISE         int(11) not null auto_increment comment '主键',
   CREATE_BY_ID         int comment '本条记录系统用户创建者ID',
   CREATE_BY_TIME       datetime comment '本条记录系统用户创建时间',
   UPDATE_BY_ID         int comment '本条记录系统用户修改者ID',
   UPDATE_BY_TIME       datetime comment '本条记录系统用户修改时间',
   IS_VALID             tinyint not null default 1 comment '删除状态位(1有效，0无效，作废的时候表示无效)',
   primary key (PK_SUPERVISE)
);

alter table DE_SUPERVISE comment '督办表';

