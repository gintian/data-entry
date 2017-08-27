insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('50','0','收发文管理','1','','','1','5','1','0');
insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('51',(SELECT t.menuId FROM sys_menu t WHERE t.menuName = '收发文管理'),'收文管理（公安系统）','3','/de/recFile/goList?DICT_FILE_SOURCE=FILE_SOURCE_GAXT','','1','1','1','0');
insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('52',(SELECT t.menuId FROM sys_menu t WHERE t.menuName = '收发文管理'),'收文管理（外部系统）','3','/de/recFile/goList?DICT_FILE_SOURCE=FILE_SOURCE_WBXT','','1','2','1','0');
insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('53',(SELECT t.menuId FROM sys_menu t WHERE t.menuName = '收发文管理'),'收文管理（办公室内部收文）','3','/de/recFile/goList?DICT_FILE_SOURCE=FILE_SOURCE_BGSNBSW','','1','3','1','0');
insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('54',(SELECT t.menuId FROM sys_menu t WHERE t.menuName = '收发文管理'),'收文管理（局直单位呈报）','3','/de/recFile/goList?DICT_FILE_SOURCE=FILE_SOURCE_JZDWCB','','1','4','1','0');
insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('55',(SELECT t.menuId FROM sys_menu t WHERE t.menuName = '收发文管理'),'发文管理','3','/de/sendFile/goList','','1','5','1','0');
insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('56',(SELECT t.menuId FROM sys_menu t WHERE t.menuName = '收发文管理'),'收文签收清单','3','/de/recFile/goSignList','','1','6','1','0');

insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('60','0','机构管理','1','','','1','10','1','0');
insert into `sys_menu` (`menuId`, `parentId`, `menuName`, `menuType`, `menuUrl`, `inco`, `openType`, `orderNo`, `openState`, `isPublic`) values('61',(SELECT t.menuId FROM sys_menu t WHERE t.menuName = '机构管理'),'机构维护','3','/de/organization/goList','','1','1','1','0');
