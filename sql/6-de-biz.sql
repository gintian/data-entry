/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/8/2 11:22:32                            */
/*==============================================================*/


drop table if exists DE_ORGANIZATION;

drop table if exists DE_REC_FILE;

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
   DICT_REC_COMPANY     varchar(32) not null comment '来文单位，字典表：公安部、省公安厅、市委、市政府、市委政法委、市委办公厅、市政府办公厅、市委政法委办公室、市综治办、市委组织部、市纪委',
   REC_DATE             date not null comment '收文日期，格式yyyyMMdd',
   REC_NO               varchar(32) not null comment '收文号：流水号，自动生成',
   FILE_CODE            varchar(64) comment '文号，比如闽公宗（2017）051号',
   FILE_TITLE           varchar(256) not null comment '文件标题',
   DICT_DENSE           varchar(32) not null comment '密级，字典表：非密、秘密、机密、绝密、内部文件',
   DENSE_CODE           varchar(64) comment '密级编号，只有当选项是秘密或机密或绝密时，才出现密级编号，密级编号不是必填项，也可以填无',
   DICT_GRADE           varchar(32) not null comment '等级，字典表：普通，加急，平急，特提',
   FILE_CNT             int not null comment '文件数量',
   HANDLE_PRES          date comment '办理时效，如果选择了日期，则在超时后自动显示红色，同时用户可以手动点击已办结，然后不显示红色',
   IS_HANDLE            tinyint comment '是否办结：1是0否，',
   IS_PROPOSED          tinyint not null comment '是否拟办：1是0否',
   PROPOSED_COMMENTS    varchar(2000) comment '拟办意见',
   LEADER_INS           varchar(2000) comment '领导批示',
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
/* Table: DE_SEND_FILE                                          */
/*==============================================================*/
create table DE_SEND_FILE
(
   PK_SEND_FILE         int(11) not null auto_increment comment '主键',
   DICT_FILE_CATEGORY   varchar(32) not null comment '文件类别，字典表：公文件、机要件、挂号信件、普通信件',
   FILE_TITLE           varchar(256) not null comment '文件标题',
   SEND_COMPANYS        varchar(256) not null comment '发送单位：存放机构单位主键，多个以，分隔',
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

