--得到操作语句编码
select get_sqlCode('t_sys_supplier') from dual;
select getStrBytableName('t_sys_supplier') from dual;

--操作语句
select t.*,rowid from t_oracle_sql t where t.sql_code='tSysSupplier';
--操作语句子表
select t.*,rowid from t_oracle_sql_child t;

--------------同步数据字典供应商经营类别到t_sys_static-------
select t.*,rowid from t_sys_static t where t.varcode='03';
select * from t_base_data_dictionary t where t.up_system_id='0g02' ;

-----------------------

select t.code from t_oracle_sql_child t
