--考评主表
select t.*,rowid from t_sys_supplier_valua t;
--考评、供应商关系表
select t.*,rowid from t_supplier_kaoping_relation t;
--考评明细表
select t.*,rowid from  T_pms_kp_detail t;
--考评标准表
select t.*,rowid from t_kp_standard t;
--考评模板表
select t.*,rowid from t_kp_model t;
--考评标准和模板关系表
select t.*,rowid from t_kp_standard_model_ralation t;

--评审配置表
select * from t_pms_kaoping_install t where t.suppliertype='0g0201' and t.kaopingtype='0g0e01' and t.indicatortype='0g0g01' for update;
--
select * from t_sys_configure t;

insert into t_pms_kaoping_install
select '0g0201' suppliertype,'0g0e01' kaopingtype,t.system_id indicatortype,'' indicatoritem,'' percentage,'生产厂商 /准入评审/新项目新增' remark,'考评指标','考评项目' from t_base_data_dictionary t where t.up_system_id='0g0g';

begin 
  
  for p in (select * from t_base_data_dictionary t where t.up_system_id='0g0h') loop
    
  end loop;

end;

select * from t_base_data_dictionary t where t.up_system_id='0g0h';
