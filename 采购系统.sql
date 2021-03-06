--供应商信息变更日志临时表
select * from t_supplier_changelog_temp t;
--供应商信息变更日志表
select t.*,rowid from t_supplier_changelog t;
----供应商信息变更跟踪主表
select t.*,rowid from t_supplier_changetrace t;
--供应商信息变更跟踪明细表
select t.*,rowid from t_supplier_changetrace_detail t;
--不良处理
select t.*,rowid from t_supplier_bad_manage t where t.managecode='20140317022700058';
--不良处理和供应商关系表
select * from t_supplier_bad_ralation t;
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
select t.*,rowid from t_sys_supplier t where t.gcompanyid='402881bd44ae9aaf0144af982c910001'  for update;
select * from t_sys_supplier_linkman t where t.lcompanyid='1F70F6304DD04CB1B6BDC1DA8E1FCD1C';
select * from t_sys_supplier_linkman_bak t;
select * from T_SYS_Supplier_Tinform t where t.tinformid='402881bd4549198c01454996e4dd0000';--发布通知表
select * from t_Supplier_notice_relation t where t.supplierid='A4169D058502457C88DF5FCFCA8B2EE3';--供应商与通知关系表
select t.*,rowid from t_sys_supplier_valua t  ;
select * from t_supplier_kaoping_relation t where t.valuaid='402881bd449035450144904b60970000';
select * from t_sys_supplier_remind t ;
select t.*,rowid from t_sys_supplier_agreement t ;
--select * from t_sys_affix t;
select * from  T_SYS_ATTACHED t where t.fk_no='a0d5729a4e454ef18031fc6943fb8550';
select * from t_sys_accessory t where t.businessid='402881bd44e20eae0144e2b527c70005';--附件表
select t.* from t_sys_static t ;


select * from t_sys_user t where t.id='402881aa412f34ea01412f3800a70000';
select * from t_sys_user t where t.lname='DHEC-09-M0494';
select * from t_sys_uds t where t.superid='402881bd4581b57b01458394b78d0022';
select * from t_sys_user t;
select t.*,rowid from T_BASE_USER_RoLE t where t.user_id='40288f8140adfe700140ae1036b80000';
select * from t_Base_Role t where t.id='402881bd4337adca014337b3990e0000';
select * from t_Base_Role t where t.name like '系统管理员';


select * from T_SYS_Pactinfo;



--------------同步数据字典供应商经营类别到t_sys_static-------
select t.*,rowid from t_sys_static t where t.varcode='BUSINESS_TYPE';
select t.up_system_id,t.system_id,t.chinese_name from t_base_data_dictionary t where t.up_system_id='0g02' ;


select getsuppliercode('0g0201') from dual;
-----------------------


select * from t_sys_supplier_linkman;
select to_char(sysdate,'yy')  from dual;


begin
  --dbms_output.put_line(getSupplierCode(''));
  dbms_output.put_line(getSupplierKPCode());
end;


--delete from t_sys_user;

select substr('000000',0,6-7)||'1111111' from t_sys_user t ;
select substr('000000',0,6-7) from t_sys_user t ;
select *  from t_sys_user t where t.id='40288f8140adfe700140ae1036b80000';

select substr('000000',0,6-length(max(t.*)+1))||to_char(max(t.*)+1) from dual t ;

select  substr('0000',-1,1) from dual;



