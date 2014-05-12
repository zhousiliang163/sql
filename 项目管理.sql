--数据权限配置表
select t.*,rowid from t_data_permission t where t.business_type_id='010401' or t.id='402881bd45da47980145daa3f3580006' 
union all
select t.*,rowid from t_data_permission t where t.business_type_id='010401' or t.id='402881bd45da47980145daa3f3580006' ;
