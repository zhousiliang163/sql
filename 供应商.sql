--��Ӧ����Ϣ�����־��ʱ��
select * from t_supplier_changelog_temp t;
--��Ӧ����Ϣ�����־��
select t.*,rowid from t_supplier_changelog t;
--��Ӧ����Ϣ�������
select t.*,rowid from t_supplier_changetrace t where t.supplierid='1CB0245CB04C4C85B4DF70261EB9F44F';
--��Ӧ����Ϣ�����ϸ��
select t.*,rowid from t_supplier_changetrace_detail t where t.changecode='20140521143141559460844';
--��������
select t.*,rowid from t_supplier_bad_manage t where t.managecode='20140317022700058';
--��������͹�Ӧ�̹�ϵ��
select * from t_supplier_bad_ralation t;
--��Ӧ����ʱ��
select * from t_sys_supplier_temp t;
--��Ӧ�̱��ݱ�

/*
begin
 --����
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
select t.*,rowid from t_sys_supplier t where t.gcompanycode='DHEC-14-S0522';
select * from t_sys_supplier_linkman t where t.lcompanyid='0A034122C25F42738ACEC8C39A787368';
select * from t_sys_supplier_linkman_bak t;
select t.*,rowid from T_SYS_Supplier_Tinform t where t.tinformid='402881bd4549198c01454996e4dd0000';--����֪ͨ��
select * from t_Supplier_notice_relation t where t.supplierid='A4169D058502457C88DF5FCFCA8B2EE3';--��Ӧ����֪ͨ��ϵ��
select t.*,rowid from t_sys_supplier_valua t;
select * from t_supplier_kaoping_relation t where t.valuaid='402881bd449035450144904b60970000';
select * from t_sys_supplier_remind t ;
select t.*,rowid from t_sys_supplier_agreement t ;
--select * from t_sys_affix t;
select * from  T_SYS_ATTACHED t where t.fk_no='a0d5729a4e454ef18031fc6943fb8550';
select * from t_sys_accessory t where t.businessid='402881bd46170c1a0146172022ac001c';--������


select t.*,rowid from t_sys_static t where t.varcode='BUSINESS_TYPE';
select t.system_id,t.chinese_name from t_base_data_dictionary t where t.up_system_id='0g02';

select t.businesstypecode,t.propertycode,t.remark,t.propertyname from T_BUSINESSTYPE_PROPERTY t where t.businesstypecode='01050402' and t.code01='';
select t.*,rowid from T_BUSINESSTYPE_PROPERTY t; 
select * from T_BUSINESSTYPE_RALATION t;
select t.*,rowid from T_BUSINESSTYPE_PROPERTY_detail t where t.state=1 and  t.propertycode in ('741B8D425CD8425E9E2D49AEF88536FA','48644CC647AF492EA08EDBE29596FB13');

select * from t_sys_configure t;

--ҵ�����չ��
select t.*,rowid from t_column_extend t where t.column_name like'%ajor%';
select getUniqueCode(),getColumnCode(),getStrBytableName('in_col_name') from dual;
 

--insert into t_column_extend(column_code,column_name,column_comments)
values(getColumnCode(),getStrBytableName('floor_space'),'�������');

--ҵ�����չ�й�ϵ��������һ����������Щ�ֶ�
select t.*,rowid from t_column_extend_relation t where t.business_type='0g0205';

--insert into t_column_extend_relation(business_type,column_code) 
select '0g0205',t.column_code from t_column_extend t where t.column_code in ('000001','000002','000003','000004','000007','000019','000021','000022','000023','000024','000025','000016','000012','000011');

select cer.business_type,ce.column_name,ce.column_comments from t_column_extend ce,t_column_extend_relation cer where ce.column_code=cer.column_code
and ce.state=1 and cer.state=1
and cer.business_type='0g0205';
--ҵ�����չ�е�ֵ
select * from t_sys_supplier_other t where t.state=1 
and t.supplier_code='DHEC-14-S0514'
and t.column_name='' ;

select t.*,rowid from t_sys_supplier_other t where t.supplier_code='DHEC-14-S0515';

select to_char(supplier_other_select('DHEC-14-S0516')) from dual;

--��Ӧ�������豸��
select t.*,rowid from t_sys_supplier_equipment t;
--��Ӧ�������豸��ʷ��
select t.*,rowid from th_sys_supplier_equipment t;
--�����豸���������־�������ĵĴ洢������
select t.*,rowid from t_supplier_equipment_auditLog t;
--��Ӧ���������
select * from t_supplier_qualification t;
--��Ӧ����������ʷ��
select * from th_supplier_qualification t;

