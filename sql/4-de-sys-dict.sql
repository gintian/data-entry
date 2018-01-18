INSERT INTO sys_dict (dictName,dictCode,dictType,remark,STATUS) VALUES ('机构类别','DICT_ORG_CATEGORY',0,'',1);
--INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_ORG_CATEGORY')),'局领导','ORG_CATEGORY_JLD','1','',1,'1');
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_ORG_CATEGORY')),'局直各单位','ORG_CATEGORY_JZGDW','2','',1,'2');
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_ORG_CATEGORY')),'各分局县（市）区公安局','ORG_CATEGORY_GFJXSQGAJ','3','',1,'3');
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_ORG_CATEGORY')),'内部各单位','ORG_CATEGORY_NBGDW','4','',1,'4');
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_ORG_CATEGORY')),'其他','ORG_CATEGORY_QT','5','',1,'5');

INSERT INTO sys_dict (dictName,dictCode,dictType,remark,STATUS) VALUES ('文件来源','DICT_FILE_SOURCE',0,'',1);
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_FILE_SOURCE')),'公安系统','FILE_SOURCE_GAXT','1','',1,'1');
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_FILE_SOURCE')),'外部系统','FILE_SOURCE_WBXT','2','',1,'2');
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_FILE_SOURCE')),'办公室内部收文','FILE_SOURCE_BGSNBSW','3','',1,'3');
INSERT INTO sys_dict_item (dictId,itemName,itemCode,itemVal,remark,STATUS,orderNo) VALUES (((SELECT t.dictId FROM sys_dict t WHERE t.dictCode='DICT_FILE_SOURCE')),'局直单位呈报','FILE_SOURCE_JZDWCB','4','',1,'4');

insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('文件类别','DICT_FILE_CATEGORY',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY')),'公文件','FILE_CATEGORY_GWJ','1','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY')),'机要件','FILE_CATEGORY_JYJ','2','',1,'2');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY')),'挂号信件','FILE_CATEGORY_GHXJ','3','',1,'3');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY')),'普通信件','FILE_CATEGORY_PTXJ','4','',1,'4');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY')),'密码电报','FILE_CATEGORY_MMDB','5','',1,'5');

insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('文件类别（非涉密）','DICT_FILE_CATEGORY_OPT',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY_OPT')),'公文件','FILE_CATEGORY_GWJ','1','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY_OPT')),'机要件','FILE_CATEGORY_JYJ','2','',1,'2');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY_OPT')),'挂号信件','FILE_CATEGORY_GHXJ','3','',1,'3');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY_OPT')),'普通信件','FILE_CATEGORY_PTXJ','4','',1,'4');

insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('来文单位','DICT_REC_COMPANY',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'公安部','REC_COMPANY_GAB','1','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'省公安厅','REC_COMPANY_SGAT','2','',1,'2');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市委','REC_COMPANY_SW','3','',1,'3');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市政府','REC_COMPANY_SZF','4','',1,'4');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市委政法委','REC_COMPANY_SWZFW','5','',1,'5');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市委办公厅','REC_COMPANY_SWBGT','6','',1,'6');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市政府办公厅','REC_COMPANY_SZFBGT','7','',1,'7');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市委政法委办公室','REC_COMPANY_SWZFWBGT','8','',1,'8');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市综治办','REC_COMPANY_SZZB','9','',1,'9');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市委组织部','REC_COMPANY_SWZZB','10','',1,'10');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_COMPANY')),'市纪委','REC_COMPANY_SJW','11','',1,'11');

insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('密级','DICT_DENSE',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_DENSE')),'非密','DENSE_FM','1','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_DENSE')),'秘密','DENSE_MM','2','',1,'2');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_DENSE')),'机密','DENSE_JIM','3','',1,'3');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_DENSE')),'绝密','DENSE_JUEM','4','',1,'4');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_DENSE')),'内部文件','DENSE_NBWJ','5','',1,'5');

insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('密级（非涉密）','DICT_DENSE_OPT',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_DENSE_OPT')),'非密','DENSE_FM','1','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_DENSE_OPT')),'内部文件','DENSE_NBWJ','5','',1,'5');

insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('等级','DICT_GRADE',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_GRADE')),'普通','GRADE_PT','1','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_GRADE')),'平急','GRADE_PJ','2','',1,'2');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_GRADE')),'加急','GRADE_JJ','3','',1,'3');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_GRADE')),'特提','GRADE_TJ','4','',1,'4');

insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('收发文前缀','DICT_REC_SEND_PREFIX',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'收文号前缀','PREFIX_REC','SW','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'收文号前缀（涉密）','PREFIX_REC_DENSE','MS','',1,'2');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'发文号前缀','PREFIX_SEND','FW','',1,'3');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'发文号前缀（涉密）','PREFIX_SEND_DENSE','MF','',1,'4');

