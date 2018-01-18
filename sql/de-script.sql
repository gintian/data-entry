-- 20171126（已上线）
alter table DE_REC_FILE add (IS_NEED_FEEDBACK tinyint);

// 来文单位模糊匹配 权限设置（/de/recFile/queryRecCompanys）


-- 20171207（已上线）
insert into sys_dict (dictName,dictCode,dictType,remark,status) values ('收发文前缀','DICT_REC_SEND_PREFIX',0,'',1);
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'收文号前缀','PREFIX_REC','SW','',1,'1');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'收文号前缀（涉密）','PREFIX_REC_DENSE','MS','',1,'2');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'发文号前缀','PREFIX_SEND','FW','',1,'3');
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_REC_SEND_PREFIX')),'发文号前缀（涉密）','PREFIX_SEND_DENSE','MF','',1,'4');


-- 20171213（已上线）
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_GRADE')),'特急','GRADE_TJJ','5','',1,'5');


-- 20180104（已上线）
// 删除涉密单机的文件类别选项：公文件
DELETE FROM sys_dict_item WHERE itemCode = 'FILE_CATEGORY_GWJ' AND `dictId` IN (SELECT dictId FROM sys_dict WHERE dictCode = 'DICT_FILE_CATEGORY');
UPDATE sys_menu t SET t.`menuUrl` = '/de/recFile/goList?FLAG=SIGN_LIST' WHERE t.`menuName` = '收文签收清单';
ALTER TABLE DE_REC_FILE add (PROPOSED_DATE date);
ALTER TABLE DE_REC_FILE_SIGN ADD (SIGN_UP2 VARCHAR(32));
ALTER TABLE DE_REC_FILE_SIGN ADD (SIGN_TIME2 DATETIME);
ALTER TABLE DE_SEND_FILE ADD (CONFIDENTIAL_CODE VARCHAR(32));


-- 20180110（未上线）
ALTER TABLE DE_REC_FILE MODIFY PROPOSED_COMMENTS VARCHAR(4000);
ALTER TABLE DE_REC_FILE MODIFY LEADER_INS VARCHAR(4000);

// 增加涉密单机（1、10）的文件类别选项：公文件
insert into sys_dict_item (dictId,itemName,itemCode,itemVal,remark,status,orderNo) values (((select t.dictId from sys_dict t where t.dictCode='DICT_FILE_CATEGORY')),'公文件','FILE_CATEGORY_GWJ','1','',1,'1');

// 合并签收单位、签收人、签收时间到拟办意见或者局领导批示
REPLACE INTO de_rec_file (
  `PK_REC_FILE`,
  `DICT_FILE_SOURCE`,
  `DICT_FILE_CATEGORY`,
  `DICT_REC_COMPANY`,
  `REC_DATE`,
  `REC_NO`,
  `FILE_CODE`,
  `FILE_TITLE`,
  `DICT_DENSE`,
  `DENSE_CODE`,
  `DICT_GRADE`,
  `FILE_CNT`,
  `HANDLE_PRES`,
  `IS_DISPATCH`,
  `IS_HANDLE`,
  `IS_PROPOSED`,
  `PROPOSED_COMMENTS`,
  `LEADER_INS`,
  `DIRECTOR_OPER`,
  `SIGN_UP_STATUS`,
  `ATTACHMENT`,
  `MEMO`,
  `CREATE_BY_ID`,
  `CREATE_BY_TIME`,
  `UPDATE_BY_ID`,
  `UPDATE_BY_TIME`,
  `IS_VALID`,
  `IS_NEED_FEEDBACK`,
  `PROPOSED_DATE` 
) 
  SELECT `PK_REC_FILE`,
  `DICT_FILE_SOURCE`,
  `DICT_FILE_CATEGORY`,
  `DICT_REC_COMPANY`,
  `REC_DATE`,
  `REC_NO`,
  `FILE_CODE`,
  `FILE_TITLE`,
  `DICT_DENSE`,
  `DENSE_CODE`,
  `DICT_GRADE`,
  `FILE_CNT`,
  `HANDLE_PRES`,
  `IS_DISPATCH`,
  `IS_HANDLE`,
  `IS_PROPOSED`,
   CASE WHEN t.`IS_PROPOSED` = 1 THEN CONCAT(t.`PROPOSED_COMMENTS`, f.result) ELSE t.`PROPOSED_COMMENTS` END AS PROPOSED_COMMENTS,
   CASE WHEN t.`IS_PROPOSED` = 0 THEN CONCAT(t.`LEADER_INS`, f.result) ELSE t.`LEADER_INS` END AS LEADER_INS,
  `DIRECTOR_OPER`,
  `SIGN_UP_STATUS`,
  `ATTACHMENT`,
  `MEMO`,
  `CREATE_BY_ID`,
  `CREATE_BY_TIME`,
  `UPDATE_BY_ID`,
  `UPDATE_BY_TIME`,
  `IS_VALID`,
  `IS_NEED_FEEDBACK`,
  `PROPOSED_DATE` 
FROM de_rec_file t
INNER JOIN (
SELECT 
  d.`FK_REC_FILE`,
  CONCAT('（', GROUP_CONCAT(
    CONCAT(CASE WHEN o.`DICT_ORG_CATEGORY` = 'ORG_CATEGORY_QT' THEN d.`SIGN_UP_OTHER` ELSE o.`ORG_COMPANY` END, 
	   d.`SIGN_UP`, 
	   IF(d.`SIGN_TIME`, DATE_FORMAT(SIGN_TIME, '%Y-%m-%d'), ''),
	   '取走'
	   )
     SEPARATOR ','
  ), '）') AS result
FROM de_rec_file_sign d 
INNER JOIN de_organization o ON d.`FK_ORGANIZATION` = o.`PK_ORGANIZATION` 
GROUP BY d.`FK_REC_FILE`
) f ON t.pk_rec_file = f.fk_rec_file;


