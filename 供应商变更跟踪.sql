--供应商信息变更主表
select t.*,rowid from t_supplier_changetrace t;
--供应商信息变更明细表
select t.*,rowid from t_supplier_changetrace_detail t;

select * from t_supplier_changetrace sc,t_supplier_changetrace_detail cd where sc.changecode=cd.changecode;


select '01050401','供应商信息表',t.COLUMN_NAME,sys_guid(),t.COMMENTS,rowid from user_col_comments t where t.TABLE_NAME=upper('t_sys_supplier');
/*
declare
v_businesstypecode varchar2(50):='01050402';
v_businesstype varchar2(50):='日志表t_sys_accessory';
begin
  insert into T_BUSINESSTYPE_PROPERTY(businesstypecode ,businesstype,propertyname,propertycode,remark)
select v_businesstypecode,v_businesstype,t.COLUMN_NAME,sys_guid(),t.COMMENTS from user_col_comments t where t.TABLE_NAME=upper('t_sys_accessory');
  

end ;
*/


/*
declare
v_businesstypecode varchar2(50):='01050402';
begin
  insert into T_BUSINESSTYPE_PROPERTY_detail(propertycode,showname)
select t.propertycode,t.remark from T_BUSINESSTYPE_PROPERTY t where t.businesstypecode=v_businesstypecode and t.state=1;
  

end ;
*/
select t.businesstypecode,t.propertycode,t.remark,t.propertyname from T_BUSINESSTYPE_PROPERTY t where t.businesstypecode='01050402';
select * from T_BUSINESSTYPE_RALATION t;
select t.*,rowid from T_BUSINESSTYPE_PROPERTY_detail t where t.state=1 and  t.propertycode in ('741B8D425CD8425E9E2D49AEF88536FA','48644CC647AF492EA08EDBE29596FB13');

select * from t_sys_configure t;
select * from user_tab_cols t where t.COLUMN_NAME=upper('businesstypecode');
select * from user_tab_histograms t where t.TABLE_NAME='T_BASE_DATA_DICTIONARY' ;
/*

附件和联系人的变更：
1.分别建一个临时表。（记录变更类型）
2.删除的记录判断：删除的记录在原有的记录要已经存在。
*/
