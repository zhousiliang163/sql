--供应商信息变更日志临时表
select * from t_supplier_changelog_temp t;
--供应商信息变更日志表
select t.*,rowid from t_supplier_changelog t;
--供应商信息变更主表
select t.*,rowid from t_supplier_changetrace t where t.supplierid='20140522102420800366353';
select t.*,rowid from t_supplier_changetrace t where t.changecode='20140620162211630192101';
--供应商信息变更明细表
select t.*,rowid from t_supplier_changetrace_detail t where t.changecode='20140620162211630192101';
--不良处理
select t.*,rowid from t_supplier_bad_manage t where t.managecode='20140604033700049';
--不良处理和供应商关系表

select * from t_supplier_bad_ralation t where t.managecode='20140604033700049';

select t.*,rowid from t_supplier_bad_ralation t where t.managecode='20140604033700049';

--供应商临时表
select * from t_sys_supplier_temp t;
--供应商备份表

/*
begin
 --备份
 delete from t_sys_supplier_bak sb where exists(select 1 from t_sys_supplier ts where ts.gcompanyid=sb.gcompanyid);
 insert into t_sys_supplier_bak  select * from t_sys_supplier ts;
 
 delete from t_sys_supplier_linkman_bak lb where 
 exists (select 1 from t_sys_supplier_linkman tl where lb.linkmanid=tl.linkmanid );
  insert into t_sys_supplier_linkman_bak select * from t_sys_supplier_linkman tl ;
 commit;
end;
*/
select * from t_sys_supplier_bak t;

select t.*,rowid from t_sys_supplier t where t.gcompanyid='402881bd45f878f70145f8facabb0004'  for update;
select t.*,rowid from t_sys_supplier t where t.gcompanycode='DHEC-14-C0001';


select t.*,rowid from T_SYS_Supplier_Tinform t where t.tinformid='402881bd4549198c01454996e4dd0000';--发布通知表
select * from t_Supplier_notice_relation t where t.supplierid='A4169D058502457C88DF5FCFCA8B2EE3';--供应商与通知关系表
select t.*,rowid from t_sys_supplier_valua t where t.vcode='2014KP-011';
select * from t_supplier_kaoping_relation t where t.valuaid='402881bd466e926f01466f1430bc0000';
select * from t_sys_supplier_remind t ;
select t.*,rowid from t_sys_supplier_agreement t ;
--select * from t_sys_affix t;
select t.*,rowid from  T_SYS_ATTACHED t where t.fk_no='097880bc-22eb-74ad-a6a3-23d2faebfe0c';
select t.*,rowid from t_sys_accessory t where t.businessid='402881bd46170c1a0146172022ac001c';--表


select t.*,rowid from t_sys_static t where t.varcode='BUSINESS_TYPE';
select t.system_id,t.chinese_name from t_base_data_dictionary t where t.up_system_id='0g02';

select t.businesstypecode,t.propertycode,t.remark,t.propertyname from T_BUSINESSTYPE_PROPERTY t where t.businesstypecode='01050402' and t.code01='';
select t.*,rowid from T_BUSINESSTYPE_PROPERTY t; 
select * from T_BUSINESSTYPE_RALATION t;
select t.*,rowid from T_BUSINESSTYPE_PROPERTY_detail t where t.state=1 and  t.propertycode in ('741B8D425CD8425E9E2D49AEF88536FA','48644CC647AF492EA08EDBE29596FB13');



--业务表扩展列
select t.*,rowid from t_column_extend t where t.column_name like'%ound%';
select getUniqueCode(),getColumnCode(),getStrBytableName('in_col_name') from dual;
 

--insert into t_column_extend(column_code,column_name,column_comments)
values(getColumnCode(),getStrBytableName('founded_yearBy_company'),'公司成立年份');

--业务表扩展列关系表，用来绑定一个类型有哪些字段
select t.*,rowid from t_column_extend_relation t where t.business_type='0g0205';

--insert into t_column_extend_relation(business_type,column_code) 
select '0g0205',t.column_code from t_column_extend t where t.column_code in ('000028');

select cer.business_type,ce.column_name,ce.column_comments from t_column_extend ce,t_column_extend_relation cer where ce.column_code=cer.column_code
and ce.state=1 and cer.state=1
and cer.business_type='0g0205';
--业务表扩展列的值
select * from t_sys_supplier_other t where t.state=1 
and t.supplier_code='DHEC-14-S0514'
and t.column_name='' ;

select t.*,rowid from t_sys_supplier_other t where t.supplier_code='DHEC-14-S0515';

select to_char(supplier_other_select('DHEC-14-S0516')) from dual;

--供应商生产设备表
select t.*,rowid from t_sys_supplier_equipment t;
--供应商生产设备历史表
select t.*,rowid from th_sys_supplier_equipment t;
--生产设备变更审批日志表
select t.*,rowid from t_supplier_equipment_auditLog t;

--供应商资质类表
select * from t_supplier_qualification t;--097880bc-22eb-74ad-a6a3-23d2faebfe0c
--供应商资质类历史表
select t.*,rowid from th_supplier_qualification t;
--供应商资质类变更审批日志表
select * from t_qualification_auditLog t where t.id in ('402881bd46b8540d0146b85628ae0001');

--供应商可提供的资质文件表
select t.*,rowid from t_sys_accessory t where t.accessoryid='2014061810565579169566';
--供应商可提供的资质文件表历史表
select t.*,rowid from th_sys_accessory t where t.accessoryid='2014061810565579169566';
--供应商可提供的资质文件变更审批日志表
select t.*,rowid from t_sys_accessory_auditLog t where t.accessoryid='2014061810565579169566';

--主要客户及实绩表
select t.*,rowid from   t_customer_performance t;
--主要客户及实绩历史表
select t.*,rowid from   th_customer_performance t;
--主要客户及实绩变更审批日志表
select t.*,rowid from   t_performance_auditLog t;

--主要客户及销售的产品表
select t.*,rowid from   t_customer_product t;
--主要客户及销售的产品历史表
select t.*,rowid from   th_customer_product t;
--主要客户及销售的产品变更审批日志表
select t.*,rowid from   t_customer_product_auditLog t;
--供应商联系人
select * from t_sys_supplier_linkman t where t.lcompanyid='402881bd46cbe77e0146cc62d72a09d1';
select * from t_sys_supplier_linkman t where t.lcompanyid='0A034122C25F42738ACEC8C39A787368';
select * from t_sys_supplier_linkman_bak t;
--供应商联系人历史表
select * from th_sys_supplier_linkman t where t.linkmancode='20140624145013125514852';
--供应商联系人变更审批表
select * from t_supplier_linkman_auditLog;


